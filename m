Return-Path: <SRS0=clLO=73=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93425C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2020 08:04:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F00220714
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2020 08:04:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mymailcheap.com header.i=@mymailcheap.com header.b="X9wdSW+h";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="A0sIOz5H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F00220714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=flygoat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkNdG-0004G5-Lk
	for qemu-devel@archiver.kernel.org; Sun, 14 Jun 2020 04:04:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59854)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1jkNcR-0002tF-OP
 for qemu-devel@nongnu.org; Sun, 14 Jun 2020 04:03:55 -0400
Received: from relay1.mymailcheap.com ([149.56.97.132]:36838)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1jkNcP-0004nE-Tm
 for qemu-devel@nongnu.org; Sun, 14 Jun 2020 04:03:55 -0400
Received: from filter1.mymailcheap.com (filter1.mymailcheap.com
 [149.56.130.247])
 by relay1.mymailcheap.com (Postfix) with ESMTPS id 5E8453F201;
 Sun, 14 Jun 2020 04:03:50 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by filter1.mymailcheap.com (Postfix) with ESMTP id 3A0ED2A3AE;
 Sun, 14 Jun 2020 04:03:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mymailcheap.com;
 s=default; t=1592121830;
 bh=3chMFuOQMgc9QzGLu50+ndxJoqfGHEefwrW77Wyex+g=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=X9wdSW+hbGX5GOMJkRBUWehYIFE2hgbDk5+tjjG8vAFKkjxsS2dPAZhRGPZHoqPYw
 KWxOuneHECJuJ7rF8N/q7TWBCgFEzrZMva/POgWxk+VhPWhFMH4A9AfY95C6OGKa8t
 56jeHhkm+5+C3vQWU9Exo40cCzgh8ex4XXIi5hEY=
X-Virus-Scanned: Debian amavisd-new at filter1.mymailcheap.com
Received: from filter1.mymailcheap.com ([127.0.0.1])
 by localhost (filter1.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FkHsVE0ujJ_s; Sun, 14 Jun 2020 04:03:49 -0400 (EDT)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by filter1.mymailcheap.com (Postfix) with ESMTPS;
 Sun, 14 Jun 2020 04:03:49 -0400 (EDT)
Received: from [148.251.23.173] (ml.mymailcheap.com [148.251.23.173])
 by mail20.mymailcheap.com (Postfix) with ESMTP id 60FCC40EFB;
 Sun, 14 Jun 2020 08:03:48 +0000 (UTC)
Authentication-Results: mail20.mymailcheap.com; dkim=pass (1024-bit key;
 unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="A0sIOz5H"; 
 dkim-atps=neutral
AI-Spam-Status: Not processed
Received: from halation.202.net.flygoat.com (unknown [183.157.45.207])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by mail20.mymailcheap.com (Postfix) with ESMTPSA id D9D64403B5;
 Sun, 14 Jun 2020 08:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=flygoat.com;
 s=default; t=1592121675;
 bh=3chMFuOQMgc9QzGLu50+ndxJoqfGHEefwrW77Wyex+g=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=A0sIOz5H01tf3iL4JYRXrN7cl5Us7ECAxN+FzuBArDBS/YaGhLQTREoaBWBmFunWm
 NyWcTiII1b2OwVxPZX0Nh9havjtxUVrrFZ4/66EcCHekYI9A1sA5znq6kmkAvK3Kix
 kfRCLvklV7Ahtch96Pk3oq5efcCpMqPuCNbvmJl4=
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
To: aleksandar.qemu.devel@gmail.com
Subject: [PATCH 2/4] target/mips: Add comments for vendor-specific ASEs
Date: Sun, 14 Jun 2020 16:00:47 +0800
Message-Id: <20200614080049.31134-3-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200614080049.31134-1-jiaxun.yang@flygoat.com>
References: <20200614080049.31134-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 60FCC40EFB
X-Spamd-Result: default: False [6.40 / 10.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 BROKEN_CONTENT_TYPE(1.50)[]; R_SPF_SOFTFAIL(0.00)[~all:c];
 RCPT_COUNT_FIVE(0.00)[5]; ML_SERVERS(-3.10)[148.251.23.173];
 DKIM_TRACE(0.00)[flygoat.com:+];
 DMARC_POLICY_ALLOW(0.00)[flygoat.com,none];
 DMARC_POLICY_ALLOW_WITH_FAILURES(0.00)[];
 FREEMAIL_TO(0.00)[gmail.com]; RCVD_NO_TLS_LAST(0.10)[];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 ASN(0.00)[asn:24940, ipnet:148.251.0.0/16, country:DE];
 RECEIVED_SPAMHAUS_PBL(0.00)[183.157.45.207:received];
 ARC_NA(0.00)[]; R_DKIM_ALLOW(0.00)[flygoat.com:s=default];
 FROM_HAS_DN(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TAGGED_RCPT(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; MID_CONTAINS_FROM(1.00)[];
 HFILTER_HELO_BAREIP(3.00)[148.251.23.173,1];
 RCVD_COUNT_TWO(0.00)[2]; SUSPICIOUS_RECIPS(1.50)[]
X-Rspamd-Server: mail20.mymailcheap.com
X-Spam: Yes
Received-SPF: pass client-ip=149.56.97.132;
 envelope-from=jiaxun.yang@flygoat.com; helo=relay1.mymailcheap.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/14 04:03:50
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, aleksandar.rikalo@syrmia.com,
 qemu-devel@nongnu.org, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Abbreviations of vendor-specific ASEs looks very similiar.
Add comments to explain the full name and vendors of these flags.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 target/mips/mips-defs.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/mips/mips-defs.h b/target/mips/mips-defs.h
index f1b833f947..ed6a7a9e54 100644
--- a/target/mips/mips-defs.h
+++ b/target/mips/mips-defs.h
@@ -57,9 +57,13 @@
 /*
  *   bits 52-63: vendor-specific ASEs
  */
+/* MultiMedia Instructions defined by R5900 */
 #define ASE_MMI           0x0010000000000000ULL
+/* MIPS eXtension/enhanced Unit defined by Ingenic */
 #define ASE_MXU           0x0020000000000000ULL
+/* Loongson MultiMedia Instructions */
 #define ASE_LMMI          0x0040000000000000ULL
+/* Loongson EXTensions */
 #define ASE_LEXT          0x0080000000000000ULL
 
 /* MIPS CPU defines. */
-- 
2.27.0

