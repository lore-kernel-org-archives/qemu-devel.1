Received: from eggs.gnu.org ([2001:4830:134:3::10]:46195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cGqbt-00062S-6Q
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 12:11:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cGqbp-0002VQ-6f
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 12:11:25 -0500
Received: from mail-wj0-f173.google.com ([209.85.210.173]:33816)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cGqbo-0002V6-W4
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 12:11:21 -0500
Received: by mail-wj0-f173.google.com with SMTP id tg4so106554050wjb.1
	for <qemu-devel@nongnu.org>; Tue, 13 Dec 2016 09:11:20 -0800 (PST)
References: <20161201051433.17168-1-bobby.prani@gmail.com>
	<20161201051433.17168-13-bobby.prani@gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20161201051433.17168-13-bobby.prani@gmail.com>
Date: Tue, 13 Dec 2016 17:10:18 +0000
Message-ID: <8737hru551.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 12/19] tests/tcg: Add tests-tcg hook in
 Makefile
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pranith Kumar <bobby.prani@gmail.com>
Cc: qemu-devel@nongnu.org, rth@twiddle.net


Pranith Kumar <bobby.prani@gmail.com> writes:

> You can call 'make tests-tcg' to build and run native tcg tests.
>
> Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>

This breaks the normal make check output:

  GTESTER tests/ptimer-test
  CC      tests/tmp105-test.o
  CC      tests/libqos/pci.o
tests/libqos/pci.c:14:24: fatal error: libqos/pci.h: No such file or directory
compilation terminated.
/home/alex/lsrc/qemu/qemu.git/rules.mak:60: recipe for target 'tests/libqos/pci.o' failed
make: *** [tests/libqos/pci.o] Error 1


> ---
>  tests/Makefile.include     |  1 +
>  tests/tcg/Makefile.include | 33 +++++++++++++++++++++++++++++++++
>  2 files changed, 34 insertions(+)
>  create mode 100644 tests/tcg/Makefile.include
>
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 2a2b78d..b046bdd 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -836,3 +836,4 @@ all: $(QEMU_IOTESTS_HELPERS-y)
>
>  -include $(wildcard tests/*.d)
>  -include $(wildcard tests/libqos/*.d)
> +-include $(SRC_PATH)/tests/tcg/Makefile.include
> diff --git a/tests/tcg/Makefile.include b/tests/tcg/Makefile.include
> new file mode 100644
> index 0000000..3eff125
> --- /dev/null
> +++ b/tests/tcg/Makefile.include
> @@ -0,0 +1,33 @@
> +#
> +# linux-user TCG tests
> +#
> +# The Make is expected to be invoked in the ${BUILD_DIR} directory
> +# using the tests-tcg target
> +#
> +BUILD_DIR?=$(CURDIR)
> +include $(BUILD_DIR)/config-host.mak	# brings in SRC_PATH
> +
> +UNAME_M := $(shell uname -m)
> +
> +tests-tcg: prepare $(UNAME_M)
> +
> +prepare:
> +	mkdir -p $(BUILD_DIR)/$(UNAME_M)-linux-user/tests/
> +
> +x86_64:
> +	cd $(BUILD_DIR)/x86_64-linux-user/tests/ && \
> +	make -f $(SRC_PATH)/tests/tcg/i386/Makefile
> +
> +i386:
> +	cd $(BUILD_DIR)/i386-linux-user/tests/ && \
> +	make -f $(SRC_PATH)/tests/tcg/i386/Makefile
> +
> +arm:
> +	cd $(BUILD_DIR)/arm-linux-user/tests/ && \
> +	make -f $(SRC_PATH)/tests/tcg/arm/Makefile
> +
> +aarch64:
> +	cd $(BUILD_DIR)/aarch64-linux-user/tests/ && \
> +	make -f $(SRC_PATH)/tests/tcg/arm/Makefile
> +
> +.PHONY: tests-tcg


--
Alex Bennée
