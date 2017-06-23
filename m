Received: from eggs.gnu.org ([2001:4830:134:3::10]:42919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dOMcr-0006lo-Sd
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 07:19:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dOMcm-00048e-U3
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 07:19:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59350)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dOMcm-00048G-KR
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 07:19:40 -0400
References: <20170621142152.GA18094@wxdeubuntu.ipads-lab.se.sjtu.edu.cn>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <641e1f35-813a-4244-0194-ffce08130533@redhat.com>
Date: Fri, 23 Jun 2017 13:19:35 +0200
MIME-Version: 1.0
In-Reply-To: <20170621142152.GA18094@wxdeubuntu.ipads-lab.se.sjtu.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target/i386: fix interrupt CPL error when
 using ist in x86-64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wu Xiang <willx8@gmail.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>



On 21/06/2017 16:21, Wu Xiang wrote:
> In do_interrupt64(), when interrupt stack table(ist) is enabled
> and the the target code segment is conforming(e2 & DESC_C_MASK), the
> old implementation always set new CPL to 0, and SS.RPL to 0.
> 
> This is incorrect for when CPL3 code access a CPL0 conforming code
> segment, the CPL should remain unchanged. Otherwise higher privileged
> code can be compromised.
> 
> The patch fix this for always set dpl = cpl when the target code segment
> is conforming, and modify the last parameter `flags`, which contains
> correct new CPL, in cpu_x86_load_seg_cache().
> 
> Signed-off-by: Wu Xiang <willx8@gmail.com>
> ---
>  target/i386/seg_helper.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

The patch looks good, but I'm thinking of a cleanup on top that simplifies
the handling of conforming code segments:

diff --git a/target/i386/seg_helper.c b/target/i386/seg_helper.c
index 9af69c23e0..600a4d7586 100644
--- a/target/i386/seg_helper.c
+++ b/target/i386/seg_helper.c
@@ -692,7 +692,10 @@ static void do_interrupt_protected(CPUX86State *env, int intno, int is_int,
     if (!(e2 & DESC_P_MASK)) {
         raise_exception_err(env, EXCP0B_NOSEG, selector & 0xfffc);
     }
-    if (!(e2 & DESC_C_MASK) && dpl < cpl) {
+    if (e2 & DESC_C_MASK) {
+        dpl = cpl;
+    }
+    if (dpl < cpl) {
         /* to inner privilege */
         get_ss_esp_from_tss(env, &ss, &esp, dpl, 0);
         if ((ss & 0xfffc) == 0) {
@@ -719,7 +722,7 @@ static void do_interrupt_protected(CPUX86State *env, int intno, int is_int,
         new_stack = 1;
         sp_mask = get_sp_mask(ss_e2);
         ssp = get_seg_base(ss_e1, ss_e2);
-    } else if ((e2 & DESC_C_MASK) || dpl == cpl) {
+    } else  {
         /* to same privilege */
         if (vm86) {
             raise_exception_err(env, EXCP0D_GPF, selector & 0xfffc);
@@ -728,13 +731,6 @@ static void do_interrupt_protected(CPUX86State *env, int intno, int is_int,
         sp_mask = get_sp_mask(env->segs[R_SS].flags);
         ssp = env->segs[R_SS].base;
         esp = env->regs[R_ESP];
-        dpl = cpl;
-    } else {
-        raise_exception_err(env, EXCP0D_GPF, selector & 0xfffc);
-        new_stack = 0; /* avoid warning */
-        sp_mask = 0; /* avoid warning */
-        ssp = 0; /* avoid warning */
-        esp = 0; /* avoid warning */
     }
 
     shift = type >> 3;
@@ -919,25 +915,21 @@ static void do_interrupt64(CPUX86State *env, int intno, int is_int,
     if (!(e2 & DESC_L_MASK) || (e2 & DESC_B_MASK)) {
         raise_exception_err(env, EXCP0D_GPF, selector & 0xfffc);
     }
-    if ((!(e2 & DESC_C_MASK) && dpl < cpl) || ist != 0) {
+    if (e2 & DESC_C_MASK) {
+        dpl = cpl;
+    }
+    if (dpl < cpl || ist != 0) {
         /* to inner privilege */
         new_stack = 1;
         esp = get_rsp_from_tss(env, ist != 0 ? ist + 3 : dpl);
         ss = 0;
-    } else if ((e2 & DESC_C_MASK) || dpl == cpl) {
+    } else {
         /* to same privilege */
         if (env->eflags & VM_MASK) {
             raise_exception_err(env, EXCP0D_GPF, selector & 0xfffc);
         }
         new_stack = 0;
         esp = env->regs[R_ESP];
-    } else {
-        raise_exception_err(env, EXCP0D_GPF, selector & 0xfffc);
-        new_stack = 0; /* avoid warning */
-        esp = 0; /* avoid warning */
-    }
-    if (e2 & DESC_C_MASK) {
-        dpl = cpl;
     }
     esp &= ~0xfLL; /* align stack */
 

Because dpl == cpl after the new "if", it's now unnecessary to check
the C bit when testing dpl < cpl.  Furthermore, dpl > cpl is checked
slightly above this code, so the final "else" is unreachable.

What do you think?

Paolo

> diff --git a/target/i386/seg_helper.c b/target/i386/seg_helper.c
> index 0374031..9af69c2 100644
> --- a/target/i386/seg_helper.c
> +++ b/target/i386/seg_helper.c
> @@ -931,12 +931,14 @@ static void do_interrupt64(CPUX86State *env, int intno, int is_int,
>          }
>          new_stack = 0;
>          esp = env->regs[R_ESP];
> -        dpl = cpl;
>      } else {
>          raise_exception_err(env, EXCP0D_GPF, selector & 0xfffc);
>          new_stack = 0; /* avoid warning */
>          esp = 0; /* avoid warning */
>      }
> +    if (e2 & DESC_C_MASK) {
> +        dpl = cpl;
> +    }
>      esp &= ~0xfLL; /* align stack */
>  
>      PUSHQ(esp, env->segs[R_SS].selector);
> @@ -956,7 +958,7 @@ static void do_interrupt64(CPUX86State *env, int intno, int is_int,
>  
>      if (new_stack) {
>          ss = 0 | dpl;
> -        cpu_x86_load_seg_cache(env, R_SS, ss, 0, 0, 0);
> +        cpu_x86_load_seg_cache(env, R_SS, ss, 0, 0, dpl << DESC_DPL_SHIFT);
>      }
>      env->regs[R_ESP] = esp;
>  
> 
