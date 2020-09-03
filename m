Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9891C433E9
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 16:40:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E1B72072A
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 16:40:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="A8G6QCwU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E1B72072A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDsI6-0006uY-KD
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 12:40:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42654)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1kDsFb-0002Gu-9T; Thu, 03 Sep 2020 12:38:15 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:40621)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1kDsFZ-0003v1-3e; Thu, 03 Sep 2020 12:38:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=Dhx9hX0levtP/jPZ7VqO61MeCwOwD1gQmuwN0FfN37U=; 
 b=A8G6QCwUQ8YbT61yUHCGmYEOYfnCx3zQD6QUenQUm4r/uo1/ev1LgVa19lqYe1T2oJQJim+5/cxF+Y0h5s+PlhFI5s9hzghB9WIz2r/q+KGo4BU622D9uRDYdSe6CovkEJjp6zDlnowJebZS+0VAsU5Ph0ywZV6yEPV8KFq8p/hBvpUmjnHiQPQy0TRgZkYYgRAVQn8CYNJabAgtpxeM9zQ0+E54S5Cm6Bpa5xzTmyL7wYwtk4l2ucfyt5paF0YEg+Q/cDXLbggxdIdxtHAtArt+1BqA0c6zFHUIEiHfR33eEflC3EyPqsgTJfVKOSkiZrJN9cobriJg8nSYVtGwVw==;
Received: from [81.0.33.67] (helo=perseus.local)
 by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1kDsFW-0002F9-7T; Thu, 03 Sep 2020 18:38:10 +0200
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1kDsFJ-00082k-3l; Thu, 03 Sep 2020 18:37:57 +0200
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/3] qcow2: Don't check nb_clusters when removing l2meta
 from the list
Date: Thu,  3 Sep 2020 18:37:48 +0200
Message-Id: <ab0b67c29c7ba26e598db35f12aa5ab5982539c1.1599150873.git.berto@igalia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1599150873.git.berto@igalia.com>
References: <cover.1599150873.git.berto@igalia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 12:38:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In the past, when a new cluster was allocated the l2meta structure was
a variable in the stack so it was necessary to have a way to tell
whether it had been initialized and contained valid data or not. The
nb_clusters field was used for this purpose. Since commit f50f88b9fe
this is no longer the case, l2meta (nowadays a pointer to a list) is
only allocated when needed and nb_clusters is guaranteed to be > 0 so
this check is unnecessary.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index da56b1a4df..54a7d2f475 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2112,9 +2112,7 @@ static coroutine_fn int qcow2_handle_l2meta(BlockDriverState *bs,
         }
 
         /* Take the request off the list of running requests */
-        if (l2meta->nb_clusters != 0) {
-            QLIST_REMOVE(l2meta, next_in_flight);
-        }
+        QLIST_REMOVE(l2meta, next_in_flight);
 
         qemu_co_queue_restart_all(&l2meta->dependent_requests);
 
-- 
2.20.1


