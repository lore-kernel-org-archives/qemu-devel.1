Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE86C34047
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 16:43:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAF8420578
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 16:43:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FjsDRhqn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAF8420578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4SRN-0001e7-Tx
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 11:43:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39161)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1j4S3r-0001sk-24
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:18:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1j4S3q-0004Uh-3I
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:18:54 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32350
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1j4S3p-0004UV-Vj
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:18:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582129133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4eemmDcoP3QvnFaPO/GnjcJxYo3rxsRY3nqc5CLtRTI=;
 b=FjsDRhqnF6VSjjz/ig8RnpOz0O2w8Mu/mnT7i7Yr0H/3MxUUVvuyAfkzSsEDkPOHRuYO/S
 VqGm3NBe6+KQFMhLMZ3wJoYKqsT7NklC/VABS7e/B00//YFlhE58HHY5d1y0qW2VIkqnRE
 eV1JqDvNb9KSzWmLSS32RjvbodTmuvg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-28-atkPe6bKOru6A9p1WmwxpA-1; Wed, 19 Feb 2020 11:18:49 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5ACC61088385;
 Wed, 19 Feb 2020 16:18:48 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-116-151.ams2.redhat.com [10.36.116.151])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8D529811F8;
 Wed, 19 Feb 2020 16:18:46 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 06/13] migrate/ram: Discard new RAM when growing RAM blocks
 and the VM is stopped
Date: Wed, 19 Feb 2020 17:17:18 +0100
Message-Id: <20200219161725.115218-7-david@redhat.com>
In-Reply-To: <20200219161725.115218-1-david@redhat.com>
References: <20200219161725.115218-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: atkPe6bKOru6A9p1WmwxpA-1
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

In case we grow our RAM after ram_postcopy_incoming_init() (e.g., when
synchronizing the RAM block state with the migration source), the resized
part would not get discarded. Let's perform that when being notified
about a resize while postcopy has been advised and the guest is not
running yet.

Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>
Cc: Peter Xu <peterx@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 migration/ram.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/migration/ram.c b/migration/ram.c
index 57f32011a3..cbd54947fb 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3722,6 +3722,25 @@ static void ram_mig_ram_block_resized(RAMBlockNotifi=
er *n, void *host,
         return;
     }
=20
+    /*
+     * Especially at the start of precopy on the migration target, before
+     * starting postcopy, we synchronize the RAM block sizes. Let's make s=
ure
+     * that any resizes before starting the guest are properly handled by
+     * postcopy. Note: All other postcopy handling (e.g., registering hand=
lers,
+     * disabling THP) happens after all resizes (e.g., during precopy) wer=
e
+     * performed.
+     */
+    if (postcopy_is_advised() && !runstate_is_running()) {
+        /* Update what ram_postcopy_incoming_init()->init_range() does. */
+        if (old_size < new_size) {
+            if (ram_discard_range(rb->idstr, old_size, new_size - old_size=
)) {
+                error_report("RAM block '%s' discard of resized RAM failed=
",
+                             rb->idstr);
+            }
+        }
+        return;
+    }
+
     /*
      * Some resizes are triggered on the migration target by precopy code,
      * when synchronizing RAM block sizes. In these cases, the VM is not
--=20
2.24.1


