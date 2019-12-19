Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23467C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 12:33:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1C4A218AC
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 12:33:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iW7WWw8q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1C4A218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihuzn-0002Ac-FU
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 07:33:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59943)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ihur2-0007mu-PC
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:24:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ihur1-0007aN-6r
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:24:32 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25490
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ihur0-0007XJ-VH
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:24:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576758270;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hzzv/OgiqADH7KAChwWwmBUi+2fw7rFny0fFHFYO0ng=;
 b=iW7WWw8qDViqjWNnPJe84ylulm8z8wz9UiVR+kXQ2I5Z+baAjNNNBvsoDYqnBtjW/SYBdL
 dXiD738JTtGigRDMTCOhIT9K6Y8HaBIrlmdajXY3/FWSEx1ZvR/8mJi7g1b9Rc1NXNdCaR
 Kjw7RsKUYK8RyD93imLQ6XKGHsdA5pk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-143-Kq-17XzfN6CKUCb9DcxLFA-1; Thu, 19 Dec 2019 07:24:29 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A3AA1005514
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 12:24:28 +0000 (UTC)
Received: from 640k.localdomain.com (ovpn-112-55.ams2.redhat.com
 [10.36.112.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B1DF760C18;
 Thu, 19 Dec 2019 12:24:26 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 102/132] meson: convert hw/acpi
Date: Thu, 19 Dec 2019 13:23:22 +0100
Message-Id: <1576758232-12439-11-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: Kq-17XzfN6CKUCb9DcxLFA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/Makefile.objs      |  1 -
 hw/acpi/Makefile.objs | 22 ----------------------
 hw/acpi/meson.build   | 21 +++++++++++++++++++++
 hw/meson.build        |  1 +
 4 files changed, 22 insertions(+), 23 deletions(-)
 delete mode 100644 hw/acpi/Makefile.objs
 create mode 100644 hw/acpi/meson.build

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index 5823867..3dc4dec 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -1,6 +1,5 @@
 ifeq ($(CONFIG_SOFTMMU), y)
 devices-dirs-$(call lor,$(CONFIG_VIRTIO_9P),$(call land,$(CONFIG_VIRTFS),$=
(CONFIG_XEN))) +=3D 9pfs/
-devices-dirs-y +=3D acpi/
 endif
=20
 common-obj-y +=3D $(devices-dirs-y)
diff --git a/hw/acpi/Makefile.objs b/hw/acpi/Makefile.objs
deleted file mode 100644
index 9bb2101..0000000
--- a/hw/acpi/Makefile.objs
+++ /dev/null
@@ -1,22 +0,0 @@
-ifeq ($(CONFIG_ACPI),y)
-common-obj-$(CONFIG_ACPI_X86) +=3D core.o piix4.o pcihp.o
-common-obj-$(CONFIG_ACPI_X86_ICH) +=3D ich9.o tco.o
-common-obj-$(CONFIG_ACPI_CPU_HOTPLUG) +=3D cpu_hotplug.o
-common-obj-$(CONFIG_ACPI_MEMORY_HOTPLUG) +=3D memory_hotplug.o
-common-obj-$(CONFIG_ACPI_CPU_HOTPLUG) +=3D cpu.o
-common-obj-$(CONFIG_ACPI_NVDIMM) +=3D nvdimm.o
-common-obj-$(CONFIG_ACPI_VMGENID) +=3D vmgenid.o
-common-obj-$(call lnot,$(CONFIG_ACPI_X86)) +=3D acpi-stub.o
-
-common-obj-y +=3D acpi_interface.o
-common-obj-y +=3D bios-linker-loader.o
-common-obj-y +=3D aml-build.o utils.o
-common-obj-$(CONFIG_ACPI_PCI) +=3D pci.o
-common-obj-$(CONFIG_TPM) +=3D tpm.o
-
-common-obj-$(CONFIG_IPMI) +=3D ipmi.o
-common-obj-$(call lnot,$(CONFIG_IPMI)) +=3D ipmi-stub.o
-else
-common-obj-y +=3D acpi-stub.o
-endif
-common-obj-$(CONFIG_ALL) +=3D acpi-stub.o ipmi-stub.o
diff --git a/hw/acpi/meson.build b/hw/acpi/meson.build
new file mode 100644
index 0000000..7d160c2
--- /dev/null
+++ b/hw/acpi/meson.build
@@ -0,0 +1,21 @@
+acpi_ss =3D ss.source_set()
+acpi_ss.add(files(
+  'acpi_interface.c',
+  'aml-build.c',
+  'bios-linker-loader.c',
+  'utils.c',
+))
+acpi_ss.add(when: 'CONFIG_ACPI_CPU_HOTPLUG', if_true: files('cpu.c'))
+acpi_ss.add(when: 'CONFIG_ACPI_CPU_HOTPLUG', if_true: files('cpu_hotplug.c=
'))
+acpi_ss.add(when: 'CONFIG_ACPI_MEMORY_HOTPLUG', if_true: files('memory_hot=
plug.c'))
+acpi_ss.add(when: 'CONFIG_ACPI_NVDIMM', if_true: files('nvdimm.c'))
+acpi_ss.add(when: 'CONFIG_ACPI_PCI', if_true: files('pci.c'))
+acpi_ss.add(when: 'CONFIG_ACPI_VMGENID', if_true: files('vmgenid.c'))
+acpi_ss.add(when: 'CONFIG_ACPI_X86', if_true: files('core.c', 'piix4.c', '=
pcihp.c'), if_false: files('acpi-stub.c'))
+acpi_ss.add(when: 'CONFIG_ACPI_X86_ICH', if_true: files('ich9.c', 'tco.c')=
)
+acpi_ss.add(when: 'CONFIG_IPMI', if_true: files('ipmi.c'), if_false: files=
('ipmi-stub.c'))
+acpi_ss.add(when: 'CONFIG_TPM', if_true: files('tpm.c'))
+softmmu_ss.add_all(when: 'CONFIG_ACPI', if_true: acpi_ss)
+
+softmmu_ss.add(when: 'CONFIG_ACPI', if_false: files('acpi-stub.c'))
+softmmu_ss.add(when: 'CONFIG_ALL', if_true: files('acpi-stub.c', 'ipmi-stu=
b.c'))
diff --git a/hw/meson.build b/hw/meson.build
index 33d5f9f..b2f8d6c 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -1,3 +1,4 @@
+subdir('acpi')
 subdir('adc')
 subdir('audio')
 subdir('block')
--=20
1.8.3.1



