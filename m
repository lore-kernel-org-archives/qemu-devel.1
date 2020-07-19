Return-Path: <SRS0=x6dg=A6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28674C433E1
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jul 2020 14:41:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7B352080D
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jul 2020 14:41:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="eVweJzS+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7B352080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxAV1-0004Yh-5b
	for qemu-devel@archiver.kernel.org; Sun, 19 Jul 2020 10:41:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40004)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <cb67ffe2c8e5bddc31511d62a859cebfda0b7feb@lizzy.crudebyte.com>)
 id 1jxAUJ-00042n-Dr
 for qemu-devel@nongnu.org; Sun, 19 Jul 2020 10:40:23 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:45411)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <cb67ffe2c8e5bddc31511d62a859cebfda0b7feb@lizzy.crudebyte.com>)
 id 1jxAUH-0005Cv-Jf
 for qemu-devel@nongnu.org; Sun, 19 Jul 2020 10:40:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=dniHciHWD1s2sUmY62gnL597ZGnuF2fTUNk4k5tqqLE=; b=eVweJ
 zS+kwjAOSABAGZ/OnBEdXfzmO7BfwNaxrKRKbK5BUgXgL1NzbhbmncITp9StAj9qBulqV0BpBWzLv
 5HAnIib+Dq7tjnXlQS418i5pjYly96pPyGySSN7JOGDXnjZUkHSlEJWbAZkvfYU+kfXp2sE3RQAKq
 tsdDh4DmxK1Hap2XvDyDNWhfR9J7SFEbTLcUdo6tna80k3i5WKiL1TbUL4h5fRhaz8kImqlbn5WsX
 GPCyrL0kGeLYrqaD90Om0yjPYSKtJ4GOvjHH6NgV4xwt7Sw2/OJ7CPLEfTcVpXQSAuw0hK2Fzz0gw
 4SRkF0Ak8qPXBzKx80FjXGCyyk3Pw==;
Message-Id: <cb67ffe2c8e5bddc31511d62a859cebfda0b7feb.1595166227.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1595166227.git.qemu_oss@crudebyte.com>
References: <cover.1595166227.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Sun, 19 Jul 2020 15:39:59 +0200
Subject: [PATCH v7 6/6] 9pfs: clarify latency of v9fs_co_run_in_worker()
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>
Received-SPF: none client-ip=91.194.90.13;
 envelope-from=cb67ffe2c8e5bddc31511d62a859cebfda0b7feb@lizzy.crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/19 10:12:15
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As we just fixed a severe performance issue with Treaddir request
handling, clarify this overall issue as a comment on
v9fs_co_run_in_worker() with the intention to hopefully prevent
such performance mistakes in future (and fixing other yet
outstanding ones).

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 hw/9pfs/coth.h | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/hw/9pfs/coth.h b/hw/9pfs/coth.h
index fd4a45bc7c..c51289903d 100644
--- a/hw/9pfs/coth.h
+++ b/hw/9pfs/coth.h
@@ -19,7 +19,7 @@
 #include "qemu/coroutine.h"
 #include "9p.h"
 
-/*
+/**
  * we want to use bottom half because we want to make sure the below
  * sequence of events.
  *
@@ -28,6 +28,16 @@
  *   3. Enter the coroutine in the worker thread.
  * we cannot swap step 1 and 2, because that would imply worker thread
  * can enter coroutine while step1 is still running
+ *
+ * @b PERFORMANCE @b CONSIDERATIONS: As a rule of thumb, keep in mind
+ * that hopping between threads adds @b latency! So when handling a
+ * 9pfs request, avoid calling v9fs_co_run_in_worker() too often, because
+ * this might otherwise sum up to a significant, huge overall latency for
+ * providing the response for just a single request. For that reason it
+ * is highly recommended to fetch all data from fs driver with a single
+ * fs driver request on a background I/O thread (bottom half) in one rush
+ * first and then eventually assembling the final response from that data
+ * on main I/O thread (top half).
  */
 #define v9fs_co_run_in_worker(code_block)                               \
     do {                                                                \
-- 
2.20.1


