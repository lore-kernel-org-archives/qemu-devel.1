Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B03C2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 09:54:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA4232076A
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 09:54:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NG+xBg+y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA4232076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL1TN-0006gB-NA
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 05:54:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35294)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kL1Mo-0006j4-4V
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 05:47:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30819)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kL1Mm-0007W7-Br
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 05:47:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600854431;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i8i04RflSSAEa8AF3BhF/y7h5IJuR6XGASJTy9nNJmQ=;
 b=NG+xBg+yrsIieyG/EQB2yGezWk+Z0CgVxNH1JMcKmvaFyZnxDTj9ME29gaEHDDCTKEZ+ih
 kP0yP+YWbKQPMHYp1/EJpY9/tH/2VdAYkA6b2vTUtIIf2Bw5Laq2cuKgfiDS47QnNwApzc
 iqMXiKAsMaLTn2g4EenguMAhL+PNd4U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-M3kV4D0TNiu3P2N9YWYgFw-1; Wed, 23 Sep 2020 05:47:07 -0400
X-MC-Unique: M3kV4D0TNiu3P2N9YWYgFw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 88EE6186DD2D;
 Wed, 23 Sep 2020 09:47:06 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 89E5055778;
 Wed, 23 Sep 2020 09:47:05 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 03/11] x86: cpuhp: refuse cpu hot-unplug request earlier if
 not supported
Date: Wed, 23 Sep 2020 05:46:42 -0400
Message-Id: <20200923094650.1301166-4-imammedo@redhat.com>
In-Reply-To: <20200923094650.1301166-1-imammedo@redhat.com>
References: <20200923094650.1301166-1-imammedo@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 00:53:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: lersek@redhat.com, ankur.a.arora@oracle.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

CPU hot-unplug with SMM requires firmware participation to prevent
guest crash (i.e. CPU can be removed only after OS _and_ firmware
were prepared for the action).
Previous patches introduced ICH9_LPC_SMI_F_CPU_HOT_UNPLUG_BIT
feature bit, which is advertised by firmware when it has support
for CPU hot-unplug. Use it to check if guest is able to handle
unplug and make device_del fail gracefully if hot-unplug feature
hasn't been negotiated.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Tested-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
---
v2:
 - fix typo in commit message
 - drop 5.1 version from hint message (Laszlo)
---
 hw/acpi/ich9.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
index 0acc9a3107..95cb0f935b 100644
--- a/hw/acpi/ich9.c
+++ b/hw/acpi/ich9.c
@@ -460,6 +460,18 @@ void ich9_pm_device_unplug_request_cb(HotplugHandler *hotplug_dev,
                                       errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU) &&
                !lpc->pm.cpu_hotplug_legacy) {
+        uint64_t negotiated = lpc->smi_negotiated_features;
+
+        if (negotiated & BIT_ULL(ICH9_LPC_SMI_F_BROADCAST_BIT) &&
+            !(negotiated & BIT_ULL(ICH9_LPC_SMI_F_CPU_HOT_UNPLUG_BIT))) {
+            error_setg(errp, "cpu hot-unplug with SMI wasn't enabled "
+                             "by firmware");
+            error_append_hint(errp, "update machine type to a version having "
+                                    "x-smi-cpu-hotunplug=on and firmware that "
+                                    "supports CPU hot-unplug with SMM");
+            return;
+        }
+
         acpi_cpu_unplug_request_cb(hotplug_dev, &lpc->pm.cpuhp_state,
                                    dev, errp);
     } else {
-- 
2.27.0


