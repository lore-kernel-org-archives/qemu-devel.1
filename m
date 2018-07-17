Received: from eggs.gnu.org ([2001:4830:134:3::10]:53653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffGbT-00024c-Km
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 23:24:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffGbQ-0004zR-GQ
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 23:24:43 -0400
Received: from mail-qk0-x234.google.com ([2607:f8b0:400d:c09::234]:34543)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffGbQ-0004zL-As
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 23:24:40 -0400
Received: by mail-qk0-x234.google.com with SMTP id b66-v6so21616867qkj.1
	for <qemu-devel@nongnu.org>; Mon, 16 Jul 2018 20:24:40 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180713121741.19262-1-alex.bennee@linaro.org>
	<20180713121741.19262-14-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <6af06a44-1ea6-0b5e-087a-4bef58ea1464@amsat.org>
Date: Tue, 17 Jul 2018 00:24:23 -0300
MIME-Version: 1.0
In-Reply-To: <20180713121741.19262-14-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 for 3.0 13/16] docker: add --hint to
 docker.py check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, cota@braap.org, famz@redhat.com, berrange@redhat.com, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org

On 07/13/2018 09:17 AM, Alex Bennée wrote:
> When a check fails we currently just report why we failed. This is not
> totally helpful to people who want to boot-strap a new image. Add a
> --hint option which we can pass down to give a bit more information.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  tests/docker/Makefile.include | 3 ++-
>  tests/docker/docker.py        | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
> index ec23620153..c9e412f9d0 100644
> --- a/tests/docker/Makefile.include
> +++ b/tests/docker/Makefile.include
> @@ -73,7 +73,8 @@ docker-binfmt-image-debian-%: $(DOCKER_FILES_DIR)/debian-bootstrap.docker
>  			$(if $(EXECUTABLE),--include-executable=$(EXECUTABLE)), \
>  			"BUILD","binfmt debian-$* (debootstrapped)"),		\
>  		$(call quiet-command,						\
> -			$(DOCKER_SCRIPT) check --quiet qemu:debian-$* $<,	\
> +			$(DOCKER_SCRIPT) check --quiet qemu:debian-$* $<	\
> +			--hint "you will need to build $(EXECUTABLE)",		\
>  			"CHECK", "debian-$* exists"))
>  
>  endif
> diff --git a/tests/docker/docker.py b/tests/docker/docker.py
> index 2f81c6b13b..523f4b95a2 100755
> --- a/tests/docker/docker.py
> +++ b/tests/docker/docker.py
> @@ -475,6 +475,7 @@ class CheckCommand(SubCommand):
>                              default="checksum", help="check type")
>          parser.add_argument("--olderthan", default=60, type=int,
>                              help="number of minutes")
> +        parser.add_argument("--hint", default="", help="hint to user")
>  
>      def run(self, args, argv):
>          tag = args.tag
> @@ -487,7 +488,7 @@ class CheckCommand(SubCommand):
>  
>          info = dkr.inspect_tag(tag)
>          if info is None:
> -            print("Image does not exist")
> +            print("Image does not exist %s" % (args.hint))
>              return 1
>  
>          if args.checktype == "checksum":
> 
