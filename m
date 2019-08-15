Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A5DC3A589
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 16:45:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 295DE20578
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 16:45:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 295DE20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyIss-000583-1W
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 12:45:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47269)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1hyIj6-0001jO-4l
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 12:35:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hyIj0-0002PI-Bc
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 12:35:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54762)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hyIj0-0002Ol-5v
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 12:35:42 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7282065F58;
 Thu, 15 Aug 2019 16:35:41 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-19.ams2.redhat.com
 [10.36.117.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C3C7FBAAC;
 Thu, 15 Aug 2019 16:35:35 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 15 Aug 2019 17:34:42 +0100
Message-Id: <20190815163504.18937-12-dgilbert@redhat.com>
In-Reply-To: <20190815163504.18937-1-dgilbert@redhat.com>
References: <20190815163504.18937-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Thu, 15 Aug 2019 16:35:41 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 11/33] migration/savevm: move non SaveStateEntry
 condition check out of iteration
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
Cc: quintela@redhat.com, yury-kotov@yandex-team.ru,
 richardw.yang@linux.intel.com, marcandre.lureau@redhat.com,
 ivanren@tencent.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Wei Yang <richardw.yang@linux.intel.com>

in_postcopy and iterable_only are not SaveStateEntry specific, it would
be more proper to check them out of iteration.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
Message-Id: <20190709140924.13291-4-richardw.yang@linux.intel.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/savevm.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 63545a3026..69a827a92f 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1247,8 +1247,7 @@ void qemu_savevm_state_complete_postcopy(QEMUFile *=
f)
 }
=20
 static
-int qemu_savevm_state_complete_precopy_iterable(QEMUFile *f, bool in_pos=
tcopy,
-                                                bool iterable_only)
+int qemu_savevm_state_complete_precopy_iterable(QEMUFile *f, bool in_pos=
tcopy)
 {
     SaveStateEntry *se;
     int ret;
@@ -1257,7 +1256,6 @@ int qemu_savevm_state_complete_precopy_iterable(QEM=
UFile *f, bool in_postcopy,
         if (!se->ops ||
             (in_postcopy && se->ops->has_postcopy &&
              se->ops->has_postcopy(se->opaque)) ||
-            (in_postcopy && !iterable_only) ||
             !se->ops->save_live_complete_precopy) {
             continue;
         }
@@ -1369,10 +1367,11 @@ int qemu_savevm_state_complete_precopy(QEMUFile *=
f, bool iterable_only,
=20
     cpu_synchronize_all_states();
=20
-    ret =3D qemu_savevm_state_complete_precopy_iterable(f, in_postcopy,
-                                                      iterable_only);
-    if (ret) {
-        return ret;
+    if (!in_postcopy || iterable_only) {
+        ret =3D qemu_savevm_state_complete_precopy_iterable(f, in_postco=
py);
+        if (ret) {
+            return ret;
+        }
     }
=20
     if (iterable_only) {
--=20
2.21.0


