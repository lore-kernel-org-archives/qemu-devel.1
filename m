Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6100C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 09:29:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AFF22051A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 09:29:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AFF22051A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBbC9-00006R-65
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 05:29:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48822)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jBb9A-0003jf-7a
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 05:25:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1jBb98-0008Cz-Rx
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 05:25:56 -0400
Received: from indium.canonical.com ([91.189.90.7]:41586)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1jBb98-0008AQ-MJ
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 05:25:54 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jBb97-0005CC-9g
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 09:25:53 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 45BF52E80C0
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 09:25:53 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Mar 2020 09:14:44 -0000
From: Laurent Vivier <Laurent@vivier.eu>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Committed; importance=Undecided;
 assignee=alex.bennee@linaro.org; 
X-Launchpad-Bug-Tags: mttcg tcg
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: ajbennee laurent-vivier yifanlu
X-Launchpad-Bug-Reporter: Yifan (yifanlu)
X-Launchpad-Bug-Modifier: Laurent Vivier (laurent-vivier)
References: <158154486735.14935.3370403781300872079.malonedeb@soybean.canonical.com>
Message-Id: <158383168411.7681.10081222011480059251.malone@chaenomeles.canonical.com>
Subject: [Bug 1863025] Re: Use-after-free after flush in TCG accelerator
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="e0878392dc799b267dea80578fa65500a5d74155";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 45a72f10448d8c52f58bceb13f32669d9757cbb8
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
Reply-To: Bug 1863025 <1863025@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fixed here:
https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3D886cc68943eb

** Changed in: qemu
       Status: Confirmed =3D> Fix Committed

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1863025

Title:
  Use-after-free after flush in TCG accelerator

Status in QEMU:
  Fix Committed

Bug description:
  I believe I found a UAF in TCG that can lead to a guest VM escape. The
  security list informed me "This can not be treated as a security
  issue." and to post it here. I am looking at the 4.2.0 source code.
  The issue requires a race and I will try to describe it in terms of
  three concurrent threads.

  Thread A:

  A1. qemu_tcg_cpu_thread_fn runs work loop
  A2. qemu_wait_io_event =3D> qemu_wait_io_event_common =3D> process_queued=
_cpu_work
  A3. start_exclusive critical section entered
  A4. do_tb_flush is called, TB memory freed/re-allocated
  A5. end_exclusive exits critical section

  Thread B:

  B1. qemu_tcg_cpu_thread_fn runs work loop
  B2. tcg_cpu_exec =3D> cpu_exec =3D> tb_find =3D> tb_gen_code
  B3. tcg_tb_alloc obtains a new TB

  Thread C:

  C1. qemu_tcg_cpu_thread_fn runs work loop
  C2. cpu_exec_step_atomic executes
  C3. TB obtained with tb_lookup__cpu_state or tb_gen_code
  C4. start_exclusive critical section entered
  C5. cpu_tb_exec executes the TB code
  C6. end_exclusive exits critical section

  Consider the following sequence of events:
  =C2=A0=C2=A0B2 =3D> B3 =3D> C3 (same TB as B2) =3D> A3 =3D> A4 (TB freed)=
 =3D> A5 =3D> B2 =3D>
  =C2=A0=C2=A0B3 (re-allocates TB from B2) =3D> C4 =3D> C5 (freed/reused TB=
 now executing) =3D> C6

  In short, because thread C uses the TB in the critical section, there
  is no guarantee that the pointer has not been "freed" (rather the
  memory is marked as re-usable) and therefore a use-after-free occurs.

  Since the TCG generated code can be in the same memory as the TB data
  structure, it is possible for an attacker to overwrite the UAF pointer
  with code generated from TCG. This can overwrite key pointer values
  and could lead to code execution on the host outside of the TCG
  sandbox.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1863025/+subscriptions

