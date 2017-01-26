Received: from eggs.gnu.org ([2001:4830:134:3::10]:59921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cWg2l-0000Df-C9
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 04:08:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cWg2k-0008FN-Cq
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 04:08:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46140)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1cWg2k-0008FF-4T
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 04:08:34 -0500
Date: Thu, 26 Jan 2017 17:08:29 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170126090829.GG6879@lemon>
References: <20170124143346.22240-1-alex.bennee@linaro.org>
	<20170124143346.22240-5-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170124143346.22240-5-alex.bennee@linaro.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 4/7] tests/docker: add basic user
 mapping support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: "open list:All patches CC here" <qemu-devel@nongnu.org>

On Tue, 01/24 14:33, Alex Benn=E9e wrote:
> Currently all docker builds are done by exporting a tarball to the
> docker container and running the build as the containers root user.
> Other use cases are possible however and it is possible to map a part
> of users file-system to the container. This is useful for example for
> doing cross-builds of arbitrary source trees. For this to work
> smoothly the container needs to have a user created that maps cleanly
> to the host system.
>=20
> This adds a -u option to the docker script so that:
>=20
>   DEB_ARCH=3Darmhf DEB_TYPE=3Dstable ./tests/docker/docker.py build \
>     -u --include-executable=3Darm-linux-user/qemu-arm \
>     debian:armhf ./tests/docker/dockerfiles/debian-bootstrap.docker
>=20
> Will build a container that can then be run like:
>=20
>   docker run --rm -it -v /home/alex/lsrc/qemu/risu.git/:/src \
>     --user=3Dalex:alex -w /src/ debian:armhf \
>     sh -c "make clean && ./configure -s && make"
>=20
> Signed-off-by: Alex Benn=E9e <alex.bennee@linaro.org>
>=20
> ---
> v2
>   - write the useradd directly
>   - change long option to --add-current-user
> ---
>  tests/docker/docker.py | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>=20
> diff --git a/tests/docker/docker.py b/tests/docker/docker.py
> index 37d83199e7..b85739a9e2 100755
> --- a/tests/docker/docker.py
> +++ b/tests/docker/docker.py
> @@ -25,6 +25,7 @@ import signal
>  from tarfile import TarFile, TarInfo
>  from StringIO import StringIO
>  from shutil import copy, rmtree
> +from pwd import getpwuid
> =20
> =20
>  DEVNULL =3D open(os.devnull, 'wb')
> @@ -149,13 +150,20 @@ class Docker(object):
>          labels =3D json.loads(resp)[0]["Config"].get("Labels", {})
>          return labels.get("com.qemu.dockerfile-checksum", "")
> =20
> -    def build_image(self, tag, docker_dir, dockerfile, quiet=3DTrue, a=
rgv=3DNone):
> +    def build_image(self, tag, docker_dir, dockerfile,
> +                    quiet=3DTrue, user=3DFalse, argv=3DNone):
>          if argv =3D=3D None:
>              argv =3D []
> =20
>          tmp_df =3D tempfile.NamedTemporaryFile(dir=3Ddocker_dir, suffi=
x=3D".docker")
>          tmp_df.write(dockerfile)
> =20
> +        if user:
> +            uid =3D os.getuid()
> +            uname =3D getpwuid(uid).pw_name
> +            tmp_df.write("\n")
> +            tmp_df.write("RUN useradd -u %d -U %s" % (uid, uname))
> +
>          tmp_df.write("\n")
>          tmp_df.write("LABEL com.qemu.dockerfile-checksum=3D%s" %
>                       _text_checksum(dockerfile))
> @@ -225,6 +233,9 @@ class BuildCommand(SubCommand):
>                              help=3D"""Specify a binary that will be co=
pied to the
>                              container together with all its dependent
>                              libraries""")
> +        parser.add_argument("--add-current-user", "-u", dest=3D"user",
> +                            action=3D"store_true",
> +                            help=3D"Add the current user to images pas=
swd")

s/images/image's/ ?

otherwise looks good. If you fix that, you can add

Reviewed-by: Fam Zheng <famz@redhat.com>

>          parser.add_argument("tag",
>                              help=3D"Image Tag")
>          parser.add_argument("dockerfile",
> @@ -261,7 +272,7 @@ class BuildCommand(SubCommand):
>                                         docker_dir)
> =20
>              dkr.build_image(tag, docker_dir, dockerfile,
> -                            quiet=3Dargs.quiet, argv=3Dargv)
> +                            quiet=3Dargs.quiet, user=3Dargs.user, argv=
=3Dargv)
> =20
>              rmtree(docker_dir)
> =20
> --=20
> 2.11.0
>=20
>=20
