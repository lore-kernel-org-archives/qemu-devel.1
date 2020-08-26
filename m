Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E22C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 14:40:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1001214F1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 14:40:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BHT026J7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1001214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAwan-0001Og-0g
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 10:40:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46260)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1kAwYX-0004sK-Rl
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 10:37:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40192)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1kAwYW-0006Cd-Es
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 10:37:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598452658;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=myzuQLMFrzrzm+iQjl6HxCd2/viSh0aOZ9bTWanImV8=;
 b=BHT026J70uVOjV/gQy7OvD06bdjUl9b5B2JZMspjz6RSL8M//heHYbhyTpW9E8HE1dkeif
 qxZvpe/8sqjYQIsr1CkffLpoR/9AWgYUuInYmZWW1G3gL3HnKeBetZ0vCOBte9bji9D0AJ
 VEYBjqopj+/ZJPdAPXmK1DTKvoBxUHY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-491-ye5iZrQCM9O2I99XGP3gFQ-1; Wed, 26 Aug 2020 10:37:36 -0400
X-MC-Unique: ye5iZrQCM9O2I99XGP3gFQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C448980F043;
 Wed, 26 Aug 2020 14:37:34 +0000 (UTC)
Received: from eperezma.remote.csb (ovpn-115-59.ams2.redhat.com [10.36.115.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 04B2D76E00;
 Wed, 26 Aug 2020 14:37:27 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Xu <peterx@redhat.com>
Subject: [RFC v6 02/13] memory: Add IOMMUTLBNotificationType to IOMMUTLBEntry
Date: Wed, 26 Aug 2020 16:36:40 +0200
Message-Id: <20200826143651.7915-3-eperezma@redhat.com>
In-Reply-To: <20200826143651.7915-1-eperezma@redhat.com>
References: <20200625191651.5817-1-eperezma@redhat.com>
 <20200826143651.7915-1-eperezma@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eperezma@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 23:30:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Yan Zhao <yan.y.zhao@intel.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Avi Kivity <avi@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This way we can tell between MAPs and UNMAP, and potentially avoid to
send them to a notifier that does not require them.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 include/exec/memory.h | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 22c5f564d1..f6d91c54aa 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -59,6 +59,12 @@ struct ReservedRegion {
 
 typedef struct IOMMUTLBEntry IOMMUTLBEntry;
 
+typedef enum {
+    IOMMU_IOTLB_NONE  = 0,
+    IOMMU_IOTLB_UNMAP = 1,
+    IOMMU_IOTLB_MAP   = 2,
+} IOMMUTLBNotificationType;
+
 /* See address_space_translate: bit 0 is read, bit 1 is write.  */
 typedef enum {
     IOMMU_NONE = 0,
@@ -70,11 +76,12 @@ typedef enum {
 #define IOMMU_ACCESS_FLAG(r, w) (((r) ? IOMMU_RO : 0) | ((w) ? IOMMU_WO : 0))
 
 struct IOMMUTLBEntry {
-    AddressSpace    *target_as;
-    hwaddr           iova;
-    hwaddr           translated_addr;
-    hwaddr           addr_mask;  /* 0xfff = 4k translation */
-    IOMMUAccessFlags perm;
+    AddressSpace            *target_as;
+    hwaddr                   iova;
+    hwaddr                   translated_addr;
+    hwaddr                   addr_mask;  /* 0xfff = 4k translation */
+    IOMMUAccessFlags         perm;
+    IOMMUTLBNotificationType type; /* Only valid if it is a notification */
 };
 
 /*
-- 
2.18.1


