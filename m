Received: from eggs.gnu.org ([2001:4830:134:3::10]:58718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dNMdk-0002Sc-ST
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 13:08:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dNMdh-00085J-M2
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 13:08:32 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:34761)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dNMdh-00084J-I5
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 13:08:29 -0400
Received: by mail-qt0-x243.google.com with SMTP id o21so23969483qtb.1
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 10:08:29 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170616161334.7492-1-f4bug@amsat.org>
	<20170616161334.7492-4-f4bug@amsat.org> <87lgorujg7.fsf@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <df659ac4-ec43-6a3c-0b73-5c2346b58df7@amsat.org>
Date: Tue, 20 Jun 2017 14:08:25 -0300
MIME-Version: 1.0
In-Reply-To: <87lgorujg7.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 03/11] travis: use yes/no variable to
 enable/disable tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

On 06/17/2017 05:06 AM, Alex Bennée wrote:
>
> Philippe Mathieu-Daudé <f4bug@amsat.org> writes:
>
>> having the command to run in the variable make scripts harder to
>> manage.
>
> I'm not sure this adds much over the TEST_CMD not set == don't run we
> had before.

I don't like it neither but had trouble expanding commands in $TEST_CMD. 
Anyway I drop this approach in the next version of this series.

>
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>
>> using 0/1 or no/yes is pretty much the same.
>>
>>  .travis.yml | 14 +++++++-------
>>  1 file changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/.travis.yml b/.travis.yml
>> index b2c69fdd59..c9ac741afc 100644
>> --- a/.travis.yml
>> +++ b/.travis.yml
>> @@ -46,7 +46,7 @@ notifications:
>>  env:
>>    global:
>>      - PARALLEL_JOBS="$(($(getconf _NPROCESSORS_ONLN) + 1))"
>> -    - TEST_CMD="make check"
>> +    - RUN_TESTS="yes"
>>    matrix:
>>      - CONFIG=""
>>      - CONFIG="--enable-debug --enable-debug-tcg --enable-trace-backends=log"
>> @@ -66,7 +66,7 @@ before_script:
>>    - ./configure ${CONFIG}
>>  script:
>>    - make -j${PARALLEL_JOBS}
>> -  - test -z "${TEST_CMD}" || ${TEST_CMD}
>> +  - if [ "${RUN_TESTS}" == "yes" ]; then make check; fi
>>  matrix:
>>    include:
>>      # Test with CLang for compile portability
>> @@ -77,16 +77,16 @@ matrix:
>>        compiler: gcc
>>      # We manually include builds which we disable "make check" for
>>      - env: CONFIG="--enable-debug --enable-tcg-interpreter"
>> -           TEST_CMD=""
>> +           RUN_TESTS="no"
>>        compiler: gcc
>>      - env: CONFIG="--enable-trace-backends=simple"
>> -           TEST_CMD=""
>> +           RUN_TESTS="no"
>>        compiler: gcc
>>      - env: CONFIG="--enable-trace-backends=ftrace"
>> -           TEST_CMD=""
>> +           RUN_TESTS="no"
>>        compiler: gcc
>>      - env: CONFIG="--enable-trace-backends=ust"
>> -           TEST_CMD=""
>> +           RUN_TESTS="no"
>>        compiler: gcc
>>      - env: CONFIG=""
>>        os: osx
>> @@ -191,6 +191,6 @@ matrix:
>>        env:
>>          - COMPILER_NAME=gcc CXX=g++-5 CC=gcc-5
>>          - CONFIG="--cc=gcc-5 --cxx=g++-5 --disable-pie --disable-linux-user"
>> -        - TEST_CMD=""
>> +        - RUN_TESTS="no"
>>        before_script:
>>          - ./configure ${CONFIG} --extra-cflags="-g3 -O0 -fsanitize=thread -fuse-ld=gold" || cat config.log
>
>
> --
> Alex Bennée
>
