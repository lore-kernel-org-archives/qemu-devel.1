Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA3BC2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 16:43:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E44672064C
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 16:43:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gBpIkUQL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E44672064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZzPO-00076v-2v
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 11:43:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45108)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kZzNX-0005Ck-BQ
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 11:41:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31310)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kZzNT-0000us-Un
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 11:41:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604421706;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mererF9HuyYNHimsOEPiQGenYCAMq3ZydrAziKY9gY8=;
 b=gBpIkUQLqiV6LWEbcOCy2CVtuUHTQPh/jiz6aKd3jWZsGj6UADRP95bd6EwA5J6d/8erMQ
 U7F8lqrPssNrJC/Xl6y3xGDG+GM3JA9+qgL/qmWB4rHZL3gyNAYy1WZGq8Su53yJFMKvYY
 YWLYvXijWayKZRdGhw7gtnRPCOvWdyM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-cD6dB4IUO-yg3Vp-FC25XQ-1; Tue, 03 Nov 2020 11:41:45 -0500
X-MC-Unique: cD6dB4IUO-yg3Vp-FC25XQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3304010A0B80
 for <qemu-devel@nongnu.org>; Tue,  3 Nov 2020 16:41:44 +0000 (UTC)
Received: from localhost (unknown [10.40.195.44])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6938221E99;
 Tue,  3 Nov 2020 16:41:37 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.2] virtiofsd: Announce submounts even without statx()
Date: Tue,  3 Nov 2020 17:41:35 +0100
Message-Id: <20201103164135.169325-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
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
Cc: virtio-fs@redhat.com, Miklos Szeredi <mszeredi@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Contrary to what the check (and warning) in lo_init() claims, we can
announce submounts just fine even without statx() -- the check is based
on comparing both the mount ID and st_dev of parent and child.  Without
statx(), we will not have the mount ID; but we always have st_dev.

The only problems we have (without statx() and its mount ID) are:

(1) Mounting the same device twice may lead to both trees being treated
    as exactly the same tree by virtiofsd.  But that is a problem that
    is completely independent of mirroring host submounts in the guest.
    Both submount roots will still show the FUSE_SUBMOUNT flag, because
    their st_dev still differs from their respective parent.

(2) There is only one exception to (1), and that is if you mount a
    device inside a mount of itself: Then, its st_dev will be the same
    as that of its parent, and so without a mount ID, virtiofsd will not
    be able to recognize the nested mount's root as a submount.
    However, thanks to virtiofsd then treating both trees as exactly the
    same tree, it will be caught up in a loop when the guest tries to
    examine the nested submount, so the guest will always see nothing
    but an ELOOP there.  Therefore, this case is just fully broken
    without statx(), whether we check for submounts (based on st_dev) or
    not.

All in all, checking for submounts works well even without comparing the
mount ID (i.e., without statx()).  The only concern is an edge case
that, without statx() mount IDs, is utterly broken anyway.

Thus, drop said check in lo_init().

Reported-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tools/virtiofsd/passthrough_ll.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough_ll.c
index ec1008bceb..6c64b03f1a 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -610,14 +610,6 @@ static void lo_init(void *userdata, struct fuse_conn_info *conn)
                  "does not support it\n");
         lo->announce_submounts = false;
     }
-
-#ifndef CONFIG_STATX
-    if (lo->announce_submounts) {
-        fuse_log(FUSE_LOG_WARNING, "lo_init: Cannot announce submounts, there "
-                 "is no statx()\n");
-        lo->announce_submounts = false;
-    }
-#endif
 }
 
 static void lo_getattr(fuse_req_t req, fuse_ino_t ino,
-- 
2.26.2


