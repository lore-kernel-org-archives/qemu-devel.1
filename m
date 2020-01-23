Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E09C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 13:10:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE41724655
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 13:10:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SiVBriRd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE41724655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iucFU-0005xX-77
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 08:10:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40407)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1iub8v-00028l-12
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:59:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1iub8t-00054g-VP
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:59:24 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56158
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1iub8t-00054O-Rc
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:59:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579780763;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gEtrEl/b8zHxSZ0DTpznmiBp8GHFsRGG0f8Y5qLnuEY=;
 b=SiVBriRdpB5X/OJgQdJ8qjC4CYmH7GOueQm8w4dVOtOkFEEeGwvVqxWyEa71ZDaDUf8Piz
 ziHX8F1OExhcEuthi8t27xTTX5RJcXRrVuWO0hmmbvk4qOfrcDMSRvrZp+PpSk5DyoeLDq
 vVS1ITESTf9VOcDyCTLHKfo/AxlOw+U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-396-WR10frG8NdSn4J3T_dMsaQ-1; Thu, 23 Jan 2020 06:59:21 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D50EB800D4C
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 11:59:20 +0000 (UTC)
Received: from secure.mitica (ovpn-116-207.ams2.redhat.com [10.36.116.207])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7CF4B19C69;
 Thu, 23 Jan 2020 11:59:18 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 13/21] multifd: multifd_send_sync_main only needs the
 qemufile
Date: Thu, 23 Jan 2020 12:58:23 +0100
Message-Id: <20200123115831.36842-14-quintela@redhat.com>
In-Reply-To: <20200123115831.36842-1-quintela@redhat.com>
References: <20200123115831.36842-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: WR10frG8NdSn4J3T_dMsaQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/ram.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index d4c829bc77..2783dc60f4 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1082,7 +1082,7 @@ void multifd_save_cleanup(void)
     multifd_send_state =3D NULL;
 }
=20
-static void multifd_send_sync_main(RAMState *rs)
+static void multifd_send_sync_main(QEMUFile *f)
 {
     int i;
=20
@@ -1090,7 +1090,7 @@ static void multifd_send_sync_main(RAMState *rs)
         return;
     }
     if (multifd_send_state->pages->used) {
-        if (multifd_send_pages(rs->f) < 0) {
+        if (multifd_send_pages(f) < 0) {
             error_report("%s: multifd_send_pages fail", __func__);
             return;
         }
@@ -1111,7 +1111,7 @@ static void multifd_send_sync_main(RAMState *rs)
         p->packet_num =3D multifd_send_state->packet_num++;
         p->flags |=3D MULTIFD_FLAG_SYNC;
         p->pending_job++;
-        qemu_file_update_transfer(rs->f, p->packet_len);
+        qemu_file_update_transfer(f, p->packet_len);
         ram_counters.multifd_bytes +=3D p->packet_len;
         ram_counters.transferred +=3D p->packet_len;
         qemu_mutex_unlock(&p->mutex);
@@ -3426,7 +3426,7 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
     ram_control_before_iterate(f, RAM_CONTROL_SETUP);
     ram_control_after_iterate(f, RAM_CONTROL_SETUP);
=20
-    multifd_send_sync_main(*rsp);
+    multifd_send_sync_main(f);
     qemu_put_be64(f, RAM_SAVE_FLAG_EOS);
     qemu_fflush(f);
=20
@@ -3526,7 +3526,7 @@ static int ram_save_iterate(QEMUFile *f, void *opaque=
)
 out:
     if (ret >=3D 0
         && migration_is_setup_or_active(migrate_get_current()->state)) {
-        multifd_send_sync_main(rs);
+        multifd_send_sync_main(rs->f);
         qemu_put_be64(f, RAM_SAVE_FLAG_EOS);
         qemu_fflush(f);
         ram_counters.transferred +=3D 8;
@@ -3585,7 +3585,7 @@ static int ram_save_complete(QEMUFile *f, void *opaqu=
e)
     }
=20
     if (ret >=3D 0) {
-        multifd_send_sync_main(rs);
+        multifd_send_sync_main(rs->f);
         qemu_put_be64(f, RAM_SAVE_FLAG_EOS);
         qemu_fflush(f);
     }
--=20
2.24.1


