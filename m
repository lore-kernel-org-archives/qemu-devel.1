Received: from eggs.gnu.org ([2001:4830:134:3::10]:43800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d7gYW-0007j5-HG
	for qemu-devel@nongnu.org; Mon, 08 May 2017 07:10:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d7gYT-0003oi-BZ
	for qemu-devel@nongnu.org; Mon, 08 May 2017 07:10:20 -0400
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:36898)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1d7gYT-0003nU-4y
	for qemu-devel@nongnu.org; Mon, 08 May 2017 07:10:17 -0400
Received: by mail-wm0-x22b.google.com with SMTP id m123so60719678wma.0
	for <qemu-devel@nongnu.org>; Mon, 08 May 2017 04:10:17 -0700 (PDT)
References: <20170508045715.21770-1-f4bug@amsat.org>
	<20170508045715.21770-14-f4bug@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170508045715.21770-14-f4bug@amsat.org>
Date: Mon, 08 May 2017 12:10:59 +0100
Message-ID: <8760hba9j0.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH 13/23] docker: add --include-file
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
>  tests/docker/Makefile.include | 3 ++-
>  tests/docker/docker.py        | 5 +++++
>  2 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
> index ceff2c1654..47978fb56c 100644
> --- a/tests/docker/Makefile.include
> +++ b/tests/docker/Makefile.include
> @@ -51,7 +51,8 @@ docker-image-%: $(DOCKER_FILES_DIR)/%.docker
>  		$(SRC_PATH)/tests/docker/docker.py build qemu:$* $< \
>  		$(if $V,,--quiet) $(if $(NOCACHE),--no-cache) \
>  		$(if $(NOUSER),,--add-current-user) \
> -		$(if $(EXECUTABLE),--include-executable=$(EXECUTABLE)),\
> +		$(if $(EXECUTABLE),--include-executable=$(EXECUTABLE))\
> +		$(if $(EXTRA_FILE),--include-file=$(EXTRA_FILE)),\
>  		"BUILD","$*")
>
>  # Enforce dependancies for composite images
> diff --git a/tests/docker/docker.py b/tests/docker/docker.py
> index 6ddc6e4c2a..4c096a8178 100755
> --- a/tests/docker/docker.py
> +++ b/tests/docker/docker.py
> @@ -237,6 +237,9 @@ class BuildCommand(SubCommand):
>                              help="""Specify a binary that will be copied to the
>                              container together with all its dependent
>                              libraries""")
> +        parser.add_argument("--include-file", "-f",
> +                            help="""Specify a binary that will be copied to the
> +                            container""")

It's not a binary, just an additional file (which might be a binary).

>          parser.add_argument("--add-current-user", "-u", dest="user",
>                              action="store_true",
>                              help="Add the current user to image's passwd")
> @@ -274,6 +277,8 @@ class BuildCommand(SubCommand):
>              if args.include_executable:
>                  _copy_binary_with_libs(args.include_executable,
>                                         docker_dir)
> +            if args.include_file:
> +                _copy_with_mkdir(args.include_file, docker_dir)
>
>              argv += ["--build-arg=" + k.lower() + "=" + v
>                          for k, v in os.environ.iteritems()


--
Alex Bennée
