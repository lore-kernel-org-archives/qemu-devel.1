Received: from eggs.gnu.org ([2001:4830:134:3::10]:60131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d7wKx-0004Nr-IN
	for qemu-devel@nongnu.org; Tue, 09 May 2017 00:01:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d7wKu-0008Ft-GL
	for qemu-devel@nongnu.org; Tue, 09 May 2017 00:01:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41684)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1d7wKu-0008FV-7D
	for qemu-devel@nongnu.org; Tue, 09 May 2017 00:01:20 -0400
Date: Tue, 9 May 2017 12:01:15 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170509040115.GA18973@lemon.lan>
References: <20170508221759.15616-1-f4bug@amsat.org>
	<20170508221759.15616-3-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170508221759.15616-3-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 02/21] docker: add --include-file
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

On Mon, 05/08 19:17, Philippe Mathieu-Daud=E9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> ---
>  tests/docker/Makefile.include | 3 ++-
>  tests/docker/docker.py        | 5 +++++
>  2 files changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.incl=
ude
> index 03eda37bf4..c99ce702ea 100644
> --- a/tests/docker/Makefile.include
> +++ b/tests/docker/Makefile.include
> @@ -51,7 +51,8 @@ docker-image-%: $(DOCKER_FILES_DIR)/%.docker
>  		$(SRC_PATH)/tests/docker/docker.py build qemu:$* $< \
>  		$(if $V,,--quiet) $(if $(NOCACHE),--no-cache) \
>  		$(if $(NOUSER),,--add-current-user) \
> -		$(if $(EXECUTABLE),--include-executable=3D$(EXECUTABLE)),\
> +		$(if $(EXECUTABLE),--include-executable=3D$(EXECUTABLE))\
> +		$(if $(EXTRA_FILE),--include-file=3D$(EXTRA_FILE)),\
>  		"BUILD","$*")
> =20
>  # Enforce dependancies for composite images
> diff --git a/tests/docker/docker.py b/tests/docker/docker.py
> index 6ddc6e4c2a..90520e4bca 100755
> --- a/tests/docker/docker.py
> +++ b/tests/docker/docker.py
> @@ -237,6 +237,9 @@ class BuildCommand(SubCommand):
>                              help=3D"""Specify a binary that will be co=
pied to the
>                              container together with all its dependent
>                              libraries""")
> +        parser.add_argument("--include-file", "-f",
> +                            help=3D"""Specify a file that will be copi=
ed to the
> +                            container""")

Is it more useful if it's '--include-files' that accepts multiple files? =
Or
alternatively allow this option to be use multiple times:

    -f foo -f bar -f ...

Similarly, should EXTRA_FILE be EXTRA_FILES or something?

We are already lacking this with --include-executable's documentation, bu=
t
please also document "where" is it copied to in the container's filesyste=
m.

Fam

>          parser.add_argument("--add-current-user", "-u", dest=3D"user",
>                              action=3D"store_true",
>                              help=3D"Add the current user to image's pa=
sswd")
> @@ -274,6 +277,8 @@ class BuildCommand(SubCommand):
>              if args.include_executable:
>                  _copy_binary_with_libs(args.include_executable,
>                                         docker_dir)
> +            if args.include_file:
> +                _copy_with_mkdir(args.include_file, docker_dir)
> =20
>              argv +=3D ["--build-arg=3D" + k.lower() + "=3D" + v
>                          for k, v in os.environ.iteritems()
> --=20
> 2.11.0
>=20
