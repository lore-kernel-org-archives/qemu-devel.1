Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E7D4C34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 15:02:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1127A2176D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 15:02:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1127A2176D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=twiddle.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j44O5-0004rs-2l
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 10:02:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32769)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1j44N6-0003rg-Lv
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 10:01:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1j44N5-0003zG-CZ
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 10:01:12 -0500
Received: from indium.canonical.com ([91.189.90.7]:47180)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1j44N5-0003y5-73
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 10:01:11 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1j44N2-0000vo-QP
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 15:01:08 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id B8FB92E80C8
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 15:01:08 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Feb 2020 14:48:35 -0000
From: Richard Henderson <rth@twiddle.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: tcg testcase
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: amarkovic rth stvlvrn
X-Launchpad-Bug-Reporter: Stevie Lavern (stvlvrn)
X-Launchpad-Bug-Modifier: Richard Henderson (rth)
References: <158038956597.5319.13308249814127344774.malonedeb@chaenomeles.canonical.com>
Message-Id: <158203731512.15140.9628335118593104369.malone@soybean.canonical.com>
Subject: [Bug 1861404] Re: AVX instruction VMOVDQU implementation error for
 YMM registers
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="19413b719a8df7423ab1390528edadce9e0e4aca";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 091c65c73b616e383e75e0ad69bd4b70a23320aa
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1861404 <1861404@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The "AVX512 BFloat16" patch is for KVM support.

As for finding the GSoC work, please follow that link,
and the ones buried inside that.  There are hundreds
of patches involved.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1861404

Title:
  AVX instruction VMOVDQU implementation error for YMM registers

Status in QEMU:
  New

Bug description:
  Hi,

  Tested with Qemu 4.2.0, and with git version
  bddff6f6787c916b0e9d63ef9e4d442114257739.

  The x86 AVX instruction VMOVDQU doesn't work properly with YMM registers =
(32 bytes).
  It works with XMM registers (16 bytes) though.

  See the attached test case `ymm.c`: when copying from memory-to-ymm0
  and then back from ymm0-to-memory using VMOVDQU, Qemu only copies the
  first 16 of the total 32 bytes.

  ```
  user@ubuntu ~/Qemu % gcc -o ymm ymm.c -Wall -Wextra -Werror

  user@ubuntu ~/Qemu % ./ymm
  00 01 02 03 04 05 06 07 08 09 0A 0B 0C 0D 0E 0F 10 11 12 13 14 15 16 17 1=
8 19 1A 1B 1C 1D 1E 1F

  user@ubuntu ~/Qemu % ./x86_64-linux-user/qemu-x86_64 -cpu max ymm
  00 01 02 03 04 05 06 07 08 09 0A 0B 0C 0D 0E 0F 00 00 00 00 00 00 00 00 0=
0 00 00 00 00 00 00 00
  ```

  This seems to be because in `translate.c > gen_sse()`, the case
  handling the VMOVDQU instruction calls `gen_ldo_env_A0` which always
  performs a 16 bytes copy using two 8 bytes load and store operations
  (with `tcg_gen_qemu_ld_i64` and `tcg_gen_st_i64`).

  Instead, the `gen_ldo_env_A0` function should generate a copy with a
  size corresponding to the used register.

  =

  ```
  static void gen_sse(CPUX86State *env, DisasContext *s, int b,
                      target_ulong pc_start, int rex_r)
  {
          [...]
          case 0x26f: /* movdqu xmm, ea */
              if (mod !=3D 3) {
                  gen_lea_modrm(env, s, modrm);
                  gen_ldo_env_A0(s, offsetof(CPUX86State, xmm_regs[reg]));
              } else { =

          [...]
  ```

  ```
  static inline void gen_ldo_env_A0(DisasContext *s, int offset)
  {
      int mem_index =3D s->mem_index;
      tcg_gen_qemu_ld_i64(s->tmp1_i64, s->A0, mem_index, MO_LEQ);
      tcg_gen_st_i64(s->tmp1_i64, cpu_env, offset + offsetof(ZMMReg, ZMM_Q(=
0)));
      tcg_gen_addi_tl(s->tmp0, s->A0, 8);
      tcg_gen_qemu_ld_i64(s->tmp1_i64, s->tmp0, mem_index, MO_LEQ);
      tcg_gen_st_i64(s->tmp1_i64, cpu_env, offset + offsetof(ZMMReg, ZMM_Q(=
1)));
  }
  ```

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1861404/+subscriptions

