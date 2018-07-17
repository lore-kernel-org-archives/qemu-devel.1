Received: from eggs.gnu.org ([2001:4830:134:3::10]:51776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffGKZ-0008AL-Ia
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 23:07:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffGKW-0008KJ-CT
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 23:07:15 -0400
Received: from mail-ua0-x242.google.com ([2607:f8b0:400c:c08::242]:35369)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffGKW-0008KA-6x
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 23:07:12 -0400
Received: by mail-ua0-x242.google.com with SMTP id q12-v6so26223501ual.2
	for <qemu-devel@nongnu.org>; Mon, 16 Jul 2018 20:07:12 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180713121741.19262-1-alex.bennee@linaro.org>
	<20180713121741.19262-9-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f3c5f4d2-0468-ccf8-c1c3-04ddba9f3bd6@amsat.org>
Date: Tue, 17 Jul 2018 00:07:05 -0300
MIME-Version: 1.0
In-Reply-To: <20180713121741.19262-9-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 for 3.0 08/16] docker: Makefile.include
 don't include partial images
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
> Rename DOCKER_INTERMEDIATE_IMAGES to DOCKER_PARTIAL_IMAGES and add the
> incomplete cross compiler images that can build tests but can't build
> QEMU itself. We also add debian, debian-bootstrap and the tricode
> images to the list.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  tests/docker/Makefile.include | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
> index b2a7e761cc..09fb7db7fa 100644
> --- a/tests/docker/Makefile.include
> +++ b/tests/docker/Makefile.include
> @@ -6,7 +6,7 @@ DOCKER_SUFFIX := .docker
>  DOCKER_FILES_DIR := $(SRC_PATH)/tests/docker/dockerfiles
>  DOCKER_DEPRECATED_IMAGES := debian
>  # we don't run tests on intermediate images (used as base by another image)
> -DOCKER_INTERMEDIATE_IMAGES := debian8 debian9 debian8-mxe debian-ports debian-sid
> +DOCKER_PARTIAL_IMAGES := debian debian8 debian9 debian8-mxe debian-ports debian-sid debian-bootstrap
>  DOCKER_IMAGES := $(filter-out $(DOCKER_DEPRECATED_IMAGES),$(sort $(notdir $(basename $(wildcard $(DOCKER_FILES_DIR)/*.docker)))))
>  DOCKER_TARGETS := $(patsubst %,docker-image-%,$(DOCKER_IMAGES))
>  # Use a global constant ccache directory to speed up repetitive builds
> @@ -121,6 +121,11 @@ docker-image-travis: NOUSER=1
>  # Specialist build images, sometimes very limited tools
>  docker-image-tricore-cross: docker-image-debian9
>  
> +# These images may be good enough for building tests but not for test builds
> +DOCKER_PARTIAL_IMAGES += debian-alpha-cross debian-hppa-cross debian-m68k-cross debian-sh4-cross
> +DOCKER_PARTIAL_IMAGES += debian-sparc64-cross debian-mips64-cross debian-riscv64-cross
> +DOCKER_PARTIAL_IMAGES += debian-tricore-cross debian-powerpc-cross fedora-i386-cross

What about inverting the logic? Only keep track of 'full' images, and
use the $(filter ) function.

Anyway:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> +
>  # Rules for building linux-user powered images
>  #
>  # These are slower than using native cross compiler setups but can
> @@ -137,7 +142,7 @@ docker-image-debian-powerpc-user-cross: docker-binfmt-image-debian-powerpc-user
>  DOCKER_USER_IMAGES += debian-powerpc-user
>  
>  # Expand all the pre-requistes for each docker image and test combination
> -$(foreach i,$(filter-out $(DOCKER_INTERMEDIATE_IMAGES),$(DOCKER_IMAGES) $(DOCKER_DEPRECATED_IMAGES)), \
> +$(foreach i,$(filter-out $(DOCKER_PARTIAL_IMAGES),$(DOCKER_IMAGES) $(DOCKER_DEPRECATED_IMAGES)), \
>  	$(foreach t,$(DOCKER_TESTS) $(DOCKER_TOOLS), \
>  		$(eval .PHONY: docker-$t@$i) \
>  		$(eval docker-$t@$i: docker-image-$i docker-run-$t@$i) \
> 
