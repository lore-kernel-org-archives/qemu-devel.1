Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 692FAC433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 14:28:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5C59221E5
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 14:28:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GiMGQq8U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5C59221E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFecC-0001Cv-LE
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 10:28:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38082)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kFeaO-0005RM-GE
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 10:27:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50769)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kFeZr-0006t4-7d
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 10:27:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599575189;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BaphSdiGhAZ4WeZEOB6GUUl46i+DVX/CX44TODloQyM=;
 b=GiMGQq8U7SZcAxZCFkwfGbp/KTM+X/Qzhawm/HoMCi1fJXWGRC5RuzR3MLKTISqXQIX99h
 AvfTVBma+jhvgHtjiNvFy0RNgJZPDA8cloyhPMR/P/7rOUeE8M46olYy2dzty8IMVpXMj8
 ovh2Sk9/lY4n2BN+oAcP1Yri9e3LCNE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-42-hpC9qOtGgNAfYs6XeBA-1; Tue, 08 Sep 2020 10:26:27 -0400
X-MC-Unique: 42-hpC9qOtGgNAfYs6XeBA-1
Received: by mail-wr1-f69.google.com with SMTP id a12so7046747wrg.13
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 07:26:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BaphSdiGhAZ4WeZEOB6GUUl46i+DVX/CX44TODloQyM=;
 b=ErVE9tkF68CEKrzEvBRiO/Qe/MOruEZeh3J3gzMssLBCznaDPVCdo064o1IGntVXMf
 2biFDZc1yWtqEwJ3qAlT3/uQvokNVpzqKnDnpVvtazbwOBWw6O62Swc2kEVg0MuroPhg
 /DxVqo+kjKcQkJfprFyOWJa1WilE1jh/C2mVU/WhYADMKOoY/5/vw7eWYW+R8hZ/QRhX
 gwyzuxOaSlTsu7AyjULtfYyIqAW2moISspLCw7QfcvrJZp4tM/8rXsXIUQ0sq2HJ90jQ
 KptiIAX+fPZq9zUU8qFC/upZsUVFTvXlHiuJu4ZG//1sz77iIpNG/MFeWfBRYG0NvUr4
 wgDQ==
X-Gm-Message-State: AOAM532wdp81anNXcEXIvb7yT+SmRKIETYbuqAshxbHKLFvAOdJakzq8
 //PPJFuvPCPCd3oL9p9HaOBvfHeC4qnVBXf1EVlMWaODo3B/ptjjk/3s7/JBo8qWdfs1QoRjMrw
 9Xm7HYssTr3x1hYI=
X-Received: by 2002:a1c:39c4:: with SMTP id g187mr4575967wma.126.1599575186441; 
 Tue, 08 Sep 2020 07:26:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwG1Q8mWXfEdH5JVru40UflvHEFaoABVR/a5qha22ZTatoY4EPmWAN5D43sEgEnSTkTauJZww==
X-Received: by 2002:a1c:39c4:: with SMTP id g187mr4575941wma.126.1599575186206; 
 Tue, 08 Sep 2020 07:26:26 -0700 (PDT)
Received: from localhost.localdomain (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id q15sm34307052wrr.8.2020.09.08.07.26.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 07:26:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 5/5] typedefs: Restrict PCMachineState to 'hw/i386/pc.h'
Date: Tue,  8 Sep 2020 16:25:59 +0200
Message-Id: <20200908142559.192945-6-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200908142559.192945-1-philmd@redhat.com>
References: <20200908142559.192945-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 02:11:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Paul Durrant <paul@xen.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, xen-devel@lists.xenproject.org,
 Anthony Perard <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The PCMachineState type is only used under hw/i386/.
We don't need to forward-declare it for all architectures,
restrict it to the X86 one.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 include/hw/i386/pc.h    | 4 ++--
 include/qemu/typedefs.h | 1 -
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index fe52e165b27..d4ebefcf2b4 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -19,7 +19,7 @@
  * @boot_cpus: number of present VCPUs
  * @smp_dies: number of dies per one package
  */
-struct PCMachineState {
+typedef struct PCMachineState {
     /*< private >*/
     X86MachineState parent_obj;
 
@@ -50,7 +50,7 @@ struct PCMachineState {
 
     /* ACPI Memory hotplug IO base address */
     hwaddr memhp_io_base;
-};
+} PCMachineState;
 
 #define PC_MACHINE_ACPI_DEVICE_PROP "acpi-device"
 #define PC_MACHINE_MAX_RAM_BELOW_4G "max-ram-below-4g"
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 427027a9707..6281eae3b55 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -90,7 +90,6 @@ typedef struct PCIExpressDevice PCIExpressDevice;
 typedef struct PCIExpressHost PCIExpressHost;
 typedef struct PCIHostDeviceAddress PCIHostDeviceAddress;
 typedef struct PCIHostState PCIHostState;
-typedef struct PCMachineState PCMachineState;
 typedef struct PostcopyDiscardState PostcopyDiscardState;
 typedef struct Property Property;
 typedef struct PropertyInfo PropertyInfo;
-- 
2.26.2


