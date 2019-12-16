Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DATE_IN_PAST_24_48,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 256DCC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 00:31:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E42342176D
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 00:31:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="C1m+U13L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E42342176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihNFf-00085Y-PU
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 19:31:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36258)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <a5aeeb90df6eb9bfca22431fc4ee0d5eaa58c2e5@lizzy.crudebyte.com>)
 id 1ihNEP-0007Jc-8T
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 19:30:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <a5aeeb90df6eb9bfca22431fc4ee0d5eaa58c2e5@lizzy.crudebyte.com>)
 id 1ihNEN-0006PV-Sb
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 19:30:25 -0500
Received: from lizzy.crudebyte.com ([91.194.90.13]:39153)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71)
 (envelope-from <a5aeeb90df6eb9bfca22431fc4ee0d5eaa58c2e5@lizzy.crudebyte.com>)
 id 1ihNEN-0005Ph-9l
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 19:30:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Message-Id:Subject:Date:Cc:To:From:Content-Type:
 Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Content-ID:
 Content-Description; bh=GgiXB8p8Xd/QoPlYaJiPVPesefRwdQros/8Qb85D0+4=; b=C1m+U
 13LUJaLnInujhKDG80CG/9j/tsX37UtqVvC7futfXH63kfcxzTFYzjWQ9t+eLsO21C8xG3p3RCN/P
 sz+qnK8UjbJSC/vczDg/Rl8oUMzZdfMyLtb1HU2AD/7VMVvvYBunVIeGa1bIr0H/VnbISjTAYvjef
 0FtZHQTsHdtj+PizxnpUuCZFtMQlx9Sf9ysaosEkBCyOQuQ4boSrkVd5712Y6RK6xlsLrnug92Vpe
 qhDGeUOFxaKpVdorbovrI9L0yqicfNJ97b0uG9A1A+bV/B/uxyyKDqWCOLYkhv39zU56/XFjDP2C1
 94j9WXsoXncSo8cCIq+W9Ei3hGqNA==;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>
Date: Mon, 16 Dec 2019 15:43:39 +0100
Subject: [PATCH 2/9] 9pfs: validate count sent by client with T_readdir
Message-Id: <E1ihMum-00076q-5l@lizzy.crudebyte.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 91.194.90.13
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

A good 9p client sends T_readdir with "count" parameter that's
sufficiently smaller than client's initially negotiated msize
(maximum message size). We perform a check for that though to
avoid the server to be interrupted with a "Failed to encode
VirtFS reply type 41" error message by bad clients.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 hw/9pfs/9p.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 520177f40c..30e33b6573 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -2414,6 +2414,7 @@ static void coroutine_fn v9fs_readdir(void *opaque)
     int32_t count;
     uint32_t max_count;
     V9fsPDU *pdu = opaque;
+    V9fsState *s = pdu->s;
 
     retval = pdu_unmarshal(pdu, offset, "dqd", &fid,
                            &initial_offset, &max_count);
@@ -2422,6 +2423,13 @@ static void coroutine_fn v9fs_readdir(void *opaque)
     }
     trace_v9fs_readdir(pdu->tag, pdu->id, fid, initial_offset, max_count);
 
+    if (max_count > s->msize - P9_IOHDRSZ) {
+        max_count = s->msize - P9_IOHDRSZ;
+        warn_report_once(
+            "9p: bad client: T_readdir with count > msize - P9_IOHDRSZ"
+        );
+    }
+
     fidp = get_fid(pdu, fid);
     if (fidp == NULL) {
         retval = -EINVAL;
-- 
2.20.1


