Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A036C10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 14:25:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E94A20850
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 14:25:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="GV3u4n3D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E94A20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49744 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEae4-0005VQ-D7
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 10:25:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58689)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hEaca-0004cg-Ly
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 10:24:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hEacZ-00011s-SI
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 10:24:08 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:49195)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>)
	id 1hEacZ-00011R-6O; Thu, 11 Apr 2019 10:24:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; 
	h=References:In-Reply-To:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
	bh=X/ZwFGm9zP/P0qGL8Qgrfgtfw/BlGCpKm61+gKSCvm0=; 
	b=GV3u4n3DoXq9LUUAuViOQiDGKvPyNZ93C7wAYQyyCcaLSMPsEEEhwIA9nWoNJz2OUmfY5bfRvyKQ3tOwFsgTX/L3V5F6yjZtOcpuoFzYEnX0ykSJs/U/kW6mTd4OsTiic6OEm46/OgcxD6XoC2c5Ukw6E3EF8Mi0Ia9hv691eT5JoQOR+kAiB60tHUybry0jHl6g3Q0tOHXZm6MGCkvEQCJm92j9bgBBzHRWM9Wm6Vs8PkHMMtKrOHigBRJDVobbAUGIC4/21sfLzDrDPzti8JFfAN9lb52XQQZondCyPbaY9l+v0S5qwTlxX02Q/GWjEswmU6olyGPb1SgC+XIUDg==;
Received: from 178-55-128-240.bb.dnainternet.fi ([178.55.128.240]
	helo=perseus.local) by fanzine.igalia.com with esmtpsa 
	(Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
	id 1hEacW-00019L-89; Thu, 11 Apr 2019 16:24:04 +0200
Received: from berto by perseus.local with local (Exim 4.89)
	(envelope-from <berto@igalia.com>)
	id 1hEacH-0001i3-2Q; Thu, 11 Apr 2019 17:23:49 +0300
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Date: Thu, 11 Apr 2019 17:23:46 +0300
Message-Id:
 <e68bde5c675a67b336ad567ec35a138271cf0c87.1554992449.git.berto@igalia.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1554992449.git.berto@igalia.com>
References: <cover.1554992449.git.berto@igalia.com>
In-Reply-To: <cover.1554992449.git.berto@igalia.com>
References: <cover.1554992449.git.berto@igalia.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
	timestamps) [generic] [fuzzy]
X-Received-From: 91.117.99.155
Subject: [Qemu-devel] [PATCH for-4.1 2/2] block: Clear the backing_file
 fields on detach
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
	qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190411142346.X_S97ffpAuVK7bEpobhBTOmqJqeoV7WlEwWbdwGosnU@z>

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block.c b/block.c
index e496999e2f..e9c0c9e2ad 100644
--- a/block.c
+++ b/block.c
@@ -1085,6 +1085,9 @@ static void bdrv_backing_detach(BdrvChild *c)
     error_free(parent->backing_blocker);
     parent->backing_blocker = NULL;
 
+    parent->backing_file[0] = '\0';
+    parent->backing_format[0] = '\0';
+
     bdrv_child_cb_detach(c);
 }
 
-- 
2.11.0


