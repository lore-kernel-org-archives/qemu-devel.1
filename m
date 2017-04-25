Received: from eggs.gnu.org ([2001:4830:134:3::10]:36213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d2yZm-0004le-BE
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 07:24:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d2yZl-0000nI-Bb
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 07:24:10 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <1493106839-10438-1-git-send-email-cota@braap.org>
	<1493106839-10438-8-git-send-email-cota@braap.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <a844cf87-7df3-f854-31b5-3ac88ba1bf26@twiddle.net>
Date: Tue, 25 Apr 2017 13:24:00 +0200
MIME-Version: 1.0
In-Reply-To: <1493106839-10438-8-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 07/13] tcg/i386: implement goto_ptr op
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Andrzej Zaborowski <balrogg@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Alexander Graf <agraf@suse.de>, Stefan Weil <sw@weilnetz.de>, qemu-arm@nongnu.org, alex.bennee@linaro.org, Pranith Kumar <bobby.prani+qemu@gmail.com>

On 04/25/2017 09:53 AM, Emilio G. Cota wrote:
> +    case INDEX_op_goto_ptr:
> +        /* save target address into new register */
> +        tcg_out_mov(s, TCG_TYPE_PTR, TCG_REG_EDX, a0);
> +        /* set return value to 0 */
> +        tgen_arithr(s, ARITH_XOR, TCG_REG_EAX, TCG_REG_EAX);
> +        /* jmp to the target address (could be epilogue) */
> +        tcg_out_modrm(s, OPC_GRP5, EXT5_JMPN_Ev, TCG_REG_EDX);
> +        break;

I've just thought of an improvement to be made here -- move the xor after the 
jump (and therefore just before the "normal" epilogue) like so.


r~


diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index f6fb03e..f636557 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -1907,12 +1907,8 @@ static inline void tcg_out_op
          s->tb_jmp_reset_offset[a0] = tcg_current_code_size(s);
          break;
      case INDEX_op_goto_ptr:
-        /* save target address into new register */
-        tcg_out_mov(s, TCG_TYPE_PTR, TCG_REG_EDX, a0);
-        /* set return value to 0 */
-        tgen_arithr(s, ARITH_XOR, TCG_REG_EAX, TCG_REG_EAX);
-        /* jmp to the target address (could be epilogue) */
-        tcg_out_modrm(s, OPC_GRP5, EXT5_JMPN_Ev, TCG_REG_EDX);
+        /* jmp to the given host address (could be epilogue) */
+        tcg_out_modrm(s, OPC_GRP5, EXT5_JMPN_Ev, a0);
          break;
      case INDEX_op_br:
          tcg_out_jxx(s, JCC_JMP, arg_label(a0), 0);
@@ -2579,10 +2575,13 @@ static void tcg_target_qemu_prologue
      tcg_out_modrm(s, OPC_GRP5, EXT5_JMPN_Ev, tcg_target_call_iarg_regs[1]);
  #endif

-    /* TB epilogue */
-    tb_ret_addr = s->code_ptr;
+    /* Return path for goto_ptr.  Set return value to 0, a-la exit_tb,
+       and fall through to the rest of the epilogue.  */
      s->code_gen_epilogue = s->code_ptr;
+    tcg_out_movi(s, TCG_TYPE_REG, TCG_REG_EAX, 0);

+    /* TB epilogue */
+    tb_ret_addr = s->code_ptr;
      tcg_out_addi(s, TCG_REG_CALL_STACK, stack_addend);

      for (i = ARRAY_SIZE(tcg_target_callee_save_regs) - 1; i >= 0; i--) {
