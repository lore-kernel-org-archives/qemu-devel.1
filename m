Received: from eggs.gnu.org ([2001:4830:134:3::10]:54814)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f7ztT-0000cY-QG
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 04:53:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f7ztQ-00062n-HY
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 04:53:47 -0400
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:43173)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f7ztQ-000623-7P
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 04:53:44 -0400
Received: by mail-wr0-x236.google.com with SMTP id y7so23621417wrh.10
	for <qemu-devel@nongnu.org>; Mon, 16 Apr 2018 01:53:44 -0700 (PDT)
References: <20180410193919.28026-1-alex.bennee@linaro.org>
	<20180410193919.28026-24-alex.bennee@linaro.org>
	<8838744d-6952-38ea-6cee-a151e30fdbca@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <8838744d-6952-38ea-6cee-a151e30fdbca@amsat.org>
Date: Mon, 16 Apr 2018 09:53:41 +0100
Message-ID: <87efjfbkh6.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, famz@redhat.com, cota@braap.org


Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> On 04/10/2018 04:39 PM, Alex Benn=C3=A9e wrote:
>> Now all the build infrastructure is in place we can build tests for
>> each guest that we support. That support mainly depends on having
>> cross compilers installed or docker setup. To keep all the logic for
>> that together we put the rules in tests/tcg/Makefile.include and
>> include it from the main Makefile.target.
>>=20
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  Makefile.target            |  5 +++
>>  tests/tcg/Makefile.include | 79 +++++++++++++++++++++++++++++++++++++++=
+++++++
>>  2 files changed, 84 insertions(+)
>>  create mode 100644 tests/tcg/Makefile.include
>>=20
>> diff --git a/Makefile.target b/Makefile.target
>> index d0ec77a307..a30fd40257 100644
>> --- a/Makefile.target
>> +++ b/Makefile.target
>> @@ -36,6 +36,11 @@ endif
>>  PROGS=3D$(QEMU_PROG) $(QEMU_PROGW)
>>  STPFILES=3D
>>=20=20
>> +# Makefile Tests
>> +ifdef CONFIG_USER_ONLY
>> +include $(SRC_PATH)/tests/tcg/Makefile.include
>> +endif
>> +
>>  config-target.h: config-target.h-timestamp
>>  config-target.h-timestamp: config-target.mak
>>=20=20
>> diff --git a/tests/tcg/Makefile.include b/tests/tcg/Makefile.include
>> new file mode 100644
>> index 0000000000..cb8bb36026
>> --- /dev/null
>> +++ b/tests/tcg/Makefile.include
>> @@ -0,0 +1,79 @@
>> +# -*- Mode: makefile -*-
>> +#
>> +# TCG tests (per-target rules)
>> +#
>> +# This Makefile fragement is included from the per-target
>> +# Makefile.target so will be invoked for each linux-user program we
>> +# build. We have two options for compiling, either using a configured
>> +# guest compiler or calling one of our docker images to do it for us.
>> +#
>> +
>> +# The per ARCH makefile, if it exists holds extra information about
>> +# useful docker images or alternative compiler flags. Include it if it
>> +# exists
>> +
>> +ARCH_MAKEFILE=3D$(SRC_PATH)/tests/tcg/$(TARGET_NAME)/Makefile.include
>> +CHECK_INCLUDE=3D$(wildcard $(ARCH_MAKEFILE))
>> +
>> +ifeq ($(ARCH_MAKEFILE),$(CHECK_INCLUDE))
>> +include $(ARCH_MAKEFILE)
>> +endif
>> +
>> +GUEST_BUILD=3D
>> +
>> +# Support installed Cross Compilers
>> +
>> +ifdef CROSS_CC_GUEST
>> +
>> +.PHONY: cross-build-guest-tests
>> +cross-build-guest-tests:
>> +	$(call quiet-command, \
>> +          (mkdir -p tests && cd tests && \
>> +	   make -f $(SRC_PATH)/tests/tcg/Makefile ARCH=3D$(TARGET_NAME) CC=3D$=
(CROSS_CC_GUEST)), \
>> +	  "CROSS-BUILD","$(TARGET_NAME) guest-tests with $(CROSS_CC_GUEST)")
>> +
>> +
>> +GUEST_BUILD=3Dcross-build-guest-tests
>> +
>> +endif
>> +
>> +# Support building with Docker
>> +
>> +ifeq ($(HAVE_USER_DOCKER)$(GUEST_BUILD),y)
>> +ifneq ($(DOCKER_IMAGE),)
>> +
>> +# We also need the Docker make rules to depend on
>> +include $(SRC_PATH)/tests/docker/Makefile.include
>> +
>
> Eventually:
>
> DOCKER_CROSS_COMPILER ?=3D $(DOCKER_CROSS_COMPILER_PREFIX)-gcc
>
>> +DOCKER_COMPILE_CMD=3D"$(DOCKER_SCRIPT) cc --user $(shell id -u) \
>> +		--cc $(DOCKER_CROSS_COMPILER) \
>> +		-i qemu:$(DOCKER_IMAGE) \
>> +		-s $(SRC_PATH) -- "
>
> Should we check $(DOCKER_CROSS_COMPILER) is set?

Currently it's implied. It would be nice if there was an easy way just
to fish it out of the env of the docker image as they already have it
set there.

I've been trying quite hard to ensure all the tests can just use LD (see
the hoops I jump in i386 for this). Maybe a prefix config makes more
sense though....

>
>> +DOCKER_PREREQ=3Ddocker-image-$(DOCKER_IMAGE)
>> +
>> +.PHONY: docker-build-guest-tests
>> +docker-build-guest-tests: $(DOCKER_PREREQ)
>> +	$(call quiet-command, \
>> +          (mkdir -p tests && cd tests && \
>> +	   make -f $(SRC_PATH)/tests/tcg/Makefile ARCH=3D$(TARGET_NAME) CC=3D$=
(DOCKER_COMPILE_CMD)), \
>> +	  "CROSS-BUILD","$(TARGET_NAME) guest-tests with docker qemu:$(DOCKER_=
IMAGE)")
>> +
>> +GUEST_BUILD=3Ddocker-build-guest-tests
>> +
>> +endif
>> +endif
>> +
>> +# Final targets
>> +.PHONY: guest-tests
>> +
>> +ifneq ($(GUEST_BUILD),)
>> +guest-tests: $(GUEST_BUILD)
>> +else
>> +guest-tests:
>> +	$(call quiet-command, /bin/true, "CROSS-BUILD", "$(TARGET_NAME) guest-=
tests SKIPPED")
>> +endif
>> +
>> +# It doesn't mater if these don't exits
>> +.PHONY: clean-guest-tests
>> +clean-guest-tests:
>> +	rm -rf tests || echo "no $(TARGET_NAME) tests to remove"
>>=20


--=20
Alex Benn=C3=A9e
