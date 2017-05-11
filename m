Received: from eggs.gnu.org ([2001:4830:134:3::10]:37908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hatzimiltos@gmail.com>) id 1d8i5b-0006L6-DT
	for qemu-devel@nongnu.org; Thu, 11 May 2017 03:00:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hatzimiltos@gmail.com>) id 1d8i5X-0000yu-3r
	for qemu-devel@nongnu.org; Thu, 11 May 2017 03:00:43 -0400
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:38670)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <hatzimiltos@gmail.com>)
	id 1d8i5W-0000y1-Od
	for qemu-devel@nongnu.org; Thu, 11 May 2017 03:00:39 -0400
Received: by mail-wm0-x229.google.com with SMTP id 142so24189833wma.1
	for <qemu-devel@nongnu.org>; Thu, 11 May 2017 00:00:38 -0700 (PDT)
MIME-Version: 1.0
From: Miltiadis Hatzimihail <hatzimiltos@gmail.com>
Date: Thu, 11 May 2017 08:00:16 +0100
Message-ID: <CALUZMn0mRMY7mx5ysWdSamV+UGbjwuif8UxQ47gFDK3fx8Hw2w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] Guest SIGILL when different IO is implemented
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I am trying to develop a simple PCI device and I am setting up 3 BARs. The
last BAR is a DDR and I ve tried 2 different implementations: one
with memory_region_init_io and one with memory_region_init_ram.

I ve got a small program that declares a buffer and does float operations
in the following fashion:

float *buffer;
buffer[index] =3D (float)value;

When I use QEMU with KVM, the memory_region_init_ram implementation seems
to be happy running the above code. When I use the memory_region_init_io I
get a SIGILL on the guest. I ve run this with GDB and the disassembly shows

movss %xmm0, (%rcx)

According to Intel ISA, the instruction does this

MOVSS Move Single Scalar

Opcode Cycles Instruction
F3 0F 10 MOVSS xmm reg,xmm reg/mem32
F3 0F 11 MOVSS mem32,xmm reg

MOVSS op1, op2

op1 contains 1 single precision 32-bit floating point value
op2 contains 1 single precision 32-bit floating point value

I ve looked at the KVM on the Host and hacked it to add some debug
statements to see when it fails to execute a command.

Tracing KVM during the run it fails on the movss instruction opcode: f3 0f
11:

 qemu-system-x86-1129  [000] .... 80154.583037: kvm_fpu: load
 qemu-system-x86-1129  [000] d... 80154.583037: kvm_entry: vcpu 1
 qemu-system-x86-1129  [000] .... 80154.583039: kvm_exit: reason
EPT_VIOLATION rip 0x7f2f45163c40 info 182 0
 qemu-system-x86-1129  [000] .... 80154.583039: kvm_page_fault: address
1404bc000 error_code 182
 qemu-system-x86-1129  [000] .... 80154.583042: kvm_emulate_insn:
0:7f2f45163c40:f3 0f 11 (prot64)
 qemu-system-x86-1129  [000] .N.. 80154.588339: kvm_emulate_insn:
0:7f2f45163c40:f3 0f 11 (prot64) failed
 qemu-system-x86-1129  [000] d... 80154.588342: kvm_fpu: unload
 qemu-system-x86-1129  [002] .... 80154.588523: kvm_inj_exception: #UD (0x0=
)
 qemu-system-x86-1129  [002] .... 80154.588525: kvm_fpu: load

The opcode is twobyte. Byte 0x11 is used to lookup flags from the twobyte
table in KVM

in arch/x86/kvm/emulate.c:4615
static const struct opcode twobyte_table[256] =3D {
    /* 0x00 - 0x0F */
    G(0, group6), GD(0, &group7), N, N,
    N, I(ImplicitOps | EmulateOnUD, em_syscall),
    II(ImplicitOps | Priv, em_clts, clts), N,
    DI(ImplicitOps | Priv, invd), DI(ImplicitOps | Priv, wbinvd), N, N,
    N, D(ImplicitOps | ModRM | SrcMem | NoAccess), N, N,
    /* 0x10 - 0x1F */
    N, N, N, N, N, N, N, N,
    D(ImplicitOps | ModRM | SrcMem | NoAccess),
    N, N, N, N, N, N, D(ImplicitOps | ModRM | SrcMem | NoAccess),

It looks like that the instruction is not implemented. I ve tried this on
the 3.10, 4.4 & 4.11 kernels on the host.

The interesting thing is that in the ram case the test is passing, but in
the io is failing. Also, if I try this without KVM, it passes in both cases=
.

So I ve done some reading and for the 2 cases above I get:

- KVM_EXIT_MMIO on memory_region_init_io  (KVM attempts and fails to
emulate MOVSS),
- KVM_EXIT_EXCEPTION on memory_region_init_ram(QEMU emulates MOVSS)

Is that right?

Now the question is, if I want to use the IO instead of a RAM, what's the
best way to solve this?

=E2=80=8BMilton
