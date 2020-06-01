Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 684E0C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 20:32:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2044D2073B
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 20:32:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="G3M6WuU9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2044D2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfr6t-0000Yx-Ca
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 16:32:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55014)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jason@zx2c4.com>) id 1jfr68-0008N9-5R
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 16:31:52 -0400
Received: from mail.zx2c4.com ([192.95.5.64]:34773)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jason@zx2c4.com>) id 1jfr66-0005p4-J0
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 16:31:51 -0400
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 59a01817;
 Mon, 1 Jun 2020 20:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=from:to:cc
 :subject:date:message-id:mime-version:content-transfer-encoding;
 s=mail; bh=58nGqeL2EkbwGSkolbgyaxYRu0E=; b=G3M6WuU9L+p5ROgN7eLr
 NQfC0HoEVeKZWQ71mbMri7Vsgb72a9TI1TUUcGzCkDZ3FYWk8y9ASuG2M0PN9uAj
 2UODuvuRp1S/RLesfzLv5SnwFs2xA6p/4QhI6a+5IH6v1KoPSQIn6FsZiDqysBvG
 tb9Pw3IcbbZNJGm9KMsumFof7FpHiV6Vn5wLkECWA9xqd3HMkL+lX4HFvTVOGG0c
 keJKR/bBpNfP8PJHRMnRcDLqwxc+1jKYvIirJAdJVg/nTLSFPPfcTkGpLgwiaOYg
 rVJcb7BnhD2DvR8t3PWKnf0hk4CKsyMyQqnf0lU9xxF4U89rHEWbBAyVgCfETcNr
 Kw==
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id a08cc4c3
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Mon, 1 Jun 2020 20:15:44 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] sparc: implement addr function
Date: Mon,  1 Jun 2020 14:31:43 -0600
Message-Id: <20200601203143.93424-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.95.5.64; envelope-from=Jason@zx2c4.com;
 helo=mail.zx2c4.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/01 16:31:49
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The sparc firmware provides an addr function, which is used by operating
systems like OpenBSD to query and work with framebuffer information,
addressing the cells directly. Without it, QEMU cannot start OpenBSD at
all, while with it, QEMU boots out of the box.

Suggested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
After this lands, somebody will need to update the submodule and
prebuilt inside of qemu.

 forth/device/extra.fs | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/forth/device/extra.fs b/forth/device/extra.fs
index 9ca6b78..f778f7a 100644
--- a/forth/device/extra.fs
+++ b/forth/device/extra.fs
@@ -19,6 +19,12 @@
 	rot encode-int 2swap property
 ;
 
+: addr
+  parse-word $find if
+    cell +
+  then
+;
+
 \ -------------------------------------------------------------------------
 \ property utils
 \ -------------------------------------------------------------------------
-- 
2.26.2


