Return-Path: <SRS0=qR42=YW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34350CA9EAE
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 16:27:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2B1D20717
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 16:27:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kiUdGpbH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2B1D20717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPULD-00084I-Qu
	for qemu-devel@archiver.kernel.org; Tue, 29 Oct 2019 12:27:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50681)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iPUGm-00023G-Bk
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 12:22:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iPUGl-0004tP-8i
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 12:22:56 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:35818)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iPUGl-0004qz-2L
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 12:22:55 -0400
Received: by mail-wm1-x343.google.com with SMTP id x5so3086377wmi.0
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2019 09:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=CKVENrRxKr+yy55UKAYjTBDTqL1/JJ86swpmf0+y21k=;
 b=kiUdGpbH6NIroU7ZuajNuTodiCcmbzoX5gUPPTF47CgCtM6wqFmcI6SgBBC+kmlqfc
 efD32n+GdDo5zI/TGaKn3ih9o/4SGSgrAYkNqC4txbnxIp4rYEOFQxWYBD8Lvtk3gZWc
 tXZIwLQ/x2gTFKcLt+ki7MXHTvJlLX4ww8Y35T1T1B+YO5qvgaPcDbJXz03woidYQhR+
 SikxhFFIUAqyGt+GAJP7mG4kd8ekco5nes6vnZIZ5d9/RNKeTYgeUvT765RyDrZvXXiM
 BX8V6PhJl/CqzVuPeZyKVj+NhQ44+umKUHh1VoLa3hBuwdpCNWUrQ7NTe/MxWEDsrHl5
 tTVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=CKVENrRxKr+yy55UKAYjTBDTqL1/JJ86swpmf0+y21k=;
 b=bWZ90PkoIxkIP+bjTMngCPKuYAFxsqRV5cCLAXYVm+w6lYGh116iOsKoHq2Bl7vUZk
 5Mt1GygjDyuI8hmtQKmE2BcdoOLyr4AylgTHqaslTMT2mY+tuByo5Xs6g5H4jh9ARCb1
 UlTfVl2kHYsCdb/MrOdY8OPr5PRDslNYlB74Fixil1oEVoOhBo5BApvq4c/aHRVfUu6R
 oK2rfwZkUW1T4v7Mf89q7dEzCl1dwjfp0UCk+bqFY6JwTLoB9+aFrNs/ARWx350nXnGv
 tzcBnjZW7+sjyyA+tneGggJoPDC32gXZ6e5Z00x39VFQnkV9sXdzPA08Q67nP8SfKXtV
 yoEQ==
X-Gm-Message-State: APjAAAU+gg5l5wre4InEHuJWeoI2VB1JRAIFaZni77TuPLiBiDGPDDTn
 UkbW7Y6bR+IckU3UOamecAifFHkkrJw=
X-Google-Smtp-Source: APXvYqzQFpN5cGz5sytcAt3c1aTii/pnU0NgsWJ2Rfo7Cznb8YtKkDU8tvC877rZuoMq0HAfiOCTHA==
X-Received: by 2002:a1c:a791:: with SMTP id q139mr4750556wme.155.1572366173776; 
 Tue, 29 Oct 2019 09:22:53 -0700 (PDT)
Received: from donizetti.metropole.lan (94.222.26.109.rev.sfr.net.
 [109.26.222.94])
 by smtp.gmail.com with ESMTPSA id q12sm9285661wrw.91.2019.10.29.09.22.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2019 09:22:52 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/6] memory: adjust API documentation to (modified) kerneldoc
 format
Date: Tue, 29 Oct 2019 17:22:46 +0100
Message-Id: <20191029162248.13383-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191029162248.13383-1-pbonzini@redhat.com>
References: <20191029162248.13383-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix a few instances where kernel-doc complains about doc comments
in memory.h.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/exec/memory.h | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index e499dc215b..1e875996ec 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -360,10 +360,14 @@ typedef struct IOMMUMemoryRegionClass {
 typedef struct CoalescedMemoryRange CoalescedMemoryRange;
 typedef struct MemoryRegionIoeventfd MemoryRegionIoeventfd;
 
+/** MemoryRegion:
+ *
+ * A struct representing a memory region.
+ */
 struct MemoryRegion {
     Object parent_obj;
 
-    /* All fields are private - violators will be prosecuted */
+    /* private: */
 
     /* The following fields should fit in a cache line */
     bool romd_mode;
@@ -452,7 +456,7 @@ struct MemoryListener {
  * AddressSpace: describes a mapping of addresses to #MemoryRegion objects
  */
 struct AddressSpace {
-    /* All fields are private. */
+    /* private: */
     struct rcu_head rcu;
     char *name;
     MemoryRegion *root;
@@ -1673,8 +1677,8 @@ bool memory_region_is_mapped(MemoryRegion *mr);
  *
  * Returns a #MemoryRegionSection that describes a contiguous overlap.
  * It will have the following characteristics:
- *    .@size = 0 iff no overlap was found
- *    .@mr is non-%NULL iff an overlap was found
+ * - @size = 0 iff no overlap was found
+ * - @mr is non-%NULL iff an overlap was found
  *
  * Remember that in the return value the @offset_within_region is
  * relative to the returned region (in the .@mr field), not to the
@@ -1685,8 +1689,8 @@ bool memory_region_is_mapped(MemoryRegion *mr);
  * returned one.  However, in the special case where the @mr argument
  * has no container (and thus is the root of the address space), the
  * following will hold:
- *    .@offset_within_address_space >= @addr
- *    .@offset_within_address_space + .@size <= @addr + @size
+ * - @offset_within_address_space >= @addr
+ * - @offset_within_address_space + .@size <= @addr + @size
  *
  * @mr: a MemoryRegion within which @addr is a relative address
  * @addr: start of the area within @as to be searched
-- 
2.21.0



