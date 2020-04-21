Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9EBEC2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 08:58:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5F38206E9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 08:58:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gG+LTR4b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5F38206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQojx-0005hI-QO
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 04:58:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57310)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1jQofb-0007pX-B7
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 04:54:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1jQofa-00019k-PB
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 04:54:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44980
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1jQofa-00018q-CR
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 04:54:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587459257;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PiYdaufXH/OcHgyja+9iT9AeZgtrLODnqhTcI1EwYAg=;
 b=gG+LTR4bX9tgPrdAYc/8B9XrTlsowMs+h0ITKJN4oEh18b1Anks+B47KDz3QSqhUZRpsMT
 iZ6Q0kmRjAV22bbH18DHs/GxvSMTvJRp61Y5sLklgzElOQVsbup3z3NainkQWI9dp+/he5
 0z2D8oxAqAYXED2HVHvJvP6qOhhOzJk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-65-5B3mA3g4NdOKDmIDStIK1A-1; Tue, 21 Apr 2020 04:54:16 -0400
X-MC-Unique: 5B3mA3g4NdOKDmIDStIK1A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 33CC9107ACCC;
 Tue, 21 Apr 2020 08:54:15 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-245.ams2.redhat.com [10.36.113.245])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 71064100EBB9;
 Tue, 21 Apr 2020 08:54:06 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 07/13] migration/ram: Discard RAM when growing RAM blocks
 after ram_postcopy_incoming_init()
Date: Tue, 21 Apr 2020 10:52:54 +0200
Message-Id: <20200421085300.7734-8-david@redhat.com>
In-Reply-To: <20200421085300.7734-1-david@redhat.com>
References: <20200421085300.7734-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=david@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/21 04:54:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In case we grow our RAM after ram_postcopy_incoming_init() (e.g., when
synchronizing the RAM block state with the migration source), the resized
part would not get discarded. Let's perform that when being notified
about a resize while postcopy has been advised, but is not listening
yet. With precopy, the process is as following:

1. VM created
- RAM blocks are created
2. Incomming migration started
- Postcopy is advised
- All pages in RAM blocks are discarded
3. Precopy starts
- RAM blocks are resized to match the size on the migration source.
- RAM pages from precopy stream are loaded
- Uffd handler is registered, postcopy starts listening
4. Guest started, postcopy running
- Pagefaults get resolved, pages get placed

Reviewed-by: Peter Xu <peterx@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>
Cc: Peter Xu <peterx@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 migration/ram.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/migration/ram.c b/migration/ram.c
index d587ecbd92..2704d32def 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3756,6 +3756,7 @@ static SaveVMHandlers savevm_ram_handlers =3D {
 static void ram_mig_ram_block_resized(RAMBlockNotifier *n, void *host,
                                       size_t old_size, size_t new_size)
 {
+    PostcopyState ps =3D postcopy_state_get();
     ram_addr_t offset;
     Error *err =3D NULL;
     RAMBlock *rb =3D qemu_ram_block_from_host(host, false, &offset);
@@ -3776,6 +3777,35 @@ static void ram_mig_ram_block_resized(RAMBlockNotifi=
er *n, void *host,
         error_free(err);
         migration_cancel();
     }
+
+    switch (ps) {
+    case POSTCOPY_INCOMING_ADVISE:
+        /*
+         * Update what ram_postcopy_incoming_init()->init_range() does at =
the
+         * time postcopy was advised. Syncing RAM blocks with the source w=
ill
+         * result in RAM resizes.
+         */
+        if (old_size < new_size) {
+            if (ram_discard_range(rb->idstr, old_size, new_size - old_size=
)) {
+                error_report("RAM block '%s' discard of resized RAM failed=
",
+                             rb->idstr);
+            }
+        }
+        break;
+    case POSTCOPY_INCOMING_NONE:
+    case POSTCOPY_INCOMING_RUNNING:
+    case POSTCOPY_INCOMING_END:
+        /*
+         * Once our guest is running, postcopy does no longer care about
+         * resizes. When growing, the new memory was not available on the
+         * source, no handler needed.
+         */
+        break;
+    default:
+        error_report("RAM block '%s' resized during postcopy state: %d",
+                     rb->idstr, ps);
+        exit(-1);
+    }
 }
=20
 static RAMBlockNotifier ram_mig_ram_notifier =3D {
--=20
2.25.1


