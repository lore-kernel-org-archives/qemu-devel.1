Received: from eggs.gnu.org ([2001:4830:134:3::10]:55981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <glaubitz@physik.fu-berlin.de>) id 1dssmD-0008UK-4r
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 11:43:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <glaubitz@physik.fu-berlin.de>) id 1dssm9-00043c-Vv
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 11:43:33 -0400
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:48256)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <glaubitz@physik.fu-berlin.de>)
	id 1dssm9-000436-Oh
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 11:43:29 -0400
References: <20170915065821.16600-1-jrtc27@jrtc27.com>
	<2f7283ca-6ecd-165f-c572-a0f2a781aba7@amsat.org>
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <dcfb22a7-a310-ef4e-6dae-b006b8fb6494@physik.fu-berlin.de>
Date: Fri, 15 Sep 2017 17:43:25 +0200
MIME-Version: 1.0
In-Reply-To: <2f7283ca-6ecd-165f-c572-a0f2a781aba7@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] linux-user/syscall.c: Handle SH4's
 exceptional alignment for p{read, write}64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, James Clarke <jrtc27@jrtc27.com>, QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>
Cc: Peter Maydell <peter.maydell@linaro.org>

On 09/15/2017 05:41 PM, Philippe Mathieu-Daudé wrote:
> I'd rather use arch_type from "sysemu/arch_init.h":
> 
>    case TARGET_NR_pwrite64:
>        /* SH4 doesn't align register pairs, except for p{read,write}64 */
>        if (arch_type == QEMU_ARCH_SH4 || regpairs_aligned(cpu_env)) {
>            arg4 = arg5;
>            arg5 = arg6;
>        }
> 
> What do you think?

I agree. That looks a bit cleaner. Was actually thinking about something like that.

>>           if (!(p = lock_user(VERIFY_WRITE, arg2, arg3, 0)))
>>               goto efault;
>>           ret = get_errno(pread64(arg1, p, arg3, target_offset64(arg4, arg5)));
>>           unlock_user(p, arg2, ret);
>>           break;
>>       case TARGET_NR_pwrite64:
>> +#if defined(TARGET_SH4)
>> +        /* SH4 doesn't align register pairs, except for p{read,write}64 */
>> +        arg4 = arg5;
>> +        arg5 = arg6;
>> +#else
>>           if (regpairs_aligned(cpu_env)) {
>>               arg4 = arg5;
>>               arg5 = arg6;
>>           }
>> +#endif
> 
> same here.

Dito.

-- 
  .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
   `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
