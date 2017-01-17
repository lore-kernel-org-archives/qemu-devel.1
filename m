Received: from eggs.gnu.org ([2001:4830:134:3::10]:59591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cTQOu-0000fO-1v
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 04:50:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cTQOr-0003jP-Oe
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 04:50:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46420)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1cTQOr-0003iB-G5
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 04:49:57 -0500
Date: Tue, 17 Jan 2017 17:49:53 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170117094953.GA6199@lemon>
References: <20161213132205.9114-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20161213132205.9114-1-alex.bennee@linaro.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH] tests/docker: add basic user mapping
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: bobby.prani@gmail.com, qemu-devel@nongnu.org

On Tue, 12/13 13:22, Alex Benn=E9e wrote:
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

Sorry for the late reply!

>=20
> Signed-off-by: Alex Benn=E9e <alex.bennee@linaro.org>
> ---
>  tests/docker/docker.py                           | 19 ++++++++++++++++=
+++
>  tests/docker/dockerfiles/debian-bootstrap.docker |  3 +++
>  2 files changed, 22 insertions(+)
>=20
> diff --git a/tests/docker/docker.py b/tests/docker/docker.py
> index 37d83199e7..59baac6bae 100755
> --- a/tests/docker/docker.py
> +++ b/tests/docker/docker.py
> @@ -12,6 +12,7 @@
>  # the top-level directory.
> =20
>  import os
> +import stat
>  import sys
>  import subprocess
>  import json
> @@ -25,6 +26,7 @@ import signal
>  from tarfile import TarFile, TarInfo
>  from StringIO import StringIO
>  from shutil import copy, rmtree
> +from pwd import getpwuid
> =20
> =20
>  DEVNULL =3D open(os.devnull, 'wb')
> @@ -225,6 +227,8 @@ class BuildCommand(SubCommand):
>                              help=3D"""Specify a binary that will be co=
pied to the
>                              container together with all its dependent
>                              libraries""")
> +        parser.add_argument("--user", "-u", action=3D"store_true",
> +                            help=3D"Add the current user to images pas=
swd")

Maybe use --add-current-user for the full argument name?

>          parser.add_argument("tag",
>                              help=3D"Image Tag")
>          parser.add_argument("dockerfile",
> @@ -260,6 +264,21 @@ class BuildCommand(SubCommand):
>                  _copy_binary_with_libs(args.include_executable,
>                                         docker_dir)
> =20
> +            if args.user:
> +                uid =3D os.getuid()
> +                uname =3D getpwuid(uid).pw_name
> +                scriptlet =3D docker_dir+"/setup_user.sh"
> +
> +                # write scriptlet
> +                setup =3D open(scriptlet, "w")
> +                setup.write("#!/bin/sh\n")
> +                setup.write("useradd -u %d -U %s" % (uid, uname))
> +                setup.close()
> +
> +                st =3D os.stat(scriptlet)
> +                os.chmod(scriptlet,
> +                         st.st_mode | stat.S_IXUSR | stat.S_IXGRP | st=
at.S_IXOTH)

Is it cleaner we inject commands into the docker file directly?

> +
>              dkr.build_image(tag, docker_dir, dockerfile,
>                              quiet=3Dargs.quiet, argv=3Dargv)
> =20
> diff --git a/tests/docker/dockerfiles/debian-bootstrap.docker b/tests/d=
ocker/dockerfiles/debian-bootstrap.docker
> index 3a9125e497..127782eedf 100644
> --- a/tests/docker/dockerfiles/debian-bootstrap.docker
> +++ b/tests/docker/dockerfiles/debian-bootstrap.docker
> @@ -14,6 +14,9 @@ RUN sed -i 's/in_target mount/echo not for docker in_=
target mount/g' /debootstra
>  # Run stage 2
>  RUN /debootstrap/debootstrap --second-stage
> =20
> +# Do we want to tweak the user?
> +RUN if test -e /setup_user.sh; then /setup_user.sh; fi

If we do above, there is no need to manually add this in dockerfile.

> +
>  # At this point we can install additional packages if we want
>  # Duplicate deb line as deb-src
>  RUN cat /etc/apt/sources.list | sed "s/deb/deb-src/" >> /etc/apt/sourc=
es.list
> --=20
> 2.11.0
>=20
>=20

Fam
