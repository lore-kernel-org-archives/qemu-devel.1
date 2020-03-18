Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B11B5C4332B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 22:17:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 790D220714
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 22:17:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HNV1OCFJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 790D220714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58969 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEh03-0007oM-MX
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 18:17:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60857)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jEgz0-0006yS-66
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 18:16:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jEgyy-0002P8-L3
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 18:16:13 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:48205)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jEgyy-0002M4-Ao
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 18:16:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584569772;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=huC2OGgYbvW84xwnIC5mxBB7O5lT6AM5qZ1RWUfo52o=;
 b=HNV1OCFJjvvVEFegPxGRuchHk2EPF833tpMJwIID4x9KBNE3uJY3M3ScLEgMGZN7Jwtffp
 VBxw9TwiaeAIDhnsYi/M2BtZMyOG9TN2oNdONrSTRkO0PpKI8iP9hLhh1kf4wqx5A6Go9G
 Wpl4TLWuCILpFLXLdOPXbcUOi30QxYE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-74gBU8XQP5yoxpccECO0qA-1; Wed, 18 Mar 2020 18:16:10 -0400
X-MC-Unique: 74gBU8XQP5yoxpccECO0qA-1
Received: by mail-wr1-f69.google.com with SMTP id t10so6804wrp.15
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2020 15:16:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RwaXQ72KSMPLcO7npdnd4uMzaGDTxoI8eHLkc3Jule0=;
 b=C1CqHaY1+Y4qEaufCxFTsQqJ8yd9ykOIK3Y9BjXQTL/xmAD8uMvSZsMCxi2jt6u8J8
 JPvsgGsc03ZOyei+j/YMdNuy759D9MxRurM+xljwM5t7C8oqQgKGPspO9FlvtfilUjaR
 pLxa8KePUblPFVZ/PcANxKjgM70YPjHaDXSC/DfxJZH/yOW+xRMBs39OH+lhyBx9V5Kh
 oiAEhimHumd9p4X6hRNNFnQzNSgGLInOZSWptB9khpjrG//7Yh17Xl+Kw6w3VZWbULHP
 JUCVKJ5pMU2BctZ+D/CEolnnYittwICh2fmQ0xaWHSPJkwJaFzVr5IP8a/zpVFeGlVp2
 Guew==
X-Gm-Message-State: ANhLgQ14iBKqi869ZDM4GItQaiAfqmYK9KBShKQ+8C+bC9b9OL+QqPlx
 orzfdderO2nlRaPLE5Gc+MvQVu8yzS/M9hJjRCE9g6IxGdsNwpHIOkmatNLQutds44jmz6ovdn1
 KEoK6oTt2EL726GE=
X-Received: by 2002:adf:e6ce:: with SMTP id y14mr102068wrm.152.1584569768879; 
 Wed, 18 Mar 2020 15:16:08 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsl2x0oi4PD9D+AGQyfxhPKIVAcU4f4XQuDL0gmf+Z6vZbk7Oc+du7IwHp1jxOCpG/4+Q+sDw==
X-Received: by 2002:adf:e6ce:: with SMTP id y14mr102045wrm.152.1584569768661; 
 Wed, 18 Mar 2020 15:16:08 -0700 (PDT)
Received: from localhost.localdomain (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id t193sm248214wmt.14.2020.03.18.15.16.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2020 15:16:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.0 1/2] hw/acpi/piix4: Add 'system-hotplug-support'
 property
Date: Wed, 18 Mar 2020 23:15:30 +0100
Message-Id: <20200318221531.22910-2-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200318221531.22910-1-philmd@redhat.com>
References: <20200318221531.22910-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The I/O ranges registered by the piix4_acpi_system_hot_add_init()
function are not documented in the PIIX4 datasheet.
This appears to be a PC-only feature added in commit 5e3cb5347e
("initialize hot add system / acpi gpe") which was then moved
to the PIIX4 device model in commit 9d5e77a22f ("make
qemu_system_device_hot_add piix independent")
Add a property (default enabled, to not modify the current
behavior) to allow machines wanting to model a simple PIIX4
to disable this feature.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
Should I squash this with the next patch and start with
default=3Dfalse, which is closer to the hardware model?
---
 hw/acpi/piix4.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index 964d6f5990..9c970336ac 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -78,6 +78,7 @@ typedef struct PIIX4PMState {
=20
     AcpiPciHpState acpi_pci_hotplug;
     bool use_acpi_pci_hotplug;
+    bool use_acpi_system_hotplug;
=20
     uint8_t disable_s3;
     uint8_t disable_s4;
@@ -503,8 +504,10 @@ static void piix4_pm_realize(PCIDevice *dev, Error **e=
rrp)
     s->machine_ready.notify =3D piix4_pm_machine_ready;
     qemu_add_machine_init_done_notifier(&s->machine_ready);
=20
-    piix4_acpi_system_hot_add_init(pci_address_space_io(dev),
-                                   pci_get_bus(dev), s);
+    if (s->use_acpi_system_hotplug) {
+        piix4_acpi_system_hot_add_init(pci_address_space_io(dev),
+                                       pci_get_bus(dev), s);
+    }
     qbus_set_hotplug_handler(BUS(pci_get_bus(dev)), OBJECT(s), &error_abor=
t);
=20
     piix4_pm_add_propeties(s);
@@ -635,6 +638,8 @@ static Property piix4_pm_properties[] =3D {
                      use_acpi_pci_hotplug, true),
     DEFINE_PROP_BOOL("memory-hotplug-support", PIIX4PMState,
                      acpi_memory_hotplug.is_enabled, true),
+    DEFINE_PROP_BOOL("system-hotplug-support", PIIX4PMState,
+                     use_acpi_system_hotplug, true),
     DEFINE_PROP_END_OF_LIST(),
 };
=20
--=20
2.21.1


