Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E18C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 16:37:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CF94206BB
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 16:37:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CF94206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8oa3-0005C0-ET
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 12:37:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35518)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1i8oXY-0002II-KC
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 12:35:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1i8oXX-0001ob-PX
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 12:35:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59418)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1i8oXX-0001nz-Kb
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 12:35:19 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id F33B0307D847
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2019 16:35:18 +0000 (UTC)
Received: from dgilbert-t580.localhost (unknown [10.36.118.12])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 644B460CC0;
 Fri, 13 Sep 2019 16:35:13 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	quintela@redhat.com,
	peterx@redhat.com
Date: Fri, 13 Sep 2019 17:35:06 +0100
Message-Id: <20190913163507.1403-2-dgilbert@redhat.com>
In-Reply-To: <20190913163507.1403-1-dgilbert@redhat.com>
References: <20190913163507.1403-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Fri, 13 Sep 2019 16:35:19 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 1/2] migration/rdma: Don't moan about
 disconnects at the end
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

If we've already finished the migration or something has
already gone wrong, don't moan about the migration stream disconnecting.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/rdma.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 78e6b72bac..0fcf02f48e 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -3253,10 +3253,14 @@ static void rdma_cm_poll_handler(void *opaque)
=20
     if (cm_event->event =3D=3D RDMA_CM_EVENT_DISCONNECTED ||
         cm_event->event =3D=3D RDMA_CM_EVENT_DEVICE_REMOVAL) {
-        error_report("receive cm event, cm event is %d", cm_event->event=
);
-        rdma->error_state =3D -EPIPE;
-        if (rdma->return_path) {
-            rdma->return_path->error_state =3D -EPIPE;
+        if (!rdma->error_state &&
+            migration_incoming_get_current()->state !=3D
+              MIGRATION_STATUS_COMPLETED) {
+            error_report("receive cm event, cm event is %d", cm_event->e=
vent);
+            rdma->error_state =3D -EPIPE;
+            if (rdma->return_path) {
+                rdma->return_path->error_state =3D -EPIPE;
+            }
         }
=20
         if (mis->migration_incoming_co) {
--=20
2.21.0


