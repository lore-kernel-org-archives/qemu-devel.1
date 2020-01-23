Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA41C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 19:39:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 195A721D7D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 19:39:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RkHMhcxo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 195A721D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60299 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuiKF-0004FC-9E
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 14:39:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42298)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iufee-0005oR-4i
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 11:48:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iufed-0007sf-01
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 11:48:27 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20533
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iufec-0007rw-TF
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 11:48:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579798106;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9Ag3bA9drcPsvhX304WkuYWjUv9J8GidGhbfQwwmjG0=;
 b=RkHMhcxoeDhbF2xciE9KIBgCjvjjDuXjwcjfjIvcbudJECADAqO7XzZgW1hxhmQpz5yG7t
 KbWqiUGzB59PO6Huf05AGpmhEACXbveX0gHnZwOvqZl9CzKe1TyQf9qyyxWcvVRcq8wHH5
 x0xci8bcTDiNBvb50rs6Y7ajtpF9oV4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194-dtUAvXKCNb67Xnzaj19NiA-1; Thu, 23 Jan 2020 11:48:24 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D55A6190D357
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 16:48:23 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-116-110.ams2.redhat.com
 [10.36.116.110])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2ED0628993;
 Thu, 23 Jan 2020 16:48:23 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com
Subject: [PULL 082/108] virtiofsd: enable PARALLEL_DIROPS during INIT
Date: Thu, 23 Jan 2020 16:46:04 +0000
Message-Id: <20200123164630.91498-83-dgilbert@redhat.com>
In-Reply-To: <20200123164630.91498-1-dgilbert@redhat.com>
References: <20200123164630.91498-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: dtUAvXKCNb67Xnzaj19NiA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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

From: Liu Bo <bo.liu@linux.alibaba.com>

lookup is a RO operations, PARALLEL_DIROPS can be enabled.

Signed-off-by: Liu Bo <bo.liu@linux.alibaba.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tools/virtiofsd/fuse_lowlevel.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/virtiofsd/fuse_lowlevel.c b/tools/virtiofsd/fuse_lowleve=
l.c
index aac282f278..70568d22a4 100644
--- a/tools/virtiofsd/fuse_lowlevel.c
+++ b/tools/virtiofsd/fuse_lowlevel.c
@@ -2062,6 +2062,9 @@ static void do_init(fuse_req_t req, fuse_ino_t nodeid=
,
     if (se->conn.want & FUSE_CAP_ASYNC_READ) {
         outarg.flags |=3D FUSE_ASYNC_READ;
     }
+    if (se->conn.want & FUSE_CAP_PARALLEL_DIROPS) {
+        outarg.flags |=3D FUSE_PARALLEL_DIROPS;
+    }
     if (se->conn.want & FUSE_CAP_POSIX_LOCKS) {
         outarg.flags |=3D FUSE_POSIX_LOCKS;
     }
--=20
2.24.1


