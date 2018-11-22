Received: from eggs.gnu.org ([2001:4830:134:3::10]:44057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gPojp-000678-KX
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 08:09:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gPojm-000257-GF
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 08:09:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47354)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gPojm-00023e-8k
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 08:09:42 -0500
References: <20181114123643.24091-1-marcandre.lureau@redhat.com>
	<20181114123643.24091-10-marcandre.lureau@redhat.com>
	<56d6d5ae-cc33-be46-1880-def10db32f41@redhat.com>
	<CAJ+F1CKxYgVMUJ6Sw3YTvCr4Nr36ZSxkEN-4wxeJRirsCtSvQw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <54889642-c4a4-7eb1-4217-c84936e18dcb@redhat.com>
Date: Thu, 22 Nov 2018 14:09:34 +0100
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CKxYgVMUJ6Sw3YTvCr4Nr36ZSxkEN-4wxeJRirsCtSvQw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.2 09/41] slirp: add a set_nonblock()
 callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>, samuel.thibault@ens-lyon.org, "Richard W.M. Jones" <rjones@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, renzo@cs.unibo.it

On 21/11/18 22:02, Marc-Andr=C3=A9 Lureau wrote:
> Hi
> On Thu, Nov 15, 2018 at 5:09 PM Paolo Bonzini <pbonzini@redhat.com> wro=
te:
>>
>> On 14/11/2018 13:36, Marc-Andr=C3=A9 Lureau wrote:
>>> qemu_set_nonblock() does some event registration with the main loop o=
n
>>> win32, let's have a callback.
>>>
>>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>
>> Perhaps a better interface would be register_poll_fd, which is called
>> before a file descriptor can be returned to slirp_pollfds_fill?  And
>> perhaps a dual unregister_poll_fd, which QEMU would leave empty, to be
>> called before closing the file descriptor.
>=20
> That sounds like a good idea, but I think it will bring more issues as
> qemu_fd_register() doing WSAEventSelect will put the socket in
> nonblocking mode anyway, and we don't have/need qemu_fd_unregister()
> yet:

Right, I was more thinking of other possible future clients of SLIRP.
But what you have now surely is fine.

(One possible way to work around the problem could be to put the socket
in non-blocking mode in SLIRP, since that is OS-dependent but not
client-dependent.  Then we can document that the register/unregister_fd
API is called with sockets that are already in non-blocking mode.  That
complicates the code a bit in order to have a nicer API).

Paolo

> https://msdn.microsoft.com/de-de/library/windows/desktop/ms738573(v=3Dv=
s.85).aspx
> "The WSAAsyncSelect and WSAEventSelect functions automatically set a
> socket to nonblocking mode. If WSAAsyncSelect or WSAEventSelect has
> been issued on a socket, then any attempt to use ioctlsocket to set
> the socket back to blocking mode will fail with WSAEINVAL.
> To set the socket back to blocking mode, an application must first
> disable WSAAsyncSelect by calling WSAAsyncSelect with the lEvent
> parameter equal to zero, or disable WSAEventSelect by calling
> WSAEventSelect with the lNetworkEvents parameter equal to zero."
>=20
> I will stick to the set_nonblock() callback for now.
>=20
> thanks
>=20
>=20
>=20
>> Paolo
>>
>>> ---
>>>  slirp/libslirp.h | 1 +
>>>  net/slirp.c      | 1 +
>>>  slirp/misc.c     | 2 +-
>>>  slirp/tcp_subr.c | 4 ++--
>>>  4 files changed, 5 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/slirp/libslirp.h b/slirp/libslirp.h
>>> index 88185e6c33..f2e7f94ebb 100644
>>> --- a/slirp/libslirp.h
>>> +++ b/slirp/libslirp.h
>>> @@ -20,6 +20,7 @@ typedef struct SlirpCb {
>>>                        SlirpTimerCb cb, void *opaque);
>>>      void (*timer_free)(void *timer);
>>>      void (*timer_mod)(void *timer, int64_t expire_timer);
>>> +    void (*set_nonblock)(int fd);
>>>  } SlirpCb;
>>>
>>>
>>> diff --git a/net/slirp.c b/net/slirp.c
>>> index 7b28886802..5ea8c255f6 100644
>>> --- a/net/slirp.c
>>> +++ b/net/slirp.c
>>> @@ -190,6 +190,7 @@ static SlirpCb slirp_cb =3D {
>>>      .timer_new =3D net_slirp_timer_new,
>>>      .timer_free =3D net_slirp_timer_free,
>>>      .timer_mod =3D net_slirp_timer_mod,
>>> +    .set_nonblock =3D qemu_set_nonblock,
>>>  };
>>>
>>>  static int net_slirp_init(NetClientState *peer, const char *model,
>>> diff --git a/slirp/misc.c b/slirp/misc.c
>>> index 7972b9b05b..dd2b3512a8 100644
>>> --- a/slirp/misc.c
>>> +++ b/slirp/misc.c
>>> @@ -174,7 +174,7 @@ fork_exec(struct socket *so, const char *ex)
>>>      socket_set_fast_reuse(so->s);
>>>      opt =3D 1;
>>>      qemu_setsockopt(so->s, SOL_SOCKET, SO_OOBINLINE, &opt, sizeof(in=
t));
>>> -    qemu_set_nonblock(so->s);
>>> +    so->slirp->cb->set_nonblock(so->s);
>>>      return 1;
>>>  }
>>>  #endif
>>> diff --git a/slirp/tcp_subr.c b/slirp/tcp_subr.c
>>> index 4b40850c7a..8d97f1f54e 100644
>>> --- a/slirp/tcp_subr.c
>>> +++ b/slirp/tcp_subr.c
>>> @@ -412,7 +412,7 @@ int tcp_fconnect(struct socket *so, unsigned shor=
t af)
>>>      int opt, s=3Dso->s;
>>>      struct sockaddr_storage addr;
>>>
>>> -    qemu_set_nonblock(s);
>>> +    so->slirp->cb->set_nonblock(s);
>>>      socket_set_fast_reuse(s);
>>>      opt =3D 1;
>>>      qemu_setsockopt(s, SOL_SOCKET, SO_OOBINLINE, &opt, sizeof(opt));
>>> @@ -484,7 +484,7 @@ void tcp_connect(struct socket *inso)
>>>          tcp_close(sototcpcb(so)); /* This will sofree() as well */
>>>          return;
>>>      }
>>> -    qemu_set_nonblock(s);
>>> +    so->slirp->cb->set_nonblock(s);
>>>      socket_set_fast_reuse(s);
>>>      opt =3D 1;
>>>      qemu_setsockopt(s, SOL_SOCKET, SO_OOBINLINE, &opt, sizeof(int));
>>>
>>
>>
>=20
>=20
