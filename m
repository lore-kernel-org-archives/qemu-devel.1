Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E70B2C5517A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 18:58:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 543132085B
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 18:58:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CnTu78Wr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 543132085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX7h2-0000WC-AV
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 14:58:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45970)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kX7Td-0002jK-TY
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 14:44:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26566)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kX7Ta-0003cY-FX
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 14:44:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603737853;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mm6Tj7lkIwSgB7XZCF/5J0XlTgQktMlJMB87joXdMPs=;
 b=CnTu78WrcuuR47u1gi+XTfD/3GwKLsc4vNqetGUJMji8WXzeUvuQINisLlnHAvyD77krGR
 RYzLFlbUsuqfi8QJybMM6H3ydisviyOhHf0mP8VOrSHNdxo1UQatWC83oewVNpA6x/HghE
 hAbqsYznk7MKIP5+c9SloYlJ5XZA6uA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-sqbngvIgPfuoY1zs1vk2wg-1; Mon, 26 Oct 2020 14:44:09 -0400
X-MC-Unique: sqbngvIgPfuoY1zs1vk2wg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2AE2D1009E2D;
 Mon, 26 Oct 2020 18:44:08 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-112-208.ams2.redhat.com
 [10.36.112.208])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C4F305D9CA;
 Mon, 26 Oct 2020 18:44:06 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, mreitz@redhat.com,
 misono.tomohiro@jp.fujitsu.com
Subject: [PULL 12/16] virtiofsd: Add fuse_reply_attr_with_flags()
Date: Mon, 26 Oct 2020 18:43:27 +0000
Message-Id: <20201026184331.272953-13-dgilbert@redhat.com>
In-Reply-To: <20201026184331.272953-1-dgilbert@redhat.com>
References: <20201026184331.272953-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/25 21:03:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: virtio-fs@redhat.com, vgoyal@Redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Max Reitz <mreitz@redhat.com>

The plain fuse_reply_attr() function does not allow setting
fuse_attr.flags, so add this new function that does.

Make fuse_reply_attr() a wrapper around it.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-Id: <20200909184028.262297-5-mreitz@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tools/virtiofsd/fuse_lowlevel.c | 14 ++++++++++++--
 tools/virtiofsd/fuse_lowlevel.h | 15 +++++++++++++++
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/tools/virtiofsd/fuse_lowlevel.c b/tools/virtiofsd/fuse_lowlevel.c
index 00da84432c..5198f627bc 100644
--- a/tools/virtiofsd/fuse_lowlevel.c
+++ b/tools/virtiofsd/fuse_lowlevel.c
@@ -426,8 +426,8 @@ int fuse_reply_create(fuse_req_t req, const struct fuse_entry_param *e,
     return send_reply_ok(req, buf, entrysize + sizeof(struct fuse_open_out));
 }
 
-int fuse_reply_attr(fuse_req_t req, const struct stat *attr,
-                    double attr_timeout)
+int fuse_reply_attr_with_flags(fuse_req_t req, const struct stat *attr,
+                               double attr_timeout, uint32_t attr_flags)
 {
     struct fuse_attr_out arg;
     size_t size = sizeof(arg);
@@ -437,9 +437,19 @@ int fuse_reply_attr(fuse_req_t req, const struct stat *attr,
     arg.attr_valid_nsec = calc_timeout_nsec(attr_timeout);
     convert_stat(attr, &arg.attr);
 
+    if (req->se->conn.capable & FUSE_CAP_ATTR_FLAGS) {
+        arg.attr.flags = attr_flags;
+    }
+
     return send_reply_ok(req, &arg, size);
 }
 
+int fuse_reply_attr(fuse_req_t req, const struct stat *attr,
+                    double attr_timeout)
+{
+    return fuse_reply_attr_with_flags(req, attr, attr_timeout, 0);
+}
+
 int fuse_reply_readlink(fuse_req_t req, const char *linkname)
 {
     return send_reply_ok(req, linkname, strlen(linkname));
diff --git a/tools/virtiofsd/fuse_lowlevel.h b/tools/virtiofsd/fuse_lowlevel.h
index 9c06240f9e..1ff6ba1e4f 100644
--- a/tools/virtiofsd/fuse_lowlevel.h
+++ b/tools/virtiofsd/fuse_lowlevel.h
@@ -1313,6 +1313,21 @@ int fuse_reply_create(fuse_req_t req, const struct fuse_entry_param *e,
 int fuse_reply_attr(fuse_req_t req, const struct stat *attr,
                     double attr_timeout);
 
+/**
+ * Reply with attributes and set fuse_attr.flags
+ *
+ * Possible requests:
+ *   getattr, setattr
+ *
+ * @param req request handle
+ * @param attr the attributes
+ * @param attr_timeout validity timeout (in seconds) for the attributes
+ * @param attr_flags flags to put into fuse_attr.flags
+ * @return zero for success, -errno for failure to send reply
+ */
+int fuse_reply_attr_with_flags(fuse_req_t req, const struct stat *attr,
+                               double attr_timeout, uint32_t attr_flags);
+
 /**
  * Reply with the contents of a symbolic link
  *
-- 
2.28.0


