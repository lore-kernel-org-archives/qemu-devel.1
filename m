Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B513C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 18:49:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E2522085B
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 18:49:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LXTw8R3E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E2522085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX7Yy-0007Nm-DA
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 14:49:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45908)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kX7TY-0002VX-VK
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 14:44:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54345)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kX7TX-0003bx-5j
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 14:44:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603737850;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9WnPidNZf2WIjQofTQwiF/zzMUkJuS27GfPuWC1YHJQ=;
 b=LXTw8R3EjeMHhg+K+L3TI+cZAFF0WoCOJNGKsjoaGAjleITFEY7fPeBn8WUX1ZxILIqGi+
 8FfcSRoNnAPsk/3UybljyKneno0xVQJjRlpH6tPy+PQv60XXJoTBbByFPv8V+3inaQK6yH
 L0CFuORIZo3jjUFKK9c7kyM8P8BoM14=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-569-MI5T9TsVM_2NM5iw4Jl6AQ-1; Mon, 26 Oct 2020 14:44:07 -0400
X-MC-Unique: MI5T9TsVM_2NM5iw4Jl6AQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7675E64087;
 Mon, 26 Oct 2020 18:44:06 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-112-208.ams2.redhat.com
 [10.36.112.208])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 210065D9CA;
 Mon, 26 Oct 2020 18:44:04 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, mreitz@redhat.com,
 misono.tomohiro@jp.fujitsu.com
Subject: [PULL 11/16] virtiofsd: Add attr_flags to fuse_entry_param
Date: Mon, 26 Oct 2020 18:43:26 +0000
Message-Id: <20201026184331.272953-12-dgilbert@redhat.com>
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
Received-SPF: pass client-ip=216.205.24.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 02:39:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

fuse_entry_param is converted to fuse_attr on the line (by
fill_entry()), so it should have a member that mirrors fuse_attr.flags.

fill_entry() should then copy this fuse_entry_param.attr_flags to
fuse_attr.flags.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-Id: <20200909184028.262297-4-mreitz@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tools/virtiofsd/fuse_lowlevel.c | 13 +++++++++----
 tools/virtiofsd/fuse_lowlevel.h |  5 +++++
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/tools/virtiofsd/fuse_lowlevel.c b/tools/virtiofsd/fuse_lowlevel.c
index 8679594255..00da84432c 100644
--- a/tools/virtiofsd/fuse_lowlevel.c
+++ b/tools/virtiofsd/fuse_lowlevel.c
@@ -329,7 +329,8 @@ static unsigned int calc_timeout_nsec(double t)
     }
 }
 
-static void fill_entry(struct fuse_entry_out *arg,
+static void fill_entry(struct fuse_session *se,
+                       struct fuse_entry_out *arg,
                        const struct fuse_entry_param *e)
 {
     *arg = (struct fuse_entry_out){
@@ -341,6 +342,10 @@ static void fill_entry(struct fuse_entry_out *arg,
         .attr_valid_nsec = calc_timeout_nsec(e->attr_timeout),
     };
     convert_stat(&e->attr, &arg->attr);
+
+    if (se->conn.capable & FUSE_CAP_ATTR_FLAGS) {
+        arg->attr.flags = e->attr_flags;
+    }
 }
 
 /*
@@ -365,7 +370,7 @@ size_t fuse_add_direntry_plus(fuse_req_t req, char *buf, size_t bufsize,
 
     struct fuse_direntplus *dp = (struct fuse_direntplus *)buf;
     memset(&dp->entry_out, 0, sizeof(dp->entry_out));
-    fill_entry(&dp->entry_out, e);
+    fill_entry(req->se, &dp->entry_out, e);
 
     struct fuse_dirent *dirent = &dp->dirent;
     *dirent = (struct fuse_dirent){
@@ -403,7 +408,7 @@ int fuse_reply_entry(fuse_req_t req, const struct fuse_entry_param *e)
     size_t size = sizeof(arg);
 
     memset(&arg, 0, sizeof(arg));
-    fill_entry(&arg, e);
+    fill_entry(req->se, &arg, e);
     return send_reply_ok(req, &arg, size);
 }
 
@@ -416,7 +421,7 @@ int fuse_reply_create(fuse_req_t req, const struct fuse_entry_param *e,
     struct fuse_open_out *oarg = (struct fuse_open_out *)(buf + entrysize);
 
     memset(buf, 0, sizeof(buf));
-    fill_entry(earg, e);
+    fill_entry(req->se, earg, e);
     fill_open(oarg, f);
     return send_reply_ok(req, buf, entrysize + sizeof(struct fuse_open_out));
 }
diff --git a/tools/virtiofsd/fuse_lowlevel.h b/tools/virtiofsd/fuse_lowlevel.h
index 562fd5241e..9c06240f9e 100644
--- a/tools/virtiofsd/fuse_lowlevel.h
+++ b/tools/virtiofsd/fuse_lowlevel.h
@@ -102,6 +102,11 @@ struct fuse_entry_param {
      *  large value.
      */
     double entry_timeout;
+
+    /**
+     * Flags for fuse_attr.flags that do not fit into attr.
+     */
+    uint32_t attr_flags;
 };
 
 /**
-- 
2.28.0


