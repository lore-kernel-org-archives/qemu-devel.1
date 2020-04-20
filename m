Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F3BDC54FCC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 08:34:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E09C920679
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 08:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KcN+NZ8L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E09C920679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQRsM-0004dQ-VT
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 04:33:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56462 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jQRrB-0002sv-1q
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 04:32:45 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jQRrA-0006vp-Fb
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 04:32:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49518
 helo=us-smtp-1.mimecast.com)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jQRrA-0006u4-0J
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 04:32:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587371563;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m2k6LewiTNFgf6Pzbdvr/rBx+uQJZq79kOGql1ICBkY=;
 b=KcN+NZ8LeKoU554TPO+j3AHeScDzc9ety/wCTxrHfnVPjxx4UpnDPu3uTvJftVcvzBnST7
 mDM5HImv3CS/rFh/4vgn5jHwNRtf/m3QvTJl0aq1iR2lo0LXxCPBYsthfGyYQ0qkDnpuKD
 WTWa9Fl3Sck8gmJOpQ0y9Tp7KX0GwqA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-430-3Gt_UdSlNjGcTNTuRtt-WQ-1; Mon, 20 Apr 2020 04:32:41 -0400
X-MC-Unique: 3Gt_UdSlNjGcTNTuRtt-WQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 378561005509;
 Mon, 20 Apr 2020 08:32:40 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EEEB296FB1;
 Mon, 20 Apr 2020 08:32:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C251A11358C7; Mon, 20 Apr 2020 10:32:36 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 11/11] migration/colo: Fix qmp_xen_colo_do_checkpoint() error
 handling
Date: Mon, 20 Apr 2020 10:32:36 +0200
Message-Id: <20200420083236.19309-12-armbru@redhat.com>
In-Reply-To: <20200420083236.19309-1-armbru@redhat.com>
References: <20200420083236.19309-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs1p.gnu.org: First seen = 2020/04/20
 04:32:42
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


