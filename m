Received: from eggs.gnu.org ([209.51.188.92]:39614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1grivH-0005mV-DC
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 07:36:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1grivG-0001se-IY
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 07:36:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43292)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1grivG-0001sA-9x
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 07:36:54 -0500
References: <154953276796.22523.967637403683519556.malonedeb@chaenomeles.canonical.com>
	<20190207114913.2c5f2c5b.cohuck@redhat.com>
	<6c5ac94e-065f-e66a-2df2-5d8ac81c76e1@debian.org>
	<ffb48b9f-fc99-0766-925c-4f79c692cba7@redhat.com>
	<1a3f847e-a371-eacb-8be6-678bb3c20b05@debian.org>
	<951bf77e-f953-48aa-9e2e-3f7c66bb9db2@redhat.com>
	<78990142-121a-f84d-811b-60ec503f394b@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <c5e3a50d-cc63-1933-be4c-69c031296bf6@redhat.com>
Date: Thu, 7 Feb 2019 13:36:45 +0100
MIME-Version: 1.0
In-Reply-To: <78990142-121a-f84d-811b-60ec503f394b@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Bug 1815024] [NEW] SIGILL on instruction "stck"
 under qemu-s390x in user mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, Giovanni Mascellani <gio@debian.org>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>
Cc: Bug 1815024 <1815024@bugs.launchpad.net>, qemu-devel@nongnu.org

On 2019-02-07 13:15, Richard Henderson wrote:
> On 2/7/19 12:01 PM, Thomas Huth wrote:
>> On 2019-02-07 12:46, Giovanni Mascellani wrote:
>>> Hi,
>>>
>>> Il 07/02/19 12:26, Thomas Huth ha scritto:
>>>> The problem is rather that the STCK instruction is fenced with
>>>> "#ifndef CONFIG_USER_ONLY" ... quick-n-dirty hack to allow it:
>>>
>>> Thanks for the patch. Unfortunately on my system it failes with:
>>>
>>>   LINK    s390x-linux-user/qemu-s390x
>>> /usr/bin/ld: ../libqemuutil.a(cpu-get-icount.o):(.bss+0x0): multiple
>>> definition of `use_icount'; exec.o:(.bss+0x58): first defined here
>>> collect2: error: ld returned 1 exit status
>>> make[1]: *** [Makefile:207: qemu-s390x] Error 1
>>> make: *** [Makefile:432: subdir-s390x-linux-user] Error 2
>>>
>>> The error does not appear when compiling from current master.
>>
>> I just saw it, too. Seems like the stubs/cpu-get-icount.c file now gets
>> pulled in for some reason. Try this on top:
>>
>> diff --git a/stubs/cpu-get-icount.c b/stubs/cpu-get-icount.c
>> index 35f0c1e..8da6646 100644
>> --- a/stubs/cpu-get-icount.c
>> +++ b/stubs/cpu-get-icount.c
>> @@ -4,7 +4,7 @@
>>  #include "sysemu/cpus.h"
>>  #include "qemu/main-loop.h"
>>
>> -int use_icount;
>> +int use_icount __attribute__((weak));
>>
>>  int64_t cpu_get_icount(void)
>>  {
>>
>> ... anyway, I'll ponder about that a little bit and will try to come up
>> with a proper, mergable patch instead.
> 
> See also
> 
>   https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg06734.html
> 
> which I never followed up on the review changes requested.

Ah, right, now that you've mentioned it, it rings a bell! Do you have
some spare time to respin the series, with using time2tod() in the
HELPER(stck) function?

 Thomas
