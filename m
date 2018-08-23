Received: from eggs.gnu.org ([2001:4830:134:3::10]:41443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fsrr4-0004bD-Mt
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 11:49:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fsrr1-0008Gu-H8
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 11:49:02 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:60130)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fsrr1-0008GS-7c
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 11:48:59 -0400
References: <20180818190118.12911-1-richard.henderson@linaro.org>
	<20180818190118.12911-11-richard.henderson@linaro.org>
	<51f5ba46-f63a-e433-7e0b-82e72a643d79@vivier.eu>
	<b19ce14e-2425-b4b8-3d52-82a65468f845@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <9091dd0e-dd02-1ca5-63b9-58d30140c061@vivier.eu>
Date: Thu, 23 Aug 2018 17:48:56 +0200
MIME-Version: 1.0
In-Reply-To: <b19ce14e-2425-b4b8-3d52-82a65468f845@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 10/16] linux-user: Split out some simple
 file syscalls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org

Le 23/08/2018 à 00:58, Richard Henderson a écrit :
> On 08/21/2018 05:50 PM, Laurent Vivier wrote:
>> I don't understand why you need/want to duplicate the list of syscalls here.
>>
>> If I modify your patch as following, it works without duplicating the list:
>>
>> diff --git a/linux-user/syscall-file.def.c b/linux-user/syscall-file.def.c
>> new file mode 100644
>> index 0000000000..78b1bd0467
>> --- /dev/null
>> +++ b/linux-user/syscall-file.def.c
>> @@ -0,0 +1,13 @@
>> +SYSCALL_DEF(close, ARG_DEC);
>> +#ifdef TARGET_NR_open
>> +SYSCALL_DEF(open, ARG_STR, ARG_OPENFLAG, ARG_MODEFLAG);
>> +#endif
>> +SYSCALL_DEF(openat, ARG_ATDIRFD, ARG_STR, ARG_OPENFLAG, ARG_MODEFLAG);
>> +SYSCALL_DEF(read, ARG_DEC, ARG_PTR, ARG_DEC);
>> +#ifdef TARGET_NR_readlink
>> +SYSCALL_DEF(readlink, ARG_STR, ARG_PTR, ARG_DEC);
>> +#endif
>> +#ifdef TARGET_NR_readlinkat
>> +SYSCALL_DEF(readlinkat, ARG_ATDIRFD, ARG_STR, ARG_PTR, ARG_DEC);
>> +#endif
>> +SYSCALL_DEF(write, ARG_DEC, ARG_PTR, ARG_DEC);
> 
> Sort-of interesting, but I do have other definitions of
> syscall structures that do not use this macro.
> 
> Please look through e.g. patch 15 and suggest how I might
> define mmap2 with your scheme.

We can add a base macro in syscall.h:

#define SYSCALL_DECL(NAME, ARGS, IMPL, PRINT, PRINT_RET, ...) \
    static const SyscallDef def_##NAME = { \
        .name = #NAME, .args = ARGS, .impl = IMPL, .print = PRINT, \
        .print_ret = PRINT_RET, .arg_type = { __VA_ARGS__ } \
    }

and use it with the others:

#define SYSCALL_DEF(NAME, ...) \
    SYSCALL_DECL(NAME, NULL, impl_##NAME, NULL, NULL, __VA_ARGS__)

#define SYSCALL_DEF_ARGS(NAME, ...) \
    SYSCALL_DECL(NAME, args_##NAME, impl_##NAME, NULL, NULL, __VA_ARGS__)

Then in syscall.c:

static const SyscallDef *syscall_table(int num)
{
#undef SYSCALL_DECL
#define SYSCALL_DECL(NAME, ...)  \
    case TARGET_NR_##NAME: return &def_##NAME

    switch (num) {
#include "syscall-file.def.c"
#include "syscall-ipc.def.c"
#include "syscall-mem.def.c"
#include "syscall-proc.def.c"
    }
    return NULL;

#undef SYSCALL_DECL
}

and for mmap2 in syscall-mem.def.c:

SYSCALL_DEF(mlock, ARG_PTR, ARG_DEC);
SYSCALL_DEF(mlockall, ARG_HEX);
#ifdef TARGET_NR_mmap
SYSCALL_DECL(mmap, args_mmap, impl_mmap, NULL, print_syscall_ptr_ret,
             ARG_PTR, ARG_DEC, ARG_MMAPPROT, ARG_MMAPFLAG, ARG_DEC,
ARG_DEC);
#endif
#ifdef TARGET_NR_mmap2
SYSCALL_DECL(mmap2, args_mmap2, impl_mmap, NULL, print_syscall_ptr_ret,
             ARG_PTR, ARG_DEC, ARG_MMAPPROT, ARG_MMAPFLAG, ARG_DEC,
ARG_DEC64);
#endif
...

I pushed the modifications into:
git://github.com/vivier/qemu.git lu-split-4

Note that ipc_shmat can't use the macro (because the name of structure
is def_ipc_shmat, and not def_shmat), but we don't need it because it is
not exported to the syscall_table and only used locally by
SYSCALL_ARGS(ipc).

And doing like this, I think we don't need to add -Wunused-const-variable.

Thanks,
Laurent
