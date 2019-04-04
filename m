Received: from eggs.gnu.org ([209.51.188.92]:50794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hBrZh-0003RA-5W
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 21:53:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hBrZd-0001wP-MP
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 21:53:50 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:36985)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hBrZc-0001br-2M
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 21:53:49 -0400
Received: by mail-oi1-x244.google.com with SMTP id v84so566364oif.4
	for <qemu-devel@nongnu.org>; Wed, 03 Apr 2019 18:53:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190403124948.GA14129@ls3530.dellerweb.de>
	<20190403161729.GW25150@redhat.com>
In-Reply-To: <20190403161729.GW25150@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 4 Apr 2019 08:53:26 +0700
Message-ID: <CAFEAcA-85Z9wtZrf2AddGkrPZFOPgxFZ5sNOZCCBkqZRp8M2Dg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] configure: Relax check for libseccomp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Helge Deller <deller@gmx.de>, Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On Wed, 3 Apr 2019 at 23:27, Daniel P. Berrang=C3=A9 <berrange@redhat.com> =
wrote:
>
> On Wed, Apr 03, 2019 at 02:49:48PM +0200, Helge Deller wrote:
> > diff --git a/configure b/configure
> > index 1c563a7027..8632267049 100755
> > --- a/configure
> > +++ b/configure
> > @@ -2389,7 +2389,6 @@ if test "$seccomp" !=3D "no" ; then
> >          libseccomp_minver=3D"2.3.0"
> >          ;;
> >      *)
> > -        libseccomp_minver=3D""
> >          ;;
> >      esac
>
> This makes sense to me. From a QEMU source POV we are able to build with
> libseccomp >=3D 2.2.0, which our default libseccomp_minver=3D env express=
es
> a few lines earlier.
>
> If libseccomp isn't supported on a platform, then I think we should just
> assume that libseccomp won't be present in the OS install we are building
> against. I don't think QEMU needs to second-guess whether or not it is
> supported on the given architecture.

If we want to do this then we should handle all the archs which
don't need to special case the seccomp version identically, ie
remove the x86/mips case which with this patch would be the
same as the default case.

> In fact I'd go as far as to say we
> could probably just remove all this per-arch checking and just have a
> generic >=3D 2.2.0 check, and just rely on fact libseccomp won't exist
> on a s390/ppc/etc host if the distro had version < 2.3.0

The arm case at least is present because libseccomp 2.2.0 was
being built but didn't actually work for us. See commit ae6e8ef11e6cb43ec83=
.

thanks
-- PMM
