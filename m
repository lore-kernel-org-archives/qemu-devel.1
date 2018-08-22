Received: from eggs.gnu.org ([2001:4830:134:3::10]:33407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fsHMZ-0006NN-6R
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 20:51:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fsHMV-0004Kg-S0
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 20:51:07 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:60713)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fsHMT-0004Ib-1B
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 20:51:01 -0400
References: <20180818190118.12911-1-richard.henderson@linaro.org>
	<20180818190118.12911-11-richard.henderson@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <51f5ba46-f63a-e433-7e0b-82e72a643d79@vivier.eu>
Date: Wed, 22 Aug 2018 02:50:56 +0200
MIME-Version: 1.0
In-Reply-To: <20180818190118.12911-11-richard.henderson@linaro.org>
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

Le 18/08/2018 à 21:01, Richard Henderson a écrit :
> This includes close, open, openat, read, readlink, readlinkat, write.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/strace.c           |  64 -----
>  linux-user/syscall-file.inc.c | 440 ++++++++++++++++++++++++++++++++++
>  linux-user/syscall.c          | 393 ++----------------------------
>  linux-user/strace.list        |  21 --
>  4 files changed, 463 insertions(+), 455 deletions(-)
>  create mode 100644 linux-user/syscall-file.inc.c
> 
...
> +#include "syscall-file.inc.c"
> +
>  static const SyscallDef *syscall_table(int num)
>  {
> -#define S(NAME)  case TARGET_NR_##NAME: return &def_##NAME;
> +#define S(NAME)  case TARGET_NR_##NAME: return &def_##NAME
>  
>      switch (num) {
> +    /*
> +     * Unconditional syscalls.
> +     */
> +    S(close);
> +    S(openat);
> +    S(read);
> +    S(write);
> +
> +    /*
> +     * Conditional syscalls.
> +     */
> +#ifdef TARGET_NR_open
> +    S(open);
> +#endif
> +#ifdef TARGET_NR_readlink
> +    S(readlink);
> +#endif
> +#ifdef TARGET_NR_readlinkat
> +    S(readlinkat);
> +#endif
>      }
>      return NULL;

I don't understand why you need/want to duplicate the list of syscalls here.

If I modify your patch as following, it works without duplicating the list:

diff --git a/linux-user/syscall-file.def.c b/linux-user/syscall-file.def.c
new file mode 100644
index 0000000000..78b1bd0467
--- /dev/null
+++ b/linux-user/syscall-file.def.c
@@ -0,0 +1,13 @@
+SYSCALL_DEF(close, ARG_DEC);
+#ifdef TARGET_NR_open
+SYSCALL_DEF(open, ARG_STR, ARG_OPENFLAG, ARG_MODEFLAG);
+#endif
+SYSCALL_DEF(openat, ARG_ATDIRFD, ARG_STR, ARG_OPENFLAG, ARG_MODEFLAG);
+SYSCALL_DEF(read, ARG_DEC, ARG_PTR, ARG_DEC);
+#ifdef TARGET_NR_readlink
+SYSCALL_DEF(readlink, ARG_STR, ARG_PTR, ARG_DEC);
+#endif
+#ifdef TARGET_NR_readlinkat
+SYSCALL_DEF(readlinkat, ARG_ATDIRFD, ARG_STR, ARG_PTR, ARG_DEC);
+#endif
+SYSCALL_DEF(write, ARG_DEC, ARG_PTR, ARG_DEC);
diff --git a/linux-user/syscall-file.inc.c b/linux-user/syscall-file.inc.c
index aecc63682f..dda04200ed 100644
--- a/linux-user/syscall-file.inc.c
+++ b/linux-user/syscall-file.inc.c
@@ -307,21 +307,18 @@ SYSCALL_IMPL(close)
     fd_trans_unregister(arg1);
     return get_errno(close(arg1));
 }
-SYSCALL_DEF(close, ARG_DEC);

 #ifdef TARGET_NR_open
 SYSCALL_IMPL(open)
 {
     return do_openat(cpu_env, AT_FDCWD, arg1, arg2, arg3);
 }
-SYSCALL_DEF(open, ARG_STR, ARG_OPENFLAG, ARG_MODEFLAG);
 #endif

 SYSCALL_IMPL(openat)
 {
     return do_openat(cpu_env, arg1, arg2, arg3, arg4);
 }
-SYSCALL_DEF(openat, ARG_ATDIRFD, ARG_STR, ARG_OPENFLAG, ARG_MODEFLAG);

 SYSCALL_IMPL(read)
 {
@@ -346,7 +343,6 @@ SYSCALL_IMPL(read)
     unlock_user(p, arg2, ret);
     return ret;
 }
-SYSCALL_DEF(read, ARG_DEC, ARG_PTR, ARG_DEC);

 static abi_long do_readlink_proc_exe(char *buf, abi_ulong bufsiz)
 {
@@ -386,7 +382,6 @@ SYSCALL_IMPL(readlink)
     unlock_user(p, arg1, 0);
     return ret;
 }
-SYSCALL_DEF(readlink, ARG_STR, ARG_PTR, ARG_DEC);
 #endif

 #ifdef TARGET_NR_readlinkat
@@ -411,7 +406,6 @@ SYSCALL_IMPL(readlinkat)
     unlock_user(p, arg2, 0);
     return ret;
 }
-SYSCALL_DEF(readlinkat, ARG_ATDIRFD, ARG_STR, ARG_PTR, ARG_DEC);
 #endif

 SYSCALL_IMPL(write)
@@ -437,4 +431,4 @@ SYSCALL_IMPL(write)
     unlock_user(p, arg2, 0);
     return ret;
 }
-SYSCALL_DEF(write, ARG_DEC, ARG_PTR, ARG_DEC);
+#include "syscall-file.def.c"
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index f757ae87b0..21e7700255 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -12117,33 +12117,15 @@ static abi_long do_syscall1(void *cpu_env, int
num, abi_long arg1,

 static const SyscallDef *syscall_table(int num)
 {
-#define S(NAME)  case TARGET_NR_##NAME: return &def_##NAME
+#undef SYSCALL_DEF
+#define SYSCALL_DEF(NAME, ...)  case TARGET_NR_##NAME: return &def_##NAME

     switch (num) {
-    /*
-     * Unconditional syscalls.
-     */
-    S(close);
-    S(openat);
-    S(read);
-    S(write);
-
-    /*
-     * Conditional syscalls.
-     */
-#ifdef TARGET_NR_open
-    S(open);
-#endif
-#ifdef TARGET_NR_readlink
-    S(readlink);
-#endif
-#ifdef TARGET_NR_readlinkat
-    S(readlinkat);
-#endif
+#include "syscall-file.def.c"
     }
     return NULL;

-#undef S
+#undef SYSCALL_DEF
 }

 abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
