Received: from eggs.gnu.org ([2001:4830:134:3::10]:37443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1filNh-0007JP-F7
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 14:52:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1filNg-0005eC-7j
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 14:52:57 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:52147)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1filNf-0005dY-Rd
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 14:52:56 -0400
Received: by mail-wm0-x244.google.com with SMTP id y2-v6so2959412wma.1
	for <qemu-devel@nongnu.org>; Thu, 26 Jul 2018 11:52:55 -0700 (PDT)
MIME-Version: 1.0
References: <20180726132947.28538-1-alex.bennee@linaro.org>
	<20180726132947.28538-2-alex.bennee@linaro.org>
	<a2dd4939-3fd3-31dd-7763-c96b1b627c21@vivier.eu>
	<87va91swu1.fsf@linaro.org>
	<a77ed37b-e8b0-6c39-8975-75ae5353db78@vivier.eu>
In-Reply-To: <a77ed37b-e8b0-6c39-8975-75ae5353db78@vivier.eu>
From: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Date: Thu, 26 Jul 2018 19:52:42 +0100
Message-ID: <CAHDbmO1VJDNQW8bPckFc+=gePctyH=9g_=ZQ3rdq=ccJRQJ0iw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 for 3.0 1/2] linux-user/mmap.c: handle
 len = 0 maps correctly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, 1783362@bugs.launchpad.net, Riku Voipio <riku.voipio@iki.fi>

Will do, thanks!

On Thu, 26 Jul 2018 at 19:12, Laurent Vivier <laurent@vivier.eu> wrote:

> Le 26/07/2018 =C3=A0 19:58, Alex Benn=C3=A9e a =C3=A9crit :
> >
> > Laurent Vivier <laurent@vivier.eu> writes:
> >
> >> Le 26/07/2018 =C3=A0 15:29, Alex Benn=C3=A9e a =C3=A9crit:
> >>> I've slightly re-organised the check to more closely match the
> >>> sequence that the kernel uses in do_mmap().
> >>>
> >>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> >>> Cc: umarcor <1783362@bugs.launchpad.net>
> >>> ---
> >>>  linux-user/mmap.c | 14 +++++++++++---
> >>>  1 file changed, 11 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/linux-user/mmap.c b/linux-user/mmap.c
> >>> index d0c50e4888..3ef69fa2d0 100644
> >>> --- a/linux-user/mmap.c
> >>> +++ b/linux-user/mmap.c
> >>> @@ -391,14 +391,22 @@ abi_long target_mmap(abi_ulong start, abi_ulong
> len, int prot,
> >>>      }
> >>>  #endif
> >>>
> >>> -    if (offset & ~TARGET_PAGE_MASK) {
> >>> +    if (!len) {
> >>>          errno =3D EINVAL;
> >>>          goto fail;
> >>>      }
> >>>
> >>>      len =3D TARGET_PAGE_ALIGN(len);
> >>> -    if (len =3D=3D 0)
> >>> -        goto the_end;
> >>> +    if (!len) {
> >>> +        errno =3D EINVAL;
> >>> +        goto fail;
> >>> +    }
> >>
> >> Why do you check twice len?
> >> TARGET_PAGE_ALIGN() rounds up the value, so if it was not 0, it cannot
> >> be now.
> >
> > I was trying to follow the kernel style but I realise TARGET_PAGE_ALIGN
> > might be a different test compared to the kernel's PAGE_ALIGN(len) for
> > overflows:
> ...
> >       /* Careful about overflows.. */
> >       len =3D PAGE_ALIGN(len);
> >       if (!len)
> >               return -ENOMEM;
> >
>
>
> OK, so keep it but you should use ENOMEM, not EINVAL (and add a comment :=
)
> )
>
> Thanks,
> Laurent
>


--=20
Alex Benn=C3=A9e
KVM/QEMU Hacker for Linaro
