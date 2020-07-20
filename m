Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D1A7C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 14:18:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3925320B1F
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 14:18:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HZjKvZOE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3925320B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxWcr-0004xt-ER
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 10:18:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57108)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jxWag-00014Y-Nw
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 10:16:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38728
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jxWaf-0002lk-34
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 10:16:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595254584;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7bNJFBT29B95LO3FLXiU5YcyXTspzQqwbp25IxUclUs=;
 b=HZjKvZOEv6iHnMfG6Rlo5hoxu1jMoCsIISsDZnnsBd9fF+pCrOx6C+Ud92wVUtKhm0DKH9
 E1c8nGd2xpZWqIgqXjgyDCNLPyfdszKLm0E+VoEmH2GecNBT1Y7lBKBhoXFjlP68pnDV5R
 QIQSQdIRSnClyDcyroWmPi8nKmW1a7I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-1z-WW270NfaMqCvRKCdmcA-1; Mon, 20 Jul 2020 10:16:21 -0400
X-MC-Unique: 1z-WW270NfaMqCvRKCdmcA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 799621902EBB;
 Mon, 20 Jul 2020 14:16:16 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A505F2B6E2;
 Mon, 20 Jul 2020 14:16:15 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/6] x86: cpuhp: refuse cpu hot-unplug request earlier if not
 supported
Date: Mon, 20 Jul 2020 10:16:07 -0400
Message-Id: <20200720141610.574308-4-imammedo@redhat.com>
In-Reply-To: <20200720141610.574308-1-imammedo@redhat.com>
References: <20200720141610.574308-1-imammedo@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=imammedo@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/20 02:11:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: boris.ostrovsky@oracle.com, lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

CPU hot-unplug with SMM requires firmware participation to prevent
guest crash (i.e. CPU can be removed only after OS _and_ firmware
were prepared for th action).
Previous patches introduced ICH9_LPC_SMI_F_CPU_HOT_UNPLUG_BIT
feature bit, which is advertised by firmware when it has support
for CPU hot-unplug. Use it to check if guest is able to handle
unplug and make device_del fail gracefully if hot-unplug feature
hasn't been negotiated.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/acpi/ich9.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
index 0acc9a3107..98fc363186 100644
--- a/hw/acpi/ich9.c
+++ b/hw/acpi/ich9.c
@@ -460,6 +460,17 @@ void ich9_pm_device_unplug_request_cb(HotplugHandler *hotplug_dev,
                                       errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU) &&
                !lpc->pm.cpu_hotplug_legacy) {
+        uint64_t negotiated = lpc->smi_negotiated_features;
+
+        if (negotiated & BIT_ULL(ICH9_LPC_SMI_F_BROADCAST_BIT) &&
+            !(negotiated & BIT_ULL(ICH9_LPC_SMI_F_CPU_HOT_UNPLUG_BIT))) {
+            error_setg(errp, "cpu hot-unplug with SMI wasn't enabled "
+                             "by firmware");
+            error_append_hint(errp, "update machine type to newer than 5.1 "
+                "and firmware that suppors CPU hot-unplug with SMM");
+            return;
+        }
+
         acpi_cpu_unplug_request_cb(hotplug_dev, &lpc->pm.cpuhp_state,
                                    dev, errp);
     } else {
-- 
2.26.2


