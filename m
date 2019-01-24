Received: from eggs.gnu.org ([209.51.188.92]:45198)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gmhnW-0002c9-9h
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 11:24:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gmhej-0005yA-4c
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 11:15:08 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37613)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gmheh-0005wV-VC
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 11:15:04 -0500
Received: by mail-wm1-f67.google.com with SMTP id g67so3665370wmd.2
	for <qemu-devel@nongnu.org>; Thu, 24 Jan 2019 08:15:03 -0800 (PST)
References: <20190124115448.30487-1-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <8d194bb9-dd0d-7987-b965-dc778d942a34@redhat.com>
Date: Thu, 24 Jan 2019 17:15:00 +0100
MIME-Version: 1.0
In-Reply-To: <20190124115448.30487-1-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2] tests/vm: move images to
 $HOME/.cache/qemu-vm/images
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

On 1/24/19 12:54 PM, Gerd Hoffmann wrote:
> It's easier to move around the images then, by replacing the
> subdirectory with a symlink.  Allows to share the images between
> multiple qemu checkouts for example.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
> 
> Notes:
>     v2: use $HOME/.cache/qemu-vm/images as location

Thanks :)

> 
>  tests/vm/Makefile.include | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
> index a98fb3027f..a58383d263 100644
> --- a/tests/vm/Makefile.include
> +++ b/tests/vm/Makefile.include
> @@ -3,7 +3,8 @@
>  .PHONY: vm-build-all vm-clean-all
>  
>  IMAGES := ubuntu.i386 freebsd netbsd openbsd centos
> -IMAGE_FILES := $(patsubst %, tests/vm/%.img, $(IMAGES))
> +IMAGES_DIR := $(HOME)/.cache/qemu-vm/images
> +IMAGE_FILES := $(patsubst %, $(IMAGES_DIR)/%.img, $(IMAGES))
>  
>  .PRECIOUS: $(IMAGE_FILES)
>  
> @@ -24,9 +25,10 @@ vm-build-all: $(addprefix vm-build-, $(IMAGES))
>  vm-clean-all:
>  	rm -f $(IMAGE_FILES)
>  
> -tests/vm/%.img: $(SRC_PATH)/tests/vm/% \
> -		$(SRC_PATH)/tests/vm/basevm.py \
> -		$(SRC_PATH)/tests/vm/Makefile.include
> +$(IMAGES_DIR)/%.img:	$(SRC_PATH)/tests/vm/% \
> +			$(SRC_PATH)/tests/vm/basevm.py \
> +			$(SRC_PATH)/tests/vm/Makefile.include
> +	@mkdir -p $(IMAGES_DIR)
>  	$(call quiet-command, \
>  		$< \
>  		$(if $(V)$(DEBUG), --debug) \
> @@ -37,7 +39,7 @@ tests/vm/%.img: $(SRC_PATH)/tests/vm/% \
>  
>  
>  # Build in VM $(IMAGE)
> -vm-build-%: tests/vm/%.img
> +vm-build-%: $(IMAGES_DIR)/%.img
>  	$(call quiet-command, \
>  		$(SRC_PATH)/tests/vm/$* \
>  		$(if $(V)$(DEBUG), --debug) \
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
