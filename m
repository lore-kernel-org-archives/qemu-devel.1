Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DATE_IN_PAST_24_48,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F331EC388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 11:54:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5704820857
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 11:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="NfyXETMS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5704820857
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVvec-0005dC-7K
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 07:54:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57794)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <cb2bc157997817ea2e0787aae3349b94fb0a402b@lizzy.crudebyte.com>)
 id 1kVvYL-0004BX-2i
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 07:48:13 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:39161)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <cb2bc157997817ea2e0787aae3349b94fb0a402b@lizzy.crudebyte.com>)
 id 1kVvYI-0004Jy-5Z
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 07:48:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=9ifmdLPDMaqG5Wb2AjtogbTpfUi00Bi4jhLYWV8cvng=; b=NfyXE
 TMSde0OrmuOc97vEjmJyLn6Ps8Rkj3d8ZmIGzRq1UBsUx0FO4Bw+1UcWP/kkoGTg1xiaUaZR3K0uj
 Jx/UbPqh94C3WEYiLY0AMMDoKSSOwULKACDtr+h7eYeWi2LYrYupkjfPzpOjq1eAVM/cx7mzS7eRB
 sSNhuEILhojPTqKv0oJh+Ir863Yrh06R7aVUSaoFA8fbWti155tYnt1HNFHmmGp8pBd6ZY+FWwSnV
 HhOH9DDXGMiAg5Z9HwNo2A2Ei9c2GR4PlSC8HjJrsGEgliR3DQbxUmqbKNeX7pgxeqcWH3y+NAC8E
 2W1a27mfSbQhDY9Ufvz9kjT+wLatA==;
Message-Id: <cb2bc157997817ea2e0787aae3349b94fb0a402b.1603452058.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1603452058.git.qemu_oss@crudebyte.com>
References: <cover.1603452058.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Wed, 21 Oct 2020 14:06:53 +0200
Subject: [PULL 06/13] tests/9pfs: simplify do_mkdir()
To: qemu-devel@nongnu.org,
    Peter Maydell <peter.maydell@linaro.org>
Cc: Greg Kurz <groug@kaod.org>
Received-SPF: none client-ip=91.194.90.13;
 envelope-from=cb2bc157997817ea2e0787aae3349b94fb0a402b@lizzy.crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 07:46:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_24_48=1.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
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
do_walk() and use that function in do_mkdir().

The code difference saved this way is not much, but we'll use that new
do_walk() function in the upcoming patches, so it will avoid quite
some code duplication after all.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Message-Id: <4d7275b2363f122438a443ce079cbb355285e9d6.1603285620.git.qemu_oss@crudebyte.com>
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 tests/qtest/virtio-9p-test.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/tests/qtest/virtio-9p-test.c b/tests/qtest/virtio-9p-test.c
index 2ea555fa04..21807037df 100644
--- a/tests/qtest/virtio-9p-test.c
+++ b/tests/qtest/virtio-9p-test.c
@@ -583,6 +583,23 @@ static void do_version(QVirtio9P *v9p)
     g_free(server_version);
 }
 
+/* utility function: walk to requested dir and return fid for that dir */
+static uint32_t do_walk(QVirtio9P *v9p, const char *path)
+{
+    char **wnames;
+    P9Req *req;
+    const uint32_t fid = genfid();
+
+    int nwnames = split(path, "/", &wnames);
+
+    req = v9fs_twalk(v9p, 0, fid, nwnames, wnames, 0);
+    v9fs_req_wait_for_reply(req, NULL);
+    v9fs_rwalk(req, NULL, NULL);
+
+    split_free(&wnames);
+    return fid;
+}
+
 static void fs_version(void *obj, void *data, QGuestAllocator *t_alloc)
 {
     alloc = t_alloc;
@@ -974,23 +991,17 @@ static void fs_flush_ignored(void *obj, void *data, QGuestAllocator *t_alloc)
 
 static void do_mkdir(QVirtio9P *v9p, const char *path, const char *cname)
 {
-    char **wnames;
     char *const name = g_strdup(cname);
+    uint32_t fid;
     P9Req *req;
-    const uint32_t fid = genfid();
 
-    int nwnames = split(path, "/", &wnames);
-
-    req = v9fs_twalk(v9p, 0, fid, nwnames, wnames, 0);
-    v9fs_req_wait_for_reply(req, NULL);
-    v9fs_rwalk(req, NULL, NULL);
+    fid = do_walk(v9p, path);
 
     req = v9fs_tmkdir(v9p, fid, name, 0750, 0, 0);
     v9fs_req_wait_for_reply(req, NULL);
     v9fs_rmkdir(req, NULL);
 
     g_free(name);
-    split_free(&wnames);
 }
 
 static void fs_readdir_split_128(void *obj, void *data,
-- 
2.20.1


