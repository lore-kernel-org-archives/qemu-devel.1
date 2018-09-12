Received: from eggs.gnu.org ([2001:4830:134:3::10]:49377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Sandra_Loosemore@mentor.com>) id 1g09Sk-00056z-72
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 14:02:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Sandra_Loosemore@mentor.com>) id 1g09Sg-0005X1-Hj
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 14:02:01 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:59624)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Sandra_Loosemore@mentor.com>)
	id 1g09Se-0005PP-Oh
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 14:01:57 -0400
References: <1536701379-106032-1-git-send-email-sandra@codesourcery.com>
	<618b095d-d3fd-4cbb-f2ba-37e0f4902f28@linaro.org>
From: Sandra Loosemore <sandra@codesourcery.com>
Message-ID: <6facc3cf-8ce6-9c33-1c72-5eba79bab913@codesourcery.com>
Date: Wed, 12 Sep 2018 12:01:41 -0600
MIME-Version: 1.0
In-Reply-To: <618b095d-d3fd-4cbb-f2ba-37e0f4902f28@linaro.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: marex@denx.de, crwulff@gmail.com, alex.bennee@linaro.org

On 09/12/2018 11:49 AM, Richard Henderson wrote:
> On 09/11/2018 02:29 PM, Sandra Loosemore wrote:
>> Without this patch, QEMU exits immediately when it execution stops at
>> a breakpoint, instead of reporting it to GDB.
>>
>> Signed-off-by: Sandra Loosemore <sandra@codesourcery.com>
>> ---
>>   linux-user/nios2/cpu_loop.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/linux-user/nios2/cpu_loop.c b/linux-user/nios2/cpu_loop.c
>> index dac7a06..a5ae37f 100644
>> --- a/linux-user/nios2/cpu_loop.c
>> +++ b/linux-user/nios2/cpu_loop.c
>> @@ -71,6 +71,9 @@ void cpu_loop(CPUNios2State *env)
>>                   gdbsig = TARGET_SIGTRAP;
>>                   break;
>>               }
>> +        case EXCP_DEBUG:
>> +            gdbsig = TARGET_SIGTRAP;
>> +            break;
> 
> This really isn't complete.  You set gdbsig from odd places instead of using
> queue_signal; you fail to honor the return value from gdb_handlesig.
> 
> But I suppose those should be separate patches, so
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Yes, I thought this code was rather ugly.  But I thought a minimal patch 
to un-break GDB use would be easier to get in than any kind of rewrite, 
particularly given that I'm not terribly familiar with current best 
practices in the QEMU development community, etc.

-Sandra
