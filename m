Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6AFFC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 23:12:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F14F206F7
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 23:12:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VO5x8kUh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F14F206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joEYr-000126-QU
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 19:12:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42216)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1joETq-000095-4W
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 19:06:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50527
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1joETo-0001RI-9A
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 19:06:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593040015;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ToFNM9aVXQBet1ZT+w3NmxhXnSHtmFVtuTLjusFLtHM=;
 b=VO5x8kUhMOYIcXhVu0EtDxy/GMdl/ftwOaZfpr63tz+UbAFPT+Xg29BgGJS2Fk/RiBQA6g
 ce3lEahsHiAgC5NiW3mZC3g7xVKNn9lBFme6cYjXUXBT+GHBNbtM5CHmHkfGKnz0qWzcsN
 Zge04UH6iQA+tcADChFUk2BV3340rGM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-fOE397vhPpW74SRctjRSNQ-1; Wed, 24 Jun 2020 19:06:53 -0400
X-MC-Unique: fOE397vhPpW74SRctjRSNQ-1
Received: by mail-wm1-f69.google.com with SMTP id a18so4645988wmm.3
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 16:06:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=ToFNM9aVXQBet1ZT+w3NmxhXnSHtmFVtuTLjusFLtHM=;
 b=EkBrh9M009b4HvELBMX4EPNTC7TgdW813qwEGOIwj+HEkKz2ypFFNtrrBc6fHuM4AL
 GkWa7c+lUkjIxh04loXMsILpwuKScSt6ixmN+6aCRA4esdKBTd8ZEz8x4/CA13+HmA7X
 gznVjcW6UgaVRZfeZdC+Vxw4p2UH8zG2psjdLv8440Y7ZueN8obxb+DyI3nZQ0moLYE/
 LNBU93DR8UVpLuMCyeo7X6JqrxjUXxNZIbC4HmAQuS7GGYBptQXG1x25bJ6qcOZFt8yO
 jUPSrQVG9wlSE7dQstZfEmELwPzB1hzX8qJjsGZBmef/qwYmJsfCRFsmJF/11FslfDnK
 XBeg==
X-Gm-Message-State: AOAM530YZbWA5XVGy4XHq4eNtbKF9PpgkbGWUaye0//CMbTa1LL4ho+q
 k2G0RddvyMJWJKmQkbD0KNQUbyJhzWqqCdAzLzcast3ty5qhOxIatfbXM/DgSDqbleMNPOiQbwl
 AwrhjC5IU/5XaSD4=
X-Received: by 2002:adf:e40e:: with SMTP id g14mr15027162wrm.271.1593040012245; 
 Wed, 24 Jun 2020 16:06:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwvcr5MZAJbcbla0TfBIwcJt5/2SRI/fxVP+qKYbiBzekuqGu1ip0hs7lt45IpzuPJpVASBMA==
X-Received: by 2002:adf:e40e:: with SMTP id g14mr15027146wrm.271.1593040012089; 
 Wed, 24 Jun 2020 16:06:52 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 y6sm10454373wmy.0.2020.06.24.16.06.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2020 16:06:51 -0700 (PDT)
Date: Wed, 24 Jun 2020 19:06:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 08/19] acpi: simplify build_isa_devices_aml()
Message-ID: <20200624230609.703104-9-mst@redhat.com>
References: <20200624230609.703104-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200624230609.703104-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 03:27:53
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
 Eduardo Habkost <ehabkost@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Gerd Hoffmann <kraxel@redhat.com>

x86 machines can have a single ISA bus only.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200619091905.21676-9-kraxel@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/acpi-build.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 19e9c298dc..d27cecc877 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -979,18 +979,14 @@ static void build_isa_devices_aml(Aml *table)
 {
     VMBusBridge *vmbus_bridge = vmbus_bridge_find();
     bool ambiguous;
-
-    Aml *scope = aml_scope("_SB.PCI0.ISA");
     Object *obj = object_resolve_path_type("", TYPE_ISA_BUS, &ambiguous);
+    Aml *scope;
 
-    if (ambiguous) {
-        error_report("Multiple ISA busses, unable to define IPMI ACPI data");
-    } else if (!obj) {
-        error_report("No ISA bus, unable to define IPMI ACPI data");
-    } else {
-        build_acpi_ipmi_devices(scope, BUS(obj), "\\_SB.PCI0.ISA");
-        isa_build_aml(ISA_BUS(obj), scope);
-    }
+    assert(obj && !ambiguous);
+
+    scope = aml_scope("_SB.PCI0.ISA");
+    build_acpi_ipmi_devices(scope, BUS(obj), "\\_SB.PCI0.ISA");
+    isa_build_aml(ISA_BUS(obj), scope);
 
     if (vmbus_bridge) {
         aml_append(scope, build_vmbus_device_aml(vmbus_bridge));
-- 
MST


