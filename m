Received: from eggs.gnu.org ([2001:4830:134:3::10]:59149)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jonasschievink@gmail.com>) id 1fdgFC-0002rx-T1
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 14:23:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jonasschievink@gmail.com>) id 1fdgFB-0004ZJ-Ab
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 14:23:10 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:33663)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jonasschievink@gmail.com>)
	id 1fdgFB-0004Vz-2T
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 14:23:09 -0400
Received: by mail-oi0-x244.google.com with SMTP id l10-v6so10861490oii.0
	for <qemu-devel@nongnu.org>; Thu, 12 Jul 2018 11:23:07 -0700 (PDT)
MIME-Version: 1.0
References: <5271d71e-794c-2db0-9046-183fd79dd902@amsat.org>
	<20180711221244.31869-1-jonasschievink@gmail.com>
	<5701803b-7f38-2539-fd08-6706d624271d@vivier.eu>
In-Reply-To: <5701803b-7f38-2539-fd08-6706d624271d@vivier.eu>
From: Jonas Schievink <jonasschievink@gmail.com>
Date: Thu, 12 Jul 2018 20:22:55 +0200
Message-ID: <CAJwA7S=wTPy2eY5D9q961-xh9N0bYAiF7LZRKFHqd9XqMnUV5w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] Zero out the host's `msg_control` buffer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Riku Voipio <riku.voipio@iki.fi>, qemu-devel@nongnu.org

Yes, I do. See
https://gist.github.com/jonas-schievink/cb6e6584a055539d2113f22d91068e2d

The problem is that glibc's CMSG_NXTHDR macro will access the header of the
*next* message which isn't yet overwritten by QEMU, so it still contains
garbage at that point. In particular, it will access the length field of
the header to check if the message fits inside the msg_control buffer. If
the length contains garbage, it may think that it doesn't fit and returns
NULL. This is also mentioned in the glibc bug report I linked in the
previous mail (https://sourceware.org/bugzilla/show_bug.cgi?id=3D13500), an=
d
the memset workaround is mentioned there as well.

Regards,
Jonas

On Thu, Jul 12, 2018 at 6:05 PM Laurent Vivier <laurent@vivier.eu> wrote:

> Le 12/07/2018 =C3=A0 00:12, Jonas Schievink a =C3=A9crit :
> > If this is not done, qemu would drop any control message after the firs=
t
> > one.
> >
> > This is because glibc's `CMSG_NXTHDR` macro accesses the uninitialized
> > cmsghdr's length field in order to find out if the message fits into th=
e
> > `msg_control` buffer, wrongly assuming that it doesn't because the
> > length field contains garbage. Accessing the length field is fine for
> > completed messages we receive from the kernel, but is - as far as I kno=
w
> > - not needed since the kernel won't return such an invalid cmsghdr in
> > the first place.
> >
> > This is tracked as this glibc bug:
> > https://sourceware.org/bugzilla/show_bug.cgi?id=3D13500
> >
> > It's probably also a good idea to bail with an error if `CMSG_NXTHDR`
> > returns NULL but `TARGET_CMSG_NXTHDR` doesn't (ie. we still expect
> > cmsgs).
> >
> > Signed-off-by: Jonas Schievink <jonasschievink@gmail.com>
> > ---
> > Changes in v2:
> > - put the memset right after the msg_control alloca
> > - added missing Signed-off-by line
> >
> >  linux-user/syscall.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> > index e4b1b7d7da..3c427500ef 100644
> > --- a/linux-user/syscall.c
> > +++ b/linux-user/syscall.c
> > @@ -3843,6 +3843,8 @@ static abi_long do_sendrecvmsg_locked(int fd,
> struct target_msghdr *msgp,
> >      }
> >      msg.msg_controllen =3D 2 * tswapal(msgp->msg_controllen);
> >      msg.msg_control =3D alloca(msg.msg_controllen);
> > +    memset(msg.msg_control, 0, msg.msg_controllen);
> > +
>
> I'm not sure it is needed as the content of msg.control will be
> overwritten by target_to_host_cmsg() from the content of msgp->control.
>
> Do you have a test case revealing the bug?
>
> Thanks,
> Laurent
>
