Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE323C2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 10:44:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FDB22075A
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 10:44:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LOcdIAvA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FDB22075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMqe1-000175-8G
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 06:44:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43800)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kMqcm-0007hI-0F
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 06:43:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43808)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kMqch-0006Gp-GE
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 06:43:15 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601289790;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A3SdNzYOcuYZyEtogES+gk11J9hOgVOU4XHEU9kzxcM=;
 b=LOcdIAvA0H2dsn1PVPnp/S/TC6eBY0Uv+0uE/c8Pz/cp1vEUzEKREkLsznB4r8u4qLzEaJ
 3BS4I3Z2cGGijiOXaofXqDfi65PHWD7Dzz3Xz56Exm/RuFHRCxHSJa0fl7Y1a+sknUaJVH
 lSSwnM5ed0SmRZNQ6k2KxKhuccu0bAo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-131-_ZsW-3liPhCuUHojaOoVMA-1; Mon, 28 Sep 2020 06:43:09 -0400
X-MC-Unique: _ZsW-3liPhCuUHojaOoVMA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AC6B71DDF4;
 Mon, 28 Sep 2020 10:43:07 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-56.ams2.redhat.com
 [10.36.112.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 58D621002C0A;
 Mon, 28 Sep 2020 10:43:07 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 943D240844; Mon, 28 Sep 2020 12:42:56 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 06/12] microvm/pcie: add 64bit mmio window
Date: Mon, 28 Sep 2020 12:42:50 +0200
Message-Id: <20200928104256.9241-7-kraxel@redhat.com>
In-Reply-To: <20200928104256.9241-1-kraxel@redhat.com>
References: <20200928104256.9241-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 03:29:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.576,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Radoslaw Biernacki <rad@semihalf.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Leif Lindholm <leif@nuviainc.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Place the 64bit window at the top of the physical address space, assign
25% of the avaiable address space.  Force cpu.host-phys-bits=on for
microvm machine typs so this actually works reliable.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/microvm.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index 273abe28c9c1..17e3f2f15265 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -198,6 +198,12 @@ static void microvm_devices_init(MicrovmMachineState *mms)
     }
 
     if (x86_machine_is_acpi_enabled(x86ms) && mms->pcie == ON_OFF_AUTO_ON) {
+        /* use topmost 25% of the address space available */
+        hwaddr phys_size = (hwaddr)1 << X86_CPU(first_cpu)->phys_bits;
+        if (phys_size > 0x1000000ll) {
+            mms->gpex.mmio64.size = phys_size / 4;
+            mms->gpex.mmio64.base = phys_size - mms->gpex.mmio64.size;
+        }
         mms->gpex.mmio32.base = PCIE_MMIO_BASE;
         mms->gpex.mmio32.size = PCIE_MMIO_SIZE;
         mms->gpex.ecam.base   = PCIE_ECAM_BASE;
@@ -383,6 +389,9 @@ static void microvm_fix_kernel_cmdline(MachineState *machine)
 static void microvm_device_pre_plug_cb(HotplugHandler *hotplug_dev,
                                        DeviceState *dev, Error **errp)
 {
+    X86CPU *cpu = X86_CPU(dev);
+
+    cpu->host_phys_bits = true; /* need reliable phys-bits */
     x86_cpu_pre_plug(hotplug_dev, dev, errp);
 }
 
-- 
2.27.0


