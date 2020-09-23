Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35059C2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 11:41:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B382620663
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 11:41:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cl+jnQ7F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B382620663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL390-0001EX-IG
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 07:41:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35106)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kL37V-0008Mb-7I
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 07:39:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49048
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kL37J-0006uR-PF
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 07:39:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600861158;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rzgSlGw7H3J7S5y/h6O70w+/gWvkZWt2Ih2WpHAKQWo=;
 b=Cl+jnQ7Ft3xBIcKdcbg8RbMv7kTO+4lyDYpDH/8sj44wr/RNVuv1HV3OhAAVQk0JNHKGEW
 bZe67G07r+dFB4gwHM2InvrccD2uKRSc7MKE2zvjqW0tP5UGIvU9u/Tw4lSjk2fhHoyJ3j
 B5rUWlREl9Ro7EjMw3X552fLPqaUkOE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-175-YjO_PiCpP_OUH-SblpHfjw-1; Wed, 23 Sep 2020 07:39:14 -0400
X-MC-Unique: YjO_PiCpP_OUH-SblpHfjw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 79FA3801AB7;
 Wed, 23 Sep 2020 11:39:13 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-112-54.ams2.redhat.com [10.36.112.54])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F1928702E7;
 Wed, 23 Sep 2020 11:39:11 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 3/5] memory-device: Support big alignment requirements
Date: Wed, 23 Sep 2020 13:38:58 +0200
Message-Id: <20200923113900.72718-4-david@redhat.com>
In-Reply-To: <20200923113900.72718-1-david@redhat.com>
References: <20200923113900.72718-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=david@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 07:39:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


