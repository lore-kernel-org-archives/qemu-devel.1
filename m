Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD91C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 17:57:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61BA2206DA
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 17:57:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M12TjxnH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61BA2206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifSi2-0000aF-Rm
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 12:57:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34353)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ifRWp-0007Qi-0w
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:41:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ifRWn-0004MD-SM
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:41:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23671
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ifRWn-0004KM-NW
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:41:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576168885;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C8lyShB29uQFu/CYQXLoMAOxPDmq6c9mSn6F5RCnDzw=;
 b=M12TjxnHRaVdMU9+ln+QOLzoBNg6e2JAsLwyZzlbe2D42qsuL/WzXAmBhREEPaWF/epuVc
 gao1zBOV3umHslPbRS4F+omWaNVZgF2Ibzx8wOBR7TPie77YSYS2NXdRRY8sCVYqKaJcNx
 PIABsL9iPGyv341hL6Y2oo1wy+6Noe4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-e_VFj6LyNV-lI2X3yEDTpw-1; Thu, 12 Dec 2019 11:41:21 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EB534DBB0
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 16:41:20 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-116-226.ams2.redhat.com
 [10.36.116.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9656660BF3;
 Thu, 12 Dec 2019 16:41:17 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com,
	vgoyal@redhat.com
Subject: [PATCH 082/104] virtiofsd: enable PARALLEL_DIROPS during INIT
Date: Thu, 12 Dec 2019 16:38:42 +0000
Message-Id: <20191212163904.159893-83-dgilbert@redhat.com>
In-Reply-To: <20191212163904.159893-1-dgilbert@redhat.com>
References: <20191212163904.159893-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: e_VFj6LyNV-lI2X3yEDTpw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
---
 tools/virtiofsd/fuse_lowlevel.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/virtiofsd/fuse_lowlevel.c b/tools/virtiofsd/fuse_lowleve=
l.c
index b1ff684de9..4b5fe1d7a1 100644
--- a/tools/virtiofsd/fuse_lowlevel.c
+++ b/tools/virtiofsd/fuse_lowlevel.c
@@ -2064,6 +2064,9 @@ static void do_init(fuse_req_t req, fuse_ino_t nodeid=
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
2.23.0


