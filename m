Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB12C3F2CD
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 18:01:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B8122072D
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 18:01:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B8122072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=twiddle.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGROU-0003PF-Jv
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 14:01:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57153)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jGRNi-0002o3-8o
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 14:00:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1jGRNg-0007cV-Cz
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 14:00:58 -0400
Received: from indium.canonical.com ([91.189.90.7]:41710)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1jGRNg-0007cJ-5z
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 14:00:56 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jGRNe-0000ZD-NY
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2020 18:00:54 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id B056C2E8076
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2020 18:00:54 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Mar 2020 17:52:02 -0000
From: Richard Henderson <rth@twiddle.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Incomplete; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: hansni rth
X-Launchpad-Bug-Reporter: Hansni Bu (hansni)
X-Launchpad-Bug-Modifier: Richard Henderson (rth)
References: <158495248924.11669.14742891693687812596.malonedeb@soybean.canonical.com>
Message-Id: <158498592249.19627.14987594190343413158.malone@chaenomeles.canonical.com>
Subject: [Bug 1868527] Re: alignment may overlap the TLB flags
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="3a6db24bbe7280ec09bae73384238390fcc98ad3";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: d0d412fce374601cc36169b0d8c9e7fe58305673
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
Reply-To: Bug 1868527 <1868527@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

That is of course completely dependent on the target page size.  So,
yes, a target with a very small page size cannot use large alignments.
The assert makes sure.

Is this comment simply by inspection, or did you have an actual bug to
report?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1868527

Title:
  alignment may overlap the TLB flags

Status in QEMU:
  Incomplete

Bug description:
  Hi,
  In QEMU-4.2.0, or git-9b26a610936deaf436af9b7e39e4b7f0a35e4409, alignment=
 may overlap the TLB flags. =

  For example, the alignment: MO_ALIGN_32,
      MO_ALIGN_32 =3D 5 << MO_ASHIFT,
  and the TLB flag: TLB_DISCARD_WRITE
  #define TLB_DISCARD_WRITE   (1 << (TARGET_PAGE_BITS_MIN - 6))

  then, in the function "get_alignment_bits", the assert may fail:

  #if defined(CONFIG_SOFTMMU)
      /* The requested alignment cannot overlap the TLB flags.  */
      tcg_debug_assert((TLB_FLAGS_MASK & ((1 << a) - 1)) =3D=3D 0);
  #endif

  However, the alignment of MO_ALIGN_32 is not used for now, so the
  assert cannot be triggered in current version. Anyway it seems like a
  potential conflict.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1868527/+subscriptions

