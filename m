Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC64C2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 14:02:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3362021569
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 14:02:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VoeCqGp1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3362021569
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itu74-000416-0q
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 09:02:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52655)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1itshC-0002za-TV
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 07:31:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1itsh8-0004eO-JK
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 07:31:50 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44955
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1itsh8-0004eG-FZ
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 07:31:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579609906;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EelNPo7oaGzq9Vcc5rnMRqCAK39taXFuie982T6uv/Q=;
 b=VoeCqGp1C5UFFgFDCCeQqPeT/Gv+tqISpTX7sQXli4HTAjh7nZIRfzLaCFmPLIm0sDqjgY
 EqKQBTE14Cp6BvYNUvnk2nmToF788WKqP+0f4rSBUML7OQdaS5SoCm8OkdqLgjWMwJZp3U
 Z8Tixt+KD9M6+fBSutoTGdf7no36wSQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-314-CKIU2QMnNv2or-ScyywIRg-1; Tue, 21 Jan 2020 07:31:44 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 697531083E81;
 Tue, 21 Jan 2020 12:31:43 +0000 (UTC)
Received: from dgilbert-t580.localhost (unknown [10.36.118.32])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9B82060BE0;
 Tue, 21 Jan 2020 12:31:35 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, vgoyal@redhat.com,
 berrange@redhat.com, slp@redhat.com, philmd@redhat.com
Subject: [PATCH v2 085/109] Virtiofsd: fix memory leak on fuse queueinfo
Date: Tue, 21 Jan 2020 12:24:09 +0000
Message-Id: <20200121122433.50803-86-dgilbert@redhat.com>
In-Reply-To: <20200121122433.50803-1-dgilbert@redhat.com>
References: <20200121122433.50803-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: CKIU2QMnNv2or-ScyywIRg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: m.mizuma@jp.fujitsu.com, misono.tomohiro@jp.fujitsu.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Liu Bo <bo.liu@linux.alibaba.com>

For fuse's queueinfo, both queueinfo array and queueinfos are allocated in
fv_queue_set_started() but not cleaned up when the daemon process quits.

This fixes the leak in proper places.

Signed-off-by: Liu Bo <bo.liu@linux.alibaba.com>
Signed-off-by: Eric Ren <renzhen@linux.alibaba.com>
Reviewed-by: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
---
 tools/virtiofsd/fuse_virtio.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/virtiofsd/fuse_virtio.c b/tools/virtiofsd/fuse_virtio.c
index b7948def27..fb8d6d1379 100644
--- a/tools/virtiofsd/fuse_virtio.c
+++ b/tools/virtiofsd/fuse_virtio.c
@@ -625,6 +625,8 @@ static void fv_queue_cleanup_thread(struct fv_VuDev *vu=
d, int qidx)
     }
     close(ourqi->kill_fd);
     ourqi->kick_fd =3D -1;
+    free(vud->qi[qidx]);
+    vud->qi[qidx] =3D NULL;
 }
=20
 /* Callback from libvhost-user on start or stop of a queue */
@@ -884,6 +886,12 @@ int virtio_session_mount(struct fuse_session *se)
 void virtio_session_close(struct fuse_session *se)
 {
     close(se->vu_socketfd);
+
+    if (!se->virtio_dev) {
+        return;
+    }
+
+    free(se->virtio_dev->qi);
     free(se->virtio_dev);
     se->virtio_dev =3D NULL;
 }
--=20
2.24.1


