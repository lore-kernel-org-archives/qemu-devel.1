Received: from eggs.gnu.org ([209.51.188.92]:59385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <michael@walle.cc>) id 1gpcrF-0005WN-8b
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 12:44:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <michael@walle.cc>) id 1gpcrB-0000HS-Dp
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 12:44:03 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:48753)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <michael@walle.cc>) id 1gpcr9-0000E4-Ck
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 12:43:59 -0500
Date: Fri, 01 Feb 2019 18:43:50 +0100
In-Reply-To: <875zu3v2il.fsf@zen.linaroharston>
References: <20190131215611.29341-1-michael@walle.cc>
	<20190131215611.29341-3-michael@walle.cc>
	<875zu3v2il.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Michael Walle <michael@walle.cc>
Message-ID: <A216856C-172D-4734-A33E-AD9CC6058DB5@walle.cc>
Subject: Re: [Qemu-devel] [RFC PATCH 2/3] tests/tcg: also pass AS and LD
 variables
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?ISO-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org

Am 1=2E Februar 2019 18:31:46 MEZ schrieb "Alex Benn=C3=A9e" <alex=2Ebennee=
@linaro=2Eorg>:
>
>Michael Walle <michael@walle=2Ecc> writes:
>
>> The lm32 architecture doesn't need the complete compiler=2E In fact,
>only
>> the building of GCC is skipped to make building the docker image
>faster=2E
>>
>> Signed-off-by: Michael Walle <michael@walle=2Ecc>
>> ---
>>  tests/tcg/Makefile=2Einclude | 13 +++++++++++--
>>  1 file changed, 11 insertions(+), 2 deletions(-)
>>
>> diff --git a/tests/tcg/Makefile=2Einclude b/tests/tcg/Makefile=2Einclud=
e
>> index 73b5626fc5=2E=2E19b81400f5 100644
>> --- a/tests/tcg/Makefile=2Einclude
>> +++ b/tests/tcg/Makefile=2Einclude
>> @@ -41,17 +41,26 @@ ifneq ($(DOCKER_IMAGE),)
>>  # We also need the Docker make rules to depend on
>>  include $(SRC_PATH)/tests/docker/Makefile=2Einclude
>>
>> -DOCKER_COMPILE_CMD=3D"$(DOCKER_SCRIPT) cc --user $(shell id -u) \
>> +DOCKER_CC_CMD=3D"$(DOCKER_SCRIPT) cc --user $(shell id -u) \
>>  		--cc $(DOCKER_CROSS_COMPILER) \
>>  		-i qemu:$(DOCKER_IMAGE) \
>>  		-s $(SRC_PATH) -- "
>> +DOCKER_AS_CMD=3D"$(DOCKER_SCRIPT) cc --user $(shell id -u) \
>> +		--cc $(DOCKER_CROSS_ASSEMBLER) \
>> +		-i qemu:$(DOCKER_IMAGE) \
>> +		-s $(SRC_PATH) -- "
>> +DOCKER_LD_CMD=3D"$(DOCKER_SCRIPT) cc --user $(shell id -u) \
>> +		--cc $(DOCKER_CROSS_LINKER) \
>> +		-i qemu:$(DOCKER_IMAGE) \
>> +		-s $(SRC_PATH) -- "
>>  DOCKER_PREREQ=3Ddocker-image-$(DOCKER_IMAGE)
>>
>>  =2EPHONY: docker-build-guest-tests
>>  docker-build-guest-tests: $(DOCKER_PREREQ)
>>  	$(call quiet-command, \
>>  	  (mkdir -p tests && cd tests && \
>> -	   $(MAKE) -f $(TCG_MAKE) CC=3D$(DOCKER_COMPILE_CMD) \
>> +	   $(MAKE) -f $(TCG_MAKE) CC=3D$(DOCKER_CC_CMD) \
>> +			AS=3D$(DOCKER_AS_CMD) LD=3D$(DOCKER_LD_CMD) \
>
>Hmm will these overrides break exiting builds? We haven't defined
>DOCKER_CROSS_ASSEMBLER or DOCKER_CROSS_LINKER for all our targets=2E

it's just an RFC and not intended to be used as is=2E=2E actually I'd pref=
er to use the gcc=2E but I guess it makes the Travis ci run too long=2E I'd=
 hoped there will be other ideas=2E=2E if we go with the linker and assembl=
er variables, these should only be set if the architecture make includes wi=
ll setup the variables correctly=2E=20

--=20
-michael
