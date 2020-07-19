Return-Path: <SRS0=x6dg=A6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A0DC433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jul 2020 14:45:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60D4C2080D
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jul 2020 14:45:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="kD21EKgR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60D4C2080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxAZ0-000848-JC
	for qemu-devel@archiver.kernel.org; Sun, 19 Jul 2020 10:45:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40756)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <1f315695593aa3000477c4265d56a3eca9482c23@lizzy.crudebyte.com>)
 id 1jxAYO-0007dK-Kr
 for qemu-devel@nongnu.org; Sun, 19 Jul 2020 10:44:36 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:43499)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <1f315695593aa3000477c4265d56a3eca9482c23@lizzy.crudebyte.com>)
 id 1jxAYN-0005eV-4w
 for qemu-devel@nongnu.org; Sun, 19 Jul 2020 10:44:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=pDF58CzzyVkxh+s3PWVUovZOObDqLn6VfIrB7HCsOew=; b=kD21E
 KgRVJPtdxQ6b3RjMiqeqHsI3YYT/ri6cEHVIWDDI+E0lWdUsPf7f95cm8J4wveKX+1RuDze4dUcCZ
 rMgDB/g+ahh/mGaAbFtPoRG9Bg2ayewq527kDWo+bYKvx3JmsevCQD7P6e6apPvwKxwVG6VtGirob
 QSGEjrBwkBRHC1yx2VMyIdjp8MNDo1C9su0c7rYOt+zmAo2MTqx4ccpQ8zCu4CmXneZrGpbXtcxaX
 0gocgLUDBErDEB3IEWk9Gbj8GaVpwJuaJAlxAAVpKKQGYh/XyMOroPtj+OI5Svv0eiBiqMPI5KtT9
 1DFz+EMuRcl9A6uWfKekIKrJpz1mw==;
Message-Id: <1f315695593aa3000477c4265d56a3eca9482c23.1595166227.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1595166227.git.qemu_oss@crudebyte.com>
References: <cover.1595166227.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Sun, 19 Jul 2020 13:24:18 +0200
Subject: [PATCH v7 2/6] 9pfs: make v9fs_readdir_response_size() public
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>
Received-SPF: none client-ip=91.194.90.13;
 envelope-from=1f315695593aa3000477c4265d56a3eca9482c23@lizzy.crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/19 10:12:15
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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

Rename function v9fs_readdir_data_size() -> v9fs_readdir_response_size()
and make it callable from other units. So far this function is only
used by 9p.c, however subsequent patches require the function to be
callable from another 9pfs unit. And as we're at it; also make it clear
for what this function is used for.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 hw/9pfs/9p.c | 10 ++++++++--
 hw/9pfs/9p.h |  1 +
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 2ffd96ade9..7a228c4828 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -2313,7 +2313,13 @@ out_nofid:
     pdu_complete(pdu, err);
 }
 
-static size_t v9fs_readdir_data_size(V9fsString *name)
+/**
+ * Returns size required in Rreaddir response for the passed dirent @p name.
+ *
+ * @param name - directory entry's name (i.e. file name, directory name)
+ * @returns required size in bytes
+ */
+size_t v9fs_readdir_response_size(V9fsString *name)
 {
     /*
      * Size of each dirent on the wire: size of qid (13) + size of offset (8)
@@ -2348,7 +2354,7 @@ static int coroutine_fn v9fs_do_readdir(V9fsPDU *pdu, V9fsFidState *fidp,
         }
         v9fs_string_init(&name);
         v9fs_string_sprintf(&name, "%s", dent->d_name);
-        if ((count + v9fs_readdir_data_size(&name)) > max_count) {
+        if ((count + v9fs_readdir_response_size(&name)) > max_count) {
             v9fs_readdir_unlock(&fidp->fs.dir);
 
             /* Ran out of buffer. Set dir back to old position and return */
diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
index ee2271663c..561774e843 100644
--- a/hw/9pfs/9p.h
+++ b/hw/9pfs/9p.h
@@ -419,6 +419,7 @@ void v9fs_path_init(V9fsPath *path);
 void v9fs_path_free(V9fsPath *path);
 void v9fs_path_sprintf(V9fsPath *path, const char *fmt, ...);
 void v9fs_path_copy(V9fsPath *dst, const V9fsPath *src);
+size_t v9fs_readdir_response_size(V9fsString *name);
 int v9fs_name_to_path(V9fsState *s, V9fsPath *dirpath,
                       const char *name, V9fsPath *path);
 int v9fs_device_realize_common(V9fsState *s, const V9fsTransport *t,
-- 
2.20.1


