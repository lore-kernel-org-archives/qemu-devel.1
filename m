Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E7FC433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 23:40:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F6AE2222F
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 23:40:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="L1VB/3/3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F6AE2222F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUelW-00083h-Dp
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 19:40:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47642)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <03b427019be98d12761924f1e6132eefc82c80ec@lizzy.crudebyte.com>)
 id 1kUejd-0006f0-LD
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 19:38:39 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:46091)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <03b427019be98d12761924f1e6132eefc82c80ec@lizzy.crudebyte.com>)
 id 1kUejY-0002Oq-Co
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 19:38:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=cnu0mo5+5Umg2MICUQzzLjXUPHcM5xBEoZQ/ZXahtCs=; b=L1VB/
 3/34mTBmMzzVfnJuoCMUT7tJ1lBewxwkczffWoTxs55pFGJMe10kLP8TEvdMKBzgAGi6A+db/zzxx
 ofkPi1MU9EKMkc7Jb6B3PmAweKdvUX7tZ3q+ajIQ+S+y0xtm4nq8MhoV9AkF4kQp/nXAb4A3XuWWN
 qSbpqT6MiAyJu7O1b5pB6KIZtAQhmWyEADU3u0+O55vOHcZ6hV3iC7yVF9QzdgNjQYe+aNkZ1viZc
 Fp6TmzZ34fKs3Nvdxw13bakSe8ED1xptfOS3IetfphILgvqRYrUVSqd+KKHYWOnS+/s9s2Caccb/E
 dTXNGWENTqxi0RG7aLWVqAgu8Ibfw==;
Message-Id: <03b427019be98d12761924f1e6132eefc82c80ec.1603149434.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1603149434.git.qemu_oss@crudebyte.com>
References: <cover.1603149434.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Tue, 20 Oct 2020 01:13:23 +0200
Subject: [PATCH 1/8] tests/9pfs: simplify fs_mkdir()
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>
Received-SPF: none client-ip=91.194.90.13;
 envelope-from=03b427019be98d12761924f1e6132eefc82c80ec@lizzy.crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 19:37:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Split out walking a directory path to a separate new utility function
fs_walk_fid() and use that function in fs_mkdir().

The code difference saved this way is not much, but we'll use that new
fs_walk_fid() function in the upcoming patches, so it will avoid quite
some code duplication after all.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 tests/qtest/virtio-9p-test.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/tests/qtest/virtio-9p-test.c b/tests/qtest/virtio-9p-test.c
index c15908f27b..dc724bbb1e 100644
--- a/tests/qtest/virtio-9p-test.c
+++ b/tests/qtest/virtio-9p-test.c
@@ -967,13 +967,12 @@ static void fs_flush_ignored(void *obj, void *data, QGuestAllocator *t_alloc)
     g_free(wnames[0]);
 }
 
-static void fs_mkdir(void *obj, void *data, QGuestAllocator *t_alloc,
-                     const char *path, const char *cname)
+/* utility function: walk to requested dir and return fid for that dir */
+static uint32_t fs_walk_fid(void *obj, void *data, QGuestAllocator *t_alloc,
+                            const char *path)
 {
     QVirtio9P *v9p = obj;
-    alloc = t_alloc;
     char **wnames;
-    char *const name = g_strdup(cname);
     P9Req *req;
     const uint32_t fid = genfid();
 
@@ -983,12 +982,26 @@ static void fs_mkdir(void *obj, void *data, QGuestAllocator *t_alloc,
     v9fs_req_wait_for_reply(req, NULL);
     v9fs_rwalk(req, NULL, NULL);
 
+    split_free(&wnames);
+    return fid;
+}
+
+static void fs_mkdir(void *obj, void *data, QGuestAllocator *t_alloc,
+                     const char *path, const char *cname)
+{
+    QVirtio9P *v9p = obj;
+    alloc = t_alloc;
+    char *const name = g_strdup(cname);
+    uint32_t fid;
+    P9Req *req;
+
+    fid = fs_walk_fid(v9p, data, t_alloc, path);
+
     req = v9fs_tmkdir(v9p, fid, name, 0750, 0, 0);
     v9fs_req_wait_for_reply(req, NULL);
     v9fs_rmkdir(req, NULL);
 
     g_free(name);
-    split_free(&wnames);
 }
 
 static void fs_readdir_split_128(void *obj, void *data,
-- 
2.20.1


