Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CAB3C2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 14:53:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 666932070E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 14:53:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="23SupqYV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 666932070E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwoiI-0008PF-Fu
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 09:53:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60202)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <luc.michel@greensocs.com>) id 1iwofM-0006AZ-EA
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 09:50:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <luc.michel@greensocs.com>) id 1iwofH-00010u-AN
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 09:50:04 -0500
Received: from beetle.greensocs.com ([5.135.226.135]:36766)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <luc.michel@greensocs.com>)
 id 1iwofG-0000uA-SJ
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 09:49:59 -0500
Received: from michell-laptop.bar.greensocs.com (unknown [172.17.10.6])
 by beetle.greensocs.com (Postfix) with ESMTPS id D4A3D96EF0;
 Wed, 29 Jan 2020 14:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1580309396;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=6LICdGlbcpteBkdpfMGTXk/0e4w7x8LAT7dNFujK1T4=;
 b=23SupqYVFPHtQSE0YmBRCrUpqvscE864m0jDkez/xCGx1bbRmvgl37qd7SumvjobwG+IR0
 MWmVvJPvrSblCRcMXLkCSSev31jsySBkwSzOFzfKsBc2qCdq8KYz8iFTjEqfDZ4n7VTAU3
 3W5Ad2YXqTE31u6AL95iTnAZb7Q8rNU=
From: Luc Michel <luc.michel@greensocs.com>
To: qemu-devel@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH] seqlock: fix seqlock_write_unlock_impl function
Date: Wed, 29 Jan 2020 15:49:48 +0100
Message-Id: <20200129144948.2161551-1-luc.michel@greensocs.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1580309396;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=6LICdGlbcpteBkdpfMGTXk/0e4w7x8LAT7dNFujK1T4=;
 b=Et3LCf5/WH96l9NeHK5ueXAzW0+3YDkSQ+xS7Hk6aVqeF91G81+6yiJ6t41kSr3LQsiUXU
 3zTiF8whbV1woAamuRUXKFhZW/a59WMwrKi+GLVW6OBC26gGdhhQhsJMAzdLL5pD0vUkr8
 Mc1H2rmbGTdDDM90UXVxqLRcumw7qFE=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1580309396; a=rsa-sha256; cv=none;
 b=BgkFCCLmggFyWrFYkVWAkSAwQtGa+PuXHSbEOXJMR6jhRqpSbhrYDsavTCaPFtgVpUl77p
 RF0Znpizg2L9rU9yb3ukwiX6A+KrO2flNDWTlw4hx42V133eRIRR3xvlmqOqKayfqvQ3SX
 5+RbfSsZ92p2xY4Y/WcAbjOln/HF/gE=
ARC-Authentication-Results: i=1;
	beetle.greensocs.com;
	none
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.135.226.135
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The seqlock write unlock function was incorrectly calling
seqlock_write_begin() instead of seqlock_write_end(), and was releasing
the lock before incrementing the sequence. This could lead to a race
condition and a corrupted sequence number becoming odd even though the
lock is not held.

Signed-off-by: Luc Michel <luc.michel@greensocs.com>
---
 include/qemu/seqlock.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/qemu/seqlock.h b/include/qemu/seqlock.h
index fd408b7ec5..8b6b4ee4bb 100644
--- a/include/qemu/seqlock.h
+++ b/include/qemu/seqlock.h
@@ -53,15 +53,15 @@ static inline void seqlock_write_lock_impl(QemuSeqLoc=
k *sl, QemuLockable *lock)
     seqlock_write_begin(sl);
 }
 #define seqlock_write_lock(sl, lock) \
     seqlock_write_lock_impl(sl, QEMU_MAKE_LOCKABLE(lock))
=20
-/* Lock out other writers and update the count.  */
+/* Update the count and release the lock.  */
 static inline void seqlock_write_unlock_impl(QemuSeqLock *sl, QemuLockab=
le *lock)
 {
+    seqlock_write_end(sl);
     qemu_lockable_unlock(lock);
-    seqlock_write_begin(sl);
 }
 #define seqlock_write_unlock(sl, lock) \
     seqlock_write_unlock_impl(sl, QEMU_MAKE_LOCKABLE(lock))
=20
=20
--=20
2.25.0


