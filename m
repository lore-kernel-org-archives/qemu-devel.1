Received: from eggs.gnu.org ([2001:4830:134:3::10]:53183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fOqVB-0004PH-9I
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 16:18:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fOqV6-0004as-79
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 16:18:21 -0400
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:42394)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fOqV6-0004Xd-0q
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 16:18:16 -0400
Received: by mail-pl0-x242.google.com with SMTP id w17-v6so85203pll.9
	for <qemu-devel@nongnu.org>; Fri, 01 Jun 2018 13:18:15 -0700 (PDT)
References: <20180531041822.5761-1-richard.henderson@linaro.org>
	<20180531041822.5761-2-richard.henderson@linaro.org>
	<2d80e2d0-7223-c4d5-578a-82b865a1c627@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1fa1cb21-9632-cdbf-e521-5026248fd671@linaro.org>
Date: Fri, 1 Jun 2018 13:18:12 -0700
MIME-Version: 1.0
In-Reply-To: <2d80e2d0-7223-c4d5-578a-82b865a1c627@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/2] linux-user: Implement signals for
 openrisc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: shorne@gmail.com

On 06/01/2018 12:59 PM, Laurent Vivier wrote:
> Le 31/05/2018 à 06:18, Richard Henderson a écrit :
>> All of the existing code was boilerplate from elsewhere,
>> and would crash the guest upon the first signal.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  linux-user/openrisc/target_syscall.h |  23 +--
>>  linux-user/openrisc/signal.c         | 210 +++++++++++----------------
>>  linux-user/signal.c                  |   2 +-
>>  target/openrisc/cpu.c                |   1 +
>>  4 files changed, 87 insertions(+), 149 deletions(-)
>>
>> diff --git a/linux-user/openrisc/target_syscall.h b/linux-user/openrisc/target_syscall.h
>> index 03104f80af..f21fab3192 100644
>> --- a/linux-user/openrisc/target_syscall.h
>> +++ b/linux-user/openrisc/target_syscall.h
>> @@ -2,26 +2,9 @@
>>  #define OPENRISC_TARGET_SYSCALL_H
>>  
>>  struct target_pt_regs {
>> -    union {
>> -        struct {
>> -            /* Named registers */
>> -            uint32_t sr;       /* Stored in place of r0 */
>> -            target_ulong sp;   /* r1 */
>> -        };
>> -        struct {
>> -            /* Old style */
>> -            target_ulong offset[2];
>> -            target_ulong gprs[30];
>> -        };
>> -        struct {
>> -            /* New style */
>> -            target_ulong gpr[32];
>> -        };
>> -    };
>> -    target_ulong pc;
>> -    target_ulong orig_gpr11;   /* For restarting system calls */
>> -    uint32_t syscallno;        /* Syscall number (used by strace) */
>> -    target_ulong dummy;     /* Cheap alignment fix */
>> +    abi_ulong gpr[32];
>> +    abi_ulong pc;
>> +    abi_ulong sr;
>>  };
> 
> From where is this coming from?
> 
> In linux/arch/openrisc/include/asm/ptrace.h, we have the definition you
> remove.

I'm using the one from .../include/uapi/asm/ptrace.h.
I now see that they have two different names -- this one is struct
user_regs_struct -- but this is also what is used by sigcontext.

I should fix the names too to avoid confusion.


r~
