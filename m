Received: from eggs.gnu.org ([2001:4830:134:3::10]:40862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <glaubitz@physik.fu-berlin.de>) id 1eAsv3-0001df-N9
	for qemu-devel@nongnu.org; Sat, 04 Nov 2017 03:31:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <glaubitz@physik.fu-berlin.de>) id 1eAsuz-00024a-NO
	for qemu-devel@nongnu.org; Sat, 04 Nov 2017 03:31:05 -0400
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:36297)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <glaubitz@physik.fu-berlin.de>)
	id 1eAsuz-0001zt-FZ
	for qemu-devel@nongnu.org; Sat, 04 Nov 2017 03:31:01 -0400
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
References: <20170915065821.16600-1-jrtc27@jrtc27.com>
	<20170915193313.86362-1-jrtc27@jrtc27.com>
	<f22e881a-466a-945b-2979-8c0851790854@physik.fu-berlin.de>
Message-ID: <aaa0c5b1-81a9-08f5-c945-f00da2d13682@physik.fu-berlin.de>
Date: Sat, 4 Nov 2017 08:30:54 +0100
MIME-Version: 1.0
In-Reply-To: <f22e881a-466a-945b-2979-8c0851790854@physik.fu-berlin.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] PING: Re: [PATCH v3] linux-user/syscall.c: Handle
 SH4's exceptional alignment for p{read, write}64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: James Clarke <jrtc27@jrtc27.com>, QEMU Developers <qemu-devel@nongnu.org>
Cc: Laurent Vivier <laurent@vivier.eu>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

Ping.

Please don't let this patch fall of the table. It's actually fixing a bug.

Thanks,
Adrian

On 10/04/2017 10:38 AM, John Paul Adrian Glaubitz wrote:
> Hi!
> 
> Any chance that this patch gets merged soon?
> 
> Looks like it has been reviewed by at least Richard and Philippe.
> 
> Adrian
> 
> On 09/15/2017 09:33 PM, James Clarke wrote:
>> Fixes: https://bugs.launchpad.net/qemu/+bug/1716767
>> Signed-off-by: James Clarke <jrtc27@jrtc27.com>
>> ---
>>
>> Changes since v2:
>>   * Fixed opening curly brace formatting, both for my new SH4-specific
>>     regpairs_aligned function, as well as the Arm one I touched, to appease
>>     checkpatch.pl
>>
>> Changes since v1:
>>   * Removed all changes in v1 :)
>>   * Added syscall num argument to regpairs_aligned
>>   * Added SH4-specific implementation of regpairs_aligned to return 1 for
>>     p{read,write}64
>>
>>   linux-user/syscall.c | 36 +++++++++++++++++++++++++-----------
>>   1 file changed, 25 insertions(+), 11 deletions(-)
>>
>> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
>> index 9b6364a266..0c1bd80bed 100644
>> --- a/linux-user/syscall.c
>> +++ b/linux-user/syscall.c
>> @@ -667,18 +667,32 @@ static inline int next_free_host_timer(void)
>>     /* ARM EABI and MIPS expect 64bit types aligned even on pairs or registers */
>>   #ifdef TARGET_ARM
>> -static inline int regpairs_aligned(void *cpu_env) {
>> +static inline int regpairs_aligned(void *cpu_env, int num)
>> +{
>>       return ((((CPUARMState *)cpu_env)->eabi) == 1) ;
>>   }
>>   #elif defined(TARGET_MIPS) && (TARGET_ABI_BITS == 32)
>> -static inline int regpairs_aligned(void *cpu_env) { return 1; }
>> +static inline int regpairs_aligned(void *cpu_env, int num) { return 1; }
>>   #elif defined(TARGET_PPC) && !defined(TARGET_PPC64)
>>   /* SysV AVI for PPC32 expects 64bit parameters to be passed on odd/even pairs
>>    * of registers which translates to the same as ARM/MIPS, because we start with
>>    * r3 as arg1 */
>> -static inline int regpairs_aligned(void *cpu_env) { return 1; }
>> +static inline int regpairs_aligned(void *cpu_env, int num) { return 1; }
>> +#elif defined(TARGET_SH4)
>> +/* SH4 doesn't align register pairs, except for p{read,write}64 */
>> +static inline int regpairs_aligned(void *cpu_env, int num)
>> +{
>> +    switch (num) {
>> +    case TARGET_NR_pread64:
>> +    case TARGET_NR_pwrite64:
>> +        return 1;
>> +
>> +    default:
>> +        return 0;
>> +    }
>> +}
>>   #else
>> -static inline int regpairs_aligned(void *cpu_env) { return 0; }
>> +static inline int regpairs_aligned(void *cpu_env, int num) { return 0; }
>>   #endif
>>     #define ERRNO_TABLE_SIZE 1200
>> @@ -6857,7 +6871,7 @@ static inline abi_long target_truncate64(void *cpu_env, const char *arg1,
>>                                            abi_long arg3,
>>                                            abi_long arg4)
>>   {
>> -    if (regpairs_aligned(cpu_env)) {
>> +    if (regpairs_aligned(cpu_env, TARGET_NR_truncate64)) {
>>           arg2 = arg3;
>>           arg3 = arg4;
>>       }
>> @@ -6871,7 +6885,7 @@ static inline abi_long target_ftruncate64(void *cpu_env, abi_long arg1,
>>                                             abi_long arg3,
>>                                             abi_long arg4)
>>   {
>> -    if (regpairs_aligned(cpu_env)) {
>> +    if (regpairs_aligned(cpu_env, TARGET_NR_ftruncate64)) {
>>           arg2 = arg3;
>>           arg3 = arg4;
>>       }
>> @@ -10495,7 +10509,7 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
>>   #endif
>>   #ifdef TARGET_NR_pread64
>>       case TARGET_NR_pread64:
>> -        if (regpairs_aligned(cpu_env)) {
>> +        if (regpairs_aligned(cpu_env, num)) {
>>               arg4 = arg5;
>>               arg5 = arg6;
>>           }
>> @@ -10505,7 +10519,7 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
>>           unlock_user(p, arg2, ret);
>>           break;
>>       case TARGET_NR_pwrite64:
>> -        if (regpairs_aligned(cpu_env)) {
>> +        if (regpairs_aligned(cpu_env, num)) {
>>               arg4 = arg5;
>>               arg5 = arg6;
>>           }
>> @@ -11275,7 +11289,7 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
>>           arg6 = ret;
>>   #else
>>           /* 6 args: fd, offset (high, low), len (high, low), advice */
>> -        if (regpairs_aligned(cpu_env)) {
>> +        if (regpairs_aligned(cpu_env, num)) {
>>               /* offset is in (3,4), len in (5,6) and advice in 7 */
>>               arg2 = arg3;
>>               arg3 = arg4;
>> @@ -11294,7 +11308,7 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
>>   #ifdef TARGET_NR_fadvise64
>>       case TARGET_NR_fadvise64:
>>           /* 5 args: fd, offset (high, low), len, advice */
>> -        if (regpairs_aligned(cpu_env)) {
>> +        if (regpairs_aligned(cpu_env, num)) {
>>               /* offset is in (3,4), len in 5 and advice in 6 */
>>               arg2 = arg3;
>>               arg3 = arg4;
>> @@ -11407,7 +11421,7 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
>>   #ifdef TARGET_NR_readahead
>>       case TARGET_NR_readahead:
>>   #if TARGET_ABI_BITS == 32
>> -        if (regpairs_aligned(cpu_env)) {
>> +        if (regpairs_aligned(cpu_env, num)) {
>>               arg2 = arg3;
>>               arg3 = arg4;
>>               arg4 = arg5;
>>
> 


-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
