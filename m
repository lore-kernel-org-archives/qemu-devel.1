Received: from eggs.gnu.org ([2001:4830:134:3::10]:46263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fSH60-0003Ht-Ha
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 03:18:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fSH5w-0000q4-CW
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 03:18:32 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:41512)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fSH5w-0000pY-68
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 03:18:28 -0400
Received: by mail-wr0-x243.google.com with SMTP id h10-v6so19144567wrq.8
	for <qemu-devel@nongnu.org>; Mon, 11 Jun 2018 00:18:28 -0700 (PDT)
References: <20180608123307.24773-1-alex.bennee@linaro.org>
	<20180608123307.24773-48-alex.bennee@linaro.org>
	<b1ceee53-fbb2-5e46-75db-255ad5c5c351@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <b1ceee53-fbb2-5e46-75db-255ad5c5c351@amsat.org>
Date: Mon, 11 Jun 2018 08:18:26 +0100
Message-ID: <87bmch94fx.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 47/49] tests: add top-level make
 dependency for docker builds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: cota@braap.org, famz@redhat.com, berrange@redhat.com, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, pbonzini@redhat.com, stefanha@redhat.com, stefanb@linux.vnet.ibm.com, marcandre.lureau@redhat.com, qemu-devel@nongnu.org


Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> On 06/08/2018 09:33 AM, Alex Benn=C3=A9e wrote:
>> One problem with satisfying your docker dependencies in a sub-make it
>> you might end up trying to satisfy the dependency multiple times. This
>> is especially a problem with debian-sid based cross compilers and CI
>> setups. We solve this by doing a docker build pass at the top level
>> before any sub-makes are called.
>>
>> We still need to satisfy dependencies in the Makefile.target call so
>> people can run tests from individual target directories. We introduce
>> a new Makefile.probe which gets called for each PROBE_TARGET and
>> allows us to build up the list. It does require multiply including
>> config-target.mak which shouldn't cause any issues as it shouldn't
>> define anything that clashes with config-host.mak. However we undefine
>> a few key variables each time around.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  tests/Makefile.include   | 14 +++++++++++++-
>>  tests/tcg/Makefile.probe | 31 +++++++++++++++++++++++++++++++
>>  2 files changed, 44 insertions(+), 1 deletion(-)
>>  create mode 100644 tests/tcg/Makefile.probe
>>
>> diff --git a/tests/Makefile.include b/tests/Makefile.include
>> index ca00247e36..049a387436 100644
>> --- a/tests/Makefile.include
>> +++ b/tests/Makefile.include
>> @@ -931,7 +931,19 @@ BUILD_TCG_TARGET_RULES=3D$(patsubst %,build-tcg-tes=
ts-%, $(LINUX_USER_TARGETS))
>>  CLEAN_TCG_TARGET_RULES=3D$(patsubst %,clean-tcg-tests-%, $(LINUX_USER_T=
ARGETS))
>>  RUN_TCG_TARGET_RULES=3D$(patsubst %,run-tcg-tests-%, $(LINUX_USER_TARGE=
TS))
>>
>> -build-tcg-tests-%:
>> +# Probe for the Docker Builds we need for later
>> +DOCKER_BUILD_TARGETS:=3D
>> +$(foreach PROBE_TARGET,$(TARGET_LIST), 				\
>> +	$(eval -include $(SRC_PATH)/tests/tcg/Makefile.probe) 	\
>> +	$(if $(DOCKER_PREREQ), 					\
>> +		$(eval DOCKER_BUILD_TARGETS+=3D$(DOCKER_PREREQ))))
>> +
>> +$(info DOCKER_BUILD_TARGETS=3D$(sort $(DOCKER_BUILD_TARGETS)))
>> +
>> +.PHONY: build-docker-prereqs
>> +build-docker-prereqs: $(sort $(DOCKER_BUILD_TARGETS))
>
> It seems now all docker images are built, even if you want to test a
> single arch... Using ~7GB of storage at once.

I've moved build-docker-prereqs to build-tcg and made check-tcg depend
on that. The single arch test case now relies on the sub-make building
things.

>
>> +
>> +build-tcg-tests-%: build-docker-prereqs
>>  	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) -C $* V=3D"$(V)" TARG=
ET_DIR=3D"$*/" guest-tests,)
>>
>>  run-tcg-tests-%: build-tcg-tests-%
>> diff --git a/tests/tcg/Makefile.probe b/tests/tcg/Makefile.probe
>> new file mode 100644
>> index 0000000000..7529e203ad
>> --- /dev/null
>> +++ b/tests/tcg/Makefile.probe
>> @@ -0,0 +1,31 @@
>> +# -*- Mode: makefile -*-
>> +#
>> +# TCG Compiler Probe
>> +#
>> +# This Makefile fragement is included multiple times in the main make
>> +# script to probe for available compilers. This is used to build up a
>> +# selection of required docker targets before we invoke a sub-make for
>> +# each target.
>> +
>> +# First we need the target makefile which tells us the target architect=
ure
>> +-include $(BUILD_DIR)/$(PROBE_TARGET)/config-target.mak
>> +
>> +# Then we load up the target architecture makefiles which tell us
>> +# about the compilers
>> +undefine CROSS_CC_GUEST
>> +undefine DOCKER_IMAGE
>> +DOCKER_PREREQ:=3D
>> +
>> +-include $(SRC_PATH)/tests/tcg/$(TARGET_BASE_ARCH)/Makefile.include
>> +-include $(SRC_PATH)/tests/tcg/$(TARGET_NAME)/Makefile.include
>> +
>> +ifndef CROSS_CC_GUEST
>> +ifneq ($(DOCKER_IMAGE),)
>> +DOCKER_PREREQ:=3Ddocker-image-$(DOCKER_IMAGE)
>> +endif
>> +endif
>> +
>> +# Clean-up
>> +undefine TARGET_NAME
>> +undefine TARGET_BASE_ARCH
>> +undefine TARGET_ABI_DIR
>>


--
Alex Benn=C3=A9e
