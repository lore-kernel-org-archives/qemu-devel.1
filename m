Received: from eggs.gnu.org ([2001:4830:134:3::10]:57302)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hatzimiltos@gmail.com>) id 1d8nOZ-0007kb-97
	for qemu-devel@nongnu.org; Thu, 11 May 2017 08:40:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hatzimiltos@gmail.com>) id 1d8nOX-0002PP-Oy
	for qemu-devel@nongnu.org; Thu, 11 May 2017 08:40:39 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:35287)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <hatzimiltos@gmail.com>)
	id 1d8nOX-0002Ng-Fa
	for qemu-devel@nongnu.org; Thu, 11 May 2017 08:40:37 -0400
Received: by mail-wm0-x242.google.com with SMTP id v4so6733765wmb.2
	for <qemu-devel@nongnu.org>; Thu, 11 May 2017 05:40:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <6e9a0dff-949f-5ac9-2315-cbe0e4c99f58@redhat.com>
References: <CALUZMn0mRMY7mx5ysWdSamV+UGbjwuif8UxQ47gFDK3fx8Hw2w@mail.gmail.com>
	<6e9a0dff-949f-5ac9-2315-cbe0e4c99f58@redhat.com>
From: Miltiadis Hatzimihail <hatzimiltos@gmail.com>
Date: Thu, 11 May 2017 13:40:15 +0100
Message-ID: <CALUZMn14qgNz8y+15bsKFwyB9Ganoh0wzu5tfokCDRSASnBeKA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Guest SIGILL when different IO is implemented
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org

Thanks Paolo that worked!

Btw, this line

=E2=80=8B
+       GP(SrcMem | DstReg | ModRM | Mov, &pfx_0f_10_0f_11),
+       GP(SrcReg | DstMem | ModRM | Mov, &pfx_0f_10_0f_11),
-        N, N, N, N, N, N, N, N,
+       N, N, N, N, N, N,

I think it has 2 extra Ns (not removed from your change?).

Those instructions were not implemented for a reason or is it simply a
chance of never seeing this issue that I saw?

>> The interesting thing is that in the ram case the test is passing, but i=
n
>> the io is failing. Also, if I try this without KVM, it passes in both
cases.
>
>Yes, in the RAM case KVM is not invoked at all.
So for my benefit, does this mean that any RAM transaction is emulated by
QEMU or does it go through KVM to the bare metal? (and hence, KVM is not
emulating this?)

=E2=80=8BMilton


On Thu, May 11, 2017 at 12:51 PM, Paolo Bonzini <pbonzini@redhat.com> wrote=
:

>
>
> On 11/05/2017 09:00, Miltiadis Hatzimihail wrote:
> >
> > The interesting thing is that in the ram case the test is passing, but =
in
> > the io is failing. Also, if I try this without KVM, it passes in both
> cases.
>
> Yes, in the RAM case KVM is not invoked at all.
>
> > So I ve done some reading and for the 2 cases above I get:
> >
> > - KVM_EXIT_MMIO on memory_region_init_io  (KVM attempts and fails to
> > emulate MOVSS),
> > - KVM_EXIT_EXCEPTION on memory_region_init_ram(QEMU emulates MOVSS)
>
> No, you don't get any exit for memory_region_init_ram.
>
> > Is that right?
> >
> > Now the question is, if I want to use the IO instead of a RAM, what's t=
he
> > best way to solve this?
>
> Please try this KVM patch:
>
> diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
> index c25cfaf584e7..53fbd1589d2e 100644
> --- a/arch/x86/kvm/emulate.c
> +++ b/arch/x86/kvm/emulate.c
> @@ -3534,6 +3534,22 @@ static int em_rdpmc(struct x86_emulate_ctxt *ctxt)
>         return X86EMUL_CONTINUE;
>  }
>
> +static int em_movss(struct x86_emulate_ctxt *ctxt)
> +{
> +       memcpy(ctxt->dst.valptr, ctxt->src.valptr, 4);
> +       ctxt->op_bytes =3D 4;
> +       ctxt->dst.bytes =3D 4;
> +       return X86EMUL_CONTINUE;
> +}
> +
> +static int em_movsd(struct x86_emulate_ctxt *ctxt)
> +{
> +       memcpy(ctxt->dst.valptr, ctxt->src.valptr, 8);
> +       ctxt->op_bytes =3D 8;
> +       ctxt->dst.bytes =3D 8;
> +       return X86EMUL_CONTINUE;
> +}
> +
>  static int em_mov(struct x86_emulate_ctxt *ctxt)
>  {
>         memcpy(ctxt->dst.valptr, ctxt->src.valptr,
> sizeof(ctxt->src.valptr));
> @@ -4407,6 +4423,11 @@ static int check_perm_out(struct x86_emulate_ctxt
> *ctxt)
>         I(Mmx, em_mov), I(Sse | Aligned, em_mov), N, I(Sse | Unaligned,
> em_mov),
>  };
>
> +static const struct gprefix pfx_0f_10_0f_11 =3D {
> +       I(Sse | Unaligned, em_mov), I(Sse | Unaligned, em_mov),
> +       I(Sse, em_movsd), I(Sse, em_movss),
> +};
> +
>  static const struct instr_dual instr_dual_0f_2b =3D {
>         I(0, em_mov), N
>  };
> @@ -4626,6 +4647,8 @@ static int check_perm_out(struct x86_emulate_ctxt
> *ctxt)
>         DI(ImplicitOps | Priv, invd), DI(ImplicitOps | Priv, wbinvd), N, =
N,
>         N, D(ImplicitOps | ModRM | SrcMem | NoAccess), N, N,
>         /* 0x10 - 0x1F */
> =E2=80=8B=E2=80=8B
> +       GP(SrcMem | DstReg | ModRM | Mov, &pfx_0f_10_0f_11),
> +       GP(SrcReg | DstMem | ModRM | Mov, &pfx_0f_10_0f_11),
>         N, N, N, N, N, N, N, N,
>         D(ImplicitOps | ModRM | SrcMem | NoAccess),
>         N, N, N, N, N, N, D(ImplicitOps | ModRM | SrcMem | NoAccess),
>
> Thanks,
>
> Paolo
>
