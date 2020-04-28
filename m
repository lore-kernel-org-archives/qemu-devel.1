Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4516EC83006
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 13:27:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C569206F0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 13:27:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XTyj37/a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C569206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTQH7-0005OA-6x
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 09:27:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35176)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jTQG1-0003BV-6e
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 09:26:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jTQFz-0001nI-1t
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 09:26:40 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:27022
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jTQFy-0001mt-LY
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 09:26:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588080397;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cZLAHpoF0nFbu2Hs47YYpAqe/b62f83BB8uxlXC1y4A=;
 b=XTyj37/alB5vXrPuIlgx7/drnr5+OVT0joBuv2wEDwCk+fC4Soi3QIaeW/6z8kfFsX5yUh
 kcoUwU5rp/qxHDLJnEm80d19KqLrvRz4ymnRgUWbmEi3pOeMs6RbCOPpbluM/pBPtkxBG2
 qeB/spnBFr2aD5leagrKyYQlKcG5QaQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-wSI-PD4IOpuqWo5doSgm0w-1; Tue, 28 Apr 2020 09:26:36 -0400
X-MC-Unique: wSI-PD4IOpuqWo5doSgm0w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3D352835B41;
 Tue, 28 Apr 2020 13:26:35 +0000 (UTC)
Received: from localhost (ovpn-112-143.ams2.redhat.com [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D0BA9579A9;
 Tue, 28 Apr 2020 13:26:34 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 2/4] block: Use bdrv_make_empty() where possible
Date: Tue, 28 Apr 2020 15:26:27 +0200
Message-Id: <20200428132629.796753-3-mreitz@redhat.com>
In-Reply-To: <20200428132629.796753-1-mreitz@redhat.com>
References: <20200428132629.796753-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 02:06:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/replication.c | 6 ++----
 block/vvfat.c       | 4 +---
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/block/replication.c b/block/replication.c
index da013c2041..cc6a40d577 100644
--- a/block/replication.c
+++ b/block/replication.c
@@ -331,9 +331,8 @@ static void secondary_do_checkpoint(BDRVReplicationStat=
e *s, Error **errp)
         return;
     }
=20
-    ret =3D s->active_disk->bs->drv->bdrv_make_empty(s->active_disk->bs);
+    ret =3D bdrv_make_empty(s->active_disk, errp);
     if (ret < 0) {
-        error_setg(errp, "Cannot make active disk empty");
         return;
     }
=20
@@ -343,9 +342,8 @@ static void secondary_do_checkpoint(BDRVReplicationStat=
e *s, Error **errp)
         return;
     }
=20
-    ret =3D s->hidden_disk->bs->drv->bdrv_make_empty(s->hidden_disk->bs);
+    ret =3D bdrv_make_empty(s->hidden_disk, errp);
     if (ret < 0) {
-        error_setg(errp, "Cannot make hidden disk empty");
         return;
     }
 }
diff --git a/block/vvfat.c b/block/vvfat.c
index ab800c4887..e3020b65c8 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -2960,9 +2960,7 @@ static int do_commit(BDRVVVFATState* s)
         return ret;
     }
=20
-    if (s->qcow->bs->drv && s->qcow->bs->drv->bdrv_make_empty) {
-        s->qcow->bs->drv->bdrv_make_empty(s->qcow->bs);
-    }
+    bdrv_make_empty(s->qcow, NULL);
=20
     memset(s->used_clusters, 0, sector2cluster(s, s->sector_count));
=20
--=20
2.25.4


