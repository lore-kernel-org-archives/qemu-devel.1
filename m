Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78179C282DC
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 18:57:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 526B920645
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 18:57:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 526B920645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49651 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTWQe-0001Xd-Ij
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 14:57:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1hTWOZ-00086e-OK
	for qemu-devel@nongnu.org; Wed, 22 May 2019 14:55:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1hTWHM-0002Ip-Hf
	for qemu-devel@nongnu.org; Wed, 22 May 2019 14:47:58 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:47785 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1hTWHM-0001jC-04
	for qemu-devel@nongnu.org; Wed, 22 May 2019 14:47:56 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.rt-rk.com (Postfix) with ESMTP id 185DA1A453C;
	Wed, 22 May 2019 20:46:51 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
	[10.10.13.43])
	by mail.rt-rk.com (Postfix) with ESMTPSA id F1EBC1A4516;
	Wed, 22 May 2019 20:46:50 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Wed, 22 May 2019 20:46:20 +0200
Message-Id: <1558550785-20098-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PATCH 0/5] linux-user: Support signal passing for
 targets having more signals than host
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: lvivier@redhat.com, milos.stojanovic@rt-rk.com, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Most of the targets (including Intel) define 64 signals. This
creates difficulties for targets that define, for example, 128
signals. This series adds support for signal passing even if
the host defines less signals than the target.

Milo=C5=A1 Stojanovi=C4=87 (5):
  linux-user: Fix sigismember() check
  linux-user: Add support for tracking the target signal mask
  linux-user: Add functionality for tracking target signal mask
  linux-user: Add support for multiplexing larger target signals
  linux-user: Add support for multiplexing signals in more syscalls

 linux-user/mips/signal.c   |  16 ++++
 linux-user/qemu.h          |  11 +++
 linux-user/signal-common.h |   5 ++
 linux-user/signal.c        | 217 +++++++++++++++++++++++++++++++++++++++=
+++++-
 linux-user/syscall.c       | 178 +++++++++++++++++++++++++++++++++++++
 linux-user/syscall_defs.h  |  32 +++++++
 6 files changed, 457 insertions(+), 2 deletions(-)

--=20
2.7.4


