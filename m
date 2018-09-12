Received: from eggs.gnu.org ([2001:4830:134:3::10]:43497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Sandra_Loosemore@mentor.com>) id 1g0Arp-0005Nv-5D
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 15:32:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Sandra_Loosemore@mentor.com>) id 1g0Arl-0004lk-5k
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 15:32:01 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:35550)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Sandra_Loosemore@mentor.com>)
	id 1g0Ark-0004j9-V2
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 15:31:57 -0400
References: <1536701379-106032-1-git-send-email-sandra@codesourcery.com>
	<618b095d-d3fd-4cbb-f2ba-37e0f4902f28@linaro.org>
	<87ftyeblw2.fsf@linaro.org>
From: Sandra Loosemore <sandra@codesourcery.com>
Message-ID: <7e4e8a1e-23e5-f0d2-ec5a-34bbc79905d6@codesourcery.com>
Date: Wed, 12 Sep 2018 13:31:49 -0600
MIME-Version: 1.0
In-Reply-To: <87ftyeblw2.fsf@linaro.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] Fix breakpoints in nios2 user-mode
 emulation.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, marex@denx.de, crwulff@gmail.com

On 09/12/2018 12:39 PM, Alex Bennée wrote:
> 
> Richard Henderson <richard.henderson@linaro.org> writes:
> 
>> On 09/11/2018 02:29 PM, Sandra Loosemore wrote:
>>> Without this patch, QEMU exits immediately when it execution stops at
>>> a breakpoint, instead of reporting it to GDB.
>>>
>>> Signed-off-by: Sandra Loosemore <sandra@codesourcery.com>
>>> ---
>>>   linux-user/nios2/cpu_loop.c | 3 +++
>>>   1 file changed, 3 insertions(+)
>>>
>>> diff --git a/linux-user/nios2/cpu_loop.c b/linux-user/nios2/cpu_loop.c
>>> index dac7a06..a5ae37f 100644
>>> --- a/linux-user/nios2/cpu_loop.c
>>> +++ b/linux-user/nios2/cpu_loop.c
>>> @@ -71,6 +71,9 @@ void cpu_loop(CPUNios2State *env)
>>>                   gdbsig = TARGET_SIGTRAP;
>>>                   break;
>>>               }
>>> +        case EXCP_DEBUG:
>>> +            gdbsig = TARGET_SIGTRAP;
>>> +            break;
>>
>> This really isn't complete.  You set gdbsig from odd places instead of using
>> queue_signal; you fail to honor the return value from gdb_handlesig.
>>
>> But I suppose those should be separate patches, so
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> At least the cpu_loops have been separated now.. I guess the next step
> is to audit each one for common features? There do seem to be some magic
> numbers in the nios loop which I find concerning.

I'm not sure where the 0xaa value came from, but it is used to indicate 
syscalls through the kuser page mapped at address 0x1000 in user space. 
The addresses are a fixed ABI although not terribly well-documented 
AFAICT.  There's code in target/nios2 that catches attempts to execute 
code on that page, and in the Linux kernel the code that goes on the 
kuser page is at the end of arch/nios2/kernel/entry.S.  This all could 
certainly be better documented in the QEMU cpu_loop code too.

-Sandra
