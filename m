Return-Path: <SRS0=bgql=3H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEAC3C33CB1
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 14:12:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8A0124699
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 14:12:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QIODOp1O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8A0124699
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isoq7-0008B4-UT
	for qemu-devel@archiver.kernel.org; Sat, 18 Jan 2020 09:12:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45460)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1isokn-0000Ww-Lj
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 09:07:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1isokk-0007rS-JW
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 09:07:09 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46611
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1isokh-0007p4-K0
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 09:07:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579356422;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HBMzoS3skNu2fovt8Nh1IiQc4riv5LcvrvmHGH5Oq2k=;
 b=QIODOp1Odq0bVxzx0TNeLgW/dVMgR9MUacRziXyvdgqZyiV4d/cZLAo9UgfGN5C7uiw1Nk
 HgZmbzjb9yIA+JputhngAIffwndyjwCMXLOxKCITgZHHYm/3mt7WQKvp2ZHBDChUuI9K8Q
 BLbB8jp7LJ2w0Ao2PvED//OTNNOKk/o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-76-UBxmNiA2NPKgIVNP9ajBcw-1; Sat, 18 Jan 2020 09:07:01 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0EC49185432C;
 Sat, 18 Jan 2020 14:07:00 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-59.brq.redhat.com [10.40.204.59])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0CA8A5C1D4;
 Sat, 18 Jan 2020 14:06:56 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v2 6/6] hw/core/Makefile: Group generic objects versus
 system-mode objects
Date: Sat, 18 Jan 2020 15:06:19 +0100
Message-Id: <20200118140619.26333-7-philmd@redhat.com>
In-Reply-To: <20200118140619.26333-1-philmd@redhat.com>
References: <20200118140619.26333-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: UBxmNiA2NPKgIVNP9ajBcw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

To ease review/modifications of this Makefile, group generic
objects first, then system-mode specific ones, and finally
peripherals (which are only used in system-mode).

No logical changes introduced here.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/core/Makefile.objs | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
index 2fea68ccf7..a522b7297d 100644
--- a/hw/core/Makefile.objs
+++ b/hw/core/Makefile.objs
@@ -1,32 +1,32 @@
 # core qdev-related obj files, also used by *-user:
 common-obj-y +=3D qdev.o qdev-properties.o
 common-obj-y +=3D bus.o
+common-obj-y +=3D cpu.o
+common-obj-y +=3D hotplug.o
+common-obj-y +=3D vmstate-if.o
+# irq.o needed for qdev GPIO handling:
+common-obj-y +=3D irq.o
+
 common-obj-$(CONFIG_SOFTMMU) +=3D reset.o
 common-obj-$(CONFIG_SOFTMMU) +=3D qdev-fw.o
 common-obj-$(CONFIG_SOFTMMU) +=3D fw-path-provider.o
-# irq.o needed for qdev GPIO handling:
-common-obj-y +=3D irq.o
-common-obj-y +=3D hotplug.o
 common-obj-$(CONFIG_SOFTMMU) +=3D nmi.o
 common-obj-$(CONFIG_SOFTMMU) +=3D vm-change-state-handler.o
-common-obj-y +=3D cpu.o
-common-obj-y +=3D vmstate-if.o
+common-obj-$(CONFIG_SOFTMMU) +=3D qdev-properties-system.o
+common-obj-$(CONFIG_SOFTMMU) +=3D sysbus.o
+common-obj-$(CONFIG_SOFTMMU) +=3D machine.o
+common-obj-$(CONFIG_SOFTMMU) +=3D null-machine.o
+common-obj-$(CONFIG_SOFTMMU) +=3D loader.o
+common-obj-$(CONFIG_SOFTMMU) +=3D machine-hmp-cmds.o
+obj-$(CONFIG_SOFTMMU) +=3D machine-qmp-cmds.o
+obj-$(CONFIG_SOFTMMU) +=3D numa.o
=20
 common-obj-$(CONFIG_EMPTY_SLOT) +=3D empty_slot.o
 common-obj-$(CONFIG_XILINX_AXI) +=3D stream.o
 common-obj-$(CONFIG_PTIMER) +=3D ptimer.o
-common-obj-$(CONFIG_SOFTMMU) +=3D sysbus.o
-common-obj-$(CONFIG_SOFTMMU) +=3D machine.o
-common-obj-$(CONFIG_SOFTMMU) +=3D loader.o
 common-obj-$(CONFIG_FITLOADER) +=3D loader-fit.o
-common-obj-$(CONFIG_SOFTMMU) +=3D qdev-properties-system.o
 common-obj-$(CONFIG_REGISTER) +=3D register.o
 common-obj-$(CONFIG_OR_IRQ) +=3D or-irq.o
 common-obj-$(CONFIG_SPLIT_IRQ) +=3D split-irq.o
 common-obj-$(CONFIG_PLATFORM_BUS) +=3D platform-bus.o
 common-obj-$(CONFIG_GENERIC_LOADER) +=3D generic-loader.o
-common-obj-$(CONFIG_SOFTMMU) +=3D null-machine.o
-
-obj-$(CONFIG_SOFTMMU) +=3D machine-qmp-cmds.o
-obj-$(CONFIG_SOFTMMU) +=3D numa.o
-common-obj-$(CONFIG_SOFTMMU) +=3D machine-hmp-cmds.o
--=20
2.21.1


