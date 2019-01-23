Received: from eggs.gnu.org ([209.51.188.92]:53080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmathieu@redhat.com>) id 1gmOuD-0008GJ-7B
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 15:13:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmathieu@redhat.com>) id 1gmOuB-0005a8-R2
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 15:13:49 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37815)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pmathieu@redhat.com>) id 1gmOuB-0005XX-I7
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 15:13:47 -0500
Received: by mail-wr1-f66.google.com with SMTP id s12so4003614wrt.4
	for <qemu-devel@nongnu.org>; Wed, 23 Jan 2019 12:13:46 -0800 (PST)
MIME-Version: 1.0
References: <20190121171543.32422-1-alex.bennee@linaro.org>
	<20190121171543.32422-3-alex.bennee@linaro.org>
	<7fdded47-e3df-4a36-aeca-76f05c470395@redhat.com>
In-Reply-To: <7fdded47-e3df-4a36-aeca-76f05c470395@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Wed, 23 Jan 2019 21:13:34 +0100
Message-ID: <CAP+75-Wpf_HPRo1pum5EFmi9+LKwddWyEbxfLnAoU_Mc9nxLFg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 2/3] tests/vm: add --build-target option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: kamil@netbsd.org, Brad Smith <brad@comstyle.com>, Fam Zheng <fam@euphon.net>

Hi Alex,

On Mon, Jan 21, 2019 at 11:54 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> On 1/21/19 6:15 PM, Alex Benn=C3=A9e wrote:
> > This allows us to invoke the build with a custom target (for the VMs
> > that use the {target} format string specifier). Currently OpenBSD is
> > still hardwired due to problems running check
> >
> > Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> > ---
> >  tests/vm/basevm.py | 3 +++
> >  tests/vm/freebsd   | 2 +-
> >  tests/vm/netbsd    | 3 +--
> >  3 files changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
> > index 5caf77d6b8..bdca6cb2fc 100755
> > --- a/tests/vm/basevm.py
> > +++ b/tests/vm/basevm.py
> > @@ -228,6 +228,8 @@ def parse_args(vmcls):
> >                        help=3D"build image")
> >      parser.add_option("--build-qemu",
> >                        help=3D"build QEMU from source in guest")
> > +    parser.add_option("--build-target",
> > +                      help=3D"QEMU build target", default=3D"check")
> >      parser.add_option("--interactive", "-I", action=3D"store_true",
> >                        help=3D"Interactively run command")
> >      parser.add_option("--snapshot", "-s", action=3D"store_true",
> > @@ -255,6 +257,7 @@ def main(vmcls):
> >              cmd =3D [vm.BUILD_SCRIPT.format(
> >                     configure_opts =3D " ".join(argv),
> >                     jobs=3Dargs.jobs,
> > +                   target=3Dargs.build_target,
> >                     verbose =3D "V=3D1" if args.verbose else "")]
> >          else:
> >              cmd =3D argv
> > diff --git a/tests/vm/freebsd b/tests/vm/freebsd
> > index a85c866c30..1d64c31b7c 100755
> > --- a/tests/vm/freebsd
> > +++ b/tests/vm/freebsd
> > @@ -25,7 +25,7 @@ class FreeBSDVM(basevm.BaseVM):
> >          cd $(mktemp -d /var/tmp/qemu-test.XXXXXX);
> >          tar -xf /dev/vtbd1;
> >          ./configure {configure_opts};
> > -        gmake --output-sync -j{jobs} check {verbose};
> > +        gmake --output-sync -j{jobs} {target} {verbose};
> >      """
> >
> >      def build_image(self, img):
> > diff --git a/tests/vm/netbsd b/tests/vm/netbsd
> > index fac6a7ce51..a2c3d13af4 100755
> > --- a/tests/vm/netbsd
> > +++ b/tests/vm/netbsd
> > @@ -25,8 +25,7 @@ class NetBSDVM(basevm.BaseVM):
> >          cd $(mktemp -d /var/tmp/qemu-test.XXXXXX);
> >          tar -xf /dev/rld1a;
> >          ./configure --python=3Dpython2.7 {configure_opts};
> > -        gmake --output-sync -j{jobs} {verbose};

Actually this change ^ belong to the previous patch, "call make check direc=
tly".

> > -        gmake --output-sync -j{jobs} check {verbose};
> > +        gmake --output-sync -j{jobs} {target} {verbose};
> >      """
> >
> >      def build_image(self, img):
> >
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
