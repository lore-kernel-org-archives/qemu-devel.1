Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD86C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 17:49:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F21F2067C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 17:49:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QorjUiOl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F21F2067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifSaC-0003MX-HU
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 12:49:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33809)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ifRWl-0007Md-6Q
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:41:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ifRWk-0004GM-4U
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:41:23 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:34953
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ifRWj-0004Bw-CH
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:41:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576168878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MO0JUCvEhNIW0+CT1Aubw4GeSXzXXTU2isMDQwULkMI=;
 b=QorjUiOlOs5KZ+BJdrKUAilAQhzO4PA07uCCQSjI/RJDxaTGBvpe7xpwsJwyHW0v0i23x1
 ufLJNnGHl9dEr5sYV7CjxitrZ8/RfY1TzQvscJpgMbcPnt6cWoicGV7YMRhPihDzw/orLT
 4PZLTcKbKVAGSQZhmbJx3vfwUpy0SP8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281---LHuHg6PiGA6B-yQQ9R3Q-1; Thu, 12 Dec 2019 11:41:17 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2AC5D189DF4D
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 16:41:16 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-116-226.ams2.redhat.com
 [10.36.116.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4DAAE60BF3;
 Thu, 12 Dec 2019 16:41:15 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com,
	vgoyal@redhat.com
Subject: [PATCH 080/104] virtiofsd: add helper for lo_data cleanup
Date: Thu, 12 Dec 2019 16:38:40 +0000
Message-Id: <20191212163904.159893-81-dgilbert@redhat.com>
In-Reply-To: <20191212163904.159893-1-dgilbert@redhat.com>
References: <20191212163904.159893-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: --LHuHg6PiGA6B-yQQ9R3Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

From: Liu Bo <bo.liu@linux.alibaba.com>

This offers an helper function for lo_data's cleanup.

Signed-off-by: Liu Bo <bo.liu@linux.alibaba.com>
---
 tools/virtiofsd/passthrough_ll.c | 37 ++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough=
_ll.c
index 45cf466178..097033aa00 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -2439,6 +2439,26 @@ static gboolean lo_key_equal(gconstpointer a, gconst=
pointer b)
     return la->ino =3D=3D lb->ino && la->dev =3D=3D lb->dev;
 }
=20
+static void fuse_lo_data_cleanup(struct lo_data *lo)
+{
+    if (lo->inodes) {
+        g_hash_table_destroy(lo->inodes);
+    }
+    lo_map_destroy(&lo->fd_map);
+    lo_map_destroy(&lo->dirp_map);
+    lo_map_destroy(&lo->ino_map);
+
+    if (lo->proc_self_fd >=3D 0) {
+        close(lo->proc_self_fd);
+    }
+
+    if (lo->root.fd >=3D 0) {
+        close(lo->root.fd);
+    }
+
+    free((char *)lo->source);
+}
+
 int main(int argc, char *argv[])
 {
     struct fuse_args args =3D FUSE_ARGS_INIT(argc, argv);
@@ -2594,22 +2614,7 @@ err_out2:
 err_out1:
     fuse_opt_free_args(&args);
=20
-    if (lo.inodes) {
-        g_hash_table_destroy(lo.inodes);
-    }
-    lo_map_destroy(&lo.fd_map);
-    lo_map_destroy(&lo.dirp_map);
-    lo_map_destroy(&lo.ino_map);
-
-    if (lo.proc_self_fd >=3D 0) {
-        close(lo.proc_self_fd);
-    }
-
-    if (lo.root.fd >=3D 0) {
-        close(lo.root.fd);
-    }
-
-    free((char *)lo.source);
+    fuse_lo_data_cleanup(&lo);
=20
     return ret ? 1 : 0;
 }
--=20
2.23.0


