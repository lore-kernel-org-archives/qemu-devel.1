Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 918F1C43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 18:47:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0927F2080C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 18:47:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jiz3Rspk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0927F2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG57y-0005nQ-6p
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 14:47:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56552)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kG51j-0005jC-KU
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 14:41:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23267)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kG51h-0007Op-Qf
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 14:41:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599676860;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cH7xZq5UQALYLOlvnCkkgvSjeRQrwsY6OiBeqlB2TJc=;
 b=Jiz3RspkEPMV54ED6z1HpAS8gpgq8VoTSQWwExaZOTmBvQqPcxL3HHwKIm+K7rkFxjr3ek
 23ffFj1e9Xbp6FiL+9k97YLNdj01AXzv0MCnPGxfZdqwDhZaBffnR+8vPleWmxPxBNDNa7
 GQ/OxeKCs+Aw2P7cQYQ2RVg6JCfVLVc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195-cdIuODWMPkSFLEI5TPMPGg-1; Wed, 09 Sep 2020 14:40:57 -0400
X-MC-Unique: cdIuODWMPkSFLEI5TPMPGg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E843780EF8C
 for <qemu-devel@nongnu.org>; Wed,  9 Sep 2020 18:40:56 +0000 (UTC)
Received: from localhost (ovpn-113-94.ams2.redhat.com [10.36.113.94])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7A14219C78;
 Wed,  9 Sep 2020 18:40:56 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/8] virtiofsd: Add fuse_reply_attr_with_flags()
Date: Wed,  9 Sep 2020 20:40:24 +0200
Message-Id: <20200909184028.262297-5-mreitz@redhat.com>
In-Reply-To: <20200909184028.262297-1-mreitz@redhat.com>
References: <20200909184028.262297-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 07:20:24
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
Cc: virtio-fs@redhat.com, Miklos Szeredi <mszeredi@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The plain fuse_reply_attr() function does not allow setting
fuse_attr.flags, so add this new function that does.

Make fuse_reply_attr() a wrapper around it.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tools/virtiofsd/fuse_lowlevel.h | 15 +++++++++++++++
 tools/virtiofsd/fuse_lowlevel.c | 14 ++++++++++++--
 2 files changed, 27 insertions(+), 2 deletions(-)

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
diff --git a/tools/virtiofsd/fuse_lowlevel.c b/tools/virtiofsd/fuse_lowlevel.c
index 3ca49456c3..70efd3feaf 100644
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
-- 
2.26.2


