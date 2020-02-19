Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B85C34047
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 16:41:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B86724654
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 16:41:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NYfme8wA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B86724654
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4SPf-00068I-La
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 11:41:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39124)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1j4S3j-0001gj-C2
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:18:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1j4S3i-0004SO-8m
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:18:47 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30180
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1j4S3i-0004SG-4n
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:18:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582129125;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=weIuyWpQ4HsRvv7hJb8wpGUr7pFtv7kXTouN3VzlJG8=;
 b=NYfme8wAqtIVfndFbrelMm+bDEEjSI8aN/biru7HPcGlN1srgOmzLtNLdiCMTLUfbA8geL
 /jtoWV+muTBcxeLRjzLk0g5kz/TGdb9x8vhn7YE8Rdwe754WeF8r2oF5AuH+KqAGaAWXO8
 pcKo/CPN9cicBY7KqmHemN6BpMLnucE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-w2FeIq_HP8S8yURxRV0JZg-1; Wed, 19 Feb 2020 11:18:44 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 25B24109BFC6;
 Wed, 19 Feb 2020 16:18:43 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-116-151.ams2.redhat.com [10.36.116.151])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E335C89F13;
 Wed, 19 Feb 2020 16:18:35 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 04/13] numa: Make all callbacks of ram block notifiers
 optional
Date: Wed, 19 Feb 2020 17:17:16 +0100
Message-Id: <20200219161725.115218-5-david@redhat.com>
In-Reply-To: <20200219161725.115218-1-david@redhat.com>
References: <20200219161725.115218-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: w2FeIq_HP8S8yURxRV0JZg-1
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Let's make add/remove optional. We want to introduce a RAM block
notifier for RAM migration, that's only interested in resizes.

Cc: Richard Henderson <rth@twiddle.net>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Peter Xu <peterx@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/core/numa.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/hw/core/numa.c b/hw/core/numa.c
index e28ad24fcd..4270b268c8 100644
--- a/hw/core/numa.c
+++ b/hw/core/numa.c
@@ -915,8 +915,11 @@ static int ram_block_notify_add_single(RAMBlock *rb, v=
oid *opaque)
 void ram_block_notifier_add(RAMBlockNotifier *n)
 {
     QLIST_INSERT_HEAD(&ram_list.ramblock_notifiers, n, next);
+
     /* Notify about all existing ram blocks. */
-    qemu_ram_foreach_block(ram_block_notify_add_single, n);
+    if (n->ram_block_added) {
+        qemu_ram_foreach_block(ram_block_notify_add_single, n);
+    }
 }
=20
 void ram_block_notifier_remove(RAMBlockNotifier *n)
@@ -929,7 +932,9 @@ void ram_block_notify_add(void *host, size_t size, size=
_t max_size)
     RAMBlockNotifier *notifier;
=20
     QLIST_FOREACH(notifier, &ram_list.ramblock_notifiers, next) {
-        notifier->ram_block_added(notifier, host, size, max_size);
+        if (notifier->ram_block_added) {
+            notifier->ram_block_added(notifier, host, size, max_size);
+        }
     }
 }
=20
@@ -938,7 +943,9 @@ void ram_block_notify_remove(void *host, size_t size, s=
ize_t max_size)
     RAMBlockNotifier *notifier;
=20
     QLIST_FOREACH(notifier, &ram_list.ramblock_notifiers, next) {
-        notifier->ram_block_removed(notifier, host, size, max_size);
+        if (notifier->ram_block_removed) {
+            notifier->ram_block_removed(notifier, host, size, max_size);
+        }
     }
 }
=20
--=20
2.24.1


