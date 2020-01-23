Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D879C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 12:59:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56FF024125
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 12:59:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gyHsxNtK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56FF024125
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuc5F-00021G-4H
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 07:59:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40225)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1iub8m-0001y4-37
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:59:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1iub8k-0004xA-5j
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:59:15 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:51635
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1iub8k-0004we-0L
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:59:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579780753;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zpZtx+nrJtr99ho6va+6XTZGIghNiNIClmqo3+ZKxi4=;
 b=gyHsxNtK8WwusxGaPojqDiKLRsU18zO+hMh9p6R0xbe9xTRgba4pAp5Br/SbY8OEjrjG1Z
 RGb9cNIyO+5rwCwIqlqU84zpXY2RGAo35LZKolS7JLCpvMD4AOb86D1iFZ1vR4iWsiLVZE
 3+wtSKwLI4v1N0amWFAqD9NVdEy/lKI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-213-ceFHk55COheLRJPGXxWU_g-1; Thu, 23 Jan 2020 06:59:12 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1A174107ACC4
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 11:59:11 +0000 (UTC)
Received: from secure.mitica (ovpn-116-207.ams2.redhat.com [10.36.116.207])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BFA5419C69;
 Thu, 23 Jan 2020 11:59:08 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 11/21] multifd: multifd_send_pages only needs the qemufile
Date: Thu, 23 Jan 2020 12:58:21 +0100
Message-Id: <20200123115831.36842-12-quintela@redhat.com>
In-Reply-To: <20200123115831.36842-1-quintela@redhat.com>
References: <20200123115831.36842-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: ceFHk55COheLRJPGXxWU_g-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
 migration/ram.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 125c6d0f60..19caf5ed4d 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -929,7 +929,7 @@ struct {
  * false.
  */
=20
-static int multifd_send_pages(RAMState *rs)
+static int multifd_send_pages(QEMUFile *f)
 {
     int i;
     static int next_channel;
@@ -965,7 +965,7 @@ static int multifd_send_pages(RAMState *rs)
     multifd_send_state->pages =3D p->pages;
     p->pages =3D pages;
     transferred =3D ((uint64_t) pages->used) * TARGET_PAGE_SIZE + p->packe=
t_len;
-    qemu_file_update_transfer(rs->f, transferred);
+    qemu_file_update_transfer(f, transferred);
     ram_counters.multifd_bytes +=3D transferred;
     ram_counters.transferred +=3D transferred;;
     qemu_mutex_unlock(&p->mutex);
@@ -993,7 +993,7 @@ static int multifd_queue_page(RAMState *rs, RAMBlock *b=
lock, ram_addr_t offset)
         }
     }
=20
-    if (multifd_send_pages(rs) < 0) {
+    if (multifd_send_pages(rs->f) < 0) {
         return -1;
     }
=20
@@ -1090,7 +1090,7 @@ static void multifd_send_sync_main(RAMState *rs)
         return;
     }
     if (multifd_send_state->pages->used) {
-        if (multifd_send_pages(rs) < 0) {
+        if (multifd_send_pages(rs->f) < 0) {
             error_report("%s: multifd_send_pages fail", __func__);
             return;
         }
--=20
2.24.1


