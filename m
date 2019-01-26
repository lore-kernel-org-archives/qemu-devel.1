Received: from eggs.gnu.org ([209.51.188.92]:45882)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gnIXS-00053J-CU
	for qemu-devel@nongnu.org; Sat, 26 Jan 2019 02:38:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gnIXP-0004KI-ET
	for qemu-devel@nongnu.org; Sat, 26 Jan 2019 02:38:01 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:41913)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gnIXP-0004AT-62
	for qemu-devel@nongnu.org; Sat, 26 Jan 2019 02:37:59 -0500
Received: by mail-wr1-x444.google.com with SMTP id x10so12522316wrs.8
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 23:37:58 -0800 (PST)
MIME-Version: 1.0
References: <20190125140017.6092-1-alex.bennee@linaro.org>
	<20190125140017.6092-15-alex.bennee@linaro.org>
	<20190126033712.GQ4136@habkost.net>
In-Reply-To: <20190126033712.GQ4136@habkost.net>
From: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Date: Sat, 26 Jan 2019 07:37:45 +0000
Message-ID: <CAHDbmO38Z48eypv2b5R-+6huSY0zzzBGMrPb3+w5QQDo_o1gtw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 14/14] scripts/qemu.py: allow arches use
 KVM for their 32bit cousins
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Cleber Rosa <crosa@redhat.com>

Good point. I should fall through.

On Sat, 26 Jan 2019, 03:37 Eduardo Habkost <ehabkost@redhat.com wrote:

> On Fri, Jan 25, 2019 at 02:00:17PM +0000, Alex Benn=C3=A9e wrote:
> > A lot of architectures can run their 32 bit cousins on KVM so the
> > kvm_available function needs to be a little less restricting when
> > deciding if KVM is available.
> >
> > Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> > ---
> >  scripts/qemu.py | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/scripts/qemu.py b/scripts/qemu.py
> > index 0a5e02eb56..2934ee12c5 100644
> > --- a/scripts/qemu.py
> > +++ b/scripts/qemu.py
> > @@ -25,9 +25,18 @@ import tempfile
> >
> >  LOG =3D logging.getLogger(__name__)
> >
> > +# Mapping host architecture to any additional architectures it can
> > +# support which often includes its 32 bit cousin.
> > +ADDITIONAL_ARCHES =3D {
> > +    "x86_64" : "i386",
> > +    "aarch64" : "armhf"
> > +}
> >
> >  def kvm_available(target_arch=3DNone):
> > -    if target_arch and target_arch !=3D os.uname()[4]:
> > +    host_arch =3D os.uname()[4]
> > +    if target_arch and target_arch !=3D host_arch:
> > +        if target_arch =3D=3D ADDITIONAL_ARCHES[host_arch]:
>
> This will crash host_arch isn't "x86_64" or "aarch64".  I suggest
> ADDITIONAL_ARCHES.get(host_arch)
>
> > +            return True
>
> I don't think we should skip the /dev/kvm check here.
>
>
> >          return False
> >      return os.access("/dev/kvm", os.R_OK | os.W_OK)
> >
> > --
> > 2.17.1
> >
>
> --
> Eduardo
>
