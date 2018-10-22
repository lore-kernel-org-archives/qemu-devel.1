Received: from eggs.gnu.org ([2001:4830:134:3::10]:46412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gEYGO-00064c-5d
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 07:20:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gEYGI-0000at-AZ
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 07:20:48 -0400
Received: from indium.canonical.com ([91.189.90.7]:34014)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gEYGG-0000ZA-GS
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 07:20:41 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gEYGD-0001tv-N5
	for <qemu-devel@nongnu.org>; Mon, 22 Oct 2018 11:20:37 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 865BE2E80CB
	for <qemu-devel@nongnu.org>; Mon, 22 Oct 2018 11:20:37 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Oct 2018 11:12:33 -0000
From: wwb1234 <1799200@bugs.launchpad.net>
Reply-To: Bug 1799200 <1799200@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <154020556283.828.7303147560096636851.malonedeb@wampee.canonical.com>
Message-Id: <154020675382.18361.17978404670360774421.launchpad@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1799200] Re: null pointer dereference in
 tcg_emit_op
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Summary changed:

- pointer dereference in tcg_emit_op
+ null pointer dereference in tcg_emit_op

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1799200

Title:
  null pointer dereference in tcg_emit_op

Status in QEMU:
  In Progress

Bug description:
  I am insert a custom  tcg helper function in i386_tr_insn_start for
  trace the instructions.

  most of time the qemu runed ok ,but when execute some special software
  will lead to crash.

  =

  the below is the insert code:
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

   8514 static void i386_tr_insn_start(DisasContextBase *dcbase, CPUState *=
cpu)
   8515 {
   8516     DisasContext *dc =3D container_of(dcbase, DisasContext, base);
   8517     TCGv_ptr ptr=3D tcg_const_ptr((void*)cpu); // inserted hepler c=
ode
   8518     gen_helper_mad_exec(ptr);// insert helper code
   8519     tcg_gen_insn_start(dc->base.pc_next, dc->cc_op);
   8520 }
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

  below is the callstack

  #0  0x000055555581df5e in tcg_emit_op (opc=3Dopc@entry=3DINDEX_op_movi_i6=
4) at /root/qemu/tcg/tcg.c:2205
  #1  0x0000555555825911 in tcg_gen_op2 (opc=3Dopc@entry=3DINDEX_op_movi_i6=
4, a1=3D140734736923704, a2=3Da2@entry=3D792) at /root/qemu/tcg/tcg-op.c:53
  #2  0x000055555581d713 in tcg_const_i64 (opc=3DINDEX_op_movi_i64, a2=3D79=
2, a1=3D0x7378) at /root/qemu/tcg/tcg-op.h:109
  #3  0x000055555581d713 in tcg_const_i64 (arg=3D792, ret=3D<optimized out>=
) at /root/qemu/tcg/tcg-op.h:579
  #4  0x000055555581d713 in tcg_const_i64 (val=3Dval@entry=3D792) at /root/=
qemu/tcg/tcg.c:1314
  #5  0x000055555582732d in tcg_gen_addi_i64 (ret=3D0xd18, arg1=3D0x378, ar=
g2=3Darg2@entry=3D792) at /root/qemu/tcg/tcg-op.c:1200
  #6  0x000055555590ffaf in gen_sse (b=3D792, a=3D<optimized out>, r=3D<opt=
imized out>) at /root/qemu/tcg/tcg-op.h:1258
  #7  0x000055555590ffaf in gen_sse (env=3Denv@entry=3D0x5555567424d0, s=3D=
s@entry=3D0x7fffea99a610, b=3Db@entry=3D366, pc_start=3Dpc_start@entry=3D45=
13509698, rex_r=3Drex_r@entry=3D0) at /root/qemu/target/i386/translate.c:31=
50
  #8  0x0000555555911d7f in disas_insn (s=3Ds@entry=3D0x7fffea99a610, cpu=
=3D<optimized out>) at /root/qemu/target/i386/translate.c:8336
  #9  0x00005555559207a0 in i386_tr_translate_insn (dcbase=3D0x7fffea99a610=
, cpu=3D<optimized out>) at /root/qemu/target/i386/translate.c:8543
  #10 0x0000555555892649 in translator_loop (ops=3D0x55555622dee0 <i386_tr_=
ops>, db=3D0x7fffea99a610, cpu=3D0x55555673a220, tb=3D<optimized out>) at /=
root/qemu/accel/tcg/translator.c:110
  #11 0x00005555559209ef in gen_intermediate_code (cpu=3Dcpu@entry=3D0x5555=
5673a220, tb=3Dtb@entry=3D0x7fff70682040 <code_gen_buffer+208150547>) at /r=
oot/qemu/target/i386/translate.c:8605
  #12 0x0000555555891437 in tb_gen_code (cpu=3Dcpu@entry=3D0x55555673a220, =
pc=3Dpc@entry=3D4513506448, cs_base=3Dcs_base@entry=3D0, flags=3Dflags@entr=
y=3D4244147, cflags=3Dcflags@entry=3D0) at /root/qemu/accel/tcg/translate-a=
ll.c:1728
  #13 0x000055555588f97b in cpu_exec (cf_mask=3D0, tb_exit=3D0, last_tb=3D0=
x0, cpu=3D0x0) at /root/qemu/accel/tcg/cpu-exec.c:410
  #14 0x000055555588f97b in cpu_exec (cpu=3Dcpu@entry=3D0x55555673a220) at =
/root/qemu/accel/tcg/cpu-exec.c:734
  #15 0x000055555584b152 in tcg_cpu_exec (cpu=3D0x55555673a220) at /root/qe=
mu/cpus.c:1405
  #16 0x000055555584d1b8 in qemu_tcg_rr_cpu_thread_fn (arg=3D<optimized out=
>) at /root/qemu/cpus.c:1505
  #17 0x00007ffff2585e25 in start_thread () at /lib64/libpthread.so.0
  #18 0x00007ffff22afbad in clone () at /lib64/libc.so.6

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1799200/+subscriptions
