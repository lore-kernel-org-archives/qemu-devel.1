Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67DD1C47259
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 09:55:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 374A120753
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 09:55:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y0Xk9b8b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 374A120753
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWGll-0005KF-9f
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 05:55:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54258)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1jWGhM-00050a-Bs
 for qemu-devel@nongnu.org; Wed, 06 May 2020 05:50:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33366
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1jWGhL-0004Yf-Dp
 for qemu-devel@nongnu.org; Wed, 06 May 2020 05:50:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588758638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O10BhkYK4SLEDgxOR3AeYFqIdU21u3W3cDnwDc7jdOs=;
 b=Y0Xk9b8bYdPuxHX5GylAE2gwqu/ZFrIUGAQvqE/8d5XE6eBAuf+lUjCwf7xMsHKxW1CEtl
 E+VIYqKdi+GUBXbduaKaYHRdRwiob06g+Y+CYRC1jitnQGn0GmHU2/aiiwPh7Q6yL8Zkjo
 F0vW7ZHKMtR+WlDqz9sAvefNyZDc7ZU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-499-EJvB0YQXPxi4wNhYZd1E4g-1; Wed, 06 May 2020 05:50:37 -0400
X-MC-Unique: EJvB0YQXPxi4wNhYZd1E4g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 01E92107ACF2;
 Wed,  6 May 2020 09:50:36 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-17.ams2.redhat.com [10.36.113.17])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F02245C1BD;
 Wed,  6 May 2020 09:50:33 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 07/17] migration/rdma: Use ram_block_discard_set_broken()
Date: Wed,  6 May 2020 11:49:38 +0200
Message-Id: <20200506094948.76388-8-david@redhat.com>
In-Reply-To: <20200506094948.76388-1-david@redhat.com>
References: <20200506094948.76388-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=david@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 23:48:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 "Michael S . Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

RDMA will pin all guest memory (as documented in docs/rdma.txt). We want
to mark RAM block discards to be broken - however, to keep it simple
use ram_block_discard_is_required() instead of inhibiting.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 migration/rdma.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index f61587891b..029adbb950 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -29,6 +29,7 @@
 #include "qemu/sockets.h"
 #include "qemu/bitmap.h"
 #include "qemu/coroutine.h"
+#include "exec/memory.h"
 #include <sys/socket.h>
 #include <netdb.h>
 #include <arpa/inet.h>
@@ -4017,8 +4018,14 @@ void rdma_start_incoming_migration(const char *hos=
t_port, Error **errp)
     Error *local_err =3D NULL;
=20
     trace_rdma_start_incoming_migration();
-    rdma =3D qemu_rdma_data_init(host_port, &local_err);
=20
+    /* Avoid ram_block_discard_set_broken(), cannot change during migrat=
ion. */
+    if (ram_block_discard_is_required()) {
+        error_setg(errp, "RDMA: cannot set discarding of RAM broken");
+        return;
+    }
+
+    rdma =3D qemu_rdma_data_init(host_port, &local_err);
     if (rdma =3D=3D NULL) {
         goto err;
     }
@@ -4064,10 +4071,17 @@ void rdma_start_outgoing_migration(void *opaque,
                             const char *host_port, Error **errp)
 {
     MigrationState *s =3D opaque;
-    RDMAContext *rdma =3D qemu_rdma_data_init(host_port, errp);
     RDMAContext *rdma_return_path =3D NULL;
+    RDMAContext *rdma;
     int ret =3D 0;
=20
+    /* Avoid ram_block_discard_set_broken(), cannot change during migrat=
ion. */
+    if (ram_block_discard_is_required()) {
+        error_setg(errp, "RDMA: cannot set discarding of RAM broken");
+        return;
+    }
+
+    rdma =3D qemu_rdma_data_init(host_port, errp);
     if (rdma =3D=3D NULL) {
         goto err;
     }
--=20
2.25.3


