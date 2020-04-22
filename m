Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FAD1C54FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 13:17:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47A1F20B1F
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 13:17:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DVstdFt7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47A1F20B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRFFt-0001fp-BS
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 09:17:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46880)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jRF6A-0003ol-8M
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 09:07:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jRF68-0003sv-V9
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 09:07:29 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:25361
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jRF68-0003qv-F7
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 09:07:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587560847;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wYKIi3HEA0GUP+kQcT/vivYitUM0GVQKFCyq6ffCeAY=;
 b=DVstdFt70r+OnTAccIwCoPjL6aNOLjOl634SoN/nzzd2iohkrtuPBlkzWumn3NASaxCnYP
 NKlYYN+p3Cwc35La8ZZWhbRJ5EkYrIL6fZQzednwIKLtgWH8ZlfO9QGOzderYrbTjRekd3
 3bHjw6oK7sSmyJdLS/+e+HaeTr8YSUk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-443-ArvIrDTaP3aKxzBiV66TAA-1; Wed, 22 Apr 2020 09:07:26 -0400
X-MC-Unique: ArvIrDTaP3aKxzBiV66TAA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C7E5F8017F6;
 Wed, 22 Apr 2020 13:07:24 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6DCC75D715;
 Wed, 22 Apr 2020 13:07:23 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2A4E911358C7; Wed, 22 Apr 2020 15:07:20 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 11/14] migration/colo: Fix qmp_xen_colo_do_checkpoint()
 error handling
Date: Wed, 22 Apr 2020 15:07:16 +0200
Message-Id: <20200422130719.28225-12-armbru@redhat.com>
In-Reply-To: <20200422130719.28225-1-armbru@redhat.com>
References: <20200422130719.28225-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 02:12:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: Zhang Chen <chen.zhang@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 zhanghailiang <zhang.zhanghailiang@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Error ** argument must be NULL, &error_abort, &error_fatal, or a
pointer to a variable containing NULL.  Passing an argument of the
latter kind twice without clearing it in between is wrong: if the
first call sets an error, it no longer points to NULL for the second
call.

qmp_xen_colo_do_checkpoint() passes @errp first to
replication_do_checkpoint_all(), and then to
colo_notify_filters_event().  If both fail, this will trip the
assertion in error_setv().

Similar code in secondary_vm_do_failover() calls
colo_notify_filters_event() only after replication_do_checkpoint_all()
succeeded.  Do the same here.

Fixes: 0e8818f023616677416840d6ddc880db8de3c967
Cc: Zhang Chen <chen.zhang@intel.com>
Cc: zhanghailiang <zhang.zhanghailiang@huawei.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Zhang Chen <chen.zhang@intel.com>
---
 migration/colo.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/migration/colo.c b/migration/colo.c
index a54ac84f41..1b3493729b 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -263,7 +263,13 @@ ReplicationStatus *qmp_query_xen_replication_status(Er=
ror **errp)
=20
 void qmp_xen_colo_do_checkpoint(Error **errp)
 {
-    replication_do_checkpoint_all(errp);
+    Error *err =3D NULL;
+
+    replication_do_checkpoint_all(&err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
     /* Notify all filters of all NIC to do checkpoint */
     colo_notify_filters_event(COLO_EVENT_CHECKPOINT, errp);
 }
--=20
2.21.1


