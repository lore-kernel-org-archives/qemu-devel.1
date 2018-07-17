Received: from eggs.gnu.org ([2001:4830:134:3::10]:49336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ffQB5-0003y8-7t
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 09:38:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ffQB1-0003sP-An
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 09:38:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37470 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1ffQB1-0003qW-3S
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 09:38:03 -0400
Date: Tue, 17 Jul 2018 21:37:57 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180717133757.GA8120@lemon.usersys.redhat.com>
References: <20180717024827.27897-1-f4bug@amsat.org>
	<20180717024827.27897-4-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180717024827.27897-4-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/5] tests/vm: Do not abuse parallelism
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

On Mon, 07/16 23:48, Philippe Mathieu-Daud=E9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> ---
>  tests/vm/basevm.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
> index 1f4ad04c32..715e433142 100755
> --- a/tests/vm/basevm.py
> +++ b/tests/vm/basevm.py
> @@ -233,7 +233,7 @@ def main(vmcls):
>              return 1
>          logging.basicConfig(level=3D(logging.DEBUG if args.debug
>                                     else logging.WARN))
> -        vm =3D vmcls(debug=3Dargs.debug, vcpus=3Dargs.jobs)
> +        vm =3D vmcls(debug=3Dargs.debug, vcpus=3Dargs.jobs if kvm_avai=
lable() else 0)
>          if args.build_image:
>              if os.path.exists(args.image) and not args.force:
>                  sys.stderr.writelines(["Image file exists: %s\n" % arg=
s.image,
> @@ -244,7 +244,7 @@ def main(vmcls):
>              vm.add_source_dir(args.build_qemu)
>              cmd =3D [vm.BUILD_SCRIPT.format(
>                     configure_opts =3D " ".join(argv),
> -                   jobs=3Dargs.jobs)]
> +                   jobs=3Dargs.jobs if kvm_available() else 1)]
>          else:
>              cmd =3D argv
>          vm.boot(args.image + ",snapshot=3Don")
> --=20
> 2.18.0
>=20

Could you instead change this line

    parser.add_option("--jobs", type=3Dint, default=3Dmultiprocessing.cpu=
_count() / 2,
                      help=3D"number of virtual CPUs")

to use kvm_available()? With another helper function to contain the line =
width,
probably:

    ..., default=3Dget_default_jobs(), help=3D...

and

    def get_default_jobs():
        if kvm_available():
            return ...
        else:
            return ...

Fam
