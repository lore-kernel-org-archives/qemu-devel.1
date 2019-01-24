Received: from eggs.gnu.org ([209.51.188.92]:44720)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gmcbN-0001LA-Sa
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 05:51:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gmcbN-0008WP-0s
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 05:51:17 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38931)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gmcbM-0008UK-Qi
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 05:51:16 -0500
Received: by mail-wr1-f65.google.com with SMTP id t27so5925399wra.6
	for <qemu-devel@nongnu.org>; Thu, 24 Jan 2019 02:51:16 -0800 (PST)
References: <20190124102504.24192-1-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c940889d-8f5c-7043-dfb5-aad2a2968f29@redhat.com>
Date: Thu, 24 Jan 2019 11:51:14 +0100
MIME-Version: 1.0
In-Reply-To: <20190124102504.24192-1-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] tests/vm: move images to subdirectory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Fam Zheng <fam@euphon.net>

Hi Gerd,

On 1/24/19 11:25 AM, Gerd Hoffmann wrote:
> It's easier to move around the images then, by replacing the
> subdirectory with a symlink.  Allows to share the images between
> multiple qemu checkouts for example.

Good idea!

> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  tests/vm/.gitignore       |  1 +
>  tests/vm/Makefile.include | 11 ++++++-----
>  2 files changed, 7 insertions(+), 5 deletions(-)
>  create mode 100644 tests/vm/.gitignore
> 
> diff --git a/tests/vm/.gitignore b/tests/vm/.gitignore
> new file mode 100644
> index 0000000000..c291c09129
> --- /dev/null
> +++ b/tests/vm/.gitignore
> @@ -0,0 +1 @@
> +images
> diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
> index a98fb3027f..f9f0417447 100644
> --- a/tests/vm/Makefile.include
> +++ b/tests/vm/Makefile.include
> @@ -3,7 +3,7 @@
>  .PHONY: vm-build-all vm-clean-all
>  
>  IMAGES := ubuntu.i386 freebsd netbsd openbsd centos
> -IMAGE_FILES := $(patsubst %, tests/vm/%.img, $(IMAGES))
> +IMAGE_FILES := $(patsubst %, tests/vm/images/%.img, $(IMAGES))

We already store the compressed image in ~/.cache/qemu-vm/download,
what about having:

IMAGES_DIR ?= $$HOME/.cache/qemu-vm/images
IMAGE_FILES := $(patsubst %, $(IMAGES_DIR)/%.img, $(IMAGES))

Anyway I can send that on top of your patch, so meanwhile:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

>  
>  .PRECIOUS: $(IMAGE_FILES)
>  
> @@ -24,9 +24,10 @@ vm-build-all: $(addprefix vm-build-, $(IMAGES))
>  vm-clean-all:
>  	rm -f $(IMAGE_FILES)
>  
> -tests/vm/%.img: $(SRC_PATH)/tests/vm/% \
> -		$(SRC_PATH)/tests/vm/basevm.py \
> -		$(SRC_PATH)/tests/vm/Makefile.include
> +tests/vm/images/%.img:	$(SRC_PATH)/tests/vm/% \
> +			$(SRC_PATH)/tests/vm/basevm.py \
> +			$(SRC_PATH)/tests/vm/Makefile.include
> +	@mkdir -p tests/vm/images
>  	$(call quiet-command, \
>  		$< \
>  		$(if $(V)$(DEBUG), --debug) \
> @@ -37,7 +38,7 @@ tests/vm/%.img: $(SRC_PATH)/tests/vm/% \
>  
>  
>  # Build in VM $(IMAGE)
> -vm-build-%: tests/vm/%.img
> +vm-build-%: tests/vm/images/%.img
>  	$(call quiet-command, \
>  		$(SRC_PATH)/tests/vm/$* \
>  		$(if $(V)$(DEBUG), --debug) \
> 
