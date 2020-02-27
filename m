Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1496DC4BA24
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 10:24:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D63C624672
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 10:24:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hXlM70B8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D63C624672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7GLR-0005qm-1e
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 05:24:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40517)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1j7GC4-0004OL-UP
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 05:15:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1j7GC2-0001Yj-SD
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 05:15:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46519
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1j7GC1-0001UP-OQ
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 05:14:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582798495;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7BJc03B0S3OKlAGbitvN5dpmwN+YdFl+CckVsdEMIJE=;
 b=hXlM70B8tOAzpRMxZ+K6shhKr5Sxo92s1+0soFC3m0f2Xprd1Ewm00+fs5fjUpewe8qXl/
 WgUO26UflAK1xv9RmUIrhfXTgWoWEBLNz2pjl1MhivYow/GX/TtZnsrSiLLUPj1XtwipLg
 rG23B9NSoTHgHp2VM4qufCuG36MU4cA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-175-9Yix3FYUNNGWA9dC4mphqg-1; Thu, 27 Feb 2020 05:14:53 -0500
X-MC-Unique: 9Yix3FYUNNGWA9dC4mphqg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 40B538017CC;
 Thu, 27 Feb 2020 10:14:52 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-116-36.ams2.redhat.com [10.36.116.36])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C7EA06E3EE;
 Thu, 27 Feb 2020 10:14:47 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 14/15] numa: Introduce ram_block_notifiers_support_resize()
Date: Thu, 27 Feb 2020 11:12:04 +0100
Message-Id: <20200227101205.5616-15-david@redhat.com>
In-Reply-To: <20200227101205.5616-1-david@redhat.com>
References: <20200227101205.5616-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Kotrasinski <i.kotrasinsk@partner.samsung.com>,
 David Hildenbrand <david@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>,
 Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We want to actually use resizeable allocations in resizeable ram blocks
(IOW, make everything between used_length and max_length inaccessible) -
however, not all ram block notifiers can support that.

Introduce a way to detect if any registered notifier does not
support resizes - ram_block_notifiers_support_resize() - which we can later
use to fallback to legacy handling if a registered notifier (esp., SEV and
HAX) does not support actual resizes.

Cc: Richard Henderson <rth@twiddle.net>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/core/numa.c         | 12 ++++++++++++
 include/exec/ramlist.h |  1 +
 2 files changed, 13 insertions(+)

diff --git a/hw/core/numa.c b/hw/core/numa.c
index 37ce175e13..1d5288c22c 100644
--- a/hw/core/numa.c
+++ b/hw/core/numa.c
@@ -914,3 +914,15 @@ void ram_block_notify_resize(void *host, size_t old_si=
ze, size_t new_size)
         }
     }
 }
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
index 293c0ddabe..ac5811be96 100644
--- a/include/exec/ramlist.h
+++ b/include/exec/ramlist.h
@@ -79,6 +79,7 @@ void ram_block_notifier_remove(RAMBlockNotifier *n);
 void ram_block_notify_add(void *host, size_t size, size_t max_size);
 void ram_block_notify_remove(void *host, size_t size, size_t max_size);
 void ram_block_notify_resize(void *host, size_t old_size, size_t new_size)=
;
+bool ram_block_notifiers_support_resize(void);
=20
 void ram_block_dump(Monitor *mon);
=20
--=20
2.24.1


