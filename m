Received: from eggs.gnu.org ([2001:4830:134:3::10]:35906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fp0QB-0006Rl-JY
	for qemu-devel@nongnu.org; Sun, 12 Aug 2018 20:09:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fp0Q8-0000cj-Bz
	for qemu-devel@nongnu.org; Sun, 12 Aug 2018 20:09:19 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:41405)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fp0Q7-0000cN-Sa
	for qemu-devel@nongnu.org; Sun, 12 Aug 2018 20:09:16 -0400
Received: by mail-pg1-x541.google.com with SMTP id z8-v6so6719644pgu.8
	for <qemu-devel@nongnu.org>; Sun, 12 Aug 2018 17:09:15 -0700 (PDT)
References: <20180612005145.3375-1-richard.henderson@linaro.org>
	<20180612005145.3375-13-richard.henderson@linaro.org>
	<d476b918-32ef-0360-7bf4-19bbb7e916ef@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <de9b682d-b7a2-b2c5-4b94-e68428f3d29b@linaro.org>
Date: Sun, 12 Aug 2018 17:09:11 -0700
MIME-Version: 1.0
In-Reply-To: <d476b918-32ef-0360-7bf4-19bbb7e916ef@vivier.eu>
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
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

On 08/12/2018 01:45 PM, Laurent Vivier wrote:
> Le 12/06/2018 à 02:51, Richard Henderson a écrit :
>> Defines a unified structure for implementation and strace.
>> Supplies a generator script to build the declarations and
>> the lookup function.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  linux-user/syscall.h           | 178 +++++++++++++++
>>  linux-user/strace.c            | 386 ++++++++++++++++++++++++---------
>>  linux-user/syscall.c           | 113 ++++------
>>  linux-user/Makefile.objs       |  10 +
>>  linux-user/gen_syscall_list.py |  82 +++++++
>>  5 files changed, 595 insertions(+), 174 deletions(-)
>>  create mode 100644 linux-user/syscall.h
>>  create mode 100644 linux-user/gen_syscall_list.py
> ...
>> diff --git a/linux-user/Makefile.objs b/linux-user/Makefile.objs
>> index 59a5c17354..afa69ed6d2 100644
>> --- a/linux-user/Makefile.objs
>> +++ b/linux-user/Makefile.objs
>> @@ -7,3 +7,13 @@ obj-$(TARGET_HAS_BFLT) += flatload.o
>>  obj-$(TARGET_I386) += vm86.o
>>  obj-$(TARGET_ARM) += arm/nwfpe/
>>  obj-$(TARGET_M68K) += m68k-sim.o
>> +
>> +GEN_SYSCALL_LIST = $(SRC_PATH)/linux-user/gen_syscall_list.py
>> +SYSCALL_LIST = linux-user/syscall_list.h linux-user/syscall_list.inc.c
>> +
>> +$(SYSCALL_LIST): $(GEN_SYSCALL_LIST)
>> +	$(call quiet-command,\
>> +	  $(PYTHON) $(GEN_SYSCALL_LIST) $@, "GEN", $(TARGET_DIR)$@)
>> +
>> +linux-user/syscall.o \
>> +linux-user/strace.o: $(SYSCALL_LIST)
>> diff --git a/linux-user/gen_syscall_list.py b/linux-user/gen_syscall_list.py
>> new file mode 100644
>> index 0000000000..2e0fc39100
>> --- /dev/null
>> +++ b/linux-user/gen_syscall_list.py
>> @@ -0,0 +1,82 @@
>> +#
>> +# Linux syscall table generator
>> +# Copyright (c) 2018 Linaro, Limited.
>> +#
>> +# This program is free software; you can redistribute it and/or modify
>> +# it under the terms of the GNU General Public License as published by
>> +# the Free Software Foundation; either version 2 of the License, or
>> +# (at your option) any later version.
>> +#
>> +# This program is distributed in the hope that it will be useful,
>> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
>> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> +# GNU General Public License for more details.
>> +#
>> +# You should have received a copy of the GNU General Public License
>> +# along with this program; if not, see <http://www.gnu.org/licenses/>.
>> +#
>> +
>> +from __future__ import print_function
>> +import sys
>> +
>> +# These are sets of all syscalls that have been converted.
>> +# The lists are in collation order with '_' ignored.
>> +
>> +# These syscalls are supported by all targets.
>> +# Avoiding ifdefs for these can diagnose typos in $cpu/syscall_nr.h
>> +unconditional_syscalls = [
>> +]
>> +
>> +# These syscalls are only supported by some target or abis.
>> +conditional_syscalls = [
>> +]
>> +
>> +
>> +def header(f):
>> +    # Do not ifdef the declarations -- their use may be complicated.
>> +    all = unconditional_syscalls + conditional_syscalls
>> +    all.sort()
>> +    for s in all:
>> +        print("extern const SyscallDef def_", s, ";", sep = '', file = f)
>> +
>> +
>> +def def_syscall(s, f):
>> +    print("    case TARGET_NR_", s, ": return &def_", s, ";",
>> +          sep = '', file = f);
>> +
>> +
>> +def source(f):
>> +    print("static const SyscallDef *syscall_table(int num)",
>> +          "{",
>> +          "    switch (num) {",
>> +          sep = '\n', file = f)
>> +
>> +    for s in unconditional_syscalls:
>> +        def_syscall(s, f)
>> +    for s in conditional_syscalls:
>> +        print("#ifdef TARGET_NR_", s, sep = '', file = f)
>> +        def_syscall(s, f)
>> +        print("#endif", file = f)
>> +
>> +    print("    }",
>> +          "    return NULL;",
>> +          "}",
>> +          sep = '\n', file = f);
>> +
>> +
>> +def main():
>> +    p = sys.argv[1]
>> +    f = open(p, "w")
>> +
>> +    print("/* This file is autogenerated by gensyscall.py.  */\n\n",
>> +          file = f)
>> +
>> +    if p[len(p) - 1] == 'h':
>> +        header(f)
>> +    else:
>> +        source(f)
>> +
>> +    f.close();
>> +
>> +
>> +main()
>>
> 
> As we can see in patch 19/19 it's easy to forget to update the syscalls
> lists.
> 
> Should it be possible to generate syscalls switch from the macro we
> already have?

I didn't see how, right off.

It was possible when all of the syscalls were still in the same file, as we
could get defined-but-unused warnings.  With them in different files, we don't
get that.

Perhaps there's a way that

> static const SyscallDef *syscall_table(int num)
> {
>     switch (num) {
> #include "syscall_file.def"
> #include "syscall_ipc.def"
> #include "syscall_mem.def"
> #include "syscall_proc.def"
>     }
>     return NULL;
> }
> 
> and in syscall_proc.def:

something like this achieves that, via missing-prototype warnings.

But if we have a structure like this, I wonder if we're better off with

#include "syscall_file.inc.c"
#include "syscall_ipc.inc.c"

etc and go back to the defined-but-unused warnings, which are simpler to
manage.  That lets me drop the python script entirely, much like v2.


r~
