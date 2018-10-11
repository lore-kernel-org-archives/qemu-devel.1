Received: from eggs.gnu.org ([2001:4830:134:3::10]:55831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gAkgx-0006Pg-Ht
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 19:48:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gAkgs-0006jq-U2
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 19:48:31 -0400
Received: from mail-yb1-f172.google.com ([209.85.219.172]:34068)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gAkgs-0006jO-Oh
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 19:48:26 -0400
Received: by mail-yb1-f172.google.com with SMTP id 184-v6so4311196ybg.1
	for <qemu-devel@nongnu.org>; Thu, 11 Oct 2018 16:48:26 -0700 (PDT)
MIME-Version: 1.0
References: <20180930232312.16486-1-f4bug@amsat.org>
	<20180930232312.16486-3-f4bug@amsat.org>
	<20181011024611.GB17357@magic>
In-Reply-To: <20181011024611.GB17357@magic>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 12 Oct 2018 01:48:14 +0200
Message-ID: <CAAdtpL6CbwwW4m9OnDQof_8iPiyttnbffRy_03Typt3hbdZLtw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/3] tests/vm: Do not abuse parallelism
 when KVM is not available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Thu, Oct 11, 2018 at 4:46 AM Fam Zheng <famz@redhat.com> wrote:
> On Mon, 10/01 01:23, Philippe Mathieu-Daud=C3=A9 wrote:
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> > ---
> > v2: Add get_default_jobs (Fam suggestion)
> > ---
> >  tests/vm/basevm.py | 13 ++++++++++---
> >  1 file changed, 10 insertions(+), 3 deletions(-)
> >
> > diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
> > index 5a5fa09752..fc203e9f53 100755
> > --- a/tests/vm/basevm.py
> > +++ b/tests/vm/basevm.py
> > @@ -202,6 +202,13 @@ class BaseVM(object):
> >          return self._guest.qmp(*args, **kwargs)
> >
> >  def parse_args(vm_name):
> > +
> > +    def get_default_jobs():
> > +        if kvm_available():
> > +            return multiprocessing.cpu_count() / 2
> > +        else:
> > +            return 1
> > +
> >      parser =3D optparse.OptionParser(
> >          description=3D"VM test utility.  Exit codes: "
> >                      "0 =3D success, "
> > @@ -214,7 +221,7 @@ def parse_args(vm_name):
> >                        help=3D"image file name")
> >      parser.add_option("--force", "-f", action=3D"store_true",
> >                        help=3D"force build image even if image exists")
> > -    parser.add_option("--jobs", type=3Dint, default=3Dmultiprocessing.=
cpu_count() / 2,
> > +    parser.add_option("--jobs", type=3Dint, default=3Dget_default_jobs=
(),
> >                        help=3D"number of virtual CPUs")
> >      parser.add_option("--verbose", "-V", action=3D"store_true",
> >                        help=3D"Pass V=3D1 to builds within the guest")
> > @@ -237,7 +244,7 @@ def main(vmcls):
> >              return 1
> >          logging.basicConfig(level=3D(logging.DEBUG if args.debug
> >                                     else logging.WARN))
> > -        vm =3D vmcls(debug=3Dargs.debug, vcpus=3Dargs.jobs)
> > +        vm =3D vmcls(debug=3Dargs.debug, vcpus=3Dargs.jobs if kvm_avai=
lable() else 0)
>
> What's wrong with just using args.jobs? It defaults to 1 if kvm_available=
()
> returns false, so I don't think we need another condition here.

You are right, I missed that.

>
> >          if args.build_image:
> >              if os.path.exists(args.image) and not args.force:
> >                  sys.stderr.writelines(["Image file exists: %s\n" % arg=
s.image,
> > @@ -248,7 +255,7 @@ def main(vmcls):
> >              vm.add_source_dir(args.build_qemu)
> >              cmd =3D [vm.BUILD_SCRIPT.format(
> >                     configure_opts =3D " ".join(argv),
> > -                   jobs=3Dargs.jobs,
> > +                   jobs=3Dargs.jobs if kvm_available() else 1,
>
> Again, can't we just use args.jobs?
>
> >                     verbose =3D "V=3D1" if args.verbose else "")]
> >          else:
> >              cmd =3D argv
> > --
> > 2.19.0
> >
>
> Fam
