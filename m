Received: from eggs.gnu.org ([2001:4830:134:3::10]:44829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffROu-0006vR-FE
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 10:56:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffROp-0008Iz-O7
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 10:56:28 -0400
Received: from mail-ua0-x242.google.com ([2607:f8b0:400c:c08::242]:40941)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffROp-0008IY-J4
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 10:56:23 -0400
Received: by mail-ua0-x242.google.com with SMTP id p22-v6so857710uao.7
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 07:56:23 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180713121741.19262-1-alex.bennee@linaro.org>
	<20180713121741.19262-7-alex.bennee@linaro.org>
	<a0312306-f433-a2a5-9970-b7f438773c05@amsat.org>
	<877elu5giy.fsf@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <8a9ef3b2-0807-918e-166c-0e8f652770cb@amsat.org>
Date: Tue, 17 Jul 2018 11:56:17 -0300
MIME-Version: 1.0
In-Reply-To: <877elu5giy.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 for 3.0 06/16] docker: move make check
 into check_qemu helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: cota@braap.org, famz@redhat.com, berrange@redhat.com, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, qemu-devel@nongnu.org

On 07/17/2018 06:59 AM, Alex Bennée wrote:
> Philippe Mathieu-Daudé <f4bug@amsat.org> writes:
>> On 07/13/2018 09:17 AM, Alex Bennée wrote:
>>> Not all docker images can run the check step. Let's move everything
>>> into a common helper so we don't need to replicate checks in the
>>> future.
>>>
>>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>>
>>> ---
>>> v2
>>>   - add "move" to Let's everything in commit message
>>> ---
>>>  tests/docker/common.rc  | 10 ++++++++++
>>>  tests/docker/test-clang |  2 +-
>>>  tests/docker/test-debug |  2 +-
>>>  tests/docker/test-full  |  2 +-
>>>  tests/docker/test-quick |  2 +-
>>>  5 files changed, 14 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/tests/docker/common.rc b/tests/docker/common.rc
>>> index ba1f942328..cfc620d554 100755
>>> --- a/tests/docker/common.rc
>>> +++ b/tests/docker/common.rc
>>> @@ -40,6 +40,16 @@ build_qemu()
>>>      make $MAKEFLAGS
>>>  }
>>>
>>> +check_qemu()
>>> +{
>>> +    if test -z "$@"; then
>>> +        TEST="check"
>>> +    else
>>> +        TEST="$@"
>>
>> This is a bit confuse:
>>
>>   check_qemu V=1 -> TEST=V=1
>>
>>> +    fi
>>> +    make $MAKEFLAGS $TEST
>>
>>     -> make V=1
> 
> How about s/TEST/INVOCATION/?

INVOCATION or make $MAKEFLAGS ${@:-check}:

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>>
>>> +}
>>> +
>>>  test_fail()
>>>  {
>>>      echo "$@"
>>> diff --git a/tests/docker/test-clang b/tests/docker/test-clang
>>> index e90a793178..324e341cea 100755
>>> --- a/tests/docker/test-clang
>>> +++ b/tests/docker/test-clang
>>> @@ -23,5 +23,5 @@ OPTS="--cxx=clang++ --cc=clang --host-cc=clang"
>>>  #OPTS="$OPTS --extra-cflags=-fsanitize=undefined \
>>>      #--extra-cflags=-fno-sanitize=float-divide-by-zero"
>>>  build_qemu $OPTS
>>> -make $MAKEFLAGS check
>>> +check_qemu
>>>  install_qemu
>>> diff --git a/tests/docker/test-debug b/tests/docker/test-debug
>>> index d3f9f70d01..137f4f2ddc 100755
>>> --- a/tests/docker/test-debug
>>> +++ b/tests/docker/test-debug
>>> @@ -22,5 +22,5 @@ OPTS="--cxx=clang++ --cc=clang --host-cc=clang"
>>>  OPTS="--enable-debug --enable-sanitizers $OPTS"
>>>
>>>  build_qemu $OPTS
>>> -make $MAKEFLAGS V=1 check
>>> +check_qemu check V=1
>>
>> Gotcha!
>>
>>>  install_qemu
>>> diff --git a/tests/docker/test-full b/tests/docker/test-full
>>> index b4e42d25d7..aadc0f00a2 100755
>>> --- a/tests/docker/test-full
>>> +++ b/tests/docker/test-full
>>> @@ -15,4 +15,4 @@
>>>
>>>  cd "$BUILD_DIR"
>>>
>>> -build_qemu && make check $MAKEFLAGS && install_qemu
>>> +build_qemu && check_qemu && install_qemu
>>> diff --git a/tests/docker/test-quick b/tests/docker/test-quick
>>> index 3b7bce6105..eee59c55fb 100755
>>> --- a/tests/docker/test-quick
>>> +++ b/tests/docker/test-quick
>>> @@ -18,5 +18,5 @@ cd "$BUILD_DIR"
>>>  DEF_TARGET_LIST="x86_64-softmmu,aarch64-softmmu"
>>>  TARGET_LIST=${TARGET_LIST:-$DEF_TARGET_LIST} \
>>>  build_qemu
>>> -make check $MAKEFLAGS
>>> +check_qemu
>>>  install_qemu
>>>
> 
> 
> --
> Alex Bennée
> 
