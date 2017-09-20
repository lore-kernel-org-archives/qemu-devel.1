Received: from eggs.gnu.org ([2001:4830:134:3::10]:34227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1duhe3-0003H0-I7
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 12:14:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1duhe2-0003Bd-EM
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 12:14:39 -0400
Received: from mail-io0-x242.google.com ([2607:f8b0:4001:c06::242]:35982)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1duhe2-00038Y-9Z
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 12:14:38 -0400
Received: by mail-io0-x242.google.com with SMTP id n69so2276300ioi.3
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 09:14:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170920150903.arckboulxo7o72d4@dhcp-192-218.str.redhat.com>
References: <20170808203900.7661-1-jfreimann@redhat.com>
	<20170808203900.7661-4-jfreimann@redhat.com>
	<CAJ+F1C+1WzPe4Z6DDZyn308VV+D7AjVob2VseWK+0FFpiY2NsA@mail.gmail.com>
	<20170920150903.arckboulxo7o72d4@dhcp-192-218.str.redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 20 Sep 2017 18:14:33 +0200
Message-ID: <CAJ+F1CJVZxt3pWW1GEuy+0KNab4wxY4wc8A-raMPzTF5Qq_G4Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 3/5] libvhost-user: quit when no more
 data received
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jens Freimann <jfreimann@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Victor Kaplansky <victork@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On Wed, Sep 20, 2017 at 5:09 PM, Jens Freimann <jfreimann@redhat.com> wrote=
:
> On Tue, Sep 19, 2017 at 04:46:24PM +0000, Marc-Andr?? Lureau wrote:
>>
>> Hi
>>
>> On Tue, Aug 8, 2017 at 10:52 PM Jens Freimann <jfreimann@redhat.com>
>> wrote:
>>>
>>>
>>> From: Jens Freimann <jfreiman@redhat.com>
>>>
>>> End processing of messages when VHOST_USER_NONE
>>> is received.
>>>
>>> Without this we run into a vubr_panic() call and get
>>> "PANIC: Unhandled request: 0"
>>>
>>> Signed-off-by: Jens Freimann <jfreiman@redhat.com>
>>> ---
>>>  contrib/libvhost-user/libvhost-user.c | 4 +++-
>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/contrib/libvhost-user/libvhost-user.c
>>> b/contrib/libvhost-user/libvhost-user.c
>>> index 9efb9dac0e..35fa0c5e56 100644
>>> --- a/contrib/libvhost-user/libvhost-user.c
>>> +++ b/contrib/libvhost-user/libvhost-user.c
>>> @@ -161,7 +161,7 @@ vu_message_read(VuDev *dev, int conn_fd, VhostUserM=
sg
>>> *vmsg)
>>>          rc =3D recvmsg(conn_fd, &msg, 0);
>>>      } while (rc < 0 && (errno =3D=3D EINTR || errno =3D=3D EAGAIN));
>>>
>>> -    if (rc <=3D 0) {
>>> +    if (rc < 0) {
>>>          vu_panic(dev, "Error while recvmsg: %s", strerror(errno));
>>>          return false;
>>>      }
>>> @@ -806,6 +806,8 @@ vu_process_message(VuDev *dev, VhostUserMsg *vmsg)
>>>          return vu_get_queue_num_exec(dev, vmsg);
>>>      case VHOST_USER_SET_VRING_ENABLE:
>>>          return vu_set_vring_enable_exec(dev, vmsg);
>>> +    case VHOST_USER_NONE:
>>> +        break;
>>
>>
>>
>> I am afraid this isn't working. vu_message_read() returns
>> true/success, vu_process_message() returns false/no-reply, so
>> vu_dispatch() will return success, and the caller has no clear way to
>> know that the socket got disconnected. For me the vu_panic() was quite
>> more appropriate here.
>>
>> What problem did this patch exactly solve?
>
>
> The problem was that a VhostUserMsg of size 0 is considered an
> error. But recvmsg() can return 0. When I ran my pxe

When did recvmsg() return 0? It should only be called after a poll
IN/ERR, in case of data it should always return !=3D 0, and if
disconnected, it returns 0.

> testcase using vhost-user-bridge I ran into vu_panic() because of this.
> This worked because VHOST_USER_NONE is defined as 0. Instead of
> doing this we could just allow a vmsg size of zero and not tread it
> as an error?

We want to treat disconnect as a panic condition imho, that the
library user is free to implement in different way (abort() clean
exit, reconnect etc).

Please explain your use case and how you ran into recvmsg() =3D 0 and
what you expect to happen at this point.

--=20
Marc-Andr=C3=A9 Lureau
