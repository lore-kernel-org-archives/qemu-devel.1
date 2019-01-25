Received: from eggs.gnu.org ([209.51.188.92]:53689)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gmvUL-0007Lk-I9
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 02:01:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gmvIR-0004n2-Vl
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 01:49:00 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:33736)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gmvIR-0004mX-Ls
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 01:48:59 -0500
Received: by mail-wr1-x444.google.com with SMTP id p7so9100115wru.0
	for <qemu-devel@nongnu.org>; Thu, 24 Jan 2019 22:48:59 -0800 (PST)
References: <20190124115448.30487-1-kraxel@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190124115448.30487-1-kraxel@redhat.com>
Date: Fri, 25 Jan 2019 06:48:57 +0000
Message-ID: <87lg39z0yu.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Fam Zheng <fam@euphon.net>


Gerd Hoffmann <kraxel@redhat.com> writes:

> It's easier to move around the images then, by replacing the
> subdirectory with a symlink.  Allows to share the images between
> multiple qemu checkouts for example.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Queued to testing/next, thanks.
> ---
>
> Notes:
>     v2: use $HOME/.cache/qemu-vm/images as location
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
>  IMAGES :=3D ubuntu.i386 freebsd netbsd openbsd centos
> -IMAGE_FILES :=3D $(patsubst %, tests/vm/%.img, $(IMAGES))
> +IMAGES_DIR :=3D $(HOME)/.cache/qemu-vm/images
> +IMAGE_FILES :=3D $(patsubst %, $(IMAGES_DIR)/%.img, $(IMAGES))
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


--
Alex Benn=C3=A9e
