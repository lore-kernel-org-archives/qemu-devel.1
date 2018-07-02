Received: from eggs.gnu.org ([2001:4830:134:3::10]:42796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fa1bU-0004yh-R9
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:23:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fa1bR-0006tT-LS
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:23:04 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:42046)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fa1bR-0006tK-FD
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:23:01 -0400
Received: by mail-qk0-x241.google.com with SMTP id u62-v6so8928402qkf.9
	for <qemu-devel@nongnu.org>; Mon, 02 Jul 2018 09:23:01 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180702143021.18864-1-alex.bennee@linaro.org>
	<20180702143021.18864-10-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <19661f74-d44b-590f-2226-cdcab27ab82b@amsat.org>
Date: Mon, 2 Jul 2018 13:22:55 -0300
MIME-Version: 1.0
In-Reply-To: <20180702143021.18864-10-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 09/20] linux-user: introduce
 preexit_cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, cota@braap.org, famz@redhat.com, berrange@redhat.com, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

Hi Alex,

On 07/02/2018 11:30 AM, Alex Bennée wrote:
> To avoid repeating ourselves move our preexit clean-up code into a
> helper function. I figured the continuing effort to split of the
> syscalls made it worthwhile creating a new file for it now.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  linux-user/Makefile.objs |  2 +-
>  linux-user/exit.c        | 28 ++++++++++++++++++++++++++++
>  linux-user/qemu.h        |  8 ++++++++
>  linux-user/syscall.c     | 10 ++--------
>  4 files changed, 39 insertions(+), 9 deletions(-)
>  create mode 100644 linux-user/exit.c
> 
> diff --git a/linux-user/Makefile.objs b/linux-user/Makefile.objs
> index 59a5c17354..b5dfb71f25 100644
> --- a/linux-user/Makefile.objs
> +++ b/linux-user/Makefile.objs
> @@ -1,7 +1,7 @@
>  obj-y = main.o syscall.o strace.o mmap.o signal.o \
>  	elfload.o linuxload.o uaccess.o uname.o \
>  	safe-syscall.o $(TARGET_ABI_DIR)/signal.o \
> -        $(TARGET_ABI_DIR)/cpu_loop.o
> +        $(TARGET_ABI_DIR)/cpu_loop.o exit.o
>  
>  obj-$(TARGET_HAS_BFLT) += flatload.o
>  obj-$(TARGET_I386) += vm86.o
> diff --git a/linux-user/exit.c b/linux-user/exit.c
> new file mode 100644
> index 0000000000..aed8713fae
> --- /dev/null
> +++ b/linux-user/exit.c
> @@ -0,0 +1,28 @@
> +/*
> + *  exit support for qemu
> + *
> + *  Copyright (c) 2018 Alex Bennée <alex.bennee@linaro.org>
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; either version 2 of the License, or
> + *  (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> +#include "qemu/osdep.h"
> +#include "qemu.h"
> +
> +void preexit_cleanup(CPUArchState *env, int code)
> +{
> +#ifdef TARGET_GPROF
> +        _mcleanup();
> +#endif
> +        gdb_exit(env, code);
> +}

Using:

'configure' '--enable-gprof' '--enable-gcov' '--disable-pie' --static
[...]
C compiler        gcc-8
CFLAGS            -fprofile-arcs -ftest-coverage -g -g
LDFLAGS           -Wl,--warn-common -fprofile-arcs -ftest-coverage -m64
-static -g
gprof enabled     yes
static build      yes
PIE               no
gcov              gcov
gcov enabled      yes
docker            yes

I get:

$ make subdir-ppc-linux-user
[...]
  CC      ppc-linux-user/linux-user/exit.o
linux-user/exit.c: In function ‘preexit_cleanup’:
linux-user/exit.c:29:9: error: implicit declaration of function
‘_mcleanup’ [-Werror=implicit-function-declaration]
         _mcleanup();
         ^~~~~~~~~
linux-user/exit.c:29:9: error: nested extern declaration of ‘_mcleanup’
[-Werror=nested-externs]
cc1: all warnings being treated as errors
make[1]: *** [rules.mak:69: linux-user/exit.o] Error 1
make: *** [Makefile:481: subdir-ppc-linux-user] Error 2

I suppose gprof and static builds are exclusive.

> diff --git a/linux-user/qemu.h b/linux-user/qemu.h
> index 793cd4df04..bb85c81aa4 100644
> --- a/linux-user/qemu.h
> +++ b/linux-user/qemu.h
> @@ -623,6 +623,14 @@ static inline int is_error(abi_long ret)
>      return (abi_ulong)ret >= (abi_ulong)(-4096);
>  }
>  
> +/**
> + * preexit_cleanup: housekeeping before the guest exits
> + *
> + * env: the CPU state
> + * code: the exit code
> + */
> +void preexit_cleanup(CPUArchState *env, int code);
> +
>  /* Include target-specific struct and function definitions;
>   * they may need access to the target-independent structures
>   * above, so include them last.
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 2117fb13b4..7c66442357 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -8018,10 +8018,7 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
>          }
>  
>          cpu_list_unlock();
> -#ifdef TARGET_GPROF
> -        _mcleanup();
> -#endif
> -        gdb_exit(cpu_env, arg1);
> +        preexit_cleanup(cpu_env, arg1);
>          _exit(arg1);
>          ret = 0; /* avoid warning */
>          break;
> @@ -10127,10 +10124,7 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
>  #ifdef __NR_exit_group
>          /* new thread calls */
>      case TARGET_NR_exit_group:
> -#ifdef TARGET_GPROF
> -        _mcleanup();
> -#endif
> -        gdb_exit(cpu_env, arg1);
> +        preexit_cleanup(cpu_env, arg1);
>          ret = get_errno(exit_group(arg1));
>          break;
>  #endif
> 
