Received: from eggs.gnu.org ([2001:4830:134:3::10]:54156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1gAQzk-0004f1-1c
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 22:46:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1gAQzg-0006qO-QX
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 22:46:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39430)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1gAQzb-0006XW-71
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 22:46:29 -0400
Date: Thu, 11 Oct 2018 10:46:11 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20181011024611.GB17357@magic>
References: <20180930232312.16486-1-f4bug@amsat.org>
	<20180930232312.16486-3-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180930232312.16486-3-f4bug@amsat.org>
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
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org

On Mon, 10/01 01:23, Philippe Mathieu-Daud=E9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> ---
> v2: Add get_default_jobs (Fam suggestion)
> ---
>  tests/vm/basevm.py | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>=20
> diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
> index 5a5fa09752..fc203e9f53 100755
> --- a/tests/vm/basevm.py
> +++ b/tests/vm/basevm.py
> @@ -202,6 +202,13 @@ class BaseVM(object):
>          return self._guest.qmp(*args, **kwargs)
> =20
>  def parse_args(vm_name):
> +
> +    def get_default_jobs():
> +        if kvm_available():
> +            return multiprocessing.cpu_count() / 2
> +        else:
> +            return 1
> +
>      parser =3D optparse.OptionParser(
>          description=3D"VM test utility.  Exit codes: "
>                      "0 =3D success, "
> @@ -214,7 +221,7 @@ def parse_args(vm_name):
>                        help=3D"image file name")
>      parser.add_option("--force", "-f", action=3D"store_true",
>                        help=3D"force build image even if image exists")
> -    parser.add_option("--jobs", type=3Dint, default=3Dmultiprocessing.=
cpu_count() / 2,
> +    parser.add_option("--jobs", type=3Dint, default=3Dget_default_jobs=
(),
>                        help=3D"number of virtual CPUs")
>      parser.add_option("--verbose", "-V", action=3D"store_true",
>                        help=3D"Pass V=3D1 to builds within the guest")
> @@ -237,7 +244,7 @@ def main(vmcls):
>              return 1
>          logging.basicConfig(level=3D(logging.DEBUG if args.debug
>                                     else logging.WARN))
> -        vm =3D vmcls(debug=3Dargs.debug, vcpus=3Dargs.jobs)
> +        vm =3D vmcls(debug=3Dargs.debug, vcpus=3Dargs.jobs if kvm_avai=
lable() else 0)

What's wrong with just using args.jobs? It defaults to 1 if kvm_available=
()
returns false, so I don't think we need another condition here.

>          if args.build_image:
>              if os.path.exists(args.image) and not args.force:
>                  sys.stderr.writelines(["Image file exists: %s\n" % arg=
s.image,
> @@ -248,7 +255,7 @@ def main(vmcls):
>              vm.add_source_dir(args.build_qemu)
>              cmd =3D [vm.BUILD_SCRIPT.format(
>                     configure_opts =3D " ".join(argv),
> -                   jobs=3Dargs.jobs,
> +                   jobs=3Dargs.jobs if kvm_available() else 1,

Again, can't we just use args.jobs?

>                     verbose =3D "V=3D1" if args.verbose else "")]
>          else:
>              cmd =3D argv
> --=20
> 2.19.0
>=20

Fam
