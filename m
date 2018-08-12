Received: from eggs.gnu.org ([2001:4830:134:3::10]:55693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fouan-0002sr-Az
	for qemu-devel@nongnu.org; Sun, 12 Aug 2018 13:56:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1foua1-0006dC-6j
	for qemu-devel@nongnu.org; Sun, 12 Aug 2018 13:55:44 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:39077)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fouZw-0006Vo-3y
	for qemu-devel@nongnu.org; Sun, 12 Aug 2018 13:55:02 -0400
Received: by mail-wr1-f42.google.com with SMTP id h10-v6so12348911wre.6
	for <qemu-devel@nongnu.org>; Sun, 12 Aug 2018 10:54:57 -0700 (PDT)
References: <20180812030740.99170-1-aoates@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <485414e6-9f8d-aa29-f36b-b02e76613752@redhat.com>
Date: Sun, 12 Aug 2018 12:17:35 +0200
MIME-Version: 1.0
In-Reply-To: <20180812030740.99170-1-aoates@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target-i386: Fix lcall to call gate in
 IA-32e mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Oates <aoates@google.com>, rth@twiddle.net, ehabkost@redhat.com, qemu-devel@nongnu.org

On 12/08/2018 05:07, Andrew Oates via Qemu-devel wrote:
> Currently call gates are always treated as 32-bit gates.  In IA-32e mode
> (either compatibility or 64-bit submode), system segment descriptors are
> always 64-bit.  Treating them as 32-bit has the expected unfortunate
> effect: only the lower 32 bits of the offset are loaded, the stack
> pointer is truncated, a bad new stack pointer is loaded from the TSS (if
> switching privilege levels), etc.
> 
> This change adds support for 64-bit call gate to the lcall instruction.
> Additionally, there should be a check for non-canonical stack pointers,
> but I've omitted that since there doesn't seem to be checks for
> non-canonical addresses in this code elsewhere.

Thanks.  It's also missing a check for task gates in 64-bit mode and,
since we are at it, we should also implement ljmp to call gates.
Something like this (untested):

diff --git a/target/i386/seg_helper.c b/target/i386/seg_helper.c
index d3b31f3c1b..0b2efe2cae 100644
--- a/target/i386/seg_helper.c
+++ b/target/i386/seg_helper.c
@@ -1645,6 +1645,13 @@ void helper_ljmp_protected(CPUX86State *env, int new_cs, target_ulong new_eip,
         rpl = new_cs & 3;
         cpl = env->hflags & HF_CPL_MASK;
         type = (e2 >> DESC_TYPE_SHIFT) & 0xf;
+#ifdef TARGET_X86_64
+        if (env->efer & MSR_EFER_LMA) {
+            if (type != 12) {
+                raise_exception_err_ra(env, EXCP0D_GPF, gate_cs & 0xfffc, GETPC());
+            }
+        }
+#endif
         switch (type) {
         case 1: /* 286 TSS */
         case 9: /* 386 TSS */
@@ -1666,6 +1673,21 @@ void helper_ljmp_protected(CPUX86State *env, int new_cs, target_ulong new_eip,
             new_eip = (e1 & 0xffff);
             if (type == 12) {
                 new_eip |= (e2 & 0xffff0000);
+#ifdef TARGET_X86_64
+                if (env->efer & MSR_EFER_LMA) {
+                    /* load the upper 8 bytes of the 64-bit call gate */
+                    if (load_segment_ra(env, &e1, &e2, new_cs + 8, GETPC())) {
+                        raise_exception_err_ra(env, EXCP0D_GPF, new_cs & 0xfffc,
+                                               GETPC());
+                    }
+                    type = (e2 >> DESC_TYPE_SHIFT) & 0x1f;
+                    if (type != 0) {
+                        raise_exception_err_ra(env, EXCP0D_GPF, gate_cs & 0xfffc,
+                                               GETPC());
+                    }
+                    new_eip |= ((target_ulong)e1) << 32;
+                }
+#endif
             }
             if (load_segment_ra(env, &e1, &e2, gate_cs, GETPC()) != 0) {
                 raise_exception_err_ra(env, EXCP0D_GPF, gate_cs & 0xfffc, GETPC());
@@ -1812,6 +1834,13 @@ void helper_lcall_protected(CPUX86State *env, int new_cs, target_ulong new_eip,
         type = (e2 >> DESC_TYPE_SHIFT) & 0x1f;
         dpl = (e2 >> DESC_DPL_SHIFT) & 3;
         rpl = new_cs & 3;
+#ifdef TARGET_X86_64
+        if (env->efer & MSR_EFER_LMA) {
+            if (type != 12) {
+                raise_exception_err_ra(env, EXCP0D_GPF, gate_cs & 0xfffc, GETPC());
+            }
+        }
+#endif
         switch (type) {
         case 1: /* available 286 TSS */
         case 9: /* available 386 TSS */


Out of curiosity, what OS is using 64-bit call gates? :)

Paolo

> I've left the raise_exception_err_ra lines unwapped at 80 columns to
> match the style in the rest of the file.
> 
> Signed-off-by: Andrew Oates <aoates@google.com>
> ---
>  target/i386/seg_helper.c | 145 ++++++++++++++++++++++++++++-----------
>  1 file changed, 106 insertions(+), 39 deletions(-)
