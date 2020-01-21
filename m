Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE0BC2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 12:56:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B0BC2051A
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 12:56:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OvdoFZTF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B0BC2051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itt5G-0004SH-VD
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 07:56:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51311)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1itsc9-0006qa-RA
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 07:26:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1itsc6-0002Cz-Lo
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 07:26:37 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42713
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1itsc6-0002Co-Hq
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 07:26:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579609594;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n9dF4hyv5aM2FToh7wtL+25HJTy455gud7cdpkpT+Fs=;
 b=OvdoFZTFxh8XqIN8aDy2Yam8+/qeQr1oJYG6gTqgfz4yT1Wcxb5EeyqqYmFN5M5PTHpMT7
 0VR96R/FfoFbTU4HL8393s6tz8Zg1ujcslRq9Z8rM+Km0Mw88yXevUeqarwSPd6IdskHC3
 pD6pVgbIc3DqpHmk7qLM+f1A0BLFpXE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-Mo9kXSmwNMqNf_AKLqcE3A-1; Tue, 21 Jan 2020 07:26:32 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B6542800D4E;
 Tue, 21 Jan 2020 12:26:31 +0000 (UTC)
Received: from dgilbert-t580.localhost (unknown [10.36.118.32])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 01E0560BE0;
 Tue, 21 Jan 2020 12:26:29 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, vgoyal@redhat.com,
 berrange@redhat.com, slp@redhat.com, philmd@redhat.com
Subject: [PATCH v2 025/109] virtiofsd: Keep track of replies
Date: Tue, 21 Jan 2020 12:23:09 +0000
Message-Id: <20200121122433.50803-26-dgilbert@redhat.com>
In-Reply-To: <20200121122433.50803-1-dgilbert@redhat.com>
References: <20200121122433.50803-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: Mo9kXSmwNMqNf_AKLqcE3A-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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
Cc: m.mizuma@jp.fujitsu.com, misono.tomohiro@jp.fujitsu.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Keep track of whether we sent a reply to a request; this is a bit
paranoid but it means:
  a) We should always recycle an element even if there was an error
     in the request
  b) Never try and send two replies on one queue element

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 tools/virtiofsd/fuse_virtio.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/tools/virtiofsd/fuse_virtio.c b/tools/virtiofsd/fuse_virtio.c
index 05d0e29f12..f1adeb6345 100644
--- a/tools/virtiofsd/fuse_virtio.c
+++ b/tools/virtiofsd/fuse_virtio.c
@@ -44,6 +44,7 @@ struct fv_QueueInfo {
=20
     /* The element for the command currently being processed */
     VuVirtqElement *qe;
+    bool reply_sent;
 };
=20
 /*
@@ -178,6 +179,7 @@ int virtio_send_msg(struct fuse_session *se, struct fus=
e_chan *ch,
 {
     VuVirtqElement *elem;
     VuVirtq *q;
+    int ret =3D 0;
=20
     assert(count >=3D 1);
     assert(iov[0].iov_len >=3D sizeof(struct fuse_out_header));
@@ -191,6 +193,7 @@ int virtio_send_msg(struct fuse_session *se, struct fus=
e_chan *ch,
     assert(out->unique);
     /* For virtio we always have ch */
     assert(ch);
+    assert(!ch->qi->reply_sent);
     elem =3D ch->qi->qe;
     q =3D &ch->qi->virtio_dev->dev.vq[ch->qi->qidx];
=20
@@ -208,19 +211,23 @@ int virtio_send_msg(struct fuse_session *se, struct f=
use_chan *ch,
     if (in_len < sizeof(struct fuse_out_header)) {
         fuse_log(FUSE_LOG_ERR, "%s: elem %d too short for out_header\n",
                  __func__, elem->index);
-        return -E2BIG;
+        ret =3D -E2BIG;
+        goto err;
     }
     if (in_len < tosend_len) {
         fuse_log(FUSE_LOG_ERR, "%s: elem %d too small for data len %zd\n",
                  __func__, elem->index, tosend_len);
-        return -E2BIG;
+        ret =3D -E2BIG;
+        goto err;
     }
=20
     copy_iov(iov, count, in_sg, in_num, tosend_len);
     vu_queue_push(&se->virtio_dev->dev, q, elem, tosend_len);
     vu_queue_notify(&se->virtio_dev->dev, q);
+    ch->qi->reply_sent =3D true;
=20
-    return 0;
+err:
+    return ret;
 }
=20
 /* Thread function for individual queues, created when a queue is 'started=
' */
@@ -296,6 +303,9 @@ static void *fv_queue_thread(void *opaque)
                 break;
             }
=20
+            qi->qe =3D elem;
+            qi->reply_sent =3D false;
+
             if (!fbuf.mem) {
                 fbuf.mem =3D malloc(se->bufsize);
                 assert(fbuf.mem);
@@ -331,6 +341,13 @@ static void *fv_queue_thread(void *opaque)
             /* TODO: Add checks for fuse_session_exited */
             fuse_session_process_buf_int(se, &fbuf, &ch);
=20
+            if (!qi->reply_sent) {
+                fuse_log(FUSE_LOG_DEBUG, "%s: elem %d no reply sent\n",
+                         __func__, elem->index);
+                /* I think we've still got to recycle the element */
+                vu_queue_push(dev, q, elem, 0);
+                vu_queue_notify(dev, q);
+            }
             qi->qe =3D NULL;
             free(elem);
             elem =3D NULL;
--=20
2.24.1


