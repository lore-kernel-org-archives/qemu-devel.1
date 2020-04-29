Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28FF0C83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 07:40:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E224E2073E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 07:40:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FLm0doXr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E224E2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jThKB-0004ta-0U
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 03:40:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46252)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jTh27-0007uG-8H
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 03:22:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jTh1i-0003zN-MI
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 03:21:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31206
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jTh1h-0003uf-IT
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 03:21:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588144857;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ARsxO36GYr/5NC74E6ItLer6/hyG11wa9m/wl3IdRbI=;
 b=FLm0doXrB3X2HO92y8Kwl0zTgccp+/hHd8ZrWQK8PXIb4ifY/IH1UC1HJKPtNFlgAdD8+F
 ztw+Gb9aml48074+9LLOgIh2kvLZCQHXVTrCUKmCXrtvtCqq8VKW39H4bN7+FDYxgHwTJE
 AMHPyZgMX9c5uFWpUU5x6vlXdNyxRTY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-288-0a0jWyUZOZ2y_NQq2XFQHw-1; Wed, 29 Apr 2020 03:20:54 -0400
X-MC-Unique: 0a0jWyUZOZ2y_NQq2XFQHw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BD69C8015CE;
 Wed, 29 Apr 2020 07:20:53 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 815721000329;
 Wed, 29 Apr 2020 07:20:53 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 47D3311358D2; Wed, 29 Apr 2020 09:20:49 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 21/32] migration/colo: Fix qmp_xen_colo_do_checkpoint() error
 handling
Date: Wed, 29 Apr 2020 09:20:37 +0200
Message-Id: <20200429072048.29963-22-armbru@redhat.com>
In-Reply-To: <20200429072048.29963-1-armbru@redhat.com>
References: <20200429072048.29963-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 01:42:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Message-Id: <20200422130719.28225-12-armbru@redhat.com>
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


