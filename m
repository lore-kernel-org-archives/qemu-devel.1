Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF9FC4332E
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 14:41:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AC1820663
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 14:41:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aepfle.de header.i=@aepfle.de header.b="HqMzcsLv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AC1820663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aepfle.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEwMH-0002q6-Pt
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 10:41:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50420)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <olaf@aepfle.de>) id 1jEwLO-00022Y-AE
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 10:40:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <olaf@aepfle.de>) id 1jEwLN-0005QU-5R
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 10:40:22 -0400
Received: from mo6-p00-ob.smtp.rzone.de ([2a01:238:20a:202:5300::8]:32544)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <olaf@aepfle.de>) id 1jEwLM-0005PK-Gx
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 10:40:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1584628817;
 s=strato-dkim-0002; d=aepfle.de;
 h=Message-Id:Date:Subject:To:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:
 Subject:Sender;
 bh=BF0z4/y5xd14tksiE2s1NzcpGwSorgPWdlj+dlTQj4Y=;
 b=HqMzcsLvF8foaYPKasEnj+dYheoW4Toz2gvaW73koSmsgoyrUmT51+P5ZQ1xpIFC4x
 bE6/JpybuC/Apu2+JbZfxGyvsvO9y1H8VTMSQ3vATLi7j3jQPVIM5Vl+qGNKHYBLx+At
 yoKowlC36ihQiIOw4Ff8Db1lwu9Y64AY9sg3cjr2m1hRrNTgnJCo0pa2h1qpfS8Cj3UZ
 7aIpbsnkPvv06xiyHE4WcNjeZYShCttucnyzrLe5mjFO5EoXiRZvmriJtjNecjzffTql
 ptGvRk3m5vTlx3+AJjn2p8rdPCMMty5RM/K3V/tTHeYJdUPCOcM0jkXEaLiVeBixHZsU
 c3Rw==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QXkBR9MXjAuzBW/OdlBZQ4AHSS329Ojw=="
X-RZG-CLASS-ID: mo00
Received: from sender by smtp.strato.de (RZmta 46.2.1 DYNA|AUTH)
 with ESMTPSA id k0b757w2JEeG22B
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
 (Client did not present a certificate);
 Thu, 19 Mar 2020 15:40:16 +0100 (CET)
From: Olaf Hering <olaf@aepfle.de>
To: Olaf Hering <olaf@aepfle.de>,
 qemu-devel@nongnu.org (open list:All patches CC here)
Subject: [PATCH v1] configure: record sphinx output
Date: Thu, 19 Mar 2020 15:39:54 +0100
Message-Id: <20200319143954.25694-1-olaf@aepfle.de>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 2a01:238:20a:202:5300::8
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If configure fails to run due to errors in the expected sphinx
environment no helpful message is recorded. Write all of the output to
config.log to assist with debugging.

Signed-off-by: Olaf Hering <olaf@aepfle.de>
---
 configure | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure b/configure
index 12dbb0c76b..55086b0280 100755
--- a/configure
+++ b/configure
@@ -4908,7 +4908,7 @@ has_sphinx_build() {
     # sphinx-build doesn't exist at all or if it is too old.
     mkdir -p "$TMPDIR1/sphinx"
     touch "$TMPDIR1/sphinx/index.rst"
-    "$sphinx_build" -c "$source_path/docs" -b html "$TMPDIR1/sphinx" "$TMPDIR1/sphinx/out" >/dev/null 2>&1
+    "$sphinx_build" -c "$source_path/docs" -b html "$TMPDIR1/sphinx" "$TMPDIR1/sphinx/out" >> config.log 2>&1
 }
 
 # Check if tools are available to build documentation.

