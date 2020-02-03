Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA23C47409
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 18:37:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 740832086A
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 18:37:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DR5yf2i+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 740832086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iygb6-0006fo-MX
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 13:37:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59738)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1iygWI-00085W-Hj
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 13:32:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1iygWH-0001sK-7v
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 13:32:26 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52085
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1iygWH-0001nS-2S
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 13:32:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580754742;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uSoRvfHZP0DIGem7R7am7rIs7Mbai+dIKdgAkYMJUDg=;
 b=DR5yf2i+bbPiGj8la1EDouDtTIqOvCev1x3LVpXS7BOqOquaxSuwbj2v1d3t8QcVDSnHzo
 5lxhn9ho25aoGMH2eiJebJkuuKvHrNJsGrGdqIZCW9SsHpXLQAtrScp6QE4z56D2SMgN28
 304ofSO9JPRMIHQwa9G8iDadaizHQVc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-191-Z27IfSNpPGKynlNRQI0Ozw-1; Mon, 03 Feb 2020 13:32:21 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C702218B9FC3;
 Mon,  3 Feb 2020 18:32:19 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-117-77.ams2.redhat.com [10.36.117.77])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1C3FF5D9CA;
 Mon,  3 Feb 2020 18:32:17 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 10/13] numa: Introduce ram_block_notify_resized() and
 ram_block_notifiers_support_resize()
Date: Mon,  3 Feb 2020 19:31:22 +0100
Message-Id: <20200203183125.164879-11-david@redhat.com>
In-Reply-To: <20200203183125.164879-1-david@redhat.com>
References: <20200203183125.164879-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: Z27IfSNpPGKynlNRQI0Ozw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We want to actually resize ram blocks (make everything between
used_length and max_length inaccessible) - however, not all ram block
notifiers will support that.

So introduce a way to detect if any registered notifier does not support
it and add a way to notify all notifiers that support it.

Using ram_block_notifiers_support_resize(), we can keep the existing
handling for these special cases until they implement support (e.g.,
SEV, HAX) to resize.

Cc: Richard Henderson <rth@twiddle.net>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/core/numa.c         | 21 +++++++++++++++++++++
 include/exec/ramlist.h |  4 ++++
 util/trace-events      |  1 +
 3 files changed, 26 insertions(+)

diff --git a/hw/core/numa.c b/hw/core/numa.c
index fed4046680..5ccfcbcd41 100644
--- a/hw/core/numa.c
+++ b/hw/core/numa.c
@@ -940,3 +940,24 @@ void ram_block_notify_remove(void *host, size_t size)
         notifier->ram_block_removed(notifier, host, size);
     }
 }
+
+void ram_block_notify_resized(void *host, size_t oldsize, size_t newsize)
+{
+    RAMBlockNotifier *notifier;
+
+    QLIST_FOREACH(notifier, &ram_list.ramblock_notifiers, next) {
+        notifier->ram_block_resized(notifier, host, oldsize, newsize);
+    }
+}
+
+bool ram_block_notifiers_support_resize(void)
+{
+    RAMBlockNotifier *notifier;
+
+    QLIST_FOREACH(notifier, &ram_list.ramblock_notifiers, next) {
+        if (!notifier->ram_block_resized) {
+            return false;
+        }
+    }
+    return true;
+}
diff --git a/include/exec/ramlist.h b/include/exec/ramlist.h
index bc4faa1b00..33a380cbee 100644
--- a/include/exec/ramlist.h
+++ b/include/exec/ramlist.h
@@ -67,6 +67,8 @@ void qemu_mutex_unlock_ramlist(void);
 struct RAMBlockNotifier {
     void (*ram_block_added)(RAMBlockNotifier *n, void *host, size_t size);
     void (*ram_block_removed)(RAMBlockNotifier *n, void *host, size_t size=
);
+    void (*ram_block_resized)(RAMBlockNotifier *n, void *host, size_t olds=
ize,
+                              size_t newsize);
     QLIST_ENTRY(RAMBlockNotifier) next;
 };
=20
@@ -74,6 +76,8 @@ void ram_block_notifier_add(RAMBlockNotifier *n);
 void ram_block_notifier_remove(RAMBlockNotifier *n);
 void ram_block_notify_add(void *host, size_t size);
 void ram_block_notify_remove(void *host, size_t size);
+void ram_block_notify_resized(void *host, size_t oldsize, size_t newsize);
+bool ram_block_notifiers_support_resize(void);
=20
 void ram_block_dump(Monitor *mon);
=20
diff --git a/util/trace-events b/util/trace-events
index 83b6639018..226f406c46 100644
--- a/util/trace-events
+++ b/util/trace-events
@@ -76,6 +76,7 @@ qemu_mutex_unlock(void *mutex, const char *file, const in=
t line) "released mutex
 qemu_vfio_dma_reset_temporary(void *s) "s %p"
 qemu_vfio_ram_block_added(void *s, void *p, size_t size) "s %p host %p siz=
e 0x%zx"
 qemu_vfio_ram_block_removed(void *s, void *p, size_t size) "s %p host %p s=
ize 0x%zx"
+qemu_vfio_ram_block_resized(void *s, void *p, size_t oldsize, size_t newsi=
zze) "s %p host %p oldsize 0x%zx newsize 0x%zx"
 qemu_vfio_find_mapping(void *s, void *p) "s %p host %p"
 qemu_vfio_new_mapping(void *s, void *host, size_t size, int index, uint64_=
t iova) "s %p host %p size %zu index %d iova 0x%"PRIx64
 qemu_vfio_do_mapping(void *s, void *host, size_t size, uint64_t iova) "s %=
p host %p size %zu iova 0x%"PRIx64
--=20
2.24.1


