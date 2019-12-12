Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7613BC00454
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 17:33:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 482C22253D
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 17:33:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RlshWapJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 482C22253D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifSLY-0001r7-J3
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 12:33:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34459)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ifRWp-0007Rf-GD
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:41:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ifRWo-0004Mp-61
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:41:27 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:32535
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ifRWo-0004Lu-2A
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:41:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576168885;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I6L7bMqv9tF9btHFzArvoc0R26mYOdLRdKMB1+xZzDM=;
 b=RlshWapJl4R2x4GNX3kuVKzqa/WMi4Xu2O8KEJ0x0l3e3LFHp3ce1wueyGJosJd5yvOuWC
 aWVVbbGaKe/1D56UBMDGiBcy7meNb/AzRdXQhVpjqSU2OPC/u6okHpJLD3N31BLTHVvjBB
 kG00fyaMMV5A96A7yHViW3P/qi4xyXo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-rPBSlcRVOP66gOowEM7bZw-1; Thu, 12 Dec 2019 11:41:24 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3F4868024CF
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 16:41:23 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-116-226.ams2.redhat.com
 [10.36.116.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6484160BE1;
 Thu, 12 Dec 2019 16:41:22 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com,
	vgoyal@redhat.com
Subject: [PATCH 084/104] Virtiofsd: fix memory leak on fuse queueinfo
Date: Thu, 12 Dec 2019 16:38:44 +0000
Message-Id: <20191212163904.159893-85-dgilbert@redhat.com>
In-Reply-To: <20191212163904.159893-1-dgilbert@redhat.com>
References: <20191212163904.159893-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: rPBSlcRVOP66gOowEM7bZw-1
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

For fuse's queueinfo, both queueinfo array and queueinfos are allocated in
fv_queue_set_started() but not cleaned up when the daemon process quits.

This fixes the leak in proper places.

Signed-off-by: Liu Bo <bo.liu@linux.alibaba.com>
Signed-off-by: Eric Ren <renzhen@linux.alibaba.com>
---
 tools/virtiofsd/fuse_virtio.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/virtiofsd/fuse_virtio.c b/tools/virtiofsd/fuse_virtio.c
index 7b22ae8d4f..a364f23d5d 100644
--- a/tools/virtiofsd/fuse_virtio.c
+++ b/tools/virtiofsd/fuse_virtio.c
@@ -671,6 +671,8 @@ static void fv_queue_set_started(VuDev *dev, int qidx, =
bool started)
         }
         close(ourqi->kill_fd);
         ourqi->kick_fd =3D -1;
+        free(vud->qi[qidx]);
+        vud->qi[qidx] =3D NULL;
     }
 }
=20
@@ -878,6 +880,13 @@ int virtio_session_mount(struct fuse_session *se)
 void virtio_session_close(struct fuse_session *se)
 {
     close(se->vu_socketfd);
+
+    if (!se->virtio_dev) {
+        return;
+    }
+
+    close(se->vu_socketfd);
+    free(se->virtio_dev->qi);
     free(se->virtio_dev);
     se->virtio_dev =3D NULL;
 }
--=20
2.23.0


