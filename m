Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B217C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 20:10:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 046E221D7E
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 20:10:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GUMS4sQw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 046E221D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuioG-0008AH-5M
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 15:10:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42559)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iufew-00067C-88
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 11:48:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iufeu-00006K-R8
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 11:48:46 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23240
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iufeu-00005q-OB
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 11:48:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579798124;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5oYlmc2Il84lqScujTc5YeXrb+18UGXFy3QmjmDZgzc=;
 b=GUMS4sQwNQYmm7kSHuXSMy4oX8kzbltWRN3+eGFF2tVJiAhmYvYtTEkmeGg4ZsseC6sWtF
 +wF8+IvuiSUMrMGLVxXD7hELYuNvjz+ET0hT5unlJnS1pnBwgzWiTUX7V3BaEYJ75vL9iM
 mS+4mwl7nNPMKpXHnNr8PHa5S4TewBI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-322-4yYFpDIDPNupAuei8A2ubA-1; Thu, 23 Jan 2020 11:48:40 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E412692786
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 16:48:39 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-116-110.ams2.redhat.com
 [10.36.116.110])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3E48428991;
 Thu, 23 Jan 2020 16:48:39 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com
Subject: [PULL 094/108] virtiofsd: do not always set FUSE_FLOCK_LOCKS
Date: Thu, 23 Jan 2020 16:46:16 +0000
Message-Id: <20200123164630.91498-95-dgilbert@redhat.com>
In-Reply-To: <20200123164630.91498-1-dgilbert@redhat.com>
References: <20200123164630.91498-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 4yYFpDIDPNupAuei8A2ubA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Reviewed-by: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
Reviewed-by: Sergio Lopez <slp@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tools/virtiofsd/passthrough_ll.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough=
_ll.c
index ab1613586e..ccbbec18b0 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -546,9 +546,14 @@ static void lo_init(void *userdata, struct fuse_conn_i=
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
2.24.1


