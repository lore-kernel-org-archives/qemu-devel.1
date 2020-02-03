Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E4A9C35247
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 18:35:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBBDB2082E
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 18:35:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dSpHe/mn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBBDB2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iygZf-000458-2r
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 13:35:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58767)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1iygVj-0007kz-6q
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 13:31:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1iygVi-00019D-3H
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 13:31:51 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27237
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1iygVh-00017y-UG
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 13:31:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580754709;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kvMA1iTUz7bWWg5YdYdLUqhskNqbO7FnJlpl8r7fymQ=;
 b=dSpHe/mng+dhp4hL4eazonk+vyIRivbMTDVwFBwFkWC0VA29kluiukh5AnKJBqgjO2GLjP
 LoZrrTz+cZ08uqwrNMAinkJ+CTofzgCnG0ZLCp7lwQxBWEb98I89BzWgmHnsenN6Uu3qcr
 XzfrhOWnT6F5t7yBaWHvGn02gORn9NQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-87-8TepOKHpM62NcqZmZOBzHA-1; Mon, 03 Feb 2020 13:31:47 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7C2E0108442A;
 Mon,  3 Feb 2020 18:31:46 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-117-77.ams2.redhat.com [10.36.117.77])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F0D635D9CA;
 Mon,  3 Feb 2020 18:31:44 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 02/13] exec: Factor out setting ram settings (madvise ...)
 into qemu_ram_apply_settings()
Date: Mon,  3 Feb 2020 19:31:14 +0100
Message-Id: <20200203183125.164879-3-david@redhat.com>
In-Reply-To: <20200203183125.164879-1-david@redhat.com>
References: <20200203183125.164879-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: 8TepOKHpM62NcqZmZOBzHA-1
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Factor all settings out into qemu_ram_apply_settings().

For memory_try_enable_merging(), the important bit is that it won't be
called with XEN - which is now still the case as new_block->host will
remain NULL.

Cc: Richard Henderson <rth@twiddle.net>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 exec.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/exec.c b/exec.c
index 05cfe868ab..31a462a7d3 100644
--- a/exec.c
+++ b/exec.c
@@ -2121,6 +2121,15 @@ static int memory_try_enable_merging(void *addr, siz=
e_t len)
     return qemu_madvise(addr, len, QEMU_MADV_MERGEABLE);
 }
=20
+static void qemu_ram_apply_settings(void *host, size_t length)
+{
+    memory_try_enable_merging(host, length);
+    qemu_ram_setup_dump(host, length);
+    qemu_madvise(host, length, QEMU_MADV_HUGEPAGE);
+    /* MADV_DONTFORK is also needed by KVM in absence of synchronous MMU *=
/
+    qemu_madvise(host, length, QEMU_MADV_DONTFORK);
+}
+
 /* Only legal before guest might have detected the memory size: e.g. on
  * incoming migration, or right after reset.
  *
@@ -2271,7 +2280,6 @@ static void ram_block_add(RAMBlock *new_block, Error =
**errp, bool shared)
                 qemu_mutex_unlock_ramlist();
                 return;
             }
-            memory_try_enable_merging(new_block->host, new_block->max_leng=
th);
         }
     }
=20
@@ -2309,10 +2317,7 @@ static void ram_block_add(RAMBlock *new_block, Error=
 **errp, bool shared)
                                         DIRTY_CLIENTS_ALL);
=20
     if (new_block->host) {
-        qemu_ram_setup_dump(new_block->host, new_block->max_length);
-        qemu_madvise(new_block->host, new_block->max_length, QEMU_MADV_HUG=
EPAGE);
-        /* MADV_DONTFORK is also needed by KVM in absence of synchronous M=
MU */
-        qemu_madvise(new_block->host, new_block->max_length, QEMU_MADV_DON=
TFORK);
+        qemu_ram_apply_settings(new_block->host, new_block->max_length);
         ram_block_notify_add(new_block->host, new_block->max_length);
     }
 }
--=20
2.24.1


