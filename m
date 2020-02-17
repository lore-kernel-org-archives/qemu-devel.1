Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEAC2C34021
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 17:50:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAD8A20725
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 17:50:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T7CME+gA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAD8A20725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3kXG-0005vG-TO
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 12:50:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38464)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1j3kJC-00028U-4f
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 12:35:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1j3kJA-000291-W0
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 12:35:50 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58825
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1j3kJA-00027w-K9
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 12:35:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581960947;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sqax1ayswofN/3n5dpcmnh3A7K8jp4tGRuywxX8We5o=;
 b=T7CME+gAiRZ0z9g8HNbw640AgAlWLKJ8BImQgLX7lGupiZNyltkp6K+e0QLmoLBZUHZcfO
 rUP4Uvm1EYlWvwvq4RzV80LHLODd/OBOqigWKAK887li5o8EncQBamlEk80uqpLe6Mo/0/
 TFO9LpMYUVSbUwH+2g23FeqRhLYgaAU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-19-pIfK2mN6NhqCEp4h28Fh9Q-1; Mon, 17 Feb 2020 12:35:46 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 22231801E66
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 17:35:45 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7193090526;
 Mon, 17 Feb 2020 17:35:44 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 37/79] arm/xlnx-zcu102: use memdev for RAM
Date: Mon, 17 Feb 2020 12:34:10 -0500
Message-Id: <20200217173452.15243-38-imammedo@redhat.com>
In-Reply-To: <20200217173452.15243-1-imammedo@redhat.com>
References: <20200217173452.15243-1-imammedo@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: pIfK2mN6NhqCEp4h28Fh9Q-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

memory_region_allocate_system_memory() API is going away, so
replace it with memdev allocated MemoryRegion. The later is
initialized by generic code, so board only needs to opt in
to memdev scheme by providing
  MachineClass::default_ram_id
and using MachineState::ram instead of manually initializing
RAM memory region.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/arm/xlnx-zcu102.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/hw/arm/xlnx-zcu102.c b/hw/arm/xlnx-zcu102.c
index 53cfe7c1f1..bd645ad818 100644
--- a/hw/arm/xlnx-zcu102.c
+++ b/hw/arm/xlnx-zcu102.c
@@ -28,7 +28,6 @@ typedef struct XlnxZCU102 {
     MachineState parent_obj;
=20
     XlnxZynqMPState soc;
-    MemoryRegion ddr_ram;
=20
     bool secure;
     bool virt;
@@ -87,13 +86,10 @@ static void xlnx_zcu102_init(MachineState *machine)
                  ram_size);
     }
=20
-    memory_region_allocate_system_memory(&s->ddr_ram, NULL, "ddr-ram",
-                                         ram_size);
-
     object_initialize_child(OBJECT(machine), "soc", &s->soc, sizeof(s->soc=
),
                             TYPE_XLNX_ZYNQMP, &error_abort, NULL);
=20
-    object_property_set_link(OBJECT(&s->soc), OBJECT(&s->ddr_ram),
+    object_property_set_link(OBJECT(&s->soc), OBJECT(machine->ram),
                          "ddr-ram", &error_abort);
     object_property_set_bool(OBJECT(&s->soc), s->secure, "secure",
                              &error_fatal);
@@ -211,6 +207,7 @@ static void xlnx_zcu102_machine_class_init(ObjectClass =
*oc, void *data)
     mc->ignore_memory_transaction_failures =3D true;
     mc->max_cpus =3D XLNX_ZYNQMP_NUM_APU_CPUS + XLNX_ZYNQMP_NUM_RPU_CPUS;
     mc->default_cpus =3D XLNX_ZYNQMP_NUM_APU_CPUS;
+    mc->default_ram_id =3D "ddr-ram";
 }
=20
 static const TypeInfo xlnx_zcu102_machine_init_typeinfo =3D {
--=20
2.18.1


