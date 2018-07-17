Received: from eggs.gnu.org ([2001:4830:134:3::10]:34752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffSGd-0005Dg-89
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 11:52:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffSGZ-0004vH-W1
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 11:51:59 -0400
Received: from mail-vk0-x243.google.com ([2607:f8b0:400c:c05::243]:34112)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffSGZ-0004up-PZ
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 11:51:55 -0400
Received: by mail-vk0-x243.google.com with SMTP id l143-v6so845785vke.1
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 08:51:55 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180713121741.19262-1-alex.bennee@linaro.org>
	<20180713121741.19262-13-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <24e71e70-7b36-fb6f-af43-89a60b4b4da3@amsat.org>
Date: Tue, 17 Jul 2018 12:51:48 -0300
MIME-Version: 1.0
In-Reply-To: <20180713121741.19262-13-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 for 3.0 12/16] docker: drop QEMU_TARGET
 check, fallback in EXECUTABLE not set
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
> The addition of QEMU_TARGET was intended to ensure we fall back to
> checking for the existence of an image if the build system was not
> currently configured to build it. However this breaks the direct use
> of the rule for building custom binfmt_misc images. We already check
> for EXECUTABLE so let us just use that as a proxy for deciding if we
> are just going to check the image exits.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  tests/docker/Makefile.include | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
> index e32c35be0d..ec23620153 100644
> --- a/tests/docker/Makefile.include
> +++ b/tests/docker/Makefile.include
> @@ -58,13 +58,11 @@ docker-image-%: $(DOCKER_FILES_DIR)/%.docker
>  docker-binfmt-image-debian-%: $(DOCKER_FILES_DIR)/debian-bootstrap.docker
>  	$(if $(EXECUTABLE),,\
>  		$(error EXECUTABLE not set, debootstrap of debian-$* would fail))
> -	$(if $(wildcard $(EXECUTABLE)),,\
> -		$(error Please build $(EXECUTABLE) first))
>  	$(if $(DEB_ARCH),,\
>  		$(error DEB_ARCH not set, debootstrap of debian-$* would fail))
>  	$(if $(DEB_TYPE),,\
>  		$(error DEB_TYPE not set, debootstrap of debian-$* would fail))
> -	$(if $(filter $(QEMU_TARGET),$(TARGET_DIRS)),				\
> +	$(if $(wildcard $(EXECUTABLE)),						\
>  		$(call quiet-command,						\
>  			DEB_ARCH=$(DEB_ARCH)					\
>  			DEB_TYPE=$(DEB_TYPE)					\
> @@ -136,7 +134,6 @@ DOCKER_PARTIAL_IMAGES += debian-tricore-cross debian-powerpc-cross fedora-i386-c
>  # broken so we need a qemu-linux-user for this target
>  docker-binfmt-image-debian-powerpc-user: DEB_ARCH = powerpc
>  docker-binfmt-image-debian-powerpc-user: DEB_TYPE = jessie
> -docker-binfmt-image-debian-powerpc-user: QEMU_TARGET = ppc-linux-user
>  docker-binfmt-image-debian-powerpc-user: EXECUTABLE = ${BUILD_DIR}/ppc-linux-user/qemu-ppc
>  docker-image-debian-powerpc-user-cross: docker-binfmt-image-debian-powerpc-user
>  DOCKER_USER_IMAGES += debian-powerpc-user
> 
