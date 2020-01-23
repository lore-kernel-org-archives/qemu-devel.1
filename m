Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1744CC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 14:35:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D67BC207FF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 14:35:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IEs/rO1l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D67BC207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iudaN-0006eH-CK
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 09:35:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41346)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iubAS-00041f-5X
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 07:01:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iubAR-0006JN-2d
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 07:01:00 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:33599
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iubAQ-0006Bt-Tk
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 07:00:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579780850;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S1ZZK29IBYxR/Dk9Ph6fLhiurhPZ+mhhMZJrxkegYP0=;
 b=IEs/rO1l4leAx1b8xiUKwl4cI0efVn9nBQ67kC3xOsMM4BFHImlNXaA8+EeUGw2849+/zk
 rx58OLt8cy8AUC4Jm9wUlxnLUtPv/Rg2QVNPpO6CNiJW5pN08C2rnVgxYuC7vQe0Mn1lY5
 f70g0NE2Vz63RXjOjm7og0aQaQDLy/k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-366-crsRK2CIN0OYg_OhAht-Sg-1; Thu, 23 Jan 2020 07:00:48 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0B3278018AD
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 12:00:48 +0000 (UTC)
Received: from dgilbert-t580.localhost (unknown [10.36.118.0])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 571D385754;
 Thu, 23 Jan 2020 12:00:47 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com
Subject: [PULL 082/111] virtiofsd: add helper for lo_data cleanup
Date: Thu, 23 Jan 2020 11:58:12 +0000
Message-Id: <20200123115841.138849-83-dgilbert@redhat.com>
In-Reply-To: <20200123115841.138849-1-dgilbert@redhat.com>
References: <20200123115841.138849-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: crsRK2CIN0OYg_OhAht-Sg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tools/virtiofsd/passthrough_ll.c | 37 ++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough=
_ll.c
index 056ebe8556..e8dc5c7320 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -2407,6 +2407,26 @@ static gboolean lo_key_equal(gconstpointer a, gconst=
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
+    free(lo->source);
+}
+
 int main(int argc, char *argv[])
 {
     struct fuse_args args =3D FUSE_ARGS_INIT(argc, argv);
@@ -2554,22 +2574,7 @@ err_out2:
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
-    free(lo.source);
+    fuse_lo_data_cleanup(&lo);
=20
     return ret ? 1 : 0;
 }
--=20
2.24.1


