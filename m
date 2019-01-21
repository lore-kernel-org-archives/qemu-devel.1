Received: from eggs.gnu.org ([209.51.188.92]:42153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gliVO-00081D-US
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 17:57:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gliVM-0008Or-4T
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 17:57:21 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:47071)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gliVL-0008OI-R2
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 17:57:20 -0500
Received: by mail-wr1-f67.google.com with SMTP id l9so25182095wrt.13
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 14:57:18 -0800 (PST)
References: <20190121171543.32422-1-alex.bennee@linaro.org>
	<20190121171543.32422-4-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ed667bb7-20ca-6254-5f01-1459be48e03c@redhat.com>
Date: Mon, 21 Jan 2019 23:57:16 +0100
MIME-Version: 1.0
In-Reply-To: <20190121171543.32422-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH 3/3] tests/vm: expose BUILD_TARGET,
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
Cc: kamil@netbsd.org, brad@comstyle.com, Fam Zheng <fam@euphon.net>

On 1/21/19 6:15 PM, Alex Bennée wrote:
> Now the underlying basevm support passes these along we can expose
> some additional variables to our Makefile to allow more customised
> tweaking of the build. For example:
> 
>   make vm-build-freebsd TARGET_LIST=aarch64-softmmu \
>     EXTRA_CONFIGURE_OPTS="--disable-tools --disable-docs" \
>     BUILD_TARGET=check-softfloat
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  tests/vm/Makefile.include | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
> index a98fb3027f..6be53aa297 100644
> --- a/tests/vm/Makefile.include
> +++ b/tests/vm/Makefile.include
> @@ -18,6 +18,11 @@ vm-test:
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
> @@ -45,6 +50,9 @@ vm-build-%: tests/vm/%.img
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
