Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F02B3C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:37:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9C822087E
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:37:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KIZwd7zM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9C822087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVcDR-0001X6-OI
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 10:37:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47336)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jVc6F-0005Da-Da
 for qemu-devel@nongnu.org; Mon, 04 May 2020 10:29:39 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:29370
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jVc6E-0005wQ-5T
 for qemu-devel@nongnu.org; Mon, 04 May 2020 10:29:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588602577;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gJFzG582yZB4/rnNbmblCyq8Hpszv9jfR5i6UZ4ZYJQ=;
 b=KIZwd7zMSgfU8BWzH4/IgQS+VDvQPkSRLlGP+GFM6WTRbgfKgRjIrIEQifZ9dEv2a9ef27
 gYIAcC5I4/o2NexVpdZpHahU4772ojH+nSUFM/3pZjsFLzM3rTHlC4nDPEVuC7GQsdmwLI
 WS4p/i0Fa6p0MQSDNVOFuwsFjonF2fY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-wLhKfHTKMleu3L234A83Yw-1; Mon, 04 May 2020 10:29:33 -0400
X-MC-Unique: wLhKfHTKMleu3L234A83Yw-1
Received: by mail-wm1-f69.google.com with SMTP id q5so4978769wmc.9
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 07:29:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=0MjHyyDWDqhYfXPWccymj7uxRKiJrrSPTEpq3PGIndE=;
 b=csWhx31ALJRbXibd3vYdl5JhpS0nX6hmvt00S8zQ08NgBBZ1UADbVLInDWhheDvGP5
 bxD7tlt+KrNlbbYKzpVZ//jnStqQgXy4A3NcY0CywQnzdqj0I35mH094hX0FcJ6kieab
 KMM/Pa3JZPLM22mUm9RLgOlDXyTyb2UtC3g1wXxWDiiZuZHyCWoVf0snvKclxx1pyVwa
 04cvCyNGpOYkmV0jR/DP4vv+wrphZzOzYbtDtoTorij/wOTsf6GwPQMopMspcC/+p5OV
 +Dsx2qok+KyTSDNbTiKqKWb8jh9EZ60AjePSTO6ffz6maFl5fLftZjN7CvYyMRt5jrle
 F5Sg==
X-Gm-Message-State: AGi0PuYZxRGqVjKgyBaGTw3zcbBRAK/uT62RD5WWnY/GUoA0doKITPdi
 3RTGx6Azf3fVxUuTFDJbP4vCB2cw0ZzYO/OvywiDS8jxw/6xDIsO86S4pfw0z0c/XNIX0AhjXjQ
 iMpLVFrvYDWc8RMA=
X-Received: by 2002:adf:e483:: with SMTP id i3mr18393645wrm.88.1588602572080; 
 Mon, 04 May 2020 07:29:32 -0700 (PDT)
X-Google-Smtp-Source: APiQypJcR9UMJO77NohzYNucfZbMyOc+lca8j9zIhjRf1w/+d8Q9RtsUxGU51kI7ggkAfekvbXgxIA==
X-Received: by 2002:adf:e483:: with SMTP id i3mr18393627wrm.88.1588602571917; 
 Mon, 04 May 2020 07:29:31 -0700 (PDT)
Received: from redhat.com (bzq-109-66-7-121.red.bezeqint.net. [109.66.7.121])
 by smtp.gmail.com with ESMTPSA id
 b191sm14778221wmd.39.2020.05.04.07.29.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 07:29:31 -0700 (PDT)
Date: Mon, 4 May 2020 10:29:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 07/29] acpi: add ISADeviceClass->build_aml()
Message-ID: <20200504142814.157589-8-mst@redhat.com>
References: <20200504142814.157589-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200504142814.157589-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 01:21:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Gerd Hoffmann <kraxel@redhat.com>

Also add isa_aml_build() function which walks all isa devices.
This allows to move aml builder code to isa devices.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20200429140003.7336-6-kraxel@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/isa/isa.h |  2 ++
 hw/i386/acpi-build.c |  1 +
 hw/isa/isa-bus.c     | 15 +++++++++++++++
 3 files changed, 18 insertions(+)

diff --git a/include/hw/isa/isa.h b/include/hw/isa/isa.h
index 59a4d4b50a..02c2350274 100644
--- a/include/hw/isa/isa.h
+++ b/include/hw/isa/isa.h
@@ -69,6 +69,7 @@ typedef struct IsaDmaClass {
=20
 typedef struct ISADeviceClass {
     DeviceClass parent_class;
+    void (*build_aml)(ISADevice *dev, Aml *scope);
 } ISADeviceClass;
=20
 struct ISABus {
@@ -107,6 +108,7 @@ ISADevice *isa_try_create(ISABus *bus, const char *name=
);
 ISADevice *isa_create_simple(ISABus *bus, const char *name);
=20
 ISADevice *isa_vga_init(ISABus *bus);
+void isa_build_aml(ISABus *bus, Aml *scope);
=20
 /**
  * isa_register_ioport: Install an I/O port region on the ISA bus.
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 3a046b03e4..97f3c75cd9 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1288,6 +1288,7 @@ static void build_isa_devices_aml(Aml *table)
         error_report("No ISA bus, unable to define IPMI ACPI data");
     } else {
         build_acpi_ipmi_devices(scope, BUS(obj), "\\_SB.PCI0.ISA");
+        isa_build_aml(ISA_BUS(obj), scope);
     }
=20
     aml_append(table, scope);
diff --git a/hw/isa/isa-bus.c b/hw/isa/isa-bus.c
index 798dd9194e..1f2189f4d5 100644
--- a/hw/isa/isa-bus.c
+++ b/hw/isa/isa-bus.c
@@ -207,6 +207,21 @@ ISADevice *isa_vga_init(ISABus *bus)
     }
 }
=20
+void isa_build_aml(ISABus *bus, Aml *scope)
+{
+    BusChild *kid;
+    ISADevice *dev;
+    ISADeviceClass *dc;
+
+    QTAILQ_FOREACH(kid, &bus->parent_obj.children, sibling) {
+        dev =3D ISA_DEVICE(kid->child);
+        dc =3D ISA_DEVICE_GET_CLASS(dev);
+        if (dc->build_aml) {
+            dc->build_aml(dev, scope);
+        }
+    }
+}
+
 static void isabus_dev_print(Monitor *mon, DeviceState *dev, int indent)
 {
     ISADevice *d =3D ISA_DEVICE(dev);
--=20
MST


