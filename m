Received: from eggs.gnu.org ([2001:4830:134:3::10]:45400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f7shg-0000B4-NC
	for qemu-devel@nongnu.org; Sun, 15 Apr 2018 21:13:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f7shb-0006EE-K9
	for qemu-devel@nongnu.org; Sun, 15 Apr 2018 21:13:08 -0400
Received: from mail-qt0-x234.google.com ([2607:f8b0:400d:c0d::234]:44716)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f7shb-0006E6-Ds
	for qemu-devel@nongnu.org; Sun, 15 Apr 2018 21:13:03 -0400
Received: by mail-qt0-x234.google.com with SMTP id j26so13672615qtl.11
	for <qemu-devel@nongnu.org>; Sun, 15 Apr 2018 18:13:03 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180410193919.28026-1-alex.bennee@linaro.org>
	<20180410193919.28026-24-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <2d2a5aab-518e-f4b7-b328-5378f63b47b9@amsat.org>
Date: Sun, 15 Apr 2018 22:12:59 -0300
MIME-Version: 1.0
In-Reply-To: <20180410193919.28026-24-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 23/24] Makefile.target: add
 (clean-)guest-tests targets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: famz@redhat.com, cota@braap.org

Hi Alex,

On 04/10/2018 04:39 PM, Alex Bennée wrote:
> Now all the build infrastructure is in place we can build tests for
> each guest that we support. That support mainly depends on having
> cross compilers installed or docker setup. To keep all the logic for
> that together we put the rules in tests/tcg/Makefile.include and
> include it from the main Makefile.target.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  Makefile.target            |  5 +++
>  tests/tcg/Makefile.include | 79 ++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 84 insertions(+)
>  create mode 100644 tests/tcg/Makefile.include
> 
> diff --git a/Makefile.target b/Makefile.target
> index d0ec77a307..a30fd40257 100644
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
> index 0000000000..cb8bb36026
> --- /dev/null
> +++ b/tests/tcg/Makefile.include
> @@ -0,0 +1,79 @@
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
> +# The per ARCH makefile, if it exists holds extra information about
> +# useful docker images or alternative compiler flags. Include it if it
> +# exists
> +
> +ARCH_MAKEFILE=$(SRC_PATH)/tests/tcg/$(TARGET_NAME)/Makefile.include

What about Makefile.cross, cross.mak or even cross-$ARCH.mak?

> +CHECK_INCLUDE=$(wildcard $(ARCH_MAKEFILE))
> +
> +ifeq ($(ARCH_MAKEFILE),$(CHECK_INCLUDE))
> +include $(ARCH_MAKEFILE)
> +endif
> +
> +GUEST_BUILD=
> +
> +# Support installed Cross Compilers
> +
> +ifdef CROSS_CC_GUEST
> +
> +.PHONY: cross-build-guest-tests
> +cross-build-guest-tests:
> +	$(call quiet-command, \
> +          (mkdir -p tests && cd tests && \
> +	   make -f $(SRC_PATH)/tests/tcg/Makefile ARCH=$(TARGET_NAME) CC=$(CROSS_CC_GUEST)), \
> +	  "CROSS-BUILD","$(TARGET_NAME) guest-tests with $(CROSS_CC_GUEST)")
> +
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
> +          (mkdir -p tests && cd tests && \
> +	   make -f $(SRC_PATH)/tests/tcg/Makefile ARCH=$(TARGET_NAME) CC=$(DOCKER_COMPILE_CMD)), \
> +	  "CROSS-BUILD","$(TARGET_NAME) guest-tests with docker qemu:$(DOCKER_IMAGE)")
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
> +else
> +guest-tests:
> +	$(call quiet-command, /bin/true, "CROSS-BUILD", "$(TARGET_NAME) guest-tests SKIPPED")
> +endif
> +
> +# It doesn't mater if these don't exits
> +.PHONY: clean-guest-tests
> +clean-guest-tests:
> +	rm -rf tests || echo "no $(TARGET_NAME) tests to remove"
> 
