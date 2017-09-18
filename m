Received: from eggs.gnu.org ([2001:4830:134:3::10]:42228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dtuRX-0002r5-6q
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 07:42:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dtuRU-0007q7-4v
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 07:42:27 -0400
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:44638)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dtuRT-0007pq-TP
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 07:42:24 -0400
Received: by mail-wm0-x231.google.com with SMTP id 189so12835966wmh.1
	for <qemu-devel@nongnu.org>; Mon, 18 Sep 2017 04:42:23 -0700 (PDT)
References: <20170918024402.3265-1-famz@redhat.com>
	<20170918024402.3265-11-famz@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170918024402.3265-11-famz@redhat.com>
Date: Mon, 18 Sep 2017 12:42:21 +0100
Message-ID: <877ewwjkrm.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v8 10/13] Makefile: Add rules to run vm
 tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, Philippe =?utf-8?Q?Mathieu?= =?utf-8?Q?-Daud=C3=A9?= <f4bug@amsat.org>, pbonzini@redhat.com, stefanha@redhat.com, Cleber Rosa <crosa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, eblake@redhat.com, Kamil Rytarowski <kamil@netbsd.org>


Fam Zheng <famz@redhat.com> writes:

> Signed-off-by: Fam Zheng <famz@redhat.com>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>

> ---
>  Makefile                  |  2 ++
>  configure                 |  2 +-
>  tests/vm/Makefile.include | 42 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 45 insertions(+), 1 deletion(-)
>  create mode 100644 tests/vm/Makefile.include
>
> diff --git a/Makefile b/Makefile
> index b53fc69a60..79684ab138 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -812,6 +812,7 @@ endif
>  -include $(wildcard *.d tests/*.d)
>
>  include $(SRC_PATH)/tests/docker/Makefile.include
> +include $(SRC_PATH)/tests/vm/Makefile.include
>
>  .PHONY: help
>  help:
> @@ -835,6 +836,7 @@ help:
>  	@echo  'Test targets:'
>  	@echo  '  check           - Run all tests (check-help for details)'
>  	@echo  '  docker          - Help about targets running tests inside Docker containers'
> +	@echo  '  vm-test         - Help about targets running tests inside VM'
>  	@echo  ''
>  	@echo  'Documentation targets:'
>  	@echo  '  html info pdf txt'
> diff --git a/configure b/configure
> index 94db2d103e..bbf053e3e0 100755
> --- a/configure
> +++ b/configure
> @@ -6505,7 +6505,7 @@ if test "$ccache_cpp2" = "yes"; then
>  fi
>
>  # build tree in object directory in case the source is not in the current directory
> -DIRS="tests tests/tcg tests/tcg/cris tests/tcg/lm32 tests/libqos tests/qapi-schema tests/tcg/xtensa tests/qemu-iotests"
> +DIRS="tests tests/tcg tests/tcg/cris tests/tcg/lm32 tests/libqos tests/qapi-schema tests/tcg/xtensa tests/qemu-iotests tests/vm"
>  DIRS="$DIRS docs docs/interop fsdev"
>  DIRS="$DIRS pc-bios/optionrom pc-bios/spapr-rtas pc-bios/s390-ccw"
>  DIRS="$DIRS roms/seabios roms/vgabios"
> diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
> new file mode 100644
> index 0000000000..5daa2a3b73
> --- /dev/null
> +++ b/tests/vm/Makefile.include
> @@ -0,0 +1,42 @@
> +# Makefile for VM tests
> +
> +.PHONY: vm-build-all
> +
> +IMAGES := ubuntu.i386 freebsd netbsd openbsd
> +IMAGE_FILES := $(patsubst %, tests/vm/%.img, $(IMAGES))
> +
> +.PRECIOUS: $(IMAGE_FILES)
> +
> +vm-test:
> +	@echo "vm-test: Test QEMU in preconfigured virtual machines"
> +	@echo
> +	@echo "  vm-build-ubuntu.i386            - Build QEMU in ubuntu i386 VM"
> +	@echo "  vm-build-freebsd                - Build QEMU in FreeBSD VM"
> +	@echo "  vm-build-netbsd                 - Build QEMU in NetBSD VM"
> +	@echo "  vm-build-openbsd                - Build QEMU in OpenBSD VM"
> +
> +vm-build-all: $(addprefix vm-build-, $(IMAGES))
> +
> +tests/vm/%.img: $(SRC_PATH)/tests/vm/% \
> +		$(SRC_PATH)/tests/vm/basevm.py \
> +		$(SRC_PATH)/tests/vm/Makefile.include
> +	$(call quiet-command, \
> +		$< \
> +		$(if $(V)$(DEBUG), --debug) \
> +		--image "$@" \
> +		--force \
> +		--build-image $@, \
> +		"  VM-IMAGE $*")
> +
> +
> +# Build in VM $(IMAGE)
> +vm-build-%: tests/vm/%.img
> +	$(call quiet-command, \
> +		$(SRC_PATH)/tests/vm/$* \
> +		$(if $(V)$(DEBUG), --debug) \
> +		$(if $(DEBUG), --interactive) \
> +		$(if $(J),--jobs $(J)) \
> +		--image "$<" \
> +		--build-qemu $(SRC_PATH), \
> +		"  VM-BUILD $*")
> +


--
Alex Bennée
