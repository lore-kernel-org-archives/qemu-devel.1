Received: from eggs.gnu.org ([2001:4830:134:3::10]:38682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1euDgA-0004bk-Hy
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 03:47:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1euDg7-0007XW-GA
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 03:47:06 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39222 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1euDg7-0007X3-Bs
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 03:47:03 -0500
References: <20180308083231.20180-1-kraxel@redhat.com>
	<CAFEAcA8wUN_T9XrUULCROVFdv+vGipdMuhNz5km1mcX_nVrQgg@mail.gmail.com>
	<20180309065247.xzribx4zjgx5bnj5@sirius.home.kraxel.org>
	<20180309075054.e4bpa4wsl2wak57w@sirius.home.kraxel.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <f0968a33-fb14-4de2-3a1b-130e2ae7b0ee@redhat.com>
Date: Fri, 9 Mar 2018 09:46:44 +0100
MIME-Version: 1.0
In-Reply-To: <20180309075054.e4bpa4wsl2wak57w@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 0/8] Ui 20180308 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 09.03.2018 08:50, Gerd Hoffmann wrote:
>   Hi,
> 
>> Maybe I should move the code to a separate source file so it can be
>> built with different compiler flags, without needing #pragma?  I don't
>> feel like building all gtk code with -Wno-deprecated-declarations ...
> 
> Hmm, that idea doesn't fly, seems per-object cflags don't work for
> object files which get linked into a module.
> 
> Other ideas anyone?

Maybe simply remove the '#pragma GCC diagnostic ignored
"-Wunused-but-set-variable"' from the configure test and change
util/coroutine-ucontext.c:

diff a/util/coroutine-ucontext.c b/util/coroutine-ucontext.c
--- a/util/coroutine-ucontext.c
+++ b/util/coroutine-ucontext.c
@@ -170,7 +170,7 @@ Coroutine *qemu_coroutine_new(void)
 }

 #ifdef CONFIG_VALGRIND_H
-#ifdef CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE
+#if defined(CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE) && !defined(__clang__)
 /* Work around an unused variable in the valgrind.h macro... */
 #pragma GCC diagnostic push
 #pragma GCC diagnostic ignored "-Wunused-but-set-variable"
@@ -179,7 +179,7 @@ static inline void
valgrind_stack_deregister(CoroutineUContext *co)
 {
     VALGRIND_STACK_DEREGISTER(co->valgrind_stack_id);
 }
-#ifdef CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE
+#if defined(CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE) && !defined(__clang__)
 #pragma GCC diagnostic pop
 #endif
 #endif


?

 Thomas
