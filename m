Received: from eggs.gnu.org ([2001:4830:134:3::10]:39020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fa5VL-00079x-9i
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 16:33:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fa5VH-0008Ii-82
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 16:32:59 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:38128)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fa5VH-0008IG-2i
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 16:32:55 -0400
Received: by mail-qt0-x243.google.com with SMTP id c5-v6so14955986qth.5
	for <qemu-devel@nongnu.org>; Mon, 02 Jul 2018 13:32:54 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180702143021.18864-1-alex.bennee@linaro.org>
	<20180702143021.18864-20-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <e5cbb8f7-9555-ed85-744e-77f6ac646c40@amsat.org>
Date: Mon, 2 Jul 2018 17:32:47 -0300
MIME-Version: 1.0
In-Reply-To: <20180702143021.18864-20-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 19/20] docker: add special rule for
 deboostrapped images
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, cota@braap.org, famz@redhat.com, berrange@redhat.com, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org

On 07/02/2018 11:30 AM, Alex Bennée wrote:
> We might as well have a custom rule for this. For one thing the
> dependencies are different. As the primary dependency for
> docker-image-% could never be docker-image-debian-bootstrap we can
> drop that test in the main rule as well.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v3:
>   - changed rule to docker-binfmt-image-debian-%:
>   - leave executable in the main rule
>   - rm stray whitespace fix
> ---
>  tests/docker/Makefile.include | 23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
> index 8641f5da2c..fdc87b8a57 100644
> --- a/tests/docker/Makefile.include
> +++ b/tests/docker/Makefile.include
> @@ -49,9 +49,6 @@ docker-image-%: $(DOCKER_FILES_DIR)/%.docker
>  		"CHECK", "$*")
>  else
>  docker-image-%: $(DOCKER_FILES_DIR)/%.docker
> -	@if test "$@" = docker-image-debian-bootstrap -a -z "$(EXECUTABLE)"; then \
> -		echo WARNING: EXECUTABLE is not set, debootstrap may fail. 2>&1 ; \
> -	fi
>  	$(call quiet-command,\
>  		$(DOCKER_SCRIPT) build qemu:$* $< \
>  		$(if $V,,--quiet) $(if $(NOCACHE),--no-cache) \
> @@ -59,6 +56,26 @@ docker-image-%: $(DOCKER_FILES_DIR)/%.docker
>  		$(if $(EXTRA_FILES),--extra-files $(EXTRA_FILES))\
>  		$(if $(EXECUTABLE),--include-executable=$(EXECUTABLE)),\
>  		"BUILD","$*")
> +
> +# Special rule for debootstraped binfmt linux-user images
> +docker-binfmt-image-debian-%: $(DOCKER_FILES_DIR)/debian-bootstrap.docker
> +	@if test -z "$(EXECUTABLE)"; then \
> +		echo WARNING: EXECUTABLE is not set, debootstrap may fail. 2>&1 ; \
> +	fi
> +	@if test -z "$(DEB_ARCH)"; then 					\
> +		echo WARNING: DEB_ARCH is not set, debootstrap may fail. 2>&1 ; \
> +        fi
> +	@if test -z "$(DEB_TYPE)"; then 					\
> +		echo WARNING: DEB_TYPE is not set, debootstrap may fail. 2>&1 ; \
> +        fi
> +	$(call quiet-command,							\

Here I had to add:

+               DEB_ARCH=$(DEB_ARCH) \
+               DEB_TYPE=$(DEB_TYPE) \

> +		$(DOCKER_SCRIPT) build qemu:debian-$* $< \
> +		$(if $V,,--quiet) $(if $(NOCACHE),--no-cache) \
> +		$(if $(NOUSER),,--add-current-user) \
> +		$(if $(EXTRA_FILES),--extra-files $(EXTRA_FILES))\
> +		$(if $(EXECUTABLE),--include-executable=$(EXECUTABLE)), \
> +		"BUILD","binfmt debian-$* (debootstrapped)")
> +
>  endif
>  
>  # Enforce dependencies for composite images
> 
