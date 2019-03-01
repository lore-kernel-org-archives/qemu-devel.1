Received: from eggs.gnu.org ([209.51.188.92]:36334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gzeWh-0006b0-JD
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 04:32:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gzeWO-0007w4-0z
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 04:32:01 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:39976)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gzeWN-0007tw-PT
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 04:31:59 -0500
Received: by mail-wm1-x341.google.com with SMTP id g20so10761328wmh.5
	for <qemu-devel@nongnu.org>; Fri, 01 Mar 2019 01:31:56 -0800 (PST)
References: <20190228202537.4638-1-alex.bennee@linaro.org>
	<20190228202537.4638-6-alex.bennee@linaro.org>
	<c3a65d4b-8720-2957-1394-032823a78760@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <c3a65d4b-8720-2957-1394-032823a78760@redhat.com>
Date: Fri, 01 Mar 2019 09:31:54 +0000
Message-ID: <87tvgnj5yt.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 05/16] tests/tcg/mips: fix hello-mips
 compilation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: qemu-devel@nongnu.org, edgar.iglesias@gmail.com, qemu-arm@nongnu.org, jcmvbkbc@gmail.com


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> Hi Alex,
>
> On 2/28/19 9:25 PM, Alex Benn=C3=A9e wrote:
>> The compilation flags for proper building are in the source tree. We
>> also fix exit to 0 so the result is counted as a success.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  tests/tcg/mips/Makefile.target | 11 ++++-------
>>  tests/tcg/mips/hello-mips.c    |  2 +-
>>  2 files changed, 5 insertions(+), 8 deletions(-)
>>
>> diff --git a/tests/tcg/mips/Makefile.target b/tests/tcg/mips/Makefile.ta=
rget
>> index 086625f533..1a994d5525 100644
>> --- a/tests/tcg/mips/Makefile.target
>> +++ b/tests/tcg/mips/Makefile.target
>> @@ -8,15 +8,12 @@ MIPS_SRC=3D$(SRC_PATH)/tests/tcg/mips
>>  # Set search path for all sources
>>  VPATH 		+=3D $(MIPS_SRC)
>>
>> +# hello-mips is 32 bit only
>
> Correct.
>
>> +ifeq ($(findstring 64,$(TARGET_NAME)),)
>>  MIPS_TESTS=3Dhello-mips
>>
>>  TESTS +=3D $(MIPS_TESTS)
>>
>> -hello-mips: CFLAGS+=3D-ffreestanding
>> +hello-mips: CFLAGS+=3D-mno-abicalls -fno-PIC -mabi=3D32
>
> As suggested in the header.
>
>>  hello-mips: LDFLAGS+=3D-nostdlib
>> -
>> -# For MIPS32 and 64 we have a bunch of extra tests in sub-directories
>> -# however they are intended for system tests.
>> -
>> -run-hello-mips: hello-mips
>> -	$(call skip-test, $<, "BROKEN")
>> +endif
>> diff --git a/tests/tcg/mips/hello-mips.c b/tests/tcg/mips/hello-mips.c
>> index c7052fdf2e..4e1cf501af 100644
>> --- a/tests/tcg/mips/hello-mips.c
>> +++ b/tests/tcg/mips/hello-mips.c
>> @@ -60,5 +60,5 @@ static inline int write(int fd, const char *buf, int l=
en)
>>  void __start(void)
>>  {
>>      write (1, "Hello, World!\n", 14);
>> -    exit1 (42);
>
> I understand 42 is to check SYS_exit1 worked, and this is not another
> qemu-user exit. But we were previously never checked the exit code for
> 42. Neither are we checking 'Hello, World' on stdout.

Hmm we could do better but this is pretty much a smoke test anyway.
Either things are so broken it crashes out (which we should detect) or
we exit with a 0 indicating a pass to the calling make.

Once we have a more use cases for non-zero exits we can come up with
some plumbing for checking things.

>
>> +    exit1(0);
>>  }
>>


--
Alex Benn=C3=A9e
