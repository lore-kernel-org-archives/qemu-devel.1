Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AAC1C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 12:19:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E697D217F4
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 12:19:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PyE4bL+J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E697D217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iubSJ-0000Lq-D0
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 07:19:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35712)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iuasV-0006P7-C1
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:42:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iuasU-0004Zd-6d
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:42:27 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:34772
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iuasU-0004Z1-2c
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:42:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579779745;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WV1vSk+tjh6xNbYHYgEON0N9FleWECMsdzY10U96mGg=;
 b=PyE4bL+JfWMe+njYV21gcszdcnTAv/xjZyJQmACRrVTJRYzYuttf2qxkuBjKSvpfbAyupU
 IONZOERWCm8QPEz3DWp1PCrZE+qjFa2lZDQNd8HZNP6/29JY77w0drS4ZFpM+Sb4k5Wke2
 sMUvNOA6xiQDkjtR5nzYc+XDHj/+5u4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-sRfegIcVM1KC6sMe8XyPZQ-1; Thu, 23 Jan 2020 06:42:24 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7F211100550E
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 11:42:23 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0761D100032E
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 11:42:22 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH REPOST v3 41/80] hw/hppa/machine: Map the PDC memory region
 with higher priority
Date: Thu, 23 Jan 2020 12:38:06 +0100
Message-Id: <1579779525-20065-42-git-send-email-imammedo@redhat.com>
In-Reply-To: <1579779525-20065-1-git-send-email-imammedo@redhat.com>
References: <1579779525-20065-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: sRfegIcVM1KC6sMe8XyPZQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

The region in range [0xf0000000 - 0xf1000000] is the PDC area
(Processor Dependent Code), where the firmware is loaded.
This region has higher priority than the main memory.

When the machine has more than 3840MB of RAM, there is an
overlap. Since the PDC is closer to the CPU in the bus
hierarchy, it gets accessed first, and the CPU does not have
access to the RAM in this range.

To model the same behavior and keep a simple memory layout,
reduce the priority of the RAM region. The PDC region ends
overlapping the RAM.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: Helge Deller <deller@gmx.de>
Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/hppa/machine.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 119ae4d..810e671 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -98,7 +98,7 @@ static void machine_hppa_init(MachineState *machine)
     ram_region =3D g_new(MemoryRegion, 1);
     memory_region_allocate_system_memory(ram_region, OBJECT(machine),
                                          "ram", ram_size);
-    memory_region_add_subregion(addr_space, 0, ram_region);
+    memory_region_add_subregion_overlap(addr_space, 0, ram_region, -1);
=20
     /* Init Dino (PCI host bus chip).  */
     pci_bus =3D dino_init(addr_space, &rtc_irq, &serial_irq);
--=20
2.7.4


