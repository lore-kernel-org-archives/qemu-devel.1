Received: from eggs.gnu.org ([209.51.188.92]:38243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gtE3z-00032U-T9
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 11:04:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gtE3y-000450-ND
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 11:04:07 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:42686)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gtE3x-000414-Py
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 11:04:06 -0500
Received: by mail-wr1-x432.google.com with SMTP id q18so5295746wrx.9
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 08:04:04 -0800 (PST)
References: <20190205170510.21984-1-peter.maydell@linaro.org>
	<20190205170510.21984-12-peter.maydell@linaro.org>
	<CAP+75-Xsn5VvHLung5V03YZLQOiqP+VSugzj6d2c3ovkyKsCKw@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAP+75-Xsn5VvHLung5V03YZLQOiqP+VSugzj6d2c3ovkyKsCKw@mail.gmail.com>
Date: Mon, 11 Feb 2019 16:04:02 +0000
Message-ID: <874l9awbv1.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 11/22] tests/tcg/aarch64: Add pauth smoke
 test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On Tue, Feb 5, 2019 at 6:28 PM Peter Maydell <peter.maydell@linaro.org> w=
rote:
>>
>> From: Richard Henderson <richard.henderson@linaro.org>
>>
>> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> Message-id: 20190201195404.30486-3-richard.henderson@linaro.org
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>>  tests/tcg/aarch64/Makefile.target |  6 +++++-
>>  tests/tcg/aarch64/pauth-1.c       | 23 +++++++++++++++++++++++
>>  2 files changed, 28 insertions(+), 1 deletion(-)
>>  create mode 100644 tests/tcg/aarch64/pauth-1.c
>>
>> diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makef=
ile.target
>> index 08c45b8470c..2bb914975be 100644
>> --- a/tests/tcg/aarch64/Makefile.target
>> +++ b/tests/tcg/aarch64/Makefile.target
>> @@ -8,10 +8,14 @@ VPATH                 +=3D $(AARCH64_SRC)
>>  # we don't build any of the ARM tests
>>  AARCH64_TESTS=3D$(filter-out $(ARM_TESTS), $(TESTS))
>>  AARCH64_TESTS+=3Dfcvt
>> -TESTS:=3D$(AARCH64_TESTS)
>>
>>  fcvt: LDFLAGS+=3D-lm
>>
>>  run-fcvt: fcvt
>>         $(call run-test,$<,$(QEMU) $<, "$< on $(TARGET_NAME)")
>>         $(call diff-out,$<,$(AARCH64_SRC)/fcvt.ref)
>> +
>> +AARCH64_TESTS +=3D pauth-1
>> +run-pauth-%: QEMU +=3D -cpu max
>> +
>> +TESTS:=3D$(AARCH64_TESTS)
>> diff --git a/tests/tcg/aarch64/pauth-1.c b/tests/tcg/aarch64/pauth-1.c
>> new file mode 100644
>> index 00000000000..ae6dc05c2b1
>> --- /dev/null
>> +++ b/tests/tcg/aarch64/pauth-1.c
>> @@ -0,0 +1,23 @@
>> +#include <assert.h>
>> +#include <sys/prctl.h>
>> +
>> +asm(".arch armv8.4-a");
>> +
>> +#ifndef PR_PAC_RESET_KEYS
>> +#define PR_PAC_RESET_KEYS  54
>> +#define PR_PAC_APDAKEY     (1 << 2)
>> +#endif
>> +
>> +int main()
>> +{
>> +    int x;
>> +    void *p0 =3D &x, *p1, *p2;
>> +
>> +    asm volatile("pacdza %0" : "=3Dr"(p1) : "0"(p0));
>> +    prctl(PR_PAC_RESET_KEYS, PR_PAC_APDAKEY, 0, 0, 0);
>> +    asm volatile("pacdza %0" : "=3Dr"(p2) : "0"(p0));
>> +
>> +    assert(p1 !=3D p0);
>> +    assert(p1 !=3D p2);
>> +    return 0;
>> +}
>> --
>> 2.20.1
>
> Travis-CI is getting an error with this test:
>
> tests/docker/docker.py cc --user 2000 --cc aarch64-linux-gnu-gcc -i
> qemu:debian-arm64-cross -s . --   -Wall -O0 -g -fno-strict-aliasing
> tests/tcg/aarch64/pauth-1.c -o pauth-1  -static
> /tmp/ccHrAqV2.s: Assembler messages:
> /tmp/ccHrAqV2.s:7: Error: unknown architecture `armv8.4-a'
> /tmp/ccHrAqV2.s:41: Error: selected processor does not support `pacdza x0'
> /tmp/ccHrAqV2.s:56: Error: selected processor does not support `pacdza x0'
> tests/tcg/Makefile:79: recipe for target 'pauth-1' failed
> make[2]: *** [pauth-1] Error 1
> make[2]: Leaving directory 'aarch64-linux-user/tests'
> tests/tcg/Makefile.include:52: recipe for target
> 'docker-build-guest-tests' failed
> make[1]: *** [docker-build-guest-tests] Error 2
> make[1]: Leaving directory 'aarch64-linux-user'
> tests/Makefile.include:1030: recipe for target
> 'build-tcg-tests-aarch64-linux-user' failed
> make: *** [build-tcg-tests-aarch64-linux-user] Error 2

The fix for that is in my latest PR.

--
Alex Benn=C3=A9e
