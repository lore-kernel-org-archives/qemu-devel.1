Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD730C4346E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 08:07:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 290622075F
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 08:07:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dx6KIoUO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 290622075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNAfJ-0005j8-2L
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 04:07:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58918)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kNA0X-0007Tt-CF
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 03:25:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42290)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kNA0V-0002B7-ET
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 03:25:05 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601364302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NSeXgPmnzPETdBWbO0i4WPdq5OHXU6nIjMDVaYnb8Ak=;
 b=Dx6KIoUOi0jZoGUMUlrz2OcsyO+BiCDAGsNutWqV67e/G09DxqlqBHixfS0BK0/HZD3a52
 mrhOR8GnLV9DxwhNc8LumHMXONnuhowbBj69ysHQ6/9XP3BXQMS6JloLeu4kGs1p9QGFUP
 AO5Gmg9eIKgNa6tNS9FU0UYqWojbqd4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-582-4UwHEhXFOK6iTop_gS-tAw-1; Tue, 29 Sep 2020 03:21:58 -0400
X-MC-Unique: 4UwHEhXFOK6iTop_gS-tAw-1
Received: by mail-wr1-f70.google.com with SMTP id a10so1335086wrw.22
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 00:21:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=NSeXgPmnzPETdBWbO0i4WPdq5OHXU6nIjMDVaYnb8Ak=;
 b=UzsidaI+8l8ZZSiWHxbSacAuaxJi/403SU+01RoEhnzSw+1Ssx7wzDm1l6aZmN2LBF
 r21igJzHk2fRprbRrIauyQyzkcQMsJ/9aA3FLi7Br03/RQag4TsPXMwf+gqyrnGBg+0r
 wGykpI4UZFHGwzTV1THkY+Yi/BdZaN5o1QgOhkxz52rDHafEKsRR73k5mZY1oWNVh5op
 Zewf5y1QhMKjZBhdgbhgZf/Iy06WNRGE2kLwIDuYkAhbt+zo4tMzkpcp4TaIjY9yVa0k
 r+qvRAPaLTQuSOgxeQoSFuqxr3T1aEr8/vy6mL0NDE1AHZZwXJVoHWPDThB3hDauJo0f
 Ctnw==
X-Gm-Message-State: AOAM530ZiFI6S9wNOOFUpCnpCHUg/Si2Zpl3szb3HD9h4XbuY+V5c1j5
 n5GvLTjiUkLGXD39Ra6+ez/pVGGkvAkiORBcYmZjk8uDrnUBVgXMyAJ4fa8iCwLCpnOAeJ/C+jr
 QzQplIU4QnKov1+Y=
X-Received: by 2002:a1c:9994:: with SMTP id b142mr2804020wme.94.1601364116696; 
 Tue, 29 Sep 2020 00:21:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyiTS5oOH/3+wVfdCjbsD04XMCCBhpusco8dCZCNvBu5yHMFsbKPycIBBb1BvNPoGoT/xRCyw==
X-Received: by 2002:a1c:9994:: with SMTP id b142mr2804007wme.94.1601364116531; 
 Tue, 29 Sep 2020 00:21:56 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id k84sm4341202wmf.6.2020.09.29.00.21.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 00:21:55 -0700 (PDT)
Date: Tue, 29 Sep 2020 03:21:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v4 23/48] x86: cpuhp: refuse cpu hot-unplug request earlier if
 not supported
Message-ID: <20200929071948.281157-24-mst@redhat.com>
References: <20200929071948.281157-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200929071948.281157-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 02:22:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Laszlo Ersek <lersek@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Igor Mammedov <imammedo@redhat.com>

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
Message-Id: <20200923094650.1301166-4-imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
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
MST


