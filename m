Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC4AC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 15:20:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E52AB206A4
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 15:20:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DtKPh3/j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E52AB206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjlTU-0008Pe-6L
	for qemu-devel@archiver.kernel.org; Fri, 12 Jun 2020 11:20:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50752)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jjl3a-0001i6-9a
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 10:53:22 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:56642
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jjl3Y-0001l3-FI
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 10:53:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591973599;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D/GZNs5L1C46gfOzGMxtE23sRQlVqpPh51YO3SQfyZM=;
 b=DtKPh3/jHpHpknEgQxeWeFj1fQc5Wr7iTrSqsTgYlgExbCSN7zNLO15ez3RXX1NfoHYR6f
 soNCiCs67tC2JwSgG/UiNt5g315WgCpJM05EfHvzq76ZEWivvGj77NhknNPO0F/MlQ8iB2
 vCyaYggVfPTRrinuZ1XJ6DzbEaguSV8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218--s92U7c-PS25Tu2R-BKSDQ-1; Fri, 12 Jun 2020 10:53:10 -0400
X-MC-Unique: -s92U7c-PS25Tu2R-BKSDQ-1
Received: by mail-wr1-f72.google.com with SMTP id w16so3977463wru.18
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2020 07:53:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=D/GZNs5L1C46gfOzGMxtE23sRQlVqpPh51YO3SQfyZM=;
 b=JsXkkIrA1r6+TS0bZafStIocTwy07j1KSlV4NKqWh5gBGyrG1h2oyNHsgusol8gdIY
 8aiyFeRLfnip0a/zl7DS10WsY9aGNNquPbnSUezd5tcM/RsuhKIYOknD3R2MgbRV6BsO
 dkDfSfwpx5wP6IEhTGri14ILmFYzw4kHehOvJ5YbvmQiPF2J0/BSXvS2QQToM/IuXkhP
 +OF1/sHVUDg78O8eDETpuUwXFsnDKmF1QK/ZDDgULO8EADyCslAxhP9MVNpa9nW86RPq
 oxD6yu7AIbieplZgIrzOU13JSq3SZaLHTkuT6PWzIqM+1hcJoiJshAnkgPjFg7UlcRGj
 oP+g==
X-Gm-Message-State: AOAM533kHxxdIhYJOvcGq2L27fHE/eKm9f5ahSfgVY7LQ+EfNM5bHUlD
 FG+U7qCytc/MyWlU6NP9Qiv4or1597Vz6BIb6iu4+4wNbWuxp2DMgoiV2VIbYIjoRvfNJFfR5bx
 cS5UQNfv1/PZeyEg=
X-Received: by 2002:a7b:cf02:: with SMTP id l2mr13811840wmg.136.1591973589411; 
 Fri, 12 Jun 2020 07:53:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx7xp0gcKJKKCkJffaHQnlVl4YAOFuhnq+k1Wmzpgw6wmORfyYY30TGsbE2HiW0+cao2ZIpXA==
X-Received: by 2002:a7b:cf02:: with SMTP id l2mr13811811wmg.136.1591973589172; 
 Fri, 12 Jun 2020 07:53:09 -0700 (PDT)
Received: from redhat.com (bzq-79-178-18-124.red.bezeqint.net. [79.178.18.124])
 by smtp.gmail.com with ESMTPSA id d9sm10286957wre.28.2020.06.12.07.53.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2020 07:53:08 -0700 (PDT)
Date: Fri, 12 Jun 2020 10:53:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 57/58] pci: Display PCI IRQ pin in "info pci"
Message-ID: <20200612141917.9446-58-mst@redhat.com>
References: <20200612141917.9446-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200612141917.9446-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/12 09:30:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 Julia Suvorova <jusual@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Peter Xu <peterx@redhat.com>

Sometimes it would be good to be able to read the pin number along
with the IRQ number allocated.  Since we'll dump the IRQ number, no
reason to not dump the pin information.  For example, the vfio-pci
device will overwrite the pin with the hardware pin number.  It would
be nice to know the pin number of one assigned device from QMP/HMP.

CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
CC: Alex Williamson <alex.williamson@redhat.com>
CC: Michael S. Tsirkin <mst@redhat.com>
CC: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
CC: Julia Suvorova <jusual@redhat.com>
CC: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20200317195908.283800-1-peterx@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/misc.json     | 6 ++++--
 hw/pci/pci.c       | 1 +
 monitor/hmp-cmds.c | 3 ++-
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/qapi/misc.json b/qapi/misc.json
index 99b90ac80b..a5a0beb902 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -403,6 +403,8 @@
 #
 # @irq: if an IRQ is assigned to the device, the IRQ number
 #
+# @irq_pin: the IRQ pin, zero means no IRQ (since 5.1)
+#
 # @qdev_id: the device name of the PCI device
 #
 # @pci_bridge: if the device is a PCI bridge, the bridge information
@@ -417,8 +419,8 @@
 { 'struct': 'PciDeviceInfo',
   'data': {'bus': 'int', 'slot': 'int', 'function': 'int',
            'class_info': 'PciDeviceClass', 'id': 'PciDeviceId',
-           '*irq': 'int', 'qdev_id': 'str', '*pci_bridge': 'PciBridgeInfo',
-           'regions': ['PciMemoryRegion']} }
+           '*irq': 'int', 'irq_pin': 'int', 'qdev_id': 'str',
+           '*pci_bridge': 'PciBridgeInfo', 'regions': ['PciMemoryRegion'] }}
 
 ##
 # @PciInfo:
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 1b88a32cf7..a60cf3ae3b 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -1776,6 +1776,7 @@ static PciDeviceInfo *qmp_query_pci_device(PCIDevice *dev, PCIBus *bus,
     info->regions = qmp_query_pci_regions(dev);
     info->qdev_id = g_strdup(dev->qdev.id ? dev->qdev.id : "");
 
+    info->irq_pin = dev->config[PCI_INTERRUPT_PIN];
     if (dev->config[PCI_INTERRUPT_PIN] != 0) {
         info->has_irq = true;
         info->irq = dev->config[PCI_INTERRUPT_LINE];
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index 9c61e769ca..e03adf0d4d 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -688,7 +688,8 @@ static void hmp_info_pci_device(Monitor *mon, const PciDeviceInfo *dev)
     }
 
     if (dev->has_irq) {
-        monitor_printf(mon, "      IRQ %" PRId64 ".\n", dev->irq);
+        monitor_printf(mon, "      IRQ %" PRId64 ", pin %c\n",
+                       dev->irq, (char)('A' + dev->irq_pin - 1));
     }
 
     if (dev->has_pci_bridge) {
-- 
MST


