Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2140CC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 11:27:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC0202074B
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 11:27:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC0202074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k16iT-0004gz-OK
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 07:27:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33788)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k16hR-0003Rd-Bv
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 07:26:13 -0400
Received: from indium.canonical.com ([91.189.90.7]:36444)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k16hO-00055U-Hi
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 07:26:13 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1k16hN-000058-7x
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2020 11:26:09 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 3AC972E8053
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2020 11:26:09 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2020 11:13:01 -0000
From: Peter Maydell <1881552@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Committed; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: philmd pmaydell
X-Launchpad-Bug-Reporter: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9_=28philmd?=
 =?utf-8?q?=29?=
X-Launchpad-Bug-Modifier: Peter Maydell (pmaydell)
References: <159100411428.13844.7436264299080242287.malonedeb@soybean.canonical.com>
Message-Id: <159610758121.16504.7090481805210110883.malone@wampee.canonical.com>
Subject: [Bug 1881552] Re: potential AArch64 ABI bug wrt handling of 128-bit
 bit-fields
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="a24057fea7e4c6a98c0220d5f878da0f3c783699";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 1a60e5d7459149c7b7e8e91ae4fc5176ab493684
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/30 07:16:04
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Reply-To: Bug 1881552 <1881552@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The warnings aren't a problem for QEMU because we don't expose these
functions as public ABI, so the whole compile will be consistently built
with the same compiler version. So we added -Wno-psabi in commit
bac8d222a19f4a30d to silence the compiler here.


** Changed in: qemu
       Status: New =3D> Fix Committed

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1881552

Title:
  potential AArch64 ABI bug wrt handling of 128-bit bit-fields

Status in QEMU:
  Fix Committed

Bug description:
  After upgrading to Ubuntu 20.04 LTS, GCC 9.3 displays a lot of notes:

  hw/block/pflash_cfi01.c: In function =E2=80=98pflash_mem_read_with_attrs=
=E2=80=99:
  hw/block/pflash_cfi01.c:663:20: note: parameter passing for argument of t=
ype =E2=80=98MemTxAttrs=E2=80=99 {aka =E2=80=98struct MemTxAttrs=E2=80=99} =
changed in GCC 9.1
    663 | static MemTxResult pflash_mem_read_with_attrs(void *opaque, hwadd=
r addr, uint64_t *value,
        |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~
  hw/block/pflash_cfi01.c: In function =E2=80=98pflash_mem_write_with_attrs=
=E2=80=99:
  hw/block/pflash_cfi01.c:677:20: note: parameter passing for argument of t=
ype =E2=80=98MemTxAttrs=E2=80=99 {aka =E2=80=98struct MemTxAttrs=E2=80=99} =
changed in GCC 9.1
    677 | static MemTxResult pflash_mem_write_with_attrs(void *opaque, hwad=
dr addr, uint64_t value,
        |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~
  hw/nvram/fw_cfg.c: In function =E2=80=98fw_cfg_dma_mem_valid=E2=80=99:
  hw/nvram/fw_cfg.c:475:13: note: parameter passing for argument of type =
=E2=80=98MemTxAttrs=E2=80=99 {aka =E2=80=98struct MemTxAttrs=E2=80=99} chan=
ged in GCC 9.1
    475 | static bool fw_cfg_dma_mem_valid(void *opaque, hwaddr addr,
        |             ^~~~~~~~~~~~~~~~~~~~
  hw/nvram/fw_cfg.c: In function =E2=80=98fw_cfg_data_mem_valid=E2=80=99:
  hw/nvram/fw_cfg.c:483:13: note: parameter passing for argument of type =
=E2=80=98MemTxAttrs=E2=80=99 {aka =E2=80=98struct MemTxAttrs=E2=80=99} chan=
ged in GCC 9.1
    483 | static bool fw_cfg_data_mem_valid(void *opaque, hwaddr addr,
        |             ^~~~~~~~~~~~~~~~~~~~~
  hw/nvram/fw_cfg.c: In function =E2=80=98fw_cfg_ctl_mem_valid=E2=80=99:
  hw/nvram/fw_cfg.c:501:13: note: parameter passing for argument of type =
=E2=80=98MemTxAttrs=E2=80=99 {aka =E2=80=98struct MemTxAttrs=E2=80=99} chan=
ged in GCC 9.1
    501 | static bool fw_cfg_ctl_mem_valid(void *opaque, hwaddr addr,
        |             ^~~~~~~~~~~~~~~~~~~~
  hw/nvram/fw_cfg.c: In function =E2=80=98fw_cfg_comb_valid=E2=80=99:
  hw/nvram/fw_cfg.c:521:13: note: parameter passing for argument of type =
=E2=80=98MemTxAttrs=E2=80=99 {aka =E2=80=98struct MemTxAttrs=E2=80=99} chan=
ged in GCC 9.1
    521 | static bool fw_cfg_comb_valid(void *opaque, hwaddr addr,
        |             ^~~~~~~~~~~~~~~~~
  hw/intc/arm_gic.c: In function =E2=80=98gic_do_hyp_read=E2=80=99:
  hw/intc/arm_gic.c:1996:20: note: parameter passing for argument of type =
=E2=80=98MemTxAttrs=E2=80=99 {aka =E2=80=98struct MemTxAttrs=E2=80=99} chan=
ged in GCC 9.1
   1996 | static MemTxResult gic_do_hyp_read(void *opaque, hwaddr addr, uin=
t64_t *data,
        |                    ^~~~~~~~~~~~~~~
  hw/intc/arm_gic.c: In function =E2=80=98gic_thiscpu_hyp_read=E2=80=99:
  hw/intc/arm_gic.c:1979:20: note: parameter passing for argument of type =
=E2=80=98MemTxAttrs=E2=80=99 {aka =E2=80=98struct MemTxAttrs=E2=80=99} chan=
ged in GCC 9.1
   1979 | static MemTxResult gic_thiscpu_hyp_read(void *opaque, hwaddr addr=
, uint64_t *data,
        |                    ^~~~~~~~~~~~~~~~~~~~
  hw/intc/arm_gic.c: In function =E2=80=98gic_get_current_pending_irq=E2=80=
=99:
  hw/intc/arm_gic.c:419:17: note: parameter passing for argument of type =
=E2=80=98MemTxAttrs=E2=80=99 {aka =E2=80=98struct MemTxAttrs=E2=80=99} chan=
ged in GCC 9.1
    419 | static uint16_t gic_get_current_pending_irq(GICState *s, int cpu,
        |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~

  This seems related to:
  https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D88469
  https://gcc.gnu.org/git/?p=3Dgcc.git&a=3Dcommit;h=3Dc590597c45

    This is pretty unlikely in real code, but similar to Arm, the AArch64
    ABI has a bug with the handling of 128-bit bit-fields, where if the
    bit-field dominates the overall alignment the back-end code may end up
    passing the argument correctly.  This is a regression that started in
    gcc-6 when the ABI support code was updated to support overaligned
    types.  The fix is very similar in concept to the Arm fix.  128-bit
    bit-fields are fortunately extremely rare, so I'd be very surprised if
    anyone has been bitten by this.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1881552/+subscriptions

