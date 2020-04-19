Return-Path: <SRS0=RqUc=6D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5384C38A30
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Apr 2020 16:22:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48B5C21973
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Apr 2020 16:22:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="gPNjdc3H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48B5C21973
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQCi3-0000lM-B2
	for qemu-devel@archiver.kernel.org; Sun, 19 Apr 2020 12:22:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40998 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <61e983e1855045ddc8c2418f87d7a096bdb72e53@lizzy.crudebyte.com>)
 id 1jQChK-0000Hn-Im
 for qemu-devel@nongnu.org; Sun, 19 Apr 2020 12:21:34 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <61e983e1855045ddc8c2418f87d7a096bdb72e53@lizzy.crudebyte.com>)
 id 1jQChI-0007us-QU
 for qemu-devel@nongnu.org; Sun, 19 Apr 2020 12:21:33 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:56377)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <61e983e1855045ddc8c2418f87d7a096bdb72e53@lizzy.crudebyte.com>)
 id 1jQChI-0006xu-1q
 for qemu-devel@nongnu.org; Sun, 19 Apr 2020 12:21:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=gC4AlObwl8Flida0/OUpjkhyIUUJyBjEp1XM5rPjBNk=; b=gPNjd
 c3HkbtRZ3irVNo7VLPERaGmX/Cm2ARM4fx5sEpkPVm2FligDumB53QATPwDKmWqXds+1yIKJrrBDj
 uH7Rc/fBsXo6bqg3vm+HwqXcMlBRI5eReMxyOj0SuZJOpjsUjzaEJx5ycI5Q0ubhp0SqytWoVnc3g
 ODaC0ZtrnFzMc4+/i26q1Neuqwn6fQq9c0+KcpOcd47B40ndg4CTgRC8rzMF/tiWHEXWD6wRXc8Wl
 M+QQqk/uB8LiTmawd1Bkzuwp25IKwxzQ/sjwuJvG1rNKghOVV5laIjmud5C3TFEV+6bNeIm+unWmo
 ZLj8Wcrz1/t4E7hcSjphnO/3kvkNw==;
Message-Id: <61e983e1855045ddc8c2418f87d7a096bdb72e53.1587309014.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1587309014.git.qemu_oss@crudebyte.com>
References: <cover.1587309014.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Sun, 19 Apr 2020 17:00:59 +0200
Subject: [PATCH v6 2/5] 9pfs: make v9fs_readdir_response_size() public
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>
Received-SPF: none client-ip=91.194.90.13;
 envelope-from=61e983e1855045ddc8c2418f87d7a096bdb72e53@lizzy.crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs1p.gnu.org: Linux 3.11 and newer
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
index 9e046f7acb..43584aca41 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -2322,7 +2322,13 @@ out_nofid:
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
@@ -2357,7 +2363,7 @@ static int coroutine_fn v9fs_do_readdir(V9fsPDU *pdu, V9fsFidState *fidp,
         }
         v9fs_string_init(&name);
         v9fs_string_sprintf(&name, "%s", dent->d_name);
-        if ((count + v9fs_readdir_data_size(&name)) > max_count) {
+        if ((count + v9fs_readdir_response_size(&name)) > max_count) {
             v9fs_readdir_unlock(&fidp->fs.dir);
 
             /* Ran out of buffer. Set dir back to old position and return */
diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
index b8f72a3bd9..9553700dbb 100644
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


