Received: from eggs.gnu.org ([2001:4830:134:3::10]:58204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d8nSo-0000Mb-KO
	for qemu-devel@nongnu.org; Thu, 11 May 2017 08:45:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d8nSl-0005Z3-GJ
	for qemu-devel@nongnu.org; Thu, 11 May 2017 08:45:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43236)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1d8nSl-0005Yx-9T
	for qemu-devel@nongnu.org; Thu, 11 May 2017 08:44:59 -0400
References: <CALUZMn0mRMY7mx5ysWdSamV+UGbjwuif8UxQ47gFDK3fx8Hw2w@mail.gmail.com>
	<6e9a0dff-949f-5ac9-2315-cbe0e4c99f58@redhat.com>
	<CALUZMn14qgNz8y+15bsKFwyB9Ganoh0wzu5tfokCDRSASnBeKA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0c725626-6485-c777-46e3-99423670df89@redhat.com>
Date: Thu, 11 May 2017 14:44:54 +0200
MIME-Version: 1.0
In-Reply-To: <CALUZMn14qgNz8y+15bsKFwyB9Ganoh0wzu5tfokCDRSASnBeKA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: Miltiadis Hatzimihail <hatzimiltos@gmail.com>
Cc: qemu-devel@nongnu.org



On 11/05/2017 14:40, Miltiadis Hatzimihail wrote:
> Thanks Paolo that worked!
>=20
> Btw, this line
>=20
> =E2=80=8B
> +       GP(SrcMem | DstReg | ModRM | Mov, &pfx_0f_10_0f_11),
> +       GP(SrcReg | DstMem | ModRM | Mov, &pfx_0f_10_0f_11),
> -        N, N, N, N, N, N, N, N,
> +       N, N, N, N, N, N,
>=20
> I think it has 2 extra Ns (not removed from your change?).

Oops, you're right.

> Those instructions were not implemented for a reason or is it simply a
> chance of never seeing this issue that I saw?

Never seeing this issue.

>>> The interesting thing is that in the ram case the test is passing, bu=
t in
>>> the io is failing. Also, if I try this without KVM, it passes in both=
 cases.
>>
>>Yes, in the RAM case KVM is not invoked at all.
> So for my benefit, does this mean that any RAM transaction is emulated
> by QEMU or does it go through KVM to the bare metal? (and hence, KVM is
> not emulating this?)

The latter.  The don't get any emulation.

Paolo

>=20
> =E2=80=8BMilton
>=20
>=20
> On Thu, May 11, 2017 at 12:51 PM, Paolo Bonzini <pbonzini@redhat.com
> <mailto:pbonzini@redhat.com>> wrote:
>=20
>=20
>=20
>     On 11/05/2017 09:00, Miltiadis Hatzimihail wrote:
>     >
>     > The interesting thing is that in the ram case the test is passing=
, but in
>     > the io is failing. Also, if I try this without KVM, it passes in =
both cases.
>=20
>     Yes, in the RAM case KVM is not invoked at all.
>=20
>     > So I ve done some reading and for the 2 cases above I get:
>     >
>     > - KVM_EXIT_MMIO on memory_region_init_io  (KVM attempts and fails=
 to
>     > emulate MOVSS),
>     > - KVM_EXIT_EXCEPTION on memory_region_init_ram(QEMU emulates MOVS=
S)
>=20
>     No, you don't get any exit for memory_region_init_ram.
>=20
>     > Is that right?
>     >
>     > Now the question is, if I want to use the IO instead of a RAM, wh=
at's the
>     > best way to solve this?
>=20
>     Please try this KVM patch:
>=20
>     diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
>     index c25cfaf584e7..53fbd1589d2e 100644
>     --- a/arch/x86/kvm/emulate.c
>     +++ b/arch/x86/kvm/emulate.c
>     @@ -3534,6 +3534,22 @@ static int em_rdpmc(struct x86_emulate_ctxt
>     *ctxt)
>             return X86EMUL_CONTINUE;
>      }
>=20
>     +static int em_movss(struct x86_emulate_ctxt *ctxt)
>     +{
>     +       memcpy(ctxt->dst.valptr, ctxt->src.valptr, 4);
>     +       ctxt->op_bytes =3D 4;
>     +       ctxt->dst.bytes =3D 4;
>     +       return X86EMUL_CONTINUE;
>     +}
>     +
>     +static int em_movsd(struct x86_emulate_ctxt *ctxt)
>     +{
>     +       memcpy(ctxt->dst.valptr, ctxt->src.valptr, 8);
>     +       ctxt->op_bytes =3D 8;
>     +       ctxt->dst.bytes =3D 8;
>     +       return X86EMUL_CONTINUE;
>     +}
>     +
>      static int em_mov(struct x86_emulate_ctxt *ctxt)
>      {
>             memcpy(ctxt->dst.valptr, ctxt->src.valptr,
>     sizeof(ctxt->src.valptr));
>     @@ -4407,6 +4423,11 @@ static int check_perm_out(struct
>     x86_emulate_ctxt *ctxt)
>             I(Mmx, em_mov), I(Sse | Aligned, em_mov), N, I(Sse |
>     Unaligned, em_mov),
>      };
>=20
>     +static const struct gprefix pfx_0f_10_0f_11 =3D {
>     +       I(Sse | Unaligned, em_mov), I(Sse | Unaligned, em_mov),
>     +       I(Sse, em_movsd), I(Sse, em_movss),
>     +};
>     +
>      static const struct instr_dual instr_dual_0f_2b =3D {
>             I(0, em_mov), N
>      };
>     @@ -4626,6 +4647,8 @@ static int check_perm_out(struct
>     x86_emulate_ctxt *ctxt)
>             DI(ImplicitOps | Priv, invd), DI(ImplicitOps | Priv,
>     wbinvd), N, N,
>             N, D(ImplicitOps | ModRM | SrcMem | NoAccess), N, N,
>             /* 0x10 - 0x1F */
>     =E2=80=8B=E2=80=8B
>     +       GP(SrcMem | DstReg | ModRM | Mov, &pfx_0f_10_0f_11),
>     +       GP(SrcReg | DstMem | ModRM | Mov, &pfx_0f_10_0f_11),
>             N, N, N, N, N, N, N, N,
>             D(ImplicitOps | ModRM | SrcMem | NoAccess),
>             N, N, N, N, N, N, D(ImplicitOps | ModRM | SrcMem | NoAccess=
),
>=20
>     Thanks,
>=20
>     Paolo
>=20
>=20
