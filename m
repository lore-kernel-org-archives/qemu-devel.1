Received: from eggs.gnu.org ([2001:4830:134:3::10]:35481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1foxEb-0005Nz-6V
	for qemu-devel@nongnu.org; Sun, 12 Aug 2018 16:45:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1foxEY-00059g-2u
	for qemu-devel@nongnu.org; Sun, 12 Aug 2018 16:45:09 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:41187)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1foxEX-00058v-OZ
	for qemu-devel@nongnu.org; Sun, 12 Aug 2018 16:45:05 -0400
References: <20180612005145.3375-1-richard.henderson@linaro.org>
	<20180612005145.3375-13-richard.henderson@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <d476b918-32ef-0360-7bf4-19bbb7e916ef@vivier.eu>
Date: Sun, 12 Aug 2018 22:45:01 +0200
MIME-Version: 1.0
In-Reply-To: <20180612005145.3375-13-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 12/19] linux-user: Setup split syscall
 infrastructure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Le 12/06/2018 à 02:51, Richard Henderson a écrit :
> Defines a unified structure for implementation and strace.
> Supplies a generator script to build the declarations and
> the lookup function.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/syscall.h           | 178 +++++++++++++++
>  linux-user/strace.c            | 386 ++++++++++++++++++++++++---------
>  linux-user/syscall.c           | 113 ++++------
>  linux-user/Makefile.objs       |  10 +
>  linux-user/gen_syscall_list.py |  82 +++++++
>  5 files changed, 595 insertions(+), 174 deletions(-)
>  create mode 100644 linux-user/syscall.h
>  create mode 100644 linux-user/gen_syscall_list.py
...
> diff --git a/linux-user/Makefile.objs b/linux-user/Makefile.objs
> index 59a5c17354..afa69ed6d2 100644
> --- a/linux-user/Makefile.objs
> +++ b/linux-user/Makefile.objs
> @@ -7,3 +7,13 @@ obj-$(TARGET_HAS_BFLT) += flatload.o
>  obj-$(TARGET_I386) += vm86.o
>  obj-$(TARGET_ARM) += arm/nwfpe/
>  obj-$(TARGET_M68K) += m68k-sim.o
> +
> +GEN_SYSCALL_LIST = $(SRC_PATH)/linux-user/gen_syscall_list.py
> +SYSCALL_LIST = linux-user/syscall_list.h linux-user/syscall_list.inc.c
> +
> +$(SYSCALL_LIST): $(GEN_SYSCALL_LIST)
> +	$(call quiet-command,\
> +	  $(PYTHON) $(GEN_SYSCALL_LIST) $@, "GEN", $(TARGET_DIR)$@)
> +
> +linux-user/syscall.o \
> +linux-user/strace.o: $(SYSCALL_LIST)
> diff --git a/linux-user/gen_syscall_list.py b/linux-user/gen_syscall_list.py
> new file mode 100644
> index 0000000000..2e0fc39100
> --- /dev/null
> +++ b/linux-user/gen_syscall_list.py
> @@ -0,0 +1,82 @@
> +#
> +# Linux syscall table generator
> +# Copyright (c) 2018 Linaro, Limited.
> +#
> +# This program is free software; you can redistribute it and/or modify
> +# it under the terms of the GNU General Public License as published by
> +# the Free Software Foundation; either version 2 of the License, or
> +# (at your option) any later version.
> +#
> +# This program is distributed in the hope that it will be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program; if not, see <http://www.gnu.org/licenses/>.
> +#
> +
> +from __future__ import print_function
> +import sys
> +
> +# These are sets of all syscalls that have been converted.
> +# The lists are in collation order with '_' ignored.
> +
> +# These syscalls are supported by all targets.
> +# Avoiding ifdefs for these can diagnose typos in $cpu/syscall_nr.h
> +unconditional_syscalls = [
> +]
> +
> +# These syscalls are only supported by some target or abis.
> +conditional_syscalls = [
> +]
> +
> +
> +def header(f):
> +    # Do not ifdef the declarations -- their use may be complicated.
> +    all = unconditional_syscalls + conditional_syscalls
> +    all.sort()
> +    for s in all:
> +        print("extern const SyscallDef def_", s, ";", sep = '', file = f)
> +
> +
> +def def_syscall(s, f):
> +    print("    case TARGET_NR_", s, ": return &def_", s, ";",
> +          sep = '', file = f);
> +
> +
> +def source(f):
> +    print("static const SyscallDef *syscall_table(int num)",
> +          "{",
> +          "    switch (num) {",
> +          sep = '\n', file = f)
> +
> +    for s in unconditional_syscalls:
> +        def_syscall(s, f)
> +    for s in conditional_syscalls:
> +        print("#ifdef TARGET_NR_", s, sep = '', file = f)
> +        def_syscall(s, f)
> +        print("#endif", file = f)
> +
> +    print("    }",
> +          "    return NULL;",
> +          "}",
> +          sep = '\n', file = f);
> +
> +
> +def main():
> +    p = sys.argv[1]
> +    f = open(p, "w")
> +
> +    print("/* This file is autogenerated by gensyscall.py.  */\n\n",
> +          file = f)
> +
> +    if p[len(p) - 1] == 'h':
> +        header(f)
> +    else:
> +        source(f)
> +
> +    f.close();
> +
> +
> +main()
> 

As we can see in patch 19/19 it's easy to forget to update the syscalls
lists.

Should it be possible to generate syscalls switch from the macro we
already have?

Something like (it should not be as simple as this but...):

#define SYSCALL_DEF(NAME, ...) \
    case TARGET_NR_##NAME: return @def_##NAME

static const SyscallDef *syscall_table(int num)
{
    switch (num) {
#include "syscall_file.def"
#include "syscall_ipc.def"
#include "syscall_mem.def"
#include "syscall_proc.def"
    }
    return NULL;
}

and in syscall_proc.def:

...
SYSCALL_DEF(clone)
#ifdef TARGET_NR_fork
SYSCALL_DEF(fork);
#endif
#ifdef TARGET_NR_vfork
SYSCALL_DEF(vfork);
#endif
...
SYSCALL_DEF(set_tid_address, ARG_PTR);

and in syscall_proc.c:
...
SYSCALL_IMPL(set_tid_address)
{
    return get_errno(set_tid_address((int *)g2h(arg1)));
}
#include "syscall_proc.def".

So compiler will detect any unused references (if SYSCALL_DEF doesn't
match SYSCALL_IMPL), the syscall_table has automatically all implemented
syscalls, it automatically manage conditional/unconditional syscalls and
we don't need generated files per target.

Thanks,
Laurent
