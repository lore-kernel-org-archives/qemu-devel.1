Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D724EC3F2CD
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 14:34:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A432E20732
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 14:34:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MsYyAbrO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A432E20732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9raN-0004qe-Ni
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 09:34:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35577)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1j9rXN-0007rT-Ph
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 09:31:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1j9rXI-0002rW-MP
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 09:31:45 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:53051
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1j9rXI-0002rD-I0
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 09:31:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583418700;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H1vGZKqDhRtg8g2lSBh3C+rY8EjMrCl2v+tMPCxz9io=;
 b=MsYyAbrOF3gFRlQ7tnAYc72bXbR1dzCc/70ZkX7iCtmznTo0zUuli3RmNKclJawXsxCstG
 ceHAE7uAe0Uj7g5u2xwXwkYuhPJ5W1gL8kZaS5Lno0/CJWfYKR63Qqfhc8pVwl3ABS9D8l
 2P2NJB0OtlLtboXNhtr7+shFhy/6g48=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-5rRkZvsoMnC8HeoaK5BQaA-1; Thu, 05 Mar 2020 09:31:38 -0500
X-MC-Unique: 5rRkZvsoMnC8HeoaK5BQaA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5B4DA107ACC4;
 Thu,  5 Mar 2020 14:31:34 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-120-166.rdu2.redhat.com [10.10.120.166])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4724F90538;
 Thu,  5 Mar 2020 14:31:20 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 04/15] exec: Factor out setting ram settings (madvise ...)
 into qemu_ram_apply_settings()
Date: Thu,  5 Mar 2020 15:29:34 +0100
Message-Id: <20200305142945.216465-5-david@redhat.com>
In-Reply-To: <20200305142945.216465-1-david@redhat.com>
References: <20200305142945.216465-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Igor Kotrasinski <i.kotrasinsk@partner.samsung.com>,
 David Hildenbrand <david@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>,
 Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
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
Reviewed-by: Peter Xu <peterx@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 exec.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/exec.c b/exec.c
index 3e980e14e0..13a0ca91fb 100644
--- a/exec.c
+++ b/exec.c
@@ -2069,6 +2069,21 @@ static int memory_try_enable_merging(void *addr, siz=
e_t len)
     return qemu_madvise(addr, len, QEMU_MADV_MERGEABLE);
 }
=20
+static void qemu_ram_apply_settings(void *host, size_t length)
+{
+    memory_try_enable_merging(host, length);
+    qemu_ram_setup_dump(host, length);
+    qemu_madvise(host, length, QEMU_MADV_HUGEPAGE);
+    /*
+     * MADV_DONTFORK is also needed by KVM in absence of synchronous MMU
+     * Configure it unless the machine is a qtest server, in which case KV=
M is
+     * not used and it may be forked (eg for fuzzing purposes).
+     */
+    if (!qtest_enabled()) {
+        qemu_madvise(host, length, QEMU_MADV_DONTFORK);
+    }
+}
+
 /*
  * Resizing RAM while migrating can result in the migration being canceled=
.
  * Care has to be taken if the guest might have already detected the memor=
y.
@@ -2227,7 +2242,6 @@ static void ram_block_add(RAMBlock *new_block, Error =
**errp, bool shared)
                 qemu_mutex_unlock_ramlist();
                 return;
             }
-            memory_try_enable_merging(new_block->host, new_block->max_leng=
th);
         }
     }
=20
@@ -2265,17 +2279,7 @@ static void ram_block_add(RAMBlock *new_block, Error=
 **errp, bool shared)
                                         DIRTY_CLIENTS_ALL);
=20
     if (new_block->host) {
-        qemu_ram_setup_dump(new_block->host, new_block->max_length);
-        qemu_madvise(new_block->host, new_block->max_length, QEMU_MADV_HUG=
EPAGE);
-        /*
-         * MADV_DONTFORK is also needed by KVM in absence of synchronous M=
MU
-         * Configure it unless the machine is a qtest server, in which cas=
e
-         * KVM is not used and it may be forked (eg for fuzzing purposes).
-         */
-        if (!qtest_enabled()) {
-            qemu_madvise(new_block->host, new_block->max_length,
-                         QEMU_MADV_DONTFORK);
-        }
+        qemu_ram_apply_settings(new_block->host, new_block->max_length);
         ram_block_notify_add(new_block->host, new_block->used_length,
                              new_block->max_length);
     }
--=20
2.24.1


