Received: from eggs.gnu.org ([2001:4830:134:3::10]:37802)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ricardo.ribalda@gmail.com>) id 1dVNGO-0006Tf-GR
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 15:25:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ricardo.ribalda@gmail.com>) id 1dVNGN-0006bF-L5
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 15:25:32 -0400
Received: from mail-it0-x244.google.com ([2607:f8b0:4001:c0b::244]:35427)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ricardo.ribalda@gmail.com>)
	id 1dVNGN-0006au-Fx
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 15:25:31 -0400
Received: by mail-it0-x244.google.com with SMTP id v193so3471409itc.2
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 12:25:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4d0a2af9-8966-0ad5-603b-3aad5d110c31@twiddle.net>
References: <CAPybu_0+enKVGf-bZHrkvWQ8reFtJnkKC=sucr2aaZ_DidaHNA@mail.gmail.com>
	<20170712184540.12352-1-rth@twiddle.net>
	<CAPybu_35LKPPZuQMxCSsRM+YaBd+jhqfj=L7kKZZEMomB0bqWg@mail.gmail.com>
	<4d0a2af9-8966-0ad5-603b-3aad5d110c31@twiddle.net>
From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date: Wed, 12 Jul 2017 21:25:09 +0200
Message-ID: <CAPybu_3xB0z+TkbYMjdUtid9fJ5bsA7kHy6bK_j6WeugDPUg-w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] target/i386: Fix BLSR and BLSI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com, pbonzini@redhat.com

This seems to work fine with the example. But my app still throughs sigsegv :(

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 2c64d2b71ec4..564b9c6057c2 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -4033,32 +4033,23 @@ static void gen_sse(CPUX86State *env,
DisasContext *s, int b,

                 switch (reg & 7) {
                 case 1: /* blsr By,Ey */
-                    tcg_gen_neg_tl(cpu_T1, cpu_T0);
+                    tcg_gen_subi_tl(cpu_T1, cpu_T0, 1);
                     tcg_gen_and_tl(cpu_T0, cpu_T0, cpu_T1);
                     gen_op_mov_reg_v(ot, s->vex_v, cpu_T0);
-                    gen_op_update2_cc();
-                    set_cc_op(s, CC_OP_BMILGB + ot);
                     break;
-
                 case 2: /* blsmsk By,Ey */
-                    tcg_gen_mov_tl(cpu_cc_src, cpu_T0);
-                    tcg_gen_subi_tl(cpu_T0, cpu_T0, 1);
-                    tcg_gen_xor_tl(cpu_T0, cpu_T0, cpu_cc_src);
-                    tcg_gen_mov_tl(cpu_cc_dst, cpu_T0);
-                    set_cc_op(s, CC_OP_BMILGB + ot);
+                    tcg_gen_subi_tl(cpu_T1, cpu_T0, 1);
+                    tcg_gen_xor_tl(cpu_T0, cpu_T0, cpu_T1);
                     break;
-
                 case 3: /* blsi By, Ey */
-                    tcg_gen_mov_tl(cpu_cc_src, cpu_T0);
-                    tcg_gen_subi_tl(cpu_T0, cpu_T0, 1);
-                    tcg_gen_and_tl(cpu_T0, cpu_T0, cpu_cc_src);
-                    tcg_gen_mov_tl(cpu_cc_dst, cpu_T0);
-                    set_cc_op(s, CC_OP_BMILGB + ot);
+                    tcg_gen_neg_tl(cpu_T1, cpu_T0);
+                    tcg_gen_and_tl(cpu_T0, cpu_T0, cpu_T1);
                     break;
-
                 default:
                     goto unknown_op;
                 }
+                gen_op_update2_cc();
+                set_cc_op(s, CC_OP_BMILGB + ot);
                 break;

             default:

On Wed, Jul 12, 2017 at 9:12 PM, Richard Henderson <rth@twiddle.net> wrote:
> On 07/12/2017 08:58 AM, Ricardo Ribalda Delgado wrote:
>>
>> Hi Richard
>>
>> Thanks again!, When I apply this patch I get the following error:
>>
>> /tmp/qemu/tcg/tcg.c:2042: tcg fatal error
>
>
> Bah.  I misremembered that OR_TMP1 is unusable in this context.
>
>
> r~



-- 
Ricardo Ribalda
