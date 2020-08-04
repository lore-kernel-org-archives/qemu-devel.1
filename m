Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 883A4C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 19:11:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26BD22086A
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 19:11:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26BD22086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k32LT-0008E7-36
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 15:11:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37232)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k32Km-0007n7-PD
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 15:10:48 -0400
Received: from indium.canonical.com ([91.189.90.7]:41644)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k32Kk-0004rg-Gj
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 15:10:48 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1k32Ki-0002F3-Oh
 for <qemu-devel@nongnu.org>; Tue, 04 Aug 2020 19:10:44 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id B0B3B2E80DC
 for <qemu-devel@nongnu.org>; Tue,  4 Aug 2020 19:10:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2020 19:03:44 -0000
From: Alexander Bulekov <1890333@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: a1xndr
X-Launchpad-Bug-Reporter: Alexander Bulekov (a1xndr)
X-Launchpad-Bug-Modifier: Alexander Bulekov (a1xndr)
Message-Id: <159656782458.2385.15174533675764579105.malonedeb@gac.canonical.com>
Subject: [Bug 1890333] [NEW] Assertion failure in address_space_stw_le_cached
 through virtio-* devices
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="a24057fea7e4c6a98c0220d5f878da0f3c783699";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 5101f36395f79baa9fed85288c5a63f6db8dcfc0
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 15:05:58
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
Reply-To: Bug 1890333 <1890333@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

Hello,
Reproducer:
cat << EOF | ./i386-softmmu/qemu-system-i386 \
-drive id=3Dmydrive,file=3Dnull-co://,size=3D2M,format=3Draw,if=3Dnone \
-device virtio-blk,drive=3Dmydrive \
-nodefaults -qtest stdio -nographic
outl 0xcf8 0x80001001
outl 0xcfc 0x6574c1ff
outl 0xcf8 0x8000100e
outl 0xcfc 0xefe5e1e
outl 0xe86 0x3aff9090
outl 0xe84 0x3aff9090
outl 0xe8e 0xe
EOF

qemu-system-i386: /home/alxndr/Development/qemu/general-fuzz/include/exec/m=
emory_ldst_cached.inc.h:88: void address_space_stw_le_cached(MemoryRegionCa=
che *, hwaddr, uint32_t, MemTxAttrs, MemTxResult *): Assertion `addr < cach=
e->len && 2 <=3D cache->len - addr' failed.
Aborted

I can trigger similar assertions with other VIRTIO devices, as-well.
I reported this at some point in Message-ID: <20200511033001.dzvtbdhl3oz5pg=
iy@mozz.bu.edu> but never created a Launchpad issue...
-Alex

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1890333

Title:
  Assertion failure in address_space_stw_le_cached through virtio-*
  devices

Status in QEMU:
  New

Bug description:
  Hello,
  Reproducer:
  cat << EOF | ./i386-softmmu/qemu-system-i386 \
  -drive id=3Dmydrive,file=3Dnull-co://,size=3D2M,format=3Draw,if=3Dnone \
  -device virtio-blk,drive=3Dmydrive \
  -nodefaults -qtest stdio -nographic
  outl 0xcf8 0x80001001
  outl 0xcfc 0x6574c1ff
  outl 0xcf8 0x8000100e
  outl 0xcfc 0xefe5e1e
  outl 0xe86 0x3aff9090
  outl 0xe84 0x3aff9090
  outl 0xe8e 0xe
  EOF

  qemu-system-i386: /home/alxndr/Development/qemu/general-fuzz/include/exec=
/memory_ldst_cached.inc.h:88: void address_space_stw_le_cached(MemoryRegion=
Cache *, hwaddr, uint32_t, MemTxAttrs, MemTxResult *): Assertion `addr < ca=
che->len && 2 <=3D cache->len - addr' failed.
  Aborted

  I can trigger similar assertions with other VIRTIO devices, as-well.
  I reported this at some point in Message-ID: <20200511033001.dzvtbdhl3oz5=
pgiy@mozz.bu.edu> but never created a Launchpad issue...
  -Alex

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1890333/+subscriptions

