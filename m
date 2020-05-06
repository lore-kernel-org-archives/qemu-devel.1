Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7312C28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 09:56:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81B5E20753
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 09:56:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OJ5WO+hX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81B5E20753
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWGn2-00083I-ML
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 05:56:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54292)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1jWGhR-00054k-Ve
 for qemu-devel@nongnu.org; Wed, 06 May 2020 05:50:46 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:52348
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1jWGhQ-0004aj-73
 for qemu-devel@nongnu.org; Wed, 06 May 2020 05:50:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588758643;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HiYZK5Z/1tdBn0MeeAphcfReGNPxF8BUMmE6+8UMB8Y=;
 b=OJ5WO+hXQOHrnk/CPhe48MGsd2B379we6FP1s6VDOasZVSBSt47aTI3qWD0kEP6v2ng9Ni
 dpL+e0WlFRxqvvGDy9PSfSAv/EKkHmWKEtn/XdWynHCgIsszlcxWXEQghQmcgTrNMxOTAc
 xNUuAzNg87mFs8JRQwkXzJx/CFzGzjA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-fjvezdvuOE2bJ1-EzJwocQ-1; Wed, 06 May 2020 05:50:39 -0400
X-MC-Unique: fjvezdvuOE2bJ1-EzJwocQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7C9211895A2B;
 Wed,  6 May 2020 09:50:38 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-17.ams2.redhat.com [10.36.113.17])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 52AF15C1BD;
 Wed,  6 May 2020 09:50:36 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 08/17] migration/colo: Use ram_block_discard_set_broken()
Date: Wed,  6 May 2020 11:49:39 +0200
Message-Id: <20200506094948.76388-9-david@redhat.com>
In-Reply-To: <20200506094948.76388-1-david@redhat.com>
References: <20200506094948.76388-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/06 05:50:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 Hailiang Zhang <zhang.zhanghailiang@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

COLO will copy all memory in a RAM block, mark discarding of RAM broken.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Hailiang Zhang <zhang.zhanghailiang@huawei.com>
Cc: Juan Quintela <quintela@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/migration/colo.h |  2 +-
 migration/migration.c    |  8 +++++++-
 migration/savevm.c       | 11 +++++++++--
 3 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/include/migration/colo.h b/include/migration/colo.h
index 1636e6f907..768e1f04c3 100644
--- a/include/migration/colo.h
+++ b/include/migration/colo.h
@@ -25,7 +25,7 @@ void migrate_start_colo_process(MigrationState *s);
 bool migration_in_colo_state(void);
=20
 /* loadvm */
-void migration_incoming_enable_colo(void);
+int migration_incoming_enable_colo(void);
 void migration_incoming_disable_colo(void);
 bool migration_incoming_colo_enabled(void);
 void *colo_process_incoming_thread(void *opaque);
diff --git a/migration/migration.c b/migration/migration.c
index 177cce9e95..f6830e4620 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -338,12 +338,18 @@ bool migration_incoming_colo_enabled(void)
=20
 void migration_incoming_disable_colo(void)
 {
+    ram_block_discard_set_broken(false);
     migration_colo_enabled =3D false;
 }
=20
-void migration_incoming_enable_colo(void)
+int migration_incoming_enable_colo(void)
 {
+    if (ram_block_discard_set_broken(true)) {
+        error_report("COLO: cannot set discarding of RAM broken");
+        return -EBUSY;
+    }
     migration_colo_enabled =3D true;
+    return 0;
 }
=20
 void migrate_add_address(SocketAddress *address)
diff --git a/migration/savevm.c b/migration/savevm.c
index c00a6807d9..19b4f9600d 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2111,8 +2111,15 @@ static int loadvm_handle_recv_bitmap(MigrationInco=
mingState *mis,
=20
 static int loadvm_process_enable_colo(MigrationIncomingState *mis)
 {
-    migration_incoming_enable_colo();
-    return colo_init_ram_cache();
+    int ret =3D migration_incoming_enable_colo();
+
+    if (!ret) {
+        ret =3D colo_init_ram_cache();
+        if (ret) {
+            migration_incoming_disable_colo();
+        }
+    }
+    return ret;
 }
=20
 /*
--=20
2.25.3


