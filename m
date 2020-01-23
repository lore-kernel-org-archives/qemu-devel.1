Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3777C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 14:46:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 721A72073A
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 14:46:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JT86/FUX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 721A72073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iudkB-0004FT-Uu
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 09:46:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41651)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iubAf-0004ED-Ps
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 07:01:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iubAd-0006Yx-Nw
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 07:01:13 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60545
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iubAb-0006WV-Um
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 07:01:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579780868;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5oYlmc2Il84lqScujTc5YeXrb+18UGXFy3QmjmDZgzc=;
 b=JT86/FUXqZOv/pqM0ZmajxqGcfoa3STmvsjp55UqComr07gPxGiHTLrY9wXVlAkpoSeKPH
 4XF2k6+9w5X4t8bhrJzavALx+hHfoQhYQ8RBYkQn2r4nMkL0wAZuP/g1Yq832WPhAVTSkJ
 lc/v2IkcMyNEh469Tg3iqNVBN15N/0Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-eqWe058ANsyI1I6Q2cWiXA-1; Thu, 23 Jan 2020 07:01:06 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 89E1310120A6
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 12:01:05 +0000 (UTC)
Received: from dgilbert-t580.localhost (unknown [10.36.118.0])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CE83985754;
 Thu, 23 Jan 2020 12:01:04 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com
Subject: [PULL 097/111] virtiofsd: do not always set FUSE_FLOCK_LOCKS
Date: Thu, 23 Jan 2020 11:58:27 +0000
Message-Id: <20200123115841.138849-98-dgilbert@redhat.com>
In-Reply-To: <20200123115841.138849-1-dgilbert@redhat.com>
References: <20200123115841.138849-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: eqWe058ANsyI1I6Q2cWiXA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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


