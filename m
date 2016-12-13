Received: from eggs.gnu.org ([2001:4830:134:3::10]:42836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cGnIu-0000gT-L3
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 08:39:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cGnIq-0005NC-Nl
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 08:39:36 -0500
Received: from mail-wj0-f173.google.com ([209.85.210.173]:33358)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cGnIq-0005Mh-H1
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 08:39:32 -0500
Received: by mail-wj0-f173.google.com with SMTP id xy5so100803306wjc.0
	for <qemu-devel@nongnu.org>; Tue, 13 Dec 2016 05:39:32 -0800 (PST)
References: <20161201051433.17168-1-bobby.prani@gmail.com>
	<20161201051433.17168-18-bobby.prani@gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20161201051433.17168-18-bobby.prani@gmail.com>
Date: Tue, 13 Dec 2016 13:38:29 +0000
Message-ID: <878trkt0dm.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 17/19] tests/tcg: Move independent tests to
 misc dir
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

> Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
> ---
>  tests/tcg/misc/Makefile           | 81 +++++++++++++++++++++++++++++++++++++++
>  tests/tcg/{ => misc}/linux-test.c |  0
>  tests/tcg/{ => misc}/sha1.c       |  0
>  tests/tcg/{ => misc}/test-mmap.c  |  0
>  tests/tcg/{ => misc}/test_path.c  |  0
>  tests/tcg/{ => misc}/testthread.c |  0
>  6 files changed, 81 insertions(+)
>  create mode 100644 tests/tcg/misc/Makefile
>  rename tests/tcg/{ => misc}/linux-test.c (100%)
>  rename tests/tcg/{ => misc}/sha1.c (100%)
>  rename tests/tcg/{ => misc}/test-mmap.c (100%)
>  rename tests/tcg/{ => misc}/test_path.c (100%)
>  rename tests/tcg/{ => misc}/testthread.c (100%)
>
> diff --git a/tests/tcg/misc/Makefile b/tests/tcg/misc/Makefile
> new file mode 100644
> index 0000000..0aa6f2e
> --- /dev/null
> +++ b/tests/tcg/misc/Makefile
> @@ -0,0 +1,81 @@
> +# -*- Mode: makefile -*-
> +#
> +# Generic linux-user TCG tests
> +#
> +# These tests all use standard non-architecture specific APIs so can
> +# be built for all TCG targets. The Make is expected to be called in
> +# the ${BUILD_DIR}/$(TARGET_NAME_ARCH)-linux-user/tests directory
> +#
> +# To build for other architectures call make with CROSS_CC set
> +#
> +
> +BUILD_DIR=../..
> +include $(BUILD_DIR)/config-host.mak	# brings in SRC_PATH
> +include ../config-target.mak		# TARGET_NAME
> +include $(SRC_PATH)/rules.mak
> +
> +$(call set-vpath, $(SRC_PATH)/tests/tcg/misc)
> +
> +QEMU=$(BUILD_DIR)/$(TARGET_NAME)-linux-user/qemu-$(TARGET_NAME)
> +
> +# Compiler set-up, default to system compiler if not set
> +CROSS_CC?=$(CC)
> +
> +CFLAGS=-Wall -O2 -g -fno-strict-aliasing -static
> +LDFLAGS=
> +
> +TESTS=linux-test \
> +      testthread \
> +      sha1 \
> +      test-mmap
> +
> +all: $(patsubst %,run-%,$(TESTS))
> +test: all
> +
> +# rules to run tests
> +
> +run-%: %
> +	-$(QEMU) ./$*
> +
> +run-linux-test: linux-test
> +run-testthread: testthread
> +run-sha1: sha1
> +run-test_path: test_path
> +
> +run-test-mmap: test-mmap
> +	-$(QEMU) ./test-mmap
> +	-$(QEMU) -p 8192 ./test-mmap 8192
> +	-$(QEMU) -p 16384 ./test-mmap 16384
> +	-$(QEMU) -p 32768 ./test-mmap 32768
> +
> +run-test_path: test_path
> +
> +# rules to compile tests
> +
> +# These two need to be re-written as relying on glib (rather than just glibc)
> +# test_path: test_path.o
> +# 	$(CROSS_CC) $^ -o $@ -lglib-2.0
> +
> +# test_path.o: test_path.c
> +# 	$(CROSS_CC) $^ -c -o $@ $(QEMU_INCLUDES) `pkg-config --cflags --libs glib-2.0`
> +
> +testthread: testthread.c
> +	$(CROSS_CC) $(CFLAGS) $(LDFLAGS) -o $@ $< -lpthread
> +
> +# generic Linux and CPU test
> +linux-test: linux-test.c
> +	$(CROSS_CC) $(CFLAGS) $(LDFLAGS) -o $@ $< -lm

This breaks the previous fix from 6/19

> +
> +test-mmap: test-mmap.c
> +	$(CROSS_CC) $(CFLAGS) -Wall -O2 $(LDFLAGS) -o $@ $< -static
> +
> +# speed test
> +sha1: sha1.c
> +	$(CROSS_CC) $(CFLAGS) $(LDFLAGS) -o $@ $<
> +
> +speed: sha1
> +	time ./sha1
> +	time $(QEMU) ./sha1
> +
> +clean:
> +	rm -f *~ *.o $(TESTS)
> diff --git a/tests/tcg/linux-test.c b/tests/tcg/misc/linux-test.c
> similarity index 100%
> rename from tests/tcg/linux-test.c
> rename to tests/tcg/misc/linux-test.c
> diff --git a/tests/tcg/sha1.c b/tests/tcg/misc/sha1.c
> similarity index 100%
> rename from tests/tcg/sha1.c
> rename to tests/tcg/misc/sha1.c
> diff --git a/tests/tcg/test-mmap.c b/tests/tcg/misc/test-mmap.c
> similarity index 100%
> rename from tests/tcg/test-mmap.c
> rename to tests/tcg/misc/test-mmap.c
> diff --git a/tests/tcg/test_path.c b/tests/tcg/misc/test_path.c
> similarity index 100%
> rename from tests/tcg/test_path.c
> rename to tests/tcg/misc/test_path.c
> diff --git a/tests/tcg/testthread.c b/tests/tcg/misc/testthread.c
> similarity index 100%
> rename from tests/tcg/testthread.c
> rename to tests/tcg/misc/testthread.c


--
Alex Bennée
