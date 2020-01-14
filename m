Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B1E3C33CB3
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 13:21:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0676420678
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 13:21:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YomcFaLP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0676420678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irM89-0002mq-27
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 08:21:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41484)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1irLjh-0003cV-3E
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 07:56:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1irLjd-00026A-BH
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 07:55:56 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:48520
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1irLjd-00025h-83
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 07:55:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579006552;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ya1F0mvUWk8XyhM6v0oEY3/vFxdIpuuT2eEdeU07i9U=;
 b=YomcFaLPNqTDgpjBK2KMmZbhvekGQxXI4rc/jUm4muArv3fptZlBDbCUaDxzqCWQlsr8PZ
 N0xNLKrZy7SM/x5OuhuhpMpbLYzVQquP9P3LfnESo4R2qr39MfMOp44kBimMREavzX36uW
 bzzuhXJXwEfJrK5e0nszKY8LFvLpmDs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-ooXaJcDQNCKrHAhYZ5NwTw-1; Tue, 14 Jan 2020 07:55:51 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 575311800D78;
 Tue, 14 Jan 2020 12:55:49 +0000 (UTC)
Received: from secure.mitica (ovpn-116-207.ams2.redhat.com [10.36.116.207])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2710B5D9E5;
 Tue, 14 Jan 2020 12:55:42 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 20/30] migration/postcopy: enable random order target page
 arrival
Date: Tue, 14 Jan 2020 13:52:44 +0100
Message-Id: <20200114125254.4515-21-quintela@redhat.com>
In-Reply-To: <20200114125254.4515-1-quintela@redhat.com>
References: <20200114125254.4515-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: ooXaJcDQNCKrHAhYZ5NwTw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Corey Minyard <cminyard@mvista.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, Wei Yang <richardw.yang@linux.intel.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Wei Yang <richardw.yang@linux.intel.com>

After using number of target page received to track one host page, we
could have the capability to handle random order target page arrival in
one host page.

This is a preparation for enabling compress during postcopy.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/ram.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 40c3fdd766..cbf8ab6a51 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -4050,7 +4050,7 @@ static int ram_load_postcopy(QEMUFile *f)
     MigrationIncomingState *mis =3D migration_incoming_get_current();
     /* Temporary page that is later 'placed' */
     void *postcopy_host_page =3D mis->postcopy_tmp_page;
-    void *last_host =3D NULL;
+    void *this_host =3D NULL;
     bool all_zero =3D false;
     int target_pages =3D 0;
=20
@@ -4097,24 +4097,26 @@ static int ram_load_postcopy(QEMUFile *f)
              * that's moved into place later.
              * The migration protocol uses,  possibly smaller, target-page=
s
              * however the source ensures it always sends all the componen=
ts
-             * of a host page in order.
+             * of a host page in one chunk.
              */
             page_buffer =3D postcopy_host_page +
                           ((uintptr_t)host & (block->page_size - 1));
             /* If all TP are zero then we can optimise the place */
             if (target_pages =3D=3D 1) {
                 all_zero =3D true;
+                this_host =3D (void *)QEMU_ALIGN_DOWN((uintptr_t)host,
+                                                    block->page_size);
             } else {
                 /* not the 1st TP within the HP */
-                if (host !=3D (last_host + TARGET_PAGE_SIZE)) {
-                    error_report("Non-sequential target page %p/%p",
-                                  host, last_host);
+                if (QEMU_ALIGN_DOWN((uintptr_t)host, block->page_size) !=
=3D
+                    (uintptr_t)this_host) {
+                    error_report("Non-same host page %p/%p",
+                                  host, this_host);
                     ret =3D -EINVAL;
                     break;
                 }
             }
=20
-
             /*
              * If it's the last part of a host page then we place the host
              * page
@@ -4125,7 +4127,6 @@ static int ram_load_postcopy(QEMUFile *f)
             }
             place_source =3D postcopy_host_page;
         }
-        last_host =3D host;
=20
         switch (flags & ~RAM_SAVE_FLAG_CONTINUE) {
         case RAM_SAVE_FLAG_ZERO:
@@ -4178,7 +4179,8 @@ static int ram_load_postcopy(QEMUFile *f)
=20
         if (!ret && place_needed) {
             /* This gets called at the last target page in the host page *=
/
-            void *place_dest =3D host + TARGET_PAGE_SIZE - block->page_siz=
e;
+            void *place_dest =3D (void *)QEMU_ALIGN_DOWN((uintptr_t)host,
+                                                       block->page_size);
=20
             if (all_zero) {
                 ret =3D postcopy_place_page_zero(mis, place_dest,
--=20
2.24.1


