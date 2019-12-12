Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB41C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 17:22:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98CCF21655
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 17:22:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XRbwEqzw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98CCF21655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifSAZ-0003OY-2J
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 12:22:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52172)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ifRVt-00064r-Bv
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:40:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ifRVs-0002Yb-CD
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:40:29 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52693
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ifRVs-0002Y6-88
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:40:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576168827;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MoT44t2XFLd9dxc6MDkYlD1+ClOZlDz4xgC7hsjItiw=;
 b=XRbwEqzwxQF1Nh6Z/y9ZEPgDsDdIJS885vfT3xsCzYj+1VZeY/KdNDdVLKcSoKzu6Qjb3E
 UXbUZfD7DiGtazuItEd5AitFwCQsdDnv+4UOs9l6a5bdJAPVIZnY9CP+JOs2sQkTOCntUT
 5NbSJrrUoMjrVvJTBPHQS7ZnOvgbau4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-191-3q9H2mm6MaGRPcfXwqUrqw-1; Thu, 12 Dec 2019 11:40:26 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 98A8B107ACC9
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 16:40:25 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-116-226.ams2.redhat.com
 [10.36.116.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7003260BF3;
 Thu, 12 Dec 2019 16:40:22 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com,
	vgoyal@redhat.com
Subject: [PATCH 048/104] virtiofsd: move to an empty network namespace
Date: Thu, 12 Dec 2019 16:38:08 +0000
Message-Id: <20191212163904.159893-49-dgilbert@redhat.com>
In-Reply-To: <20191212163904.159893-1-dgilbert@redhat.com>
References: <20191212163904.159893-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 3q9H2mm6MaGRPcfXwqUrqw-1
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

From: Stefan Hajnoczi <stefanha@redhat.com>

If the process is compromised there should be no network access.  Use an
empty network namespace to sandbox networking.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tools/virtiofsd/passthrough_ll.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough=
_ll.c
index 606824f002..135a99f2fd 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -1926,6 +1926,19 @@ static void print_capabilities(void)
     printf("}\n");
 }
=20
+/*
+ * Called after our UNIX domain sockets have been created, now we can move=
 to
+ * an empty network namespace to prevent TCP/IP and other network activity=
 in
+ * case this process is compromised.
+ */
+static void setup_net_namespace(void)
+{
+    if (unshare(CLONE_NEWNET) !=3D 0) {
+        fuse_log(FUSE_LOG_ERR, "unshare(CLONE_NEWNET): %m\n");
+        exit(1);
+    }
+}
+
 /* This magic is based on lxc's lxc_pivot_root() */
 static void setup_pivot_root(const char *source)
 {
@@ -2017,6 +2030,7 @@ static void setup_mount_namespace(const char *source)
  */
 static void setup_sandbox(struct lo_data *lo)
 {
+    setup_net_namespace();
     setup_mount_namespace(lo->source);
 }
=20
--=20
2.23.0


