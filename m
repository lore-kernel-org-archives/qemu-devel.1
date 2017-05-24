Received: from eggs.gnu.org ([2001:4830:134:3::10]:55987)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dDOjj-0000Lk-FX
	for qemu-devel@nongnu.org; Wed, 24 May 2017 01:21:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dDOjf-0007Pk-Cs
	for qemu-devel@nongnu.org; Wed, 24 May 2017 01:21:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55686)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dDOjf-0007Pa-3j
	for qemu-devel@nongnu.org; Wed, 24 May 2017 01:21:27 -0400
Date: Wed, 24 May 2017 13:21:23 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170524052123.GJ12279@lemon.lan>
References: <20170521032956.27446-1-f4bug@amsat.org>
	<20170521032956.27446-3-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170521032956.27446-3-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 02/24] docker: add --include-files
 argument to 'build' command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>

On Sun, 05/21 00:29, Philippe Mathieu-Daud=E9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> ---
>  tests/docker/Makefile.include |  5 ++++-
>  tests/docker/docker.py        | 12 +++++++++---
>  2 files changed, 13 insertions(+), 4 deletions(-)
>=20
> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.incl=
ude
> index 03eda37bf4..fe1a9a53ff 100644
> --- a/tests/docker/Makefile.include
> +++ b/tests/docker/Makefile.include
> @@ -51,6 +51,7 @@ docker-image-%: $(DOCKER_FILES_DIR)/%.docker
>  		$(SRC_PATH)/tests/docker/docker.py build qemu:$* $< \
>  		$(if $V,,--quiet) $(if $(NOCACHE),--no-cache) \
>  		$(if $(NOUSER),,--add-current-user) \
> +		$(if $(EXTRA_FILES),--extra-files $(EXTRA_FILES))\
>  		$(if $(EXECUTABLE),--include-executable=3D$(EXECUTABLE)),\
>  		"BUILD","$*")
> =20
> @@ -107,6 +108,8 @@ docker:
>  	@echo '    NOUSER               Define to disable adding current user=
 to containers passwd.'
>  	@echo '    NOCACHE=3D1            Ignore cache when build images.'
>  	@echo '    EXECUTABLE=3D<path>    Include executable in image.'
> +	@echo '    EXTRA_FILES=3D"<path> [... <path>]"'
> +	@echo '                         Include extra files in image.'
> =20
>  # This rule if for directly running against an arbitrary docker target=
.
>  # It is called by the expanded docker targets (e.g. make
> diff --git a/tests/docker/docker.py b/tests/docker/docker.py
> index 6ddc6e4c2a..68cca25f89 100755
> --- a/tests/docker/docker.py
> +++ b/tests/docker/docker.py
> @@ -237,6 +237,11 @@ class BuildCommand(SubCommand):
>                              help=3D"""Specify a binary that will be co=
pied to the
>                              container together with all its dependent
>                              libraries""")
> +        parser.add_argument("--extra-files", "-f", nargs=3D'*',
> +                            help=3D"""Specify files that will be sent =
to the
> +                            Docker daemon. The daemon will copy those =
files into
> +                            the built image. The ADD directive of the =
Dockerfile
> +                            specify where a file is placed into the im=
age""")

Or more precisely, "The daemon will copy these files into the docker buil=
d
directory, which can be copied to the built image with ADD directives in
Dockerfile"?

>          parser.add_argument("--add-current-user", "-u", dest=3D"user",
>                              action=3D"store_true",
>                              help=3D"Add the current user to image's pa=
sswd")
> @@ -270,10 +275,11 @@ class BuildCommand(SubCommand):
>                      print "%s exited with code %d" % (docker_pre, rc)
>                      return 1
> =20
> -            # Do we include a extra binary?
> +            # Include files used by ADD directives found within the Do=
ckerfile.
>              if args.include_executable:
> -                _copy_binary_with_libs(args.include_executable,
> -                                       docker_dir)
> +                _copy_binary_with_libs(args.include_executable, docker=
_dir)
> +            for filename in args.extra_files or []:
> +                _copy_with_mkdir(filename, docker_dir)
> =20
>              argv +=3D ["--build-arg=3D" + k.lower() + "=3D" + v
>                          for k, v in os.environ.iteritems()
> --=20
> 2.11.0
>=20
