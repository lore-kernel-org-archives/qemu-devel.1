Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5336AC33C99
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 11:30:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C2D72077B
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 11:30:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ib71isIT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C2D72077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ion3t-0003uT-FU
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 06:30:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59201)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1iomQR-0004dh-AH
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 05:49:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1iomQP-0004nv-W9
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 05:49:27 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:43157
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1iomQP-0004n4-SU
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 05:49:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578394163;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IoyM5N3oMYNqzFUjFx3yfuZB9d4KCOyOQGaheYlrGX0=;
 b=ib71isITp+6EXrau4bgkES8RKLDyAQXcY86oq+6SzC73VbQibofKoH7ArxKzsh+WT/cO2D
 xVfLJYGXrswkUIGStAEymag+ZvXjQn6IQ/l/imDS9GP8juF8WrLu+rbiqeiQLWZh0aHPtf
 ZQhlPhP4XREAHHAc8Uf5ybgKfHfIUEk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-366-dETClZ0sMGu2-NjZbHvPJQ-1; Tue, 07 Jan 2020 05:49:22 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6021985B6FA
 for <qemu-devel@nongnu.org>; Tue,  7 Jan 2020 10:49:21 +0000 (UTC)
Received: from secure.mitica (ovpn-116-240.ams2.redhat.com [10.36.116.240])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CF3C71A8D6;
 Tue,  7 Jan 2020 10:49:19 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/3] migration: Make sure that we don't call write() in
 case of error
Date: Tue,  7 Jan 2020 11:49:13 +0100
Message-Id: <20200107104914.1814-3-quintela@redhat.com>
In-Reply-To: <20200107104914.1814-1-quintela@redhat.com>
References: <20200107104914.1814-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: dETClZ0sMGu2-NjZbHvPJQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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

If we are exiting due to an error/finish/.... Just don't try to even
touch the channel with one IO operation.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/ram.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/migration/ram.c b/migration/ram.c
index 96feb4062c..6e678dbd2e 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -900,6 +900,12 @@ struct {
     uint64_t packet_num;
     /* send channels ready */
     QemuSemaphore channels_ready;
+    /*
+     * Have we already run terminate threads.  There is a race when it
+     * happens that we got one error while we are exiting.
+     * We will use atomic operations.  Only valid values are 0 and 1.
+     */
+    int exiting;
 } *multifd_send_state;
=20
 /*
@@ -928,6 +934,10 @@ static int multifd_send_pages(RAMState *rs)
     MultiFDPages_t *pages =3D multifd_send_state->pages;
     uint64_t transferred;
=20
+    if (atomic_read(&multifd_send_state->exiting)) {
+        return -1;
+    }
+
     qemu_sem_wait(&multifd_send_state->channels_ready);
     for (i =3D next_channel;; i =3D (i + 1) % migrate_multifd_channels()) =
{
         p =3D &multifd_send_state->params[i];
@@ -1009,6 +1019,16 @@ static void multifd_send_terminate_threads(Error *er=
r)
         }
     }
=20
+    /*
+     * We don't want to exit each threads twice.  Depending on where
+     * we get the error, or if there are two independent errors in two
+     * threads at the same time, we can end calling this function
+     * twice.
+     */
+    if (atomic_xchg(&multifd_send_state->exiting, 1)) {
+        return;
+    }
+
     for (i =3D 0; i < migrate_multifd_channels(); i++) {
         MultiFDSendParams *p =3D &multifd_send_state->params[i];
=20
@@ -1118,6 +1138,10 @@ static void *multifd_send_thread(void *opaque)
=20
     while (true) {
         qemu_sem_wait(&p->sem);
+
+        if (atomic_read(&multifd_send_state->exiting)) {
+            break;
+        }
         qemu_mutex_lock(&p->mutex);
=20
         if (p->pending_job) {
@@ -1224,6 +1248,7 @@ int multifd_save_setup(void)
     multifd_send_state->params =3D g_new0(MultiFDSendParams, thread_count)=
;
     multifd_send_state->pages =3D multifd_pages_init(page_count);
     qemu_sem_init(&multifd_send_state->channels_ready, 0);
+    atomic_set(&multifd_send_state->exiting, 0);
=20
     for (i =3D 0; i < thread_count; i++) {
         MultiFDSendParams *p =3D &multifd_send_state->params[i];
--=20
2.24.1


