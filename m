Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A516C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 18:04:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2EDA20663
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 18:04:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dHISGmYl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2EDA20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifSpR-00022z-Qv
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 13:04:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36774)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ifRX0-0007lQ-IT
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:41:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ifRWz-0004mm-Fr
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:41:38 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40708
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ifRWz-0004mC-BL
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:41:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576168897;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XdFMhPXLxEG/2BovVQr6Ct1a0mroXMy68XMoJZB1WZU=;
 b=dHISGmYlEeuSGty78WmeqnFiaYt/douhPRHV9pZDRfooJMQjXp1M28wZtHRIp4LAsk0jcx
 C6288JjJrcQnQq579jmYiYbwUH1M0u2KnmUW43GDlX38Qcv4XO6wIPPjYSUHdoJM3BvnOU
 FaJhNeWmHI6jvorLBgJJXwbuWuPIKEA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-Csl0h2EZNY-zZ9V3wB0BmA-1; Thu, 12 Dec 2019 11:41:35 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A92F112D65BB
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 16:41:34 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-116-226.ams2.redhat.com
 [10.36.116.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D1A1960BE1;
 Thu, 12 Dec 2019 16:41:33 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com,
	vgoyal@redhat.com
Subject: [PATCH 094/104] virtiofsd: do not always set FUSE_FLOCK_LOCKS
Date: Thu, 12 Dec 2019 16:38:54 +0000
Message-Id: <20191212163904.159893-95-dgilbert@redhat.com>
In-Reply-To: <20191212163904.159893-1-dgilbert@redhat.com>
References: <20191212163904.159893-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: Csl0h2EZNY-zZ9V3wB0BmA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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

From: Peng Tao <tao.peng@linux.alibaba.com>

Right now we always enable it regardless of given commandlines.
Fix it by setting the flag relying on the lo->flock bit.

Signed-off-by: Peng Tao <tao.peng@linux.alibaba.com>
---
 tools/virtiofsd/passthrough_ll.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough=
_ll.c
index 8f4ab8351c..cf6b548eee 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -548,9 +548,14 @@ static void lo_init(void *userdata, struct fuse_conn_i=
nfo *conn)
         fuse_log(FUSE_LOG_DEBUG, "lo_init: activating writeback\n");
         conn->want |=3D FUSE_CAP_WRITEBACK_CACHE;
     }
-    if (lo->flock && conn->capable & FUSE_CAP_FLOCK_LOCKS) {
-        fuse_log(FUSE_LOG_DEBUG, "lo_init: activating flock locks\n");
-        conn->want |=3D FUSE_CAP_FLOCK_LOCKS;
+    if (conn->capable & FUSE_CAP_FLOCK_LOCKS) {
+        if (lo->flock) {
+            fuse_log(FUSE_LOG_DEBUG, "lo_init: activating flock locks\n");
+            conn->want |=3D FUSE_CAP_FLOCK_LOCKS;
+        } else {
+            fuse_log(FUSE_LOG_DEBUG, "lo_init: disabling flock locks\n");
+            conn->want &=3D ~FUSE_CAP_FLOCK_LOCKS;
+        }
     }
=20
     if (conn->capable & FUSE_CAP_POSIX_LOCKS) {
--=20
2.23.0


