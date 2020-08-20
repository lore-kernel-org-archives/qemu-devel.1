Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F289CC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 00:33:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1C31208E4
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 00:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YqpYMZMZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1C31208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8YWk-00014l-N0
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 20:33:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49564)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1k8YDL-0006qz-96
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 20:13:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24999
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1k8YDJ-0002Pw-Jx
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 20:13:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597882432;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jhS4PN+Fw/eXOzgAR5OHWqgyUGZsVbiqn0VI42HR6xg=;
 b=YqpYMZMZ56JtwTy+0qSKsLM5Wc+Req7kW4bNd99fEhybYmEe0TJzOU06AnTrfRiQWCHvJT
 mOpqbyGmS9++OTabKz4zcebIETjb2T85AHMb9Nd6w0ygGEzgviW8S0l+ULrzbnQSSkXEQY
 GlbGUeYeF5K31sYcsVcnNsxE23/I/u8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-eghLf-TaPcGVLM5tZn6-hQ-1; Wed, 19 Aug 2020 20:13:51 -0400
X-MC-Unique: eghLf-TaPcGVLM5tZn6-hQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 24D388030A1;
 Thu, 20 Aug 2020 00:13:50 +0000 (UTC)
Received: from localhost (ovpn-117-244.rdu2.redhat.com [10.10.117.244])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DFA1C7BE98;
 Thu, 20 Aug 2020 00:13:49 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 30/58] ahci: Move QOM macros to header
Date: Wed, 19 Aug 2020 20:12:08 -0400
Message-Id: <20200820001236.1284548-31-ehabkost@redhat.com>
In-Reply-To: <20200820001236.1284548-1-ehabkost@redhat.com>
References: <20200820001236.1284548-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 20:13:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The TYPE_* constants and the typedefs are defined in ahci.h, so
we can move the type checking macros there too.

This will make future conversion to OBJECT_DECLARE* easier.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Changes series v1 -> v2: new patch in series v2

Cc: John Snow <jsnow@redhat.com>
Cc: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org
---
 hw/ide/ahci_internal.h | 5 -----
 include/hw/ide/ahci.h  | 3 +++
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/hw/ide/ahci_internal.h b/hw/ide/ahci_internal.h
index bab0459774..ac9bdead7b 100644
--- a/hw/ide/ahci_internal.h
+++ b/hw/ide/ahci_internal.h
@@ -332,9 +332,6 @@ struct AHCIPCIState {
     AHCIState ahci;
 };
 
-#define ICH_AHCI(obj) \
-    OBJECT_CHECK(AHCIPCIState, (obj), TYPE_ICH9_AHCI)
-
 extern const VMStateDescription vmstate_ahci;
 
 #define VMSTATE_AHCI(_field, _state) {                               \
@@ -394,6 +391,4 @@ void ahci_uninit(AHCIState *s);
 
 void ahci_reset(AHCIState *s);
 
-#define SYSBUS_AHCI(obj) OBJECT_CHECK(SysbusAHCIState, (obj), TYPE_SYSBUS_AHCI)
-
 #endif /* HW_IDE_AHCI_INTERNAL_H */
diff --git a/include/hw/ide/ahci.h b/include/hw/ide/ahci.h
index b44e3000cf..ce2bf8a5f8 100644
--- a/include/hw/ide/ahci.h
+++ b/include/hw/ide/ahci.h
@@ -53,11 +53,14 @@ typedef struct AHCIState {
 typedef struct AHCIPCIState AHCIPCIState;
 
 #define TYPE_ICH9_AHCI "ich9-ahci"
+#define ICH_AHCI(obj) \
+    OBJECT_CHECK(AHCIPCIState, (obj), TYPE_ICH9_AHCI)
 
 int32_t ahci_get_num_ports(PCIDevice *dev);
 void ahci_ide_create_devs(PCIDevice *dev, DriveInfo **hd);
 
 #define TYPE_SYSBUS_AHCI "sysbus-ahci"
+#define SYSBUS_AHCI(obj) OBJECT_CHECK(SysbusAHCIState, (obj), TYPE_SYSBUS_AHCI)
 
 typedef struct SysbusAHCIState {
     /*< private >*/
-- 
2.26.2


