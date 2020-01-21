Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 280F7C32771
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 01:40:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E600822522
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 01:40:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="GYgxfULH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E600822522
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itiWR-0003qL-OO
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 20:40:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44190)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <b6fef929757d4ea1d7ce6a0044563bb3ff68c92c@lizzy.crudebyte.com>)
 id 1itiVV-0002qR-Oq
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 20:39:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <b6fef929757d4ea1d7ce6a0044563bb3ff68c92c@lizzy.crudebyte.com>)
 id 1itiVU-0003nC-HK
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 20:39:05 -0500
Received: from lizzy.crudebyte.com ([91.194.90.13]:36919)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71)
 (envelope-from <b6fef929757d4ea1d7ce6a0044563bb3ff68c92c@lizzy.crudebyte.com>)
 id 1itiVU-00032H-Al
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 20:39:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=zcSfqVIl9aZcBw0KXvyzYkDP2ZCaLMu0GRnguhVPIY0=; b=GYgxf
 ULHKIV0zQzrYZIDWdaBXuKmLliG77/bjkughMy171HzSc3fkJhBa91AQkvLTh+J6fN8G8b9H158Az
 x6BoajQ0h1VzRjUjhOFQV/SMuXBPylMHPXr8dAWBvgF/EteokRxSHuMLDxLNjfqmuV1woJsyT8dr9
 MM8YtOHpaenolSeLZcAPCygIGhXkAalQmXhkw2bm/woeua1KNtU1OQsUv5cP4wbKPJdusxRSGKDV1
 A7CMHYrwoBOLiaMDAYts2fPuhGX90MsnaY+QqKd4TWanXSAYA+y8q9PYhy1QsgV4+wUkXWwWRsRbr
 kXH3awifGlLQ86auncxUSKGE5Xjsg==;
Message-Id: <b6fef929757d4ea1d7ce6a0044563bb3ff68c92c.1579567020.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1579567019.git.qemu_oss@crudebyte.com>
References: <cover.1579567019.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Tue, 21 Jan 2020 01:32:04 +0100
Subject: [PATCH v4 11/11] hw/9pfs/9p.c: benchmark time on T_readdir request
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>
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

This patch is not intended to be merged, it measures
and prints the time the 9p server spends on handling
a T_readdir request. It prints the total time it spent
on handling the request, and also the time it spent
on I/O (fs driver) only.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 hw/9pfs/9p.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index e0ca45d46b..9cd494edd7 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -2311,6 +2311,15 @@ static void v9fs_free_dirents(struct V9fsDirEnt *e)
     }
 }
 
+static double wall_time(void)
+{
+    struct timeval t;
+    struct timezone tz;
+    gettimeofday(&t, &tz);
+    return t.tv_sec + t.tv_usec * 0.000001;
+}
+
+
 static int coroutine_fn v9fs_do_readdir(V9fsPDU *pdu, V9fsFidState *fidp,
                                         int32_t max_count)
 {
@@ -2330,6 +2339,8 @@ static int coroutine_fn v9fs_do_readdir(V9fsPDU *pdu, V9fsFidState *fidp,
      */
     const bool dostat = pdu->s->ctx.export_flags & V9FS_REMAP_INODES;
 
+    const double start = wall_time();
+
     /*
      * Fetch all required directory entries altogether on a background IO
      * thread from fs driver. We don't want to do that for each entry
@@ -2344,6 +2355,10 @@ static int coroutine_fn v9fs_do_readdir(V9fsPDU *pdu, V9fsFidState *fidp,
     }
     count = 0;
 
+    const double end = wall_time();
+    printf("\n\nTime 9p server spent on synth_readdir() I/O only (synth "
+           "driver): %fs\n", end - start);
+
     for (struct V9fsDirEnt *e = entries; e; e = e->next) {
         dent = e->dent;
 
@@ -2416,6 +2431,8 @@ static void coroutine_fn v9fs_readdir(void *opaque)
     V9fsPDU *pdu = opaque;
     V9fsState *s = pdu->s;
 
+    const double start = wall_time();
+
     retval = pdu_unmarshal(pdu, offset, "dqd", &fid,
                            &initial_offset, &max_count);
     if (retval < 0) {
@@ -2459,6 +2476,10 @@ out:
     put_fid(pdu, fidp);
 out_nofid:
     pdu_complete(pdu, retval);
+
+    const double end = wall_time();
+    printf("Time 9p server spent on entire T_readdir request: %fs "
+           "[IMPORTANT]\n", end - start);
 }
 
 static int v9fs_xattr_write(V9fsState *s, V9fsPDU *pdu, V9fsFidState *fidp,
-- 
2.20.1


