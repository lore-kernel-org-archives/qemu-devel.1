Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 023F8C4332B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 08:06:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD2432072C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 08:06:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c50jPleC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD2432072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEqCJ-0001FQ-Ua
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 04:06:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39710)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jEq7Y-0001gv-Ip
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 04:01:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1jEq7X-0005QB-Ei
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 04:01:40 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:51337)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1jEq7X-0005Nl-AE
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 04:01:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584604899;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hSzTUuBVSD20JGOao/BrW7RhITmYyNs/OHVV6V5t7OQ=;
 b=c50jPleCtEDhXN1/dqtFHcy7L7yISMY2XLJvtKDqDUffyCDZg11qZx2QvNFYLD0rrHodmc
 zsw6VWR/HZuSz5n8n8/v7UWeuSeMHf8ZIM5P2gL3gbWHaWPj+eW+Sd6D729i/D9N2tarCD
 vs2ZIXjWmQAWKGQXWmnBOpaUVhbjUJ0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-288-urE79ladNLuwxfbR1uXmUw-1; Thu, 19 Mar 2020 04:01:36 -0400
X-MC-Unique: urE79ladNLuwxfbR1uXmUw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 83E6713EA;
 Thu, 19 Mar 2020 08:01:35 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-49.ams2.redhat.com
 [10.36.112.49])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8B2AB196AE;
 Thu, 19 Mar 2020 08:01:28 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 1167B3EC02; Thu, 19 Mar 2020 09:01:18 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 10/13] microvm/acpi: add rtc
Date: Thu, 19 Mar 2020 09:01:14 +0100
Message-Id: <20200319080117.7725-11-kraxel@redhat.com>
In-Reply-To: <20200319080117.7725-1-kraxel@redhat.com>
References: <20200319080117.7725-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/hw/i386/microvm.h | 3 +++
 hw/i386/acpi-build.c      | 3 +++
 hw/i386/microvm.c         | 5 ++---
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/include/hw/i386/microvm.h b/include/hw/i386/microvm.h
index da2852a70195..53b2457db752 100644
--- a/include/hw/i386/microvm.h
+++ b/include/hw/i386/microvm.h
@@ -57,6 +57,9 @@ typedef struct {
     bool option_roms;
     bool auto_kernel_cmdline;
=20
+    /* built-in devices */
+    ISADevice *rtc_state;
+
     /* Machine state */
     bool kernel_cmdline_fixed;
     Notifier machine_done;
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 80844db24d6b..928e0ee2deeb 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2815,6 +2815,9 @@ build_dsdt_microvm(GArray *table_data, BIOSLinker *li=
nker,
     build_dbg_aml(dsdt);
=20
     sb_scope =3D aml_scope("_SB");
+    if (mms->rtc_state) {
+        aml_append(sb_scope, build_rtc_device_aml());
+    }
     acpi_dsdt_add_fw_cfg(sb_scope, OBJECT(x86ms->fw_cfg));
     acpi_dsdt_add_virtio(sb_scope);
     aml_append(dsdt, sb_scope);
diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index fd753764fc10..748f9826fb0e 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -101,7 +101,6 @@ static void microvm_devices_init(MicrovmMachineState *m=
ms)
 {
     X86MachineState *x86ms =3D X86_MACHINE(mms);
     ISABus *isa_bus;
-    ISADevice *rtc_state;
     GSIState *gsi_state;
     int i;
=20
@@ -155,8 +154,8 @@ static void microvm_devices_init(MicrovmMachineState *m=
ms)
=20
     if (mms->rtc =3D=3D ON_OFF_AUTO_ON ||
         (mms->rtc =3D=3D ON_OFF_AUTO_AUTO && !kvm_enabled())) {
-        rtc_state =3D mc146818_rtc_init(isa_bus, 2000, NULL);
-        microvm_set_rtc(mms, rtc_state);
+        mms->rtc_state =3D mc146818_rtc_init(isa_bus, 2000, NULL);
+        microvm_set_rtc(mms, mms->rtc_state);
     }
=20
     if (mms->isa_serial) {
--=20
2.18.2


