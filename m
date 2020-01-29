Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5CB3C33CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 11:20:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D3D92070E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 11:20:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IzG8gGDX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D3D92070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwlOc-0000Gb-LB
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 06:20:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60138)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1iwlKZ-0001gT-Gg
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 06:16:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1iwlKY-0006YM-Ey
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 06:16:23 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:43535
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1iwlKY-0006YG-Ax
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 06:16:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580296582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MME6TgSV0RHAZv34MLeNAsm4siCsSWu4ch3j9XF0mMg=;
 b=IzG8gGDXn/JrAHh9YGSEEsPhecohaQ8NSCIGAcez0wBOp0oUZFjZR7sE+tJU3YKo3t5+da
 shhQ4Z5fPRlGsggr5ZWqkbutSA0mk+z2T43Zd1SC6vqC+YfdInAa2O413DvUrxL1Ad1zd/
 ar9OJIjPu/CQCk11I/N2ARFFE4PyQU0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-9l7qGtITPp6bCeD8HjGO7g-1; Wed, 29 Jan 2020 06:16:20 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F023E800D54
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2020 11:16:19 +0000 (UTC)
Received: from secure.mitica (ovpn-116-64.ams2.redhat.com [10.36.116.64])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6AC5389D2E;
 Wed, 29 Jan 2020 11:16:18 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 11/18] multifd: multifd_send_sync_main only needs the qemufile
Date: Wed, 29 Jan 2020 12:15:29 +0100
Message-Id: <20200129111536.9497-12-quintela@redhat.com>
In-Reply-To: <20200129111536.9497-1-quintela@redhat.com>
References: <20200129111536.9497-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: 9l7qGtITPp6bCeD8HjGO7g-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/ram.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index ad9cc3e7bd..152e9cf46d 100644
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
@@ -3434,7 +3434,7 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
     ram_control_before_iterate(f, RAM_CONTROL_SETUP);
     ram_control_after_iterate(f, RAM_CONTROL_SETUP);
=20
-    multifd_send_sync_main(*rsp);
+    multifd_send_sync_main(f);
     qemu_put_be64(f, RAM_SAVE_FLAG_EOS);
     qemu_fflush(f);
=20
@@ -3534,7 +3534,7 @@ static int ram_save_iterate(QEMUFile *f, void *opaque=
)
 out:
     if (ret >=3D 0
         && migration_is_setup_or_active(migrate_get_current()->state)) {
-        multifd_send_sync_main(rs);
+        multifd_send_sync_main(rs->f);
         qemu_put_be64(f, RAM_SAVE_FLAG_EOS);
         qemu_fflush(f);
         ram_counters.transferred +=3D 8;
@@ -3593,7 +3593,7 @@ static int ram_save_complete(QEMUFile *f, void *opaqu=
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


