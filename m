Received: from eggs.gnu.org ([2001:4830:134:3::10]:51156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dG6WZ-0008EC-Ps
	for qemu-devel@nongnu.org; Wed, 31 May 2017 12:31:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dG6WV-0003L8-7M
	for qemu-devel@nongnu.org; Wed, 31 May 2017 12:31:07 -0400
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:37485)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dG6WU-0003Kp-UI
	for qemu-devel@nongnu.org; Wed, 31 May 2017 12:31:03 -0400
Received: by mail-wm0-x230.google.com with SMTP id d127so26543450wmf.0
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 09:31:02 -0700 (PDT)
References: <20170527161755.7761-1-f4bug@amsat.org>
	<20170527161755.7761-3-f4bug@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170527161755.7761-3-f4bug@amsat.org>
Date: Wed, 31 May 2017 17:31:17 +0100
Message-ID: <87vaohrnsa.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 02/24] docker: add --include-files
 argument to 'build' command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>


Philippe Mathieu-Daudé <f4bug@amsat.org> writes:

> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  tests/docker/Makefile.include |  3 +++
>  tests/docker/docker.py        | 11 ++++++++---
>  2 files changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
> index 03eda37bf4..fe1a9a53ff 100644
> --- a/tests/docker/Makefile.include
> +++ b/tests/docker/Makefile.include
> @@ -51,6 +51,7 @@ docker-image-%: $(DOCKER_FILES_DIR)/%.docker
>  		$(SRC_PATH)/tests/docker/docker.py build qemu:$* $< \
>  		$(if $V,,--quiet) $(if $(NOCACHE),--no-cache) \
>  		$(if $(NOUSER),,--add-current-user) \
> +		$(if $(EXTRA_FILES),--extra-files $(EXTRA_FILES))\
>  		$(if $(EXECUTABLE),--include-executable=$(EXECUTABLE)),\
>  		"BUILD","$*")
>
> @@ -107,6 +108,8 @@ docker:
>  	@echo '    NOUSER               Define to disable adding current user to containers passwd.'
>  	@echo '    NOCACHE=1            Ignore cache when build images.'
>  	@echo '    EXECUTABLE=<path>    Include executable in image.'
> +	@echo '    EXTRA_FILES="<path> [... <path>]"'
> +	@echo '                         Include extra files in image.'
>
>  # This rule if for directly running against an arbitrary docker target.
>  # It is called by the expanded docker targets (e.g. make
> diff --git a/tests/docker/docker.py b/tests/docker/docker.py
> index 6ddc6e4c2a..5401e58fce 100755
> --- a/tests/docker/docker.py
> +++ b/tests/docker/docker.py
> @@ -237,6 +237,10 @@ class BuildCommand(SubCommand):
>                              help="""Specify a binary that will be copied to the
>                              container together with all its dependent
>                              libraries""")
> +        parser.add_argument("--extra-files", "-f", nargs='*',
> +                            help="""Specify files that will be copied in the
> +                            Docker image, fulfilling the ADD directive from the
> +                            Dockerfile""")
>          parser.add_argument("--add-current-user", "-u", dest="user",
>                              action="store_true",
>                              help="Add the current user to image's passwd")
> @@ -270,10 +274,11 @@ class BuildCommand(SubCommand):
>                      print "%s exited with code %d" % (docker_pre, rc)
>                      return 1
>
> -            # Do we include a extra binary?
> +            # Include files used by ADD directives found within the
> Dockerfile.

Minor nit, as we are not actually parsing the Dockerfile here maybe it
should be re-worded to something like:

  "Copy any extra files into the Docker context. These can be included by the use
    of the ADD directive in the Dockerfile."?

Anyway:

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>


>              if args.include_executable:
> -                _copy_binary_with_libs(args.include_executable,
> -                                       docker_dir)
> +                _copy_binary_with_libs(args.include_executable, docker_dir)
> +            for filename in args.extra_files or []:
> +                _copy_with_mkdir(filename, docker_dir)
>
>              argv += ["--build-arg=" + k.lower() + "=" + v
>                          for k, v in os.environ.iteritems()


--
Alex Bennée
