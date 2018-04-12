Received: from eggs.gnu.org ([2001:4830:134:3::10]:37057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1f6XHD-00053Q-1y
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 04:08:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1f6XH9-0004IJ-2Z
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 04:08:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37288 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1f6XH8-0004Hy-Tl
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 04:08:10 -0400
Date: Thu, 12 Apr 2018 16:07:59 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180412080759.GB24896@lemon.usersys.redhat.com>
References: <20180410193919.28026-1-alex.bennee@linaro.org>
	<20180410193919.28026-7-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180410193919.28026-7-alex.bennee@linaro.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 06/24] docker: extend "cc" command to
 accept compiler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, cota@braap.org, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>

On Tue, 04/10 20:39, Alex Benn=E9e wrote:
> When calling our cross-compilation images we want to call something
> other than the default cc.

Makes sense to me!

>=20
> Signed-off-by: Alex Benn=E9e <alex.bennee@linaro.org>
> ---
>  tests/docker/docker.py | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
>=20
> diff --git a/tests/docker/docker.py b/tests/docker/docker.py
> index 8733266153..9444f4bea4 100755
> --- a/tests/docker/docker.py
> +++ b/tests/docker/docker.py
> @@ -397,6 +397,8 @@ class CcCommand(SubCommand):
>      def args(self, parser):
>          parser.add_argument("--image", "-i", required=3DTrue,
>                              help=3D"The docker image in which to run c=
c")
> +        parser.add_argument("--cc",
> +                            help=3D"The compiler executable to call")

If add "default=3D'cc'" to this call, we don't need the 'if args.cc' chec=
k below.

>          parser.add_argument("--source-path", "-s", nargs=3D"*", dest=3D=
"paths",
>                              help=3D"""Extra paths to (ro) mount into c=
ontainer for
>                              reading sources""")
> @@ -407,9 +409,19 @@ class CcCommand(SubCommand):
>          cwd =3D os.getcwd()
>          cmd =3D ["--rm", "-w", cwd,
>                 "-v", "%s:%s:rw" % (cwd, cwd)]
> -        for p in args.paths:
> -           cmd +=3D ["-v", "%s:%s:ro,z" % (p, p)]
> -        cmd +=3D [args.image, "cc"]
> +
> +        if args.paths:
> +            for p in args.paths:
> +                cmd +=3D ["-v", "%s:%s:ro,z" % (p, p)]

I'm not sure the introduction of this if condition belongs to this patch,=
 or is
necessary at all. Could you confirm?

Thanks.

Fam

> +
> +        cmd +=3D [args.image]
> +
> +        # The compile command we are running
> +        if args.cc:
> +            cmd +=3D [args.cc]
> +        else:
> +            cmd +=3D ["cc"]
> +
>          cmd +=3D argv
>          return Docker().command("run", cmd, True)
> =20
> --=20
> 2.16.2
>=20
