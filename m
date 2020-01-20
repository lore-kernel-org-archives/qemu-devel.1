Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C60C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 10:45:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EB372073A
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 10:45:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bo8Ug2Cl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EB372073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itUYk-0001lF-MO
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 05:45:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37634)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1itUPL-0005fV-9C
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 05:35:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1itUPH-0002Me-AE
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 05:35:47 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30586
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1itUPH-0002M6-69
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 05:35:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579516542;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=52j2mgmiA4z5vA2yqyRSfUxDIXdlaCqV+gsG8XIQ6+k=;
 b=bo8Ug2ClzE0tGTtn/0nfJWA75neYAtbFc2sKFeewsb8sZX9cyfo2mpyoGWRc7pzyKoGxIJ
 QYiTwMtPYxdwFdeEljaWJ6dIeIPlH+AVz3ub0hfRgNmmJJPbJrpin5n5ByXMVvqdntXh/i
 5RggFzIQbDvFagAqi8gXABW/bb4lqg0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-z3v_9q-ePBGGlDeQda-k1w-1; Mon, 20 Jan 2020 05:35:41 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6DA821005510;
 Mon, 20 Jan 2020 10:35:39 +0000 (UTC)
Received: from secure.mitica (ovpn-116-207.ams2.redhat.com [10.36.116.207])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 440051BC6D;
 Mon, 20 Jan 2020 10:35:22 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 12/29] migration: savevm_state_handler_insert: constant-time
 element insertion
Date: Mon, 20 Jan 2020 11:33:23 +0100
Message-Id: <20200120103340.25118-13-quintela@redhat.com>
In-Reply-To: <20200120103340.25118-1-quintela@redhat.com>
References: <20200120103340.25118-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: z3v_9q-ePBGGlDeQda-k1w-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Laurent Vivier <lvivier@redhat.com>, Corey Minyard <cminyard@mvista.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Stefan Weil <sw@weilnetz.de>,
 Jason Wang <jasowang@redhat.com>, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, Scott Cheloha <cheloha@linux.vnet.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Scott Cheloha <cheloha@linux.vnet.ibm.com>

savevm_state's SaveStateEntry TAILQ is a priority queue.  Priority
sorting is maintained by searching from head to tail for a suitable
insertion spot.  Insertion is thus an O(n) operation.

If we instead keep track of the head of each priority's subqueue
within that larger queue we can reduce this operation to O(1) time.

savevm_state_handler_remove() becomes slightly more complex to
accomodate these gains: we need to replace the head of a priority's
subqueue when removing it.

With O(1) insertion, booting VMs with many SaveStateEntry objects is
more plausible.  For example, a ppc64 VM with maxmem=3D8T has 40000 such
objects to insert.

Signed-off-by: Scott Cheloha <cheloha@linux.vnet.ibm.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/savevm.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 30d980caa2..e57686bca7 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -250,6 +250,7 @@ typedef struct SaveStateEntry {
=20
 typedef struct SaveState {
     QTAILQ_HEAD(, SaveStateEntry) handlers;
+    SaveStateEntry *handler_pri_head[MIG_PRI_MAX + 1];
     int global_section_id;
     uint32_t len;
     const char *name;
@@ -261,6 +262,7 @@ typedef struct SaveState {
=20
 static SaveState savevm_state =3D {
     .handlers =3D QTAILQ_HEAD_INITIALIZER(savevm_state.handlers),
+    .handler_pri_head =3D { [MIG_PRI_DEFAULT ... MIG_PRI_MAX] =3D NULL },
     .global_section_id =3D 0,
 };
=20
@@ -709,24 +711,42 @@ static void savevm_state_handler_insert(SaveStateEntr=
y *nse)
 {
     MigrationPriority priority =3D save_state_priority(nse);
     SaveStateEntry *se;
+    int i;
=20
     assert(priority <=3D MIG_PRI_MAX);
=20
-    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
-        if (save_state_priority(se) < priority) {
+    for (i =3D priority - 1; i >=3D 0; i--) {
+        se =3D savevm_state.handler_pri_head[i];
+        if (se !=3D NULL) {
+            assert(save_state_priority(se) < priority);
             break;
         }
     }
=20
-    if (se) {
+    if (i >=3D 0) {
         QTAILQ_INSERT_BEFORE(se, nse, entry);
     } else {
         QTAILQ_INSERT_TAIL(&savevm_state.handlers, nse, entry);
     }
+
+    if (savevm_state.handler_pri_head[priority] =3D=3D NULL) {
+        savevm_state.handler_pri_head[priority] =3D nse;
+    }
 }
=20
 static void savevm_state_handler_remove(SaveStateEntry *se)
 {
+    SaveStateEntry *next;
+    MigrationPriority priority =3D save_state_priority(se);
+
+    if (se =3D=3D savevm_state.handler_pri_head[priority]) {
+        next =3D QTAILQ_NEXT(se, entry);
+        if (next !=3D NULL && save_state_priority(next) =3D=3D priority) {
+            savevm_state.handler_pri_head[priority] =3D next;
+        } else {
+            savevm_state.handler_pri_head[priority] =3D NULL;
+        }
+    }
     QTAILQ_REMOVE(&savevm_state.handlers, se, entry);
 }
=20
--=20
2.24.1


