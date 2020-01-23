Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ABB1C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 13:48:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53EA720661
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 13:48:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GzkQBQxz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53EA720661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iucqA-0003Ax-Md
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 08:48:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41491)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iubAW-00046T-0A
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 07:01:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iubAU-0006Pq-Ou
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 07:01:03 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25412
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iubAU-0006PL-LC
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 07:01:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579780862;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H+lsqLvEJ0+MjVyMcNzat6sKkhsnsZbPamB7jAxb+Nw=;
 b=GzkQBQxzhz8z5A76F25MVK0vE18CYUVt7H//Z5QevGjQ4mntjoAFwhMQKJBA3Pi5Ws7JrP
 h7lEUrqQ7UEF1hxRa79YUleDXl2R6FnGdEv8gjIiMmMnFrHh00tV/hTEwazuHIGpghQ2Oi
 4YBR/jv5QEFKCcwFaNL1kaQt/koVSZ0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-221-4AmW8YgDOTq8MGX8ZCXBXg-1; Thu, 23 Jan 2020 07:00:59 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6153318A6ED2
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 12:00:58 +0000 (UTC)
Received: from dgilbert-t580.localhost (unknown [10.36.118.0])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AF25385750;
 Thu, 23 Jan 2020 12:00:57 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com
Subject: [PULL 090/111] virtiofsd: make lo_release() atomic
Date: Thu, 23 Jan 2020 11:58:20 +0000
Message-Id: <20200123115841.138849-91-dgilbert@redhat.com>
In-Reply-To: <20200123115841.138849-1-dgilbert@redhat.com>
References: <20200123115841.138849-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 4AmW8YgDOTq8MGX8ZCXBXg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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

From: Stefan Hajnoczi <stefanha@redhat.com>

Hold the lock across both lo_map_get() and lo_map_remove() to prevent
races between two FUSE_RELEASE requests.  In this case I don't see a
serious bug but it's safer to do things atomically.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tools/virtiofsd/passthrough_ll.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough=
_ll.c
index 9414935b52..690edbc4c5 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -1772,14 +1772,18 @@ static void lo_release(fuse_req_t req, fuse_ino_t i=
no,
                        struct fuse_file_info *fi)
 {
     struct lo_data *lo =3D lo_data(req);
-    int fd;
+    struct lo_map_elem *elem;
+    int fd =3D -1;
=20
     (void)ino;
=20
-    fd =3D lo_fi_fd(req, fi);
-
     pthread_mutex_lock(&lo->mutex);
-    lo_map_remove(&lo->fd_map, fi->fh);
+    elem =3D lo_map_get(&lo->fd_map, fi->fh);
+    if (elem) {
+        fd =3D elem->fd;
+        elem =3D NULL;
+        lo_map_remove(&lo->fd_map, fi->fh);
+    }
     pthread_mutex_unlock(&lo->mutex);
=20
     close(fd);
--=20
2.24.1


