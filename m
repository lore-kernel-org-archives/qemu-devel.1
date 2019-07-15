Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81382C76195
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 14:28:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D0FD205ED
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 14:28:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D0FD205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hn1yJ-0003QN-Il
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 10:28:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34014)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.williamson@redhat.com>) id 1hn1y9-00031u-1e
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 10:28:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1hn1y8-0005bD-37
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 10:28:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56114)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1hn1y7-0005ZT-TZ
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 10:28:44 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id F15FE31628E5;
 Mon, 15 Jul 2019 14:28:41 +0000 (UTC)
Received: from gimli.home (ovpn-116-35.phx2.redhat.com [10.3.116.35])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4CA145D9C8;
 Mon, 15 Jul 2019 14:28:39 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 15 Jul 2019 08:28:39 -0600
Message-ID: <156320087103.2556.10983987500488190423.stgit@gimli.home>
User-Agent: StGit/0.19-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Mon, 15 Jul 2019 14:28:42 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH for-4.1] target/i386: sev: Do not unpin ram
 device memory region
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
Cc: pbonzini@redhat.com, brijesh.singh@amd.com, ehabkost@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The commit referenced below skipped pinning ram device memory when
ram blocks are added, we need to do the same when they're removed.

Cc: Brijesh Singh <brijesh.singh@amd.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Fixes: cedc0ad539af ("target/i386: sev: Do not pin the ram device memory region")
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 target/i386/sev.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 6dbdc3cdf10f..5ba1384ea1f6 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -161,6 +161,17 @@ sev_ram_block_removed(RAMBlockNotifier *n, void *host, size_t size)
 {
     int r;
     struct kvm_enc_region range;
+    ram_addr_t offset;
+    MemoryRegion *mr;
+
+    /*
+     * The RAM device presents a memory region that should be treated
+     * as IO region and should not have been pinned.
+     */
+    mr = memory_region_from_host(host, &offset);
+    if (mr && memory_region_is_ram_device(mr)) {
+        return;
+    }
 
     range.addr = (__u64)(unsigned long)host;
     range.size = size;


