Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D272C43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 13:53:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1710220675
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 13:53:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Agt7EO9D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1710220675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57927 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL6ig-0005xZ-CZ
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 09:53:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hL6h9-0004zg-Ru
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 09:51:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hL6h8-0007tG-Ti
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 09:51:47 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:44144)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>)
	id 1hL6h8-0007jJ-BZ; Mon, 29 Apr 2019 09:51:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; 
	h=References:In-Reply-To:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
	bh=AepjI2xjb2h5M70msNzUPlt06VQQrCDG70bRmRZ80vY=; 
	b=Agt7EO9DGCzRAswm3BxubTEU6iH5Rqt8/RRKGAG8CS+oCYpYyDxGvtOVBHGMYptZ+3v8MCRiOQP79V4ag2tjfuyzm2WO0FMP7RzldxJgRI52x4qLMPAJXKF2K0tEqjPEPUzSXL37aeqI9oBRjIItn1wsKUv4WPa2XfvtJEh6mP2t1xIaQYP+W5/sA1y5dh0mi2+bSCcBO6SlPF5ASnSx7V6YnfjSw9nOUqAzVdI6zBmgNOfzEUO6SI8bVXKww0rNdleb9rjYxmKf5X/XHNzRd8/kswtrmOLG4+IUMrA+Yqcpvb2E5XrgcZvZGU9ymV7x6wV45vMnSC4nFElVPa/OgQ==;
Received: from [212.145.226.66] (helo=perseus.local)
	by fanzine.igalia.com with esmtpsa 
	(Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
	id 1hL6gq-0006BY-T9; Mon, 29 Apr 2019 15:51:28 +0200
Received: from berto by perseus.local with local (Exim 4.89)
	(envelope-from <berto@igalia.com>)
	id 1hL6gd-0007Kj-BT; Mon, 29 Apr 2019 16:51:15 +0300
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Date: Mon, 29 Apr 2019 15:51:08 +0200
Message-Id:
 <b3ac14007e00bb926099f631e10680781d6508b7.1556540297.git.berto@igalia.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1556540297.git.berto@igalia.com>
References: <cover.1556540297.git.berto@igalia.com>
In-Reply-To: <cover.1556540297.git.berto@igalia.com>
References: <cover.1556540297.git.berto@igalia.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
	timestamps) [generic] [fuzzy]
X-Received-From: 91.117.99.155
Subject: [Qemu-devel] [PATCH v3 1/2] commit: Make base read-only if there is
 an early failure
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
Message-ID: <20190429135108.gHZBxDHFTlJq3gTowj9A8V-OXiVTiusNC1W_iVJjr8Q@z>

You can reproduce this by passing an invalid filter-node-name (like
"1234") to block-commit. In this case the base image is put in
read-write mode but is never reset back to read-only.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 block/commit.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/commit.c b/block/commit.c
index ba60fef58a..698eda1dfe 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -384,6 +384,9 @@ fail:
     if (s->top) {
         blk_unref(s->top);
     }
+    if (s->base_read_only) {
+        bdrv_reopen_set_read_only(base, true, NULL);
+    }
     job_early_fail(&s->common.job);
     /* commit_top_bs has to be replaced after deleting the block job,
      * otherwise this would fail because of lack of permissions. */
-- 
2.11.0


