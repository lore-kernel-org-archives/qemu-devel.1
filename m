Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2CA8C4BA13
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 15:54:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B281621556
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 15:54:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QSOtY/IB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B281621556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6z1R-000420-Pn
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 10:54:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33866)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1j6z06-0002QV-Px
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 10:53:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1j6z04-0002Ed-Jg
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 10:53:29 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39644
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1j6z04-0002Dg-9U
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 10:53:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582732407;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4OCFmF6ltN/CWDF6D+mlr5dH63y+a50VJFncESwHm6I=;
 b=QSOtY/IB/9FY+BeJqUKJzCVaFIzP5MipblaMpi1lg3WV2w14/yF7cgKo8nMmQSj+D6ad6g
 IcQDStMPZesQE6qkA8Wy/tHm07vnyQs6ph6DBBWj6aSHe3jKflbWLl7a+HXlyP6A0XWygo
 x4P16itpEUBasjuTC12qKMy/jsiXaao=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-k2EybYVRPi6n97NCc--TLw-1; Wed, 26 Feb 2020 10:53:25 -0500
X-MC-Unique: k2EybYVRPi6n97NCc--TLw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 67BFF190B2B7;
 Wed, 26 Feb 2020 15:53:24 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-117-196.ams2.redhat.com [10.36.117.196])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E8D72101D482;
 Wed, 26 Feb 2020 15:53:21 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 01/13] util: vfio-helpers: Factor out and fix processing of
 existing ram blocks
Date: Wed, 26 Feb 2020 16:52:52 +0100
Message-Id: <20200226155304.60219-2-david@redhat.com>
In-Reply-To: <20200226155304.60219-1-david@redhat.com>
References: <20200226155304.60219-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
 David Hildenbrand <david@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Factor it out into common code when a new notifier is registered, just
as done with the memory region notifier. This allows us to have the
logic about how to process existing ram blocks at a central place (which
will be extended soon).

Just like when adding a new ram block, we have to register the max_length
for now. We don't have a way to get notified about resizes yet, and some
memory would not be mapped when growing the ram block.

Note: Currently, ram blocks are only "fake resized". All memory
(max_length) is accessible.

We can get rid of a bunch of functions in stubs/ram-block.c . Print the
warning from inside qemu_vfio_ram_block_added().

Reviewed-by: Peter Xu <peterx@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Peter Xu <peterx@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 exec.c                    |  5 +++++
 hw/core/numa.c            | 14 ++++++++++++++
 include/exec/cpu-common.h |  1 +
 util/vfio-helpers.c       | 29 ++++++++---------------------
 4 files changed, 28 insertions(+), 21 deletions(-)

diff --git a/exec.c b/exec.c
index 231d6e5641..b2a65b793f 100644
--- a/exec.c
+++ b/exec.c
@@ -1965,6 +1965,11 @@ ram_addr_t qemu_ram_get_used_length(RAMBlock *rb)
     return rb->used_length;
 }
=20
+ram_addr_t qemu_ram_get_max_length(RAMBlock *rb)
+{
+    return rb->max_length;
+}
+
 bool qemu_ram_is_shared(RAMBlock *rb)
 {
     return rb->flags & RAM_SHARED;
diff --git a/hw/core/numa.c b/hw/core/numa.c
index 316bc50d75..dc5e5b4046 100644
--- a/hw/core/numa.c
+++ b/hw/core/numa.c
@@ -854,9 +854,23 @@ void query_numa_node_mem(NumaNodeMem node_mem[], Machi=
neState *ms)
     }
 }
=20
+static int ram_block_notify_add_single(RAMBlock *rb, void *opaque)
+{
+    const ram_addr_t max_size =3D qemu_ram_get_max_length(rb);
+    void *host =3D qemu_ram_get_host_addr(rb);
+    RAMBlockNotifier *notifier =3D opaque;
+
+    if (host) {
+        notifier->ram_block_added(notifier, host, max_size);
+    }
+    return 0;
+}
+
 void ram_block_notifier_add(RAMBlockNotifier *n)
 {
     QLIST_INSERT_HEAD(&ram_list.ramblock_notifiers, n, next);
+    /* Notify about all existing ram blocks. */
+    qemu_ram_foreach_block(ram_block_notify_add_single, n);
 }
=20
 void ram_block_notifier_remove(RAMBlockNotifier *n)
diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index b47e5630e7..09decb8d93 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -59,6 +59,7 @@ const char *qemu_ram_get_idstr(RAMBlock *rb);
 void *qemu_ram_get_host_addr(RAMBlock *rb);
 ram_addr_t qemu_ram_get_offset(RAMBlock *rb);
 ram_addr_t qemu_ram_get_used_length(RAMBlock *rb);
+ram_addr_t qemu_ram_get_max_length(RAMBlock *rb);
 bool qemu_ram_is_shared(RAMBlock *rb);
 bool qemu_ram_is_uf_zeroable(RAMBlock *rb);
 void qemu_ram_set_uf_zeroable(RAMBlock *rb);
diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
index ddd9a96e76..260570ae19 100644
--- a/util/vfio-helpers.c
+++ b/util/vfio-helpers.c
@@ -376,8 +376,14 @@ static void qemu_vfio_ram_block_added(RAMBlockNotifier=
 *n,
                                       void *host, size_t size)
 {
     QEMUVFIOState *s =3D container_of(n, QEMUVFIOState, ram_notifier);
+    int ret;
+
     trace_qemu_vfio_ram_block_added(s, host, size);
-    qemu_vfio_dma_map(s, host, size, false, NULL);
+    ret =3D qemu_vfio_dma_map(s, host, size, false, NULL);
+    if (ret) {
+        error_report("qemu_vfio_dma_map(%p, %zu) failed: %s", host, size,
+                     strerror(-ret));
+    }
 }
=20
 static void qemu_vfio_ram_block_removed(RAMBlockNotifier *n,
@@ -390,33 +396,14 @@ static void qemu_vfio_ram_block_removed(RAMBlockNotif=
ier *n,
     }
 }
=20
-static int qemu_vfio_init_ramblock(RAMBlock *rb, void *opaque)
-{
-    void *host_addr =3D qemu_ram_get_host_addr(rb);
-    ram_addr_t length =3D qemu_ram_get_used_length(rb);
-    int ret;
-    QEMUVFIOState *s =3D opaque;
-
-    if (!host_addr) {
-        return 0;
-    }
-    ret =3D qemu_vfio_dma_map(s, host_addr, length, false, NULL);
-    if (ret) {
-        fprintf(stderr, "qemu_vfio_init_ramblock: failed %p %" PRId64 "\n"=
,
-                host_addr, (uint64_t)length);
-    }
-    return 0;
-}
-
 static void qemu_vfio_open_common(QEMUVFIOState *s)
 {
     qemu_mutex_init(&s->lock);
     s->ram_notifier.ram_block_added =3D qemu_vfio_ram_block_added;
     s->ram_notifier.ram_block_removed =3D qemu_vfio_ram_block_removed;
-    ram_block_notifier_add(&s->ram_notifier);
     s->low_water_mark =3D QEMU_VFIO_IOVA_MIN;
     s->high_water_mark =3D QEMU_VFIO_IOVA_MAX;
-    qemu_ram_foreach_block(qemu_vfio_init_ramblock, s);
+    ram_block_notifier_add(&s->ram_notifier);
 }
=20
 /**
--=20
2.24.1


