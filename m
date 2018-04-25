Received: from eggs.gnu.org ([2001:4830:134:3::10]:55177)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fBMXN-0001Zh-4F
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 11:40:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fBMXK-0000yP-F0
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 11:40:53 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:33347)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fBMXK-0000y1-4J
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 11:40:50 -0400
Received: by mail-wr0-x242.google.com with SMTP id o4-v6so3513432wrm.0
	for <qemu-devel@nongnu.org>; Wed, 25 Apr 2018 08:40:49 -0700 (PDT)
References: <20180424152405.10304-1-alex.bennee@linaro.org>
	<20180424152405.10304-46-alex.bennee@linaro.org>
	<71062159-d9c0-06b1-d7d5-32dc4662da6b@amsat.org>
	<fee3b788-513f-d47b-4f5c-ce18894dd101@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <fee3b788-513f-d47b-4f5c-ce18894dd101@amsat.org>
Date: Wed, 25 Apr 2018 16:40:47 +0100
Message-ID: <878t9bl2f4.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: peter.maydell@linaro.org, cota@braap.org, famz@redhat.com, berrange@redhat.com, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, qemu-devel@nongnu.org


Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> On 04/24/2018 08:13 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 04/24/2018 12:24 PM, Alex Benn=C3=A9e wrote:
>>> This will ensure all linux-user targets build their guest test
>>> programs and ensure check-tcg will run the respective tests.
>>>
>>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>> Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>> ---
>>> v2
>>>   - use -include instead of complex macro stuff
>>>   - also include TARGET_BASE_ARCH/Makefile
>>> v3
>>>   - add build-tcg, make check-tcg actually run tests
>>> ---
>>>  tests/Makefile.include     | 26 ++++++++++++++++++++++-
>>>  tests/tcg/Makefile.include | 43 ++++++++++++++++++++++----------------
>>>  2 files changed, 50 insertions(+), 19 deletions(-)
>>>
>>> diff --git a/tests/Makefile.include b/tests/Makefile.include
>>> index 3d2f0458ab..310ccefdd9 100644
>>> --- a/tests/Makefile.include
>>> +++ b/tests/Makefile.include
>>> @@ -10,6 +10,7 @@ check-help:
>>>  	@echo " $(MAKE) check-speed          Run qobject speed tests"
>>>  	@echo " $(MAKE) check-qapi-schema    Run QAPI schema tests"
>>>  	@echo " $(MAKE) check-block          Run block tests"
>>> +	@echo " $(MAKE) check-tcg            Run TCG tests"
>>>  	@echo " $(MAKE) check-report.html    Generates an HTML test report"
>>>  	@echo " $(MAKE) check-clean          Clean the tests"
>>>  	@echo
>>> @@ -916,6 +917,30 @@ check-report.xml: $(patsubst %,check-report-qtest-=
%.xml, $(QTEST_TARGETS)) check
>>>  check-report.html: check-report.xml
>>>  	$(call quiet-command,gtester-report $< > $@,"GEN","$@")
>>>
>>> +# Per guest TCG tests
>>> +
>>> +LINUX_USER_TARGETS=3D$(filter %-linux-user,$(TARGET_LIST))
>>> +BUILD_TCG_TARGET_RULES=3D$(patsubst %,build-tcg-tests-%, $(LINUX_USER_=
TARGETS))
>>> +CLEAN_TCG_TARGET_RULES=3D$(patsubst %,clean-tcg-tests-%, $(LINUX_USER_=
TARGETS))
>>> +RUN_TCG_TARGET_RULES=3D$(patsubst %,run-tcg-tests-%, $(LINUX_USER_TARG=
ETS))
>>> +
>>> +build-tcg-tests-%:
>>> +	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) -C $* V=3D"$(V)" TAR=
GET_DIR=3D"$*/" guest-tests,)
>>> +
>>> +run-tcg-tests-%: build-tcg-tests-%
>>> +	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) -C $* V=3D"$(V)" TAR=
GET_DIR=3D"$*/" run-guest-tests,)
>>> +
>>> +clean-tcg-tests-%:
>>> +	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) -C $* V=3D"$(V)" TAR=
GET_DIR=3D"$*/" clean-guest-tests,)
>>> +
>>> +.PHONY: build-tcg
>>> +build-tcg: $(BUILD_TCG_TARGET_RULES)
>>> +
>>> +.PHONY: check-tcg
>>> +check-tcg: $(RUN_TCG_TARGET_RULES)
>>> +
>>> +.PHONY: clean-tcg
>>> +clean-tcg: $(CLEAN_TCG_TARGET_RULES)
>>>
>>>  # Other tests
>>>
>>> @@ -958,7 +983,6 @@ check-speed: $(patsubst %,check-%, $(check-speed-y))
>>>  check-block: $(patsubst %,check-%, $(check-block-y))
>>>  check: check-qapi-schema check-unit check-qtest check-decodetree
>>>  check-clean:
>>> -	$(MAKE) -C tests/tcg clean
>>>  	rm -rf $(check-unit-y) tests/*.o $(QEMU_IOTESTS_HELPERS-y)
>>>  	rm -rf $(sort $(foreach target,$(SYSEMU_TARGET_LIST), $(check-qtest-$=
(target)-y)) $(check-qtest-generic-y))
>>>  	rm -f tests/test-qapi-gen-timestamp
>>> diff --git a/tests/tcg/Makefile.include b/tests/tcg/Makefile.include
>>> index cb8bb36026..67e89ecb67 100644
>>> --- a/tests/tcg/Makefile.include
>>> +++ b/tests/tcg/Makefile.include
>>> @@ -8,19 +8,14 @@
>>>  # guest compiler or calling one of our docker images to do it for us.
>>>  #
>>>
>>> -# The per ARCH makefile, if it exists holds extra information about
>>> -# useful docker images or alternative compiler flags. Include it if it
>>> -# exists
>>> +# The per ARCH makefile, if it exists, holds extra information about
>>> +# useful docker images or alternative compiler flags.
>>>
>>> -ARCH_MAKEFILE=3D$(SRC_PATH)/tests/tcg/$(TARGET_NAME)/Makefile.include
>>> -CHECK_INCLUDE=3D$(wildcard $(ARCH_MAKEFILE))
>>> -
>>> -ifeq ($(ARCH_MAKEFILE),$(CHECK_INCLUDE))
>>> -include $(ARCH_MAKEFILE)
>>> -endif
>>> +-include $(SRC_PATH)/tests/tcg/$(TARGET_BASE_ARCH)/Makefile.include
>>> +-include $(SRC_PATH)/tests/tcg/$(TARGET_NAME)/Makefile.include
>>>
>>>  GUEST_BUILD=3D
>>> -
>>> +TCG_MAKE=3D$(SRC_PATH)/tests/tcg/Makefile
>>>  # Support installed Cross Compilers
>>>
>>>  ifdef CROSS_CC_GUEST
>>> @@ -28,10 +23,10 @@ ifdef CROSS_CC_GUEST
>>>  .PHONY: cross-build-guest-tests
>>>  cross-build-guest-tests:
>>>  	$(call quiet-command, \
>>> -          (mkdir -p tests && cd tests && \
>>> -	   make -f $(SRC_PATH)/tests/tcg/Makefile ARCH=3D$(TARGET_NAME) CC=3D=
$(CROSS_CC_GUEST)), \
>>> -	  "CROSS-BUILD","$(TARGET_NAME) guest-tests with $(CROSS_CC_GUEST)")
>>> -
>>> +	   (mkdir -p tests && cd tests && \
>>> +	    make -f $(TCG_MAKE) CC=3D$(CROSS_CC_GUEST) \
>>> +				EXTRA_CFLAGS=3D$(CROSS_CC_GUEST_CFLAGS)), \
>>> +	"CROSS-BUILD","$(TARGET_NAME) guest-tests with $(CROSS_CC_GUEST)")
>>>
>>>  GUEST_BUILD=3Dcross-build-guest-tests
>>>
>>> @@ -54,9 +49,10 @@ DOCKER_PREREQ=3Ddocker-image-$(DOCKER_IMAGE)
>>>  .PHONY: docker-build-guest-tests
>>>  docker-build-guest-tests: $(DOCKER_PREREQ)
>>>  	$(call quiet-command, \
>>> -          (mkdir -p tests && cd tests && \
>>> -	   make -f $(SRC_PATH)/tests/tcg/Makefile ARCH=3D$(TARGET_NAME) CC=3D=
$(DOCKER_COMPILE_CMD)), \
>>> -	  "CROSS-BUILD","$(TARGET_NAME) guest-tests with docker qemu:$(DOCKER=
_IMAGE)")
>>> +	  (mkdir -p tests && cd tests && \
>>> +	   make -f $(TCG_MAKE) CC=3D$(DOCKER_COMPILE_CMD) \
>>> +			       EXTRA_CFLAGS=3D$(DOCKER_CROSS_COMPILER_CFLAGS)), \
>>> +	"CROSS-BUILD","$(TARGET_NAME) guest-tests with docker qemu:$(DOCKER_I=
MAGE)")
>>
>> I'm not sure this is working as expected, for some reason "make
>> build-tcg-tests-aarch64-linux-user" try to use the debian-armel-cross im=
age:
>>
>> /build$ make build-tcg-tests-aarch64-linux-user V=3D1 -j1
>> make  BUILD_DIR=3D/build -C aarch64-linux-user V=3D"1"
>> TARGET_DIR=3D"aarch64-linux-user/" guest-tests
>> make[1]: Entering directory '/build/aarch64-linux-user'
>> /source/qemu/tests/docker/docker.py build qemu:debian9
>> /source/qemu/tests/docker/dockerfiles/debian9.docker   --add-current-user
>> [...]
>> /source/qemu/tests/docker/docker.py build qemu:debian-armel-cross
>> /source/qemu/tests/docker/dockerfiles/debian-armel-cross.docker
>> --add-current-user
>> [...]
>> (mkdir -p tests && cd tests && make -f /source/qemu/tests/tcg/Makefile
>> CC=3D"/source/qemu/tests/docker/docker.py cc --user 1000 --cc
>> arm-linux-gnueabi-gcc -i qemu:debian-armel-cross -s /source/qemu -- "
>> EXTRA_CFLAGS=3D)
>> make[2]: Entering directory '/home/phil/build/aarch64-linux-user/tests'
>> /source/qemu/tests/docker/docker.py cc --user 1000 --cc
>> arm-linux-gnueabi-gcc -i qemu:debian-armel-cross -s /source/qemu --
>> -Wall -O0 -g -fno-strict-aliasing  /source/qemu/tests/tcg/aarch64/fcvt.c
>> -o fcvt  -static -lm
>> /source/qemu/tests/tcg/aarch64/fcvt.c: In function 'print_double_number':
>> /source/qemu/tests/tcg/aarch64/fcvt.c:37:42: warning: format '%lx'
>> expects argument of type 'long unsigned int', but argument 4 has type
>> 'uint64_t {aka long long unsigned int}' [-Wformat=3D]
>>      printf("%02d DOUBLE: %02.20e / %#020lx  (%#x =3D> %s)\n",
>>                                           ^
>> /source/qemu/tests/tcg/aarch64/fcvt.c: In function 'convert_single_to_ha=
lf':
>> /source/qemu/tests/tcg/aarch64/fcvt.c:82:9: error: inconsistent operand
>> constraints in an 'asm'
>>          asm("fcvt %h0, %d1" : "=3Dw" (output) : "x" (input));
>>          ^~~
>> /source/qemu/tests/tcg/aarch64/fcvt.c: In function 'main':
>> /source/qemu/tests/tcg/aarch64/fcvt.c:241:5: error: unknown register
>> name 'x1' in 'asm'
>>      asm("msr fpsr, x1\n\t"
>>      ^~~
>> make[2]: *** [/source/qemu/tests/tcg/Makefile:49: fcvt] Error 1
>> make[2]: Leaving directory '/home/phil/build/aarch64-linux-user/tests'
>> make[1]: *** [/source/qemu/tests/tcg/Makefile.include:51:
>> docker-build-guest-tests] Error 2
>> make[1]: Leaving directory '/home/phil/build/aarch64-linux-user'
>> make: *** [/source/qemu/tests/Makefile.include:928:
>> build-tcg-tests-aarch64-linux-user] Error 2
>>
>> Note this:
>>
>> Entering directory '/build/aarch64-linux-user'
>> [...]
>> docker.py build qemu:debian-armel-cross ...
>>
>> I'm not sure this is related to this patch or the previous (44).
>
> This is due to the missing tests/tcg/aarch64/Makefile.include in patch
> 28/46.
>
>>>
>>>  GUEST_BUILD=3Ddocker-build-guest-tests
>>>
>>> @@ -68,9 +64,20 @@ endif
>>>
>>>  ifneq ($(GUEST_BUILD),)
>>>  guest-tests: $(GUEST_BUILD)
>>> +
>>> +run-guest-tests: guest-tests
>>> +	$(call quiet-command, \
>>> +	(cd tests && make -f $(TCG_MAKE) run), \
>>> +	"RUN-TESTS", "for $(TARGET_NAME)")
>>> +
>>>  else
>>>  guest-tests:
>>> -	$(call quiet-command, /bin/true, "CROSS-BUILD", "$(TARGET_NAME) guest=
-tests SKIPPED")
>>> +	$(call quiet-command, /bin/true, "CROSS-BUILD", \
>>> +		"$(TARGET_NAME) guest-tests SKIPPED")
>>> +
>>> +run-guest-tests:
>>> +	$(call quiet-command, /bin/true, "RUN-TESTS", \
>>> +		"for $(TARGET_NAME) SKIPPED")
>>>  endif
>>>
>>>  # It doesn't mater if these don't exits
>>>
>
> There is still some rule missing:
>
> $ make -j1 run-tcg-tests-sh4-linux-user  -k
>   BUILD   debian-sid
>   BUILD   debian-sh4-cross
>   CROSS-BUILD sh4 guest-tests with docker qemu:debian-sh4-cross
>   BUILD   debian-sid
>   BUILD   debian-sh4-cross
>   CROSS-BUILD sh4 guest-tests with docker qemu:debian-sh4-cross
>   RUN-TESTS for sh4
>   TEST    test-mmap (default) on sh4
> /bin/sh: 1: ../qemu-sh4: not found
> make[2]: *** [/source/qemu/tests/tcg/multiarch/Makefile.target:26:
> run-test-mmap] Error 127
>   TEST    sha1 on sh4
> /bin/sh: 1: ../qemu-sh4: not found
> make[2]: *** [/source/qemu/tests/tcg/Makefile:64: run-sha1] Error 127
>   BROKEN TEST linux-test SKIPPED on sh4
>   TEST    testthread on sh4
> /bin/sh: 1: ../qemu-sh4: not found
> make[2]: *** [/source/qemu/tests/tcg/Makefile:64: run-testthread] Error 1=
27
> make[2]: Target 'run' not remade because of errors.
> make[1]: *** [/source/qemu/tests/tcg/Makefile.include:69:
> run-guest-tests] Error 2
> make: *** [/source/qemu/tests/Makefile.include:931:
> run-tcg-tests-sh4-linux-user] Error 2
>
> Works with:
>
> $ make -j1 subdir-sh4-linux-user run-tcg-tests-sh4-linux-user

I've added:

run-guest-tests: guest-tests qemu-$(TARGET_NAME)
	$(call quiet-command, \
	(cd tests && make -f $(TCG_MAKE) run), \
	"RUN-TESTS", "for $(TARGET_NAME)")

to tests/tcg/Makefile.include


--
Alex Benn=C3=A9e
