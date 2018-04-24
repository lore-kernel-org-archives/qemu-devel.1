Received: from eggs.gnu.org ([2001:4830:134:3::10]:54319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fB77n-0006eF-GR
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 19:13:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fB77k-0006SJ-4Y
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 19:13:27 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:45671)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fB77j-0006S5-Vj
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 19:13:24 -0400
Received: by mail-qt0-x244.google.com with SMTP id b13-v6so24504488qtp.12
	for <qemu-devel@nongnu.org>; Tue, 24 Apr 2018 16:13:23 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180424152405.10304-1-alex.bennee@linaro.org>
	<20180424152405.10304-46-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <71062159-d9c0-06b1-d7d5-32dc4662da6b@amsat.org>
Date: Tue, 24 Apr 2018 20:13:18 -0300
MIME-Version: 1.0
In-Reply-To: <20180424152405.10304-46-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 45/46] tests/Makefile.include: add
 [build|clean|check]-tcg targets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org, cota@braap.org, famz@redhat.com, berrange@redhat.com, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org

Hi Alex,

On 04/24/2018 12:24 PM, Alex Bennée wrote:
> This will ensure all linux-user targets build their guest test
> programs and ensure check-tcg will run the respective tests.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
> v2
>   - use -include instead of complex macro stuff
>   - also include TARGET_BASE_ARCH/Makefile
> v3
>   - add build-tcg, make check-tcg actually run tests
> ---
>  tests/Makefile.include     | 26 ++++++++++++++++++++++-
>  tests/tcg/Makefile.include | 43 ++++++++++++++++++++++----------------
>  2 files changed, 50 insertions(+), 19 deletions(-)
> 
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 3d2f0458ab..310ccefdd9 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -10,6 +10,7 @@ check-help:
>  	@echo " $(MAKE) check-speed          Run qobject speed tests"
>  	@echo " $(MAKE) check-qapi-schema    Run QAPI schema tests"
>  	@echo " $(MAKE) check-block          Run block tests"
> +	@echo " $(MAKE) check-tcg            Run TCG tests"
>  	@echo " $(MAKE) check-report.html    Generates an HTML test report"
>  	@echo " $(MAKE) check-clean          Clean the tests"
>  	@echo
> @@ -916,6 +917,30 @@ check-report.xml: $(patsubst %,check-report-qtest-%.xml, $(QTEST_TARGETS)) check
>  check-report.html: check-report.xml
>  	$(call quiet-command,gtester-report $< > $@,"GEN","$@")
>  
> +# Per guest TCG tests
> +
> +LINUX_USER_TARGETS=$(filter %-linux-user,$(TARGET_LIST))
> +BUILD_TCG_TARGET_RULES=$(patsubst %,build-tcg-tests-%, $(LINUX_USER_TARGETS))
> +CLEAN_TCG_TARGET_RULES=$(patsubst %,clean-tcg-tests-%, $(LINUX_USER_TARGETS))
> +RUN_TCG_TARGET_RULES=$(patsubst %,run-tcg-tests-%, $(LINUX_USER_TARGETS))
> +
> +build-tcg-tests-%:
> +	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) -C $* V="$(V)" TARGET_DIR="$*/" guest-tests,)
> +
> +run-tcg-tests-%: build-tcg-tests-%
> +	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) -C $* V="$(V)" TARGET_DIR="$*/" run-guest-tests,)
> +
> +clean-tcg-tests-%:
> +	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) -C $* V="$(V)" TARGET_DIR="$*/" clean-guest-tests,)
> +
> +.PHONY: build-tcg
> +build-tcg: $(BUILD_TCG_TARGET_RULES)
> +
> +.PHONY: check-tcg
> +check-tcg: $(RUN_TCG_TARGET_RULES)
> +
> +.PHONY: clean-tcg
> +clean-tcg: $(CLEAN_TCG_TARGET_RULES)
>  
>  # Other tests
>  
> @@ -958,7 +983,6 @@ check-speed: $(patsubst %,check-%, $(check-speed-y))
>  check-block: $(patsubst %,check-%, $(check-block-y))
>  check: check-qapi-schema check-unit check-qtest check-decodetree
>  check-clean:
> -	$(MAKE) -C tests/tcg clean
>  	rm -rf $(check-unit-y) tests/*.o $(QEMU_IOTESTS_HELPERS-y)
>  	rm -rf $(sort $(foreach target,$(SYSEMU_TARGET_LIST), $(check-qtest-$(target)-y)) $(check-qtest-generic-y))
>  	rm -f tests/test-qapi-gen-timestamp
> diff --git a/tests/tcg/Makefile.include b/tests/tcg/Makefile.include
> index cb8bb36026..67e89ecb67 100644
> --- a/tests/tcg/Makefile.include
> +++ b/tests/tcg/Makefile.include
> @@ -8,19 +8,14 @@
>  # guest compiler or calling one of our docker images to do it for us.
>  #
>  
> -# The per ARCH makefile, if it exists holds extra information about
> -# useful docker images or alternative compiler flags. Include it if it
> -# exists
> +# The per ARCH makefile, if it exists, holds extra information about
> +# useful docker images or alternative compiler flags.
>  
> -ARCH_MAKEFILE=$(SRC_PATH)/tests/tcg/$(TARGET_NAME)/Makefile.include
> -CHECK_INCLUDE=$(wildcard $(ARCH_MAKEFILE))
> -
> -ifeq ($(ARCH_MAKEFILE),$(CHECK_INCLUDE))
> -include $(ARCH_MAKEFILE)
> -endif
> +-include $(SRC_PATH)/tests/tcg/$(TARGET_BASE_ARCH)/Makefile.include
> +-include $(SRC_PATH)/tests/tcg/$(TARGET_NAME)/Makefile.include
>  
>  GUEST_BUILD=
> -
> +TCG_MAKE=$(SRC_PATH)/tests/tcg/Makefile
>  # Support installed Cross Compilers
>  
>  ifdef CROSS_CC_GUEST
> @@ -28,10 +23,10 @@ ifdef CROSS_CC_GUEST
>  .PHONY: cross-build-guest-tests
>  cross-build-guest-tests:
>  	$(call quiet-command, \
> -          (mkdir -p tests && cd tests && \
> -	   make -f $(SRC_PATH)/tests/tcg/Makefile ARCH=$(TARGET_NAME) CC=$(CROSS_CC_GUEST)), \
> -	  "CROSS-BUILD","$(TARGET_NAME) guest-tests with $(CROSS_CC_GUEST)")
> -
> +	   (mkdir -p tests && cd tests && \
> +	    make -f $(TCG_MAKE) CC=$(CROSS_CC_GUEST) \
> +				EXTRA_CFLAGS=$(CROSS_CC_GUEST_CFLAGS)), \
> +	"CROSS-BUILD","$(TARGET_NAME) guest-tests with $(CROSS_CC_GUEST)")
>  
>  GUEST_BUILD=cross-build-guest-tests
>  
> @@ -54,9 +49,10 @@ DOCKER_PREREQ=docker-image-$(DOCKER_IMAGE)
>  .PHONY: docker-build-guest-tests
>  docker-build-guest-tests: $(DOCKER_PREREQ)
>  	$(call quiet-command, \
> -          (mkdir -p tests && cd tests && \
> -	   make -f $(SRC_PATH)/tests/tcg/Makefile ARCH=$(TARGET_NAME) CC=$(DOCKER_COMPILE_CMD)), \
> -	  "CROSS-BUILD","$(TARGET_NAME) guest-tests with docker qemu:$(DOCKER_IMAGE)")
> +	  (mkdir -p tests && cd tests && \
> +	   make -f $(TCG_MAKE) CC=$(DOCKER_COMPILE_CMD) \
> +			       EXTRA_CFLAGS=$(DOCKER_CROSS_COMPILER_CFLAGS)), \
> +	"CROSS-BUILD","$(TARGET_NAME) guest-tests with docker qemu:$(DOCKER_IMAGE)")

I'm not sure this is working as expected, for some reason "make
build-tcg-tests-aarch64-linux-user" try to use the debian-armel-cross image:

/build$ make build-tcg-tests-aarch64-linux-user V=1 -j1
make  BUILD_DIR=/build -C aarch64-linux-user V="1"
TARGET_DIR="aarch64-linux-user/" guest-tests
make[1]: Entering directory '/build/aarch64-linux-user'
/source/qemu/tests/docker/docker.py build qemu:debian9
/source/qemu/tests/docker/dockerfiles/debian9.docker   --add-current-user
[...]
/source/qemu/tests/docker/docker.py build qemu:debian-armel-cross
/source/qemu/tests/docker/dockerfiles/debian-armel-cross.docker
--add-current-user
[...]
(mkdir -p tests && cd tests && make -f /source/qemu/tests/tcg/Makefile
CC="/source/qemu/tests/docker/docker.py cc --user 1000 --cc
arm-linux-gnueabi-gcc -i qemu:debian-armel-cross -s /source/qemu -- "
EXTRA_CFLAGS=)
make[2]: Entering directory '/home/phil/build/aarch64-linux-user/tests'
/source/qemu/tests/docker/docker.py cc --user 1000 --cc
arm-linux-gnueabi-gcc -i qemu:debian-armel-cross -s /source/qemu --
-Wall -O0 -g -fno-strict-aliasing  /source/qemu/tests/tcg/aarch64/fcvt.c
-o fcvt  -static -lm
/source/qemu/tests/tcg/aarch64/fcvt.c: In function 'print_double_number':
/source/qemu/tests/tcg/aarch64/fcvt.c:37:42: warning: format '%lx'
expects argument of type 'long unsigned int', but argument 4 has type
'uint64_t {aka long long unsigned int}' [-Wformat=]
     printf("%02d DOUBLE: %02.20e / %#020lx  (%#x => %s)\n",
                                          ^
/source/qemu/tests/tcg/aarch64/fcvt.c: In function 'convert_single_to_half':
/source/qemu/tests/tcg/aarch64/fcvt.c:82:9: error: inconsistent operand
constraints in an 'asm'
         asm("fcvt %h0, %d1" : "=w" (output) : "x" (input));
         ^~~
/source/qemu/tests/tcg/aarch64/fcvt.c: In function 'main':
/source/qemu/tests/tcg/aarch64/fcvt.c:241:5: error: unknown register
name 'x1' in 'asm'
     asm("msr fpsr, x1\n\t"
     ^~~
make[2]: *** [/source/qemu/tests/tcg/Makefile:49: fcvt] Error 1
make[2]: Leaving directory '/home/phil/build/aarch64-linux-user/tests'
make[1]: *** [/source/qemu/tests/tcg/Makefile.include:51:
docker-build-guest-tests] Error 2
make[1]: Leaving directory '/home/phil/build/aarch64-linux-user'
make: *** [/source/qemu/tests/Makefile.include:928:
build-tcg-tests-aarch64-linux-user] Error 2

Note this:

Entering directory '/build/aarch64-linux-user'
[...]
docker.py build qemu:debian-armel-cross ...

I'm not sure this is related to this patch or the previous (44).

>  
>  GUEST_BUILD=docker-build-guest-tests
>  
> @@ -68,9 +64,20 @@ endif
>  
>  ifneq ($(GUEST_BUILD),)
>  guest-tests: $(GUEST_BUILD)
> +
> +run-guest-tests: guest-tests
> +	$(call quiet-command, \
> +	(cd tests && make -f $(TCG_MAKE) run), \
> +	"RUN-TESTS", "for $(TARGET_NAME)")
> +
>  else
>  guest-tests:
> -	$(call quiet-command, /bin/true, "CROSS-BUILD", "$(TARGET_NAME) guest-tests SKIPPED")
> +	$(call quiet-command, /bin/true, "CROSS-BUILD", \
> +		"$(TARGET_NAME) guest-tests SKIPPED")
> +
> +run-guest-tests:
> +	$(call quiet-command, /bin/true, "RUN-TESTS", \
> +		"for $(TARGET_NAME) SKIPPED")
>  endif
>  
>  # It doesn't mater if these don't exits
> 
