Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E45C35254
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 19:47:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30EDD20715
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 19:47:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FRimg8HV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30EDD20715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1F1R-0005lK-AT
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 14:47:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51392)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1j1EzX-0004Rl-62
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 14:45:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1j1EzU-0007bt-KS
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 14:45:10 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:55019
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1j1EzU-0007Z2-GY
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 14:45:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581363907;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=lXPnng9LvbAXOhNahsVHg/iAhcNcBgdKgrqzcFFcUXE=;
 b=FRimg8HVUoWJmnDJY3DCKJYL0m5TN1s4SIhaT6pWp11Z7THh2aTt8xi+5d4jd8RW3XC5bY
 2p4qjRbmqkgVsz90rX7OT2Uglr4mbUlOxRHLusDlgCEjc5T6Y0Ca7GoHivQ8ytunvKaTpq
 scqRk50v2R6uZBFLvhx8B36+/Z4ZhUA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-Gusy_Nx_OcuMSNaqxxPxQw-1; Mon, 10 Feb 2020 14:45:06 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2479510054E3
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2020 19:45:05 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-112.ams2.redhat.com
 [10.36.117.112])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B9B2019C70;
 Mon, 10 Feb 2020 19:45:01 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	quintela@redhat.com,
	peterx@redhat.com
Subject: [PATCH] migration/rdma: rdma_accept_incoming_migration fix error
 handling
Date: Mon, 10 Feb 2020 19:44:59 +0000
Message-Id: <20200210194459.112085-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: Gusy_Nx_OcuMSNaqxxPxQw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

rdma_accept_incoming_migration is called from an fd handler and
can't return an Error * anywhere.
Currently it's leaking Error's in errp/local_err - there's
no point putting them in there unless we can report them.

Turn most into fprintf's, and the last into an error_reportf_err
where it's coming up from another function.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/rdma.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 2379b8345b..f67161c98f 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -3980,13 +3980,13 @@ static void rdma_accept_incoming_migration(void *op=
aque)
     RDMAContext *rdma =3D opaque;
     int ret;
     QEMUFile *f;
-    Error *local_err =3D NULL, **errp =3D &local_err;
+    Error *local_err =3D NULL;
=20
     trace_qemu_rdma_accept_incoming_migration();
     ret =3D qemu_rdma_accept(rdma);
=20
     if (ret) {
-        ERROR(errp, "RDMA Migration initialization failed!");
+        fprintf(stderr, "RDMA ERROR: Migration initialization failed");
         return;
     }
=20
@@ -3998,13 +3998,16 @@ static void rdma_accept_incoming_migration(void *op=
aque)
=20
     f =3D qemu_fopen_rdma(rdma, "rb");
     if (f =3D=3D NULL) {
-        ERROR(errp, "could not qemu_fopen_rdma!");
+        fprintf(stderr, "RDMA ERROR: could not qemu_fopen_rdma");
         qemu_rdma_cleanup(rdma);
         return;
     }
=20
     rdma->migration_started_on_destination =3D 1;
-    migration_fd_process_incoming(f, errp);
+    migration_fd_process_incoming(f, &local_err);
+    if (local_err) {
+        error_reportf_err(local_err, "RDMA ERROR:");
+    }
 }
=20
 void rdma_start_incoming_migration(const char *host_port, Error **errp)
--=20
2.24.1


