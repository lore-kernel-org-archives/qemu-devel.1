Received: from eggs.gnu.org ([209.51.188.92]:51056)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gpA86-0002Hg-VF
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 06:03:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gpA7n-0000Ea-9h
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 06:03:23 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43446)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gpA7j-0000Co-Eg
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 06:03:13 -0500
Received: by mail-wr1-f68.google.com with SMTP id r10so2739399wrs.10
	for <qemu-devel@nongnu.org>; Thu, 31 Jan 2019 03:03:09 -0800 (PST)
References: <20190125140017.6092-1-alex.bennee@linaro.org>
	<20190125140017.6092-14-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <db088638-7d4d-31b7-c5bf-ae45eb96546f@redhat.com>
Date: Thu, 31 Jan 2019 12:03:07 +0100
MIME-Version: 1.0
In-Reply-To: <20190125140017.6092-14-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 13/14] tests/vm: expose BUILD_TARGET,
 TARGET_LIST and EXTRA_CONFIGURE_OPTS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: Fam Zheng <fam@euphon.net>

On 1/25/19 3:00 PM, Alex Bennée wrote:
> Now the underlying basevm support passes these along we can expose
> some additional variables to our Makefile to allow more customised
> tweaking of the build. For example:
> 
>   make vm-build-freebsd TARGET_LIST=aarch64-softmmu \
>     EXTRA_CONFIGURE_OPTS="--disable-tools --disable-docs" \
>     BUILD_TARGET=check-softfloat
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  tests/vm/Makefile.include | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
> index a58383d263..992d823f6b 100644
> --- a/tests/vm/Makefile.include
> +++ b/tests/vm/Makefile.include
> @@ -19,6 +19,11 @@ vm-test:
>  	@echo ""
>  	@echo "  vm-build-all                    - Build QEMU in all VMs"
>  	@echo "  vm-clean-all                    - Clean up VM images"
> +	@echo
> +	@echo "Special variables:"
> +	@echo "    BUILD_TARGET=foo		 - override the build target"
> +	@echo "    TARGET_LIST=a,b,c    	 - Override target list in builds."
> +	@echo '    EXTRA_CONFIGURE_OPTS="..."'
>  
>  vm-build-all: $(addprefix vm-build-, $(IMAGES))
>  
> @@ -47,6 +52,9 @@ vm-build-%: $(IMAGES_DIR)/%.img
>  		$(if $(J),--jobs $(J)) \
>  		$(if $(V),--verbose) \
>  		--image "$<" \
> -		--build-qemu $(SRC_PATH), \
> +		$(if $(BUILD_TARGET),--build-target $(BUILD_TARGET)) \
> +		--build-qemu $(SRC_PATH) -- \
> +		$(if $(TARGET_LIST),--target-list=$(TARGET_LIST)) \
> +		$(if $(EXTRA_CONFIGURE_OPTS),$(EXTRA_CONFIGURE_OPTS)), \
>  		"  VM-BUILD $*")
>  
> 
