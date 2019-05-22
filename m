Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B05C282DD
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 18:57:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E621420645
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 18:57:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E621420645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49647 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTWQc-0001Ve-5j
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 14:57:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1hTWOX-00086d-Lt
	for qemu-devel@nongnu.org; Wed, 22 May 2019 14:55:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1hTWHc-0002Re-A3
	for qemu-devel@nongnu.org; Wed, 22 May 2019 14:48:13 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:47878 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1hTWHc-0001t5-3U
	for qemu-devel@nongnu.org; Wed, 22 May 2019 14:48:12 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.rt-rk.com (Postfix) with ESMTP id 044B51A452D;
	Wed, 22 May 2019 20:47:09 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
	[10.10.13.43])
	by mail.rt-rk.com (Postfix) with ESMTPSA id DF8DC1A2238;
	Wed, 22 May 2019 20:47:08 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Wed, 22 May 2019 20:46:22 +0200
Message-Id: <1558550785-20098-3-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1558550785-20098-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1558550785-20098-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PATCH 2/5] linux-user: Add support for tracking the
 target signal mask
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
Cc: lvivier@redhat.com,
	=?UTF-8?q?Milo=C5=A1=20Stojanovi=C4=87?= <Milos.Stojanovic@rt-rk.com>,
	amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Milo=C5=A1 Stojanovi=C4=87 <Milos.Stojanovic@rt-rk.com>

If TRACK_TARGET_SIGMASK is defined, add fields in the TaskState structure
which will hold the target signal and suspend mask and add support for
initialization and forking. No functional changes are being introduced in
this commit. The TRACK_TARGET_SIGMASK will be defined in a later commit
where the target signal masks will be needed in order to implement
multiplexing of real-time target signals which are out of the host range.

Currently, QEMU has a copy of the host signal and suspend masks and that
is usually enough, since most of the time the signal mask of the target
architecture is either the same length or narrower. If however the signal
mask is wider, then part of it won't be tracked.

This commit enables adding support for separately tracking the target
signal masks in the following commits.

Signed-off-by: Milo=C5=A1 Stojanovi=C4=87 <Milos.Stojanovic@rt-rk.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 linux-user/qemu.h    | 5 +++++
 linux-user/signal.c  | 3 +++
 linux-user/syscall.c | 3 +++
 3 files changed, 11 insertions(+)

diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index ef400cb..9f70996 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -141,6 +141,11 @@ typedef struct TaskState {
      * currently in the middle of such a syscall
      */
     sigset_t sigsuspend_mask;
+#ifdef TRACK_TARGET_SIGMASK
+    /* Track the target signal and suspend masks. */
+    target_sigset_t target_signal_mask;
+    target_sigset_t target_sigsuspend_mask;
+#endif
     /* Nonzero if we're leaving a sigsuspend and sigsuspend_mask is vali=
d. */
     int in_sigsuspend;
=20
diff --git a/linux-user/signal.c b/linux-user/signal.c
index c08a7fe..954aef8 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -499,6 +499,9 @@ void signal_init(void)
=20
     /* Set the signal mask from the host mask. */
     sigprocmask(0, 0, &ts->signal_mask);
+#ifdef TRACK_TARGET_SIGMASK
+    host_to_target_sigset_internal(&ts->target_signal_mask, &ts->signal_=
mask);
+#endif
=20
     /* set all host signal handlers. ALL signals are blocked during
        the handlers to serialize them. */
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index efa3ec2..115ab13 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -5540,6 +5540,9 @@ static int do_fork(CPUArchState *env, unsigned int =
flags, abi_ulong newsp,
         ts->bprm =3D parent_ts->bprm;
         ts->info =3D parent_ts->info;
         ts->signal_mask =3D parent_ts->signal_mask;
+#ifdef TRACK_TARGET_SIGMASK
+        ts->target_signal_mask =3D parent_ts->target_signal_mask;
+#endif
=20
         if (flags & CLONE_CHILD_CLEARTID) {
             ts->child_tidptr =3D child_tidptr;
--=20
2.7.4


