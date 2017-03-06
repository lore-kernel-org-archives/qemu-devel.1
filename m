Received: from eggs.gnu.org ([2001:4830:134:3::10]:56055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ckhjE-0002tf-B4
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 20:46:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ckhjB-0000DN-8u
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 20:46:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37828)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1ckhjB-0000DF-2j
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 20:46:21 -0500
Date: Mon, 6 Mar 2017 09:46:16 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170306014616.GB31251@lemon.lan>
References: <20170304191230.11296-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170304191230.11296-1-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] tests/docker: support proxy / corporate
 firewall
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

On Sat, 03/04 16:12, Philippe Mathieu-Daud=E9 wrote:
> if FTP_PROXY/HTTP_PROXY/HTTPS_PROXY standard environment variables avai=
lable,
> pass them to the docker daemon to build images.
> this is required when building behind corporate proxy/firewall, but als=
o help
> when using local cache server (ie: apt/yum).
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> ---
>  tests/docker/docker.py | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/tests/docker/docker.py b/tests/docker/docker.py
> index 9fd32ab5fa..02bf9363e1 100755
> --- a/tests/docker/docker.py
> +++ b/tests/docker/docker.py
> @@ -22,12 +22,16 @@ import argparse
>  import tempfile
>  import re
>  import signal
> +import string
>  from tarfile import TarFile, TarInfo
>  from StringIO import StringIO
>  from shutil import copy, rmtree
>  from pwd import getpwuid
> =20
> =20
> +FILTERED_ENV_NAMES =3D ['FTP_PROXY', 'HTTP_PROXY', 'HTTPS_PROXY']
> +
> +
>  DEVNULL =3D open(os.devnull, 'wb')
> =20
> =20
> @@ -272,6 +276,12 @@ class BuildCommand(SubCommand):
>                  _copy_binary_with_libs(args.include_executable,
>                                         docker_dir)
> =20
> +            filtered_keys =3D map(string.upper, FILTERED_ENV_NAMES)
> +            filtered_keys +=3D map(string.lower, FILTERED_ENV_NAMES)
> +            for filtered_key in filtered_keys:
> +                if filtered_key in os.environ.keys():
> +                    argv +=3D ["--build-arg=3D" + filtered_key +
> +                                "=3D" + os.environ[filtered_key]]

Makes sense.

Could you simplify the above hunk as

    args +=3D ["--build-arg=3D" + k + "=3D" + v for k, v in \
                os.environ.iteritems() if k.upper() in FILTERED_ENV_NAMES=
]

then 'import string' is not necessary.

Fam

>              dkr.build_image(tag, docker_dir, dockerfile,
>                              quiet=3Dargs.quiet, user=3Dargs.user, argv=
=3Dargv)
> =20
> --=20
> 2.11.0
>=20
>=20
