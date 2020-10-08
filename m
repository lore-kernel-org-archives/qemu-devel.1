Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2C5EC433E7
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 08:32:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54BF2215A4
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 08:32:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hCsFv7GB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54BF2215A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQRLx-0000ce-Ao
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 04:32:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42912)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kQRKK-0007fX-OA
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 04:31:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38138)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kQRKI-0006UL-Rs
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 04:31:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602145862;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aTdtN2zUAy19rHWMCKzZPiBGRVnWwjTvuku/uO8M91Y=;
 b=hCsFv7GB/F1OdaLqXkz/QakpiPNdHcQr7mY9wKkVk5D3sPqv9nrd3XQMoCuVY/zUUJHnFV
 pe9qjOjVfihYNfKBjUMmI4mIUI6zDTO6OgiG/0eK7RD3llhG/5S1sREu4h1lJzOIjh8Suz
 HrnUhC6ux0xF1rHZ8kNq3ayS4oqqtGo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-509-DUJhYAWGMy22dKuxdOe13A-1; Thu, 08 Oct 2020 04:31:00 -0400
X-MC-Unique: DUJhYAWGMy22dKuxdOe13A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B58FF18BE164;
 Thu,  8 Oct 2020 08:30:58 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-112.ams2.redhat.com [10.36.114.112])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F1DA65C1BD;
 Thu,  8 Oct 2020 08:30:53 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 4/6] memory-device: Support big alignment requirements
Date: Thu,  8 Oct 2020 10:30:27 +0200
Message-Id: <20201008083029.9504-5-david@redhat.com>
In-Reply-To: <20201008083029.9504-1-david@redhat.com>
References: <20201008083029.9504-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/08 02:56:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.742,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Wei Yang <richardw.yang@linux.intel.com>, Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Let's warn instead of bailing out - the worst thing that can happen is
that we'll fail hot/coldplug later. The user got warned, and this should
be rare.

This will be necessary for memory devices with rather big (user-defined)
alignment requirements - say a virtio-mem device with a 2G block size -
which will become important, for example, when supporting vfio in the
future.

Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Wei Yang <richardw.yang@linux.intel.com>
Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/mem/memory-device.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
index 4bc9cf0917..8a736f1a26 100644
--- a/hw/mem/memory-device.c
+++ b/hw/mem/memory-device.c
@@ -119,9 +119,10 @@ static uint64_t memory_device_get_free_addr(MachineState *ms,
 
     /* start of address space indicates the maximum alignment we expect */
     if (!QEMU_IS_ALIGNED(range_lob(&as), align)) {
-        error_setg(errp, "the alignment (0x%" PRIx64 ") is not supported",
-                   align);
-        return 0;
+        warn_report("the alignment (0x%" PRIx64 ") exceeds the expected"
+                    " maximum alignment, memory will get fragmented and not"
+                    " all 'maxmem' might be usable for memory devices.",
+                    align);
     }
 
     memory_device_check_addable(ms, size, &err);
@@ -151,7 +152,7 @@ static uint64_t memory_device_get_free_addr(MachineState *ms,
             return 0;
         }
     } else {
-        if (range_init(&new, range_lob(&as), size)) {
+        if (range_init(&new, QEMU_ALIGN_UP(range_lob(&as), align), size)) {
             error_setg(errp, "can't add memory device, device too big");
             return 0;
         }
-- 
2.26.2


