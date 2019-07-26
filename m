Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E89FC7618B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 09:11:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 143E42238C
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 09:11:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 143E42238C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqwGW-0005tq-AO
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 05:11:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60565)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@redhat.com>) id 1hqwGA-0004b4-9U
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 05:11:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1hqwG8-0004zO-3w
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 05:11:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36978)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1hqwG7-0004sb-T2
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 05:11:28 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3E4508665A
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 09:11:26 +0000 (UTC)
Received: from localhost (ovpn-117-212.ams2.redhat.com [10.36.117.212])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C6D211001938;
 Fri, 26 Jul 2019 09:11:25 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: virtio-fs@redhat.com,
	qemu-devel@nongnu.org
Date: Fri, 26 Jul 2019 10:11:01 +0100
Message-Id: <20190726091103.23503-4-stefanha@redhat.com>
In-Reply-To: <20190726091103.23503-1-stefanha@redhat.com>
References: <20190726091103.23503-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Fri, 26 Jul 2019 09:11:26 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 3/5] virtiofsd: make lo_release() atomic
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
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hold the lock across both lo_map_get() and lo_map_remove() to prevent
races between two FUSE_RELEASE requests.  In this case I don't see a
serious bug but it's safer to do things atomically.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 contrib/virtiofsd/passthrough_ll.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/contrib/virtiofsd/passthrough_ll.c b/contrib/virtiofsd/passt=
hrough_ll.c
index 277a17fc03..c1500e092d 100644
--- a/contrib/virtiofsd/passthrough_ll.c
+++ b/contrib/virtiofsd/passthrough_ll.c
@@ -1759,14 +1759,18 @@ static void lo_open(fuse_req_t req, fuse_ino_t in=
o, struct fuse_file_info *fi)
 static void lo_release(fuse_req_t req, fuse_ino_t ino, struct fuse_file_=
info *fi)
 {
 	struct lo_data *lo =3D lo_data(req);
-	int fd;
+	struct lo_map_elem *elem;
+	int fd =3D -1;
=20
 	(void) ino;
=20
-	fd =3D lo_fi_fd(req, fi);
-
 	pthread_mutex_lock(&lo->mutex);
-	lo_map_remove(&lo->fd_map, fi->fh);
+	elem =3D lo_map_get(&lo->fd_map, fi->fh);
+	if (elem) {
+		fd =3D elem->fd;
+		elem =3D NULL;
+		lo_map_remove(&lo->fd_map, fi->fh);
+	}
 	pthread_mutex_unlock(&lo->mutex);
=20
 	close(fd);
--=20
2.21.0


