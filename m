Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A203C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 16:13:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 549FF206D5
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 16:13:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 549FF206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdcDF-0002mc-Hx
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 12:13:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53184)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jdcAX-0008II-DU
 for qemu-devel@nongnu.org; Tue, 26 May 2020 12:11:09 -0400
Received: from indium.canonical.com ([91.189.90.7]:47190)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jdcAC-0006JU-Hw
 for qemu-devel@nongnu.org; Tue, 26 May 2020 12:11:09 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jdcAA-0007p0-DE
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 16:10:46 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 612D12E8078
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 16:10:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2020 16:03:45 -0000
From: Ahmed Karaman <1880722@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: ahmedkrmn
X-Launchpad-Bug-Reporter: Ahmed Karaman (ahmedkrmn)
X-Launchpad-Bug-Modifier: Ahmed Karaman (ahmedkrmn)
Message-Id: <159050902512.8264.16089666576245848412.malonedeb@gac.canonical.com>
Subject: [Bug 1880722] [NEW] Changing executable page permissions with mmap
 causes user-mode failures
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="1f7bc749b40714a4cc10f5e4d787118a78037035";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 89d400411839215444221cd006ebbaf567474daa
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 11:25:40
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Reply-To: Bug 1880722 <1880722@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

The discussion that led to this bug discovery can be found in this =

mailing list thread:
https://lists.nongnu.org/archive/html/qemu-devel/2020-05/msg05426.html

A workaround for this problem would be to check for page crossings for =

both the user and system modes in the use_goto_tb() function across =

targets. Some targets like "hppa" already implement this fix but others
don't.

To solve the root cause of this problem, the linux-user/mmap.c should =

be fixed to do all the invalidations required. By doing so, up to 6.93% =

performance improvements will be achieved.

** Affects: qemu
     Importance: Undecided
         Status: New

** Summary changed:

- Changing executable pages permissions with mmap causes user-mode failures
+ Changing executable page permissions with mmap causes user-mode failures

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1880722

Title:
  Changing executable page permissions with mmap causes user-mode
  failures

Status in QEMU:
  New

Bug description:
  The discussion that led to this bug discovery can be found in this =

  mailing list thread:
  https://lists.nongnu.org/archive/html/qemu-devel/2020-05/msg05426.html

  A workaround for this problem would be to check for page crossings for =

  both the user and system modes in the use_goto_tb() function across =

  targets. Some targets like "hppa" already implement this fix but others
  don't.

  To solve the root cause of this problem, the linux-user/mmap.c should =

  be fixed to do all the invalidations required. By doing so, up to 6.93% =

  performance improvements will be achieved.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1880722/+subscriptions

