Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B62C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 05:06:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF5E82074B
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 05:06:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KvzzMfv3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF5E82074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiswg-0007Dd-4Q
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 01:06:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34864)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jisPE-0005b2-Dv
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 00:32:04 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:35967
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jisPD-0000kB-DV
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 00:32:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591763522;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DoK3qItB4gtR6vQ0HnOj38qj5Wwjgy/hJn+3HSuSSfw=;
 b=KvzzMfv36nuTgn/gL8z8uPu3GwymC3nBV7wRDZJ5UmLAeve19DpnIlAHeMrjNiHhxp3xEE
 1Vtp54aMfK5vIVwga1Lt3cXjhQM3+SfIRGxEiwPG7RXVLJP5uqKIOFX3KrFQmRH/Bekx14
 /xq48QJifdrkosadNUPQgLKd2mvhhXk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-iqk66d5rMsO4lWVK0N-tkw-1; Wed, 10 Jun 2020 00:28:31 -0400
X-MC-Unique: iqk66d5rMsO4lWVK0N-tkw-1
Received: by mail-wm1-f72.google.com with SMTP id a18so73802wmm.3
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 21:28:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=DoK3qItB4gtR6vQ0HnOj38qj5Wwjgy/hJn+3HSuSSfw=;
 b=U45by2utfn99XP/QrrchFTU3fEcpNQSctlR3xoClIeU5tvBa+Y/OZknmQeOr7u4788
 RE1oT674kQJocTFoUGNZ5S56ue99ie4cNCpmBvUZxEc06qblOEiwfxnH/FFZTF+s2phU
 z/X+R/MDyzRlgsL4LZNnrXACx/P4S4JwLYgLgRLoTOm4ezcZLVKYYmYQRf4K/T5txAL8
 KCtaPa9hqzhxFYQ9VMVZz6oIcubIkWhO63826BFF1rE5gMmTxJt97iPNLmcQxtu7lhlg
 iCApsCfOO3HbmxS3XOJwM70O9yhlOWOpx7+f5mViOLUtAnD1OUTC77uyUhTyhI14KxuG
 HYXw==
X-Gm-Message-State: AOAM531Rp0H6DIyDbLm5+n64H0bv6tEFyEm4PSVwkGKHpTwe/AQUbk8H
 Osy0seFc3fkhzZsTeVTSscroksbs/Rp2m87BPI5WnxwXQXbRBbbbD8MJJuXHRqVASaLnG+Owe8z
 3tV4XU1+u1IVL/VI=
X-Received: by 2002:a5d:4a8a:: with SMTP id o10mr1314171wrq.222.1591763309791; 
 Tue, 09 Jun 2020 21:28:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxyyUZL3u75xMD7K/u1BicQ19+RwPhTta0WRJYJRDC6YQbcCvcnNFxp5Pg3COeRCSCPT1L3QQ==
X-Received: by 2002:a5d:4a8a:: with SMTP id o10mr1314150wrq.222.1591763309637; 
 Tue, 09 Jun 2020 21:28:29 -0700 (PDT)
Received: from redhat.com (bzq-79-181-55-232.red.bezeqint.net. [79.181.55.232])
 by smtp.gmail.com with ESMTPSA id d17sm6753922wrg.75.2020.06.09.21.28.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 21:28:29 -0700 (PDT)
Date: Wed, 10 Jun 2020 00:28:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 51/56] acpi: make build_madt() more generic.
Message-ID: <20200610042613.1459309-52-mst@redhat.com>
References: <20200610042613.1459309-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200610042613.1459309-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 23:51:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
 Eduardo Habkost <ehabkost@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Gerd Hoffmann <kraxel@redhat.com>

Remove PCMachineState dependency from build_madt().
Pass AcpiDeviceIf as separate argument instead of
depending on PCMachineState->acpi_dev.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20200520132003.9492-6-kraxel@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/acpi-build.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 1ecb68f45f..d217fc1fe6 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -366,14 +366,13 @@ void pc_madt_cpu_entry(AcpiDeviceIf *adev, int uid,
 }
 
 static void
-build_madt(GArray *table_data, BIOSLinker *linker, PCMachineState *pcms)
+build_madt(GArray *table_data, BIOSLinker *linker,
+           X86MachineState *x86ms, AcpiDeviceIf *adev)
 {
-    MachineClass *mc = MACHINE_GET_CLASS(pcms);
-    X86MachineState *x86ms = X86_MACHINE(pcms);
-    const CPUArchIdList *apic_ids = mc->possible_cpu_arch_ids(MACHINE(pcms));
+    MachineClass *mc = MACHINE_GET_CLASS(x86ms);
+    const CPUArchIdList *apic_ids = mc->possible_cpu_arch_ids(MACHINE(x86ms));
     int madt_start = table_data->len;
-    AcpiDeviceIfClass *adevc = ACPI_DEVICE_IF_GET_CLASS(pcms->acpi_dev);
-    AcpiDeviceIf *adev = ACPI_DEVICE_IF(pcms->acpi_dev);
+    AcpiDeviceIfClass *adevc = ACPI_DEVICE_IF_GET_CLASS(adev);
     bool x2apic_mode = false;
 
     AcpiMultipleApicTable *madt;
@@ -2708,7 +2707,8 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
     aml_len += tables_blob->len - fadt;
 
     acpi_add_table(table_offsets, tables_blob);
-    build_madt(tables_blob, tables->linker, pcms);
+    build_madt(tables_blob, tables->linker, x86ms,
+               ACPI_DEVICE_IF(pcms->acpi_dev));
 
     vmgenid_dev = find_vmgenid_dev();
     if (vmgenid_dev) {
-- 
MST


