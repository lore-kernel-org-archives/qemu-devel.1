Received: from eggs.gnu.org ([2001:4830:134:3::10]:44119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dJa8s-0006jZ-7R
	for qemu-devel@nongnu.org; Sat, 10 Jun 2017 02:45:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dJa8p-0006nA-33
	for qemu-devel@nongnu.org; Sat, 10 Jun 2017 02:45:02 -0400
Received: from indium.canonical.com ([91.189.90.7]:49510)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dJa8o-0006mE-TP
	for qemu-devel@nongnu.org; Sat, 10 Jun 2017 02:44:59 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dJa8n-0004yj-SX
	for <qemu-devel@nongnu.org>; Sat, 10 Jun 2017 06:44:57 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id CB7222E8194
	for <qemu-devel@nongnu.org>; Sat, 10 Jun 2017 06:44:57 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 10 Jun 2017 06:33:05 -0000
From: Thomas Huth <904308@bugs.launchpad.net>
Reply-To: Bug 904308 <904308@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20111214154735.7533.86725.malonedeb@chaenomeles.canonical.com>
Message-Id: <149707638546.9863.5893645142829392527.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 904308] Re: x86: BT/BTS/BTR/BTC: ZF flag is
 unaffected
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Looking at the previous comments ... is there anything left to do here?
Or can we close this bug nowadays?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/904308

Title:
  x86: BT/BTS/BTR/BTC: ZF flag is unaffected

Status in QEMU:
  Incomplete

Bug description:
  Hello!

  Bug was found in qemu.git.
  See target-i386/translate.c:

      case 0x1ba: /* bt/bts/btr/btc Gv, im */
          ot =3D dflag + OT_WORD;
          modrm =3D ldub_code(s->pc++);
          op =3D (modrm >> 3) & 7;
          mod =3D (modrm >> 6) & 3;
          rm =3D (modrm & 7) | REX_B(s);
          if (mod !=3D 3) {
              s->rip_offset =3D 1;
              gen_lea_modrm(s, modrm, &reg_addr, &offset_addr);
              gen_op_ld_T0_A0(ot + s->mem_index);
          } else {
              gen_op_mov_TN_reg(ot, 0, rm);
          }
          /* load shift */
          val =3D ldub_code(s->pc++);
          gen_op_movl_T1_im(val);
          if (op < 4)
              goto illegal_op;
          op -=3D 4;
          goto bt_op;
      case 0x1a3: /* bt Gv, Ev */
          op =3D 0;
          goto do_btx;
      case 0x1ab: /* bts */
          op =3D 1;
          goto do_btx;
      case 0x1b3: /* btr */
          op =3D 2;
          goto do_btx;
      case 0x1bb: /* btc */
          op =3D 3;
      do_btx:
          ot =3D dflag + OT_WORD;
          modrm =3D ldub_code(s->pc++);
          reg =3D ((modrm >> 3) & 7) | rex_r;
          mod =3D (modrm >> 6) & 3;
          rm =3D (modrm & 7) | REX_B(s);
          gen_op_mov_TN_reg(OT_LONG, 1, reg);
          if (mod !=3D 3) {
              gen_lea_modrm(s, modrm, &reg_addr, &offset_addr);
              /* specific case: we need to add a displacement */
              gen_exts(ot, cpu_T[1]);
              tcg_gen_sari_tl(cpu_tmp0, cpu_T[1], 3 + ot);
              tcg_gen_shli_tl(cpu_tmp0, cpu_tmp0, ot);
              tcg_gen_add_tl(cpu_A0, cpu_A0, cpu_tmp0);
              gen_op_ld_T0_A0(ot + s->mem_index);
          } else {
              gen_op_mov_TN_reg(ot, 0, rm);
          }
      bt_op:
          tcg_gen_andi_tl(cpu_T[1], cpu_T[1], (1 << (3 + ot)) - 1);
          switch(op) {
          case 0:
              tcg_gen_shr_tl(cpu_cc_src, cpu_T[0], cpu_T[1]);
              tcg_gen_movi_tl(cpu_cc_dst, 0);                              =
 <<<<<<<<<<<<<<<<<<<<<< always set zf
              break;
          case 1:
              tcg_gen_shr_tl(cpu_tmp4, cpu_T[0], cpu_T[1]);
              tcg_gen_movi_tl(cpu_tmp0, 1);
              tcg_gen_shl_tl(cpu_tmp0, cpu_tmp0, cpu_T[1]);
              tcg_gen_or_tl(cpu_T[0], cpu_T[0], cpu_tmp0);
              break;
          case 2:
              tcg_gen_shr_tl(cpu_tmp4, cpu_T[0], cpu_T[1]);
              tcg_gen_movi_tl(cpu_tmp0, 1);
              tcg_gen_shl_tl(cpu_tmp0, cpu_tmp0, cpu_T[1]);
              tcg_gen_not_tl(cpu_tmp0, cpu_tmp0);
              tcg_gen_and_tl(cpu_T[0], cpu_T[0], cpu_tmp0);
              break;
          default:
          case 3:
              tcg_gen_shr_tl(cpu_tmp4, cpu_T[0], cpu_T[1]);
              tcg_gen_movi_tl(cpu_tmp0, 1);
              tcg_gen_shl_tl(cpu_tmp0, cpu_tmp0, cpu_T[1]);
              tcg_gen_xor_tl(cpu_T[0], cpu_T[0], cpu_tmp0);
              break;
          }
          s->cc_op =3D CC_OP_SARB + ot;
          if (op !=3D 0) {
              if (mod !=3D 3)
                  gen_op_st_T0_A0(ot + s->mem_index);
              else
                  gen_op_mov_reg_T0(ot, rm);
              tcg_gen_mov_tl(cpu_cc_src, cpu_tmp4);
              tcg_gen_movi_tl(cpu_cc_dst, 0);                           <<<=
<<<<<<<<<<<<<<<<<<< always set zf
          }
          break;

  always set zf...

  There is fixed patch.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/904308/+subscriptions
