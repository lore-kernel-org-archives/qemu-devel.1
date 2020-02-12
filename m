Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9060CC2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 13:50:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DC2E206B6
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 13:50:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XMz2kupM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DC2E206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1sOu-0000I7-HA
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 08:50:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39304)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1j1sIl-000753-Hd
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 08:43:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1j1sIk-00044X-Dj
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 08:43:39 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58922
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1j1sIk-000447-9u
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 08:43:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581515017;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zxlDY+iam1eGvrSP9JAuoFgfMKsrZ8lZwfOq1IgFDoE=;
 b=XMz2kupMbqLyupEc6zIXNc+UBJEXSjpkdUp/ukzeLmdrcXENIBJ+zMoCcNTiUTBJjnqvIV
 uiGqoSoLb4EjPbdTN+6L2z8bgp5vU3T3JsHBrLehdipEXVWanEc7MoMrZTSM1Fjq3xA2RW
 o3ySSkNMGX5+8JiLbkpnrQ9jdqctaF4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-56-5VpgLspdNxWtiMZ0y68tQQ-1; Wed, 12 Feb 2020 08:43:34 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 20B65800D4E;
 Wed, 12 Feb 2020 13:43:33 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-117-92.ams2.redhat.com [10.36.117.92])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3084C1001B08;
 Wed, 12 Feb 2020 13:43:31 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 fixed 05/16] exec: Factor out setting ram settings (madvise
 ...) into qemu_ram_apply_settings()
Date: Wed, 12 Feb 2020 14:42:43 +0100
Message-Id: <20200212134254.11073-6-david@redhat.com>
In-Reply-To: <20200212134254.11073-1-david@redhat.com>
References: <20200212134254.11073-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: 5VpgLspdNxWtiMZ0y68tQQ-1
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Factor all settings out into qemu_ram_apply_settings().

For memory_try_enable_merging(), the important bit is that it won't be
called with XEN - which is now still the case as new_block->host will
remain NULL.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
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


