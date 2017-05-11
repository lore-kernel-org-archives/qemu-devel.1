Received: from eggs.gnu.org ([2001:4830:134:3::10]:41359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d8mcl-0005Kx-HU
	for qemu-devel@nongnu.org; Thu, 11 May 2017 07:51:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d8mci-0002HK-BU
	for qemu-devel@nongnu.org; Thu, 11 May 2017 07:51:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37148)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1d8mci-0002Gx-3g
	for qemu-devel@nongnu.org; Thu, 11 May 2017 07:51:12 -0400
References: <CALUZMn0mRMY7mx5ysWdSamV+UGbjwuif8UxQ47gFDK3fx8Hw2w@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6e9a0dff-949f-5ac9-2315-cbe0e4c99f58@redhat.com>
Date: Thu, 11 May 2017 13:51:08 +0200
MIME-Version: 1.0
In-Reply-To: <CALUZMn0mRMY7mx5ysWdSamV+UGbjwuif8UxQ47gFDK3fx8Hw2w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Guest SIGILL when different IO is implemented
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Miltiadis Hatzimihail <hatzimiltos@gmail.com>, qemu-devel@nongnu.org



On 11/05/2017 09:00, Miltiadis Hatzimihail wrote:
> 
> The interesting thing is that in the ram case the test is passing, but in
> the io is failing. Also, if I try this without KVM, it passes in both cases.

Yes, in the RAM case KVM is not invoked at all.

> So I ve done some reading and for the 2 cases above I get:
> 
> - KVM_EXIT_MMIO on memory_region_init_io  (KVM attempts and fails to
> emulate MOVSS),
> - KVM_EXIT_EXCEPTION on memory_region_init_ram(QEMU emulates MOVSS)

No, you don't get any exit for memory_region_init_ram.

> Is that right?
> 
> Now the question is, if I want to use the IO instead of a RAM, what's the
> best way to solve this?

Please try this KVM patch:

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index c25cfaf584e7..53fbd1589d2e 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -3534,6 +3534,22 @@ static int em_rdpmc(struct x86_emulate_ctxt *ctxt)
 	return X86EMUL_CONTINUE;
 }
 
+static int em_movss(struct x86_emulate_ctxt *ctxt)
+{
+	memcpy(ctxt->dst.valptr, ctxt->src.valptr, 4);
+	ctxt->op_bytes = 4;
+	ctxt->dst.bytes = 4;
+	return X86EMUL_CONTINUE;
+}
+
+static int em_movsd(struct x86_emulate_ctxt *ctxt)
+{
+	memcpy(ctxt->dst.valptr, ctxt->src.valptr, 8);
+	ctxt->op_bytes = 8;
+	ctxt->dst.bytes = 8;
+	return X86EMUL_CONTINUE;
+}
+
 static int em_mov(struct x86_emulate_ctxt *ctxt)
 {
 	memcpy(ctxt->dst.valptr, ctxt->src.valptr, sizeof(ctxt->src.valptr));
@@ -4407,6 +4423,11 @@ static int check_perm_out(struct x86_emulate_ctxt *ctxt)
 	I(Mmx, em_mov), I(Sse | Aligned, em_mov), N, I(Sse | Unaligned, em_mov),
 };
 
+static const struct gprefix pfx_0f_10_0f_11 = {
+	I(Sse | Unaligned, em_mov), I(Sse | Unaligned, em_mov),
+	I(Sse, em_movsd), I(Sse, em_movss),
+};
+
 static const struct instr_dual instr_dual_0f_2b = {
 	I(0, em_mov), N
 };
@@ -4626,6 +4647,8 @@ static int check_perm_out(struct x86_emulate_ctxt *ctxt)
 	DI(ImplicitOps | Priv, invd), DI(ImplicitOps | Priv, wbinvd), N, N,
 	N, D(ImplicitOps | ModRM | SrcMem | NoAccess), N, N,
 	/* 0x10 - 0x1F */
+	GP(SrcMem | DstReg | ModRM | Mov, &pfx_0f_10_0f_11),
+	GP(SrcReg | DstMem | ModRM | Mov, &pfx_0f_10_0f_11),
 	N, N, N, N, N, N, N, N,
 	D(ImplicitOps | ModRM | SrcMem | NoAccess),
 	N, N, N, N, N, N, D(ImplicitOps | ModRM | SrcMem | NoAccess),

Thanks,

Paolo
