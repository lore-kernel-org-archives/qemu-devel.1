Received: from eggs.gnu.org ([2001:4830:134:3::10]:52136)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fSCMV-0004Nv-4L
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 22:15:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fSCMR-000304-1s
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 22:15:15 -0400
Received: from mail-qt0-x22b.google.com ([2607:f8b0:400d:c0d::22b]:35701)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fSCMQ-0002zY-S2
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 22:15:10 -0400
Received: by mail-qt0-x22b.google.com with SMTP id s9-v6so18949317qtg.2
	for <qemu-devel@nongnu.org>; Sun, 10 Jun 2018 19:15:10 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180608123307.24773-1-alex.bennee@linaro.org>
	<20180608123307.24773-43-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a97d48ed-46c4-41ee-7580-a04df327522c@amsat.org>
Date: Sun, 10 Jun 2018 23:15:02 -0300
MIME-Version: 1.0
In-Reply-To: <20180608123307.24773-43-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v6 42/49] Makefile.target: add
 (clean-/build-)guest-tests targets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, cota@braap.org, famz@redhat.com, berrange@redhat.com, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, pbonzini@redhat.com, stefanha@redhat.com, stefanb@linux.vnet.ibm.com, marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org

On 06/08/2018 09:33 AM, Alex Bennée wrote:
> Now all the build infrastructure is in place we can build tests for
> each guest that we support. That support mainly depends on having
> cross compilers installed or docker setup. To keep all the logic for
> that together we put the rules in tests/tcg/Makefile.include and
> include it from the main Makefile.target.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v4
>   - pulled Makefile.include bits from next patch
>   - added qemu-$(TARGET_NAME) dependency for running tests
>   - accept SPEED parameter to run slow tests
>   - pass BUILD_STATIC
>   - update MAINTAINERS
> v6
>   - bare make -> $(MAKE) for sub-makes
> ---
>  MAINTAINERS                |  1 +
>  Makefile.target            |  5 +++
>  tests/tcg/Makefile.include | 88 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 94 insertions(+)
>  create mode 100644 tests/tcg/Makefile.include
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4761f8cab4..6c1eca3a1c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2147,6 +2147,7 @@ W: http://patchew.org/QEMU/
>  Guest Test Compilation Support
>  M: Alex Bennée <alex.bennee@linaro.org>
>  F: tests/tcg/Makefile
> +F: tests/tcg/Makefile.include
>  L: qemu-devel@nongnu.org
>  
>  Documentation
> diff --git a/Makefile.target b/Makefile.target
> index dad2cf8778..a9d8928f96 100644
> --- a/Makefile.target
> +++ b/Makefile.target
> @@ -36,6 +36,11 @@ endif
>  PROGS=$(QEMU_PROG) $(QEMU_PROGW)
>  STPFILES=
>  
> +# Makefile Tests
> +ifdef CONFIG_USER_ONLY
> +include $(SRC_PATH)/tests/tcg/Makefile.include
> +endif
> +
>  config-target.h: config-target.h-timestamp
>  config-target.h-timestamp: config-target.mak
>  
> diff --git a/tests/tcg/Makefile.include b/tests/tcg/Makefile.include
> new file mode 100644
> index 0000000000..4851df0951
> --- /dev/null
> +++ b/tests/tcg/Makefile.include
> @@ -0,0 +1,88 @@
> +# -*- Mode: makefile -*-
> +#
> +# TCG tests (per-target rules)
> +#
> +# This Makefile fragement is included from the per-target
> +# Makefile.target so will be invoked for each linux-user program we
> +# build. We have two options for compiling, either using a configured
> +# guest compiler or calling one of our docker images to do it for us.
> +#
> +
> +# The per ARCH makefile, if it exists, holds extra information about
> +# useful docker images or alternative compiler flags.
> +
> +-include $(SRC_PATH)/tests/tcg/$(TARGET_BASE_ARCH)/Makefile.include
> +-include $(SRC_PATH)/tests/tcg/$(TARGET_NAME)/Makefile.include
> +
> +GUEST_BUILD=
> +TCG_MAKE=$(SRC_PATH)/tests/tcg/Makefile
> +# Support installed Cross Compilers
> +
> +ifdef CROSS_CC_GUEST
> +
> +.PHONY: cross-build-guest-tests
> +cross-build-guest-tests:
> +	$(call quiet-command, \
> +	   (mkdir -p tests && cd tests && \
> +	    $(MAKE) -f $(TCG_MAKE) CC=$(CROSS_CC_GUEST) \
> +			BUILD_STATIC=$(CROSS_CC_GUEST_STATIC) \
> +			EXTRA_CFLAGS=$(CROSS_CC_GUEST_CFLAGS)), \
> +	"CROSS-BUILD","$(TARGET_NAME) guest-tests with $(CROSS_CC_GUEST)")
> +
> +GUEST_BUILD=cross-build-guest-tests
> +
> +endif
> +
> +# Support building with Docker
> +
> +ifeq ($(HAVE_USER_DOCKER)$(GUEST_BUILD),y)
> +ifneq ($(DOCKER_IMAGE),)
> +
> +# We also need the Docker make rules to depend on
> +include $(SRC_PATH)/tests/docker/Makefile.include
> +
> +DOCKER_COMPILE_CMD="$(DOCKER_SCRIPT) cc --user $(shell id -u) \
> +		--cc $(DOCKER_CROSS_COMPILER) \
> +		-i qemu:$(DOCKER_IMAGE) \
> +		-s $(SRC_PATH) -- "
> +DOCKER_PREREQ=docker-image-$(DOCKER_IMAGE)
> +
> +.PHONY: docker-build-guest-tests
> +docker-build-guest-tests: $(DOCKER_PREREQ)
> +	$(call quiet-command, \
> +	  (mkdir -p tests && cd tests && \
> +	   $(MAKE) -f $(TCG_MAKE) CC=$(DOCKER_COMPILE_CMD) \
> +			BUILD_STATIC=y \
> +			EXTRA_CFLAGS=$(DOCKER_CROSS_COMPILER_CFLAGS)), \
> +	"CROSS-BUILD","$(TARGET_NAME) guest-tests with docker qemu:$(DOCKER_IMAGE)")
> +
> +GUEST_BUILD=docker-build-guest-tests
> +
> +endif
> +endif
> +
> +# Final targets
> +.PHONY: guest-tests
> +
> +ifneq ($(GUEST_BUILD),)
> +guest-tests: $(GUEST_BUILD)
> +
> +run-guest-tests: guest-tests qemu-$(TARGET_NAME)
> +	$(call quiet-command, \
> +	(cd tests && $(MAKE) -f $(TCG_MAKE) SPEED=$(SPEED) run), \
> +	"RUN-TESTS", "for $(TARGET_NAME)")
> +
> +else
> +guest-tests:
> +	$(call quiet-command, /bin/true, "CROSS-BUILD", \
> +		"$(TARGET_NAME) guest-tests SKIPPED")
> +
> +run-guest-tests:
> +	$(call quiet-command, /bin/true, "RUN-TESTS", \
> +		"for $(TARGET_NAME) SKIPPED")
> +endif
> +
> +# It doesn't mater if these don't exits

"matter"?

> +.PHONY: clean-guest-tests
> +clean-guest-tests:
> +	rm -rf tests || echo "no $(TARGET_NAME) tests to remove"
> 

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
