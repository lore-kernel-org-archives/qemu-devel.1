Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E0DC33CB1
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 15:33:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8D982053B
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 15:33:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S+7Q11ES"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8D982053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irkfX-0006X4-7X
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 10:33:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49378)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1irkKR-0008LP-Ch
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 10:11:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1irkKQ-00005c-6I
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 10:11:31 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60515
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1irkKQ-00005U-30
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 10:11:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579101089;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tgWHe0rY4cuGTMiep8LeBs3OdoKDy+va/6+0Y+jFW7g=;
 b=S+7Q11ESwP3IwYiWw6vdFZHotV1ibLTrCcTrazGylChsb2Vss4i11iyRyra++n4VXswFJE
 XDeQ2m6xcg7N+QFEhJh9zyTVhCLO0wAoczGeruJYPCgu5tmxGzn8F93zOouK7QhVnDL9pI
 EBrxyYZ18G9iPt8ntYgmu9ZdUhtlIuc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-216-QwVxNSkZOJijLWQ2J9srNA-1; Wed, 15 Jan 2020 10:11:26 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0C03318A8C80;
 Wed, 15 Jan 2020 15:11:25 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8476019757;
 Wed, 15 Jan 2020 15:11:23 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 38/86] s390x:s390-virtio-ccw: use memdev for RAM
Date: Wed, 15 Jan 2020 16:06:53 +0100
Message-Id: <1579100861-73692-39-git-send-email-imammedo@redhat.com>
In-Reply-To: <1579100861-73692-1-git-send-email-imammedo@redhat.com>
References: <1579100861-73692-1-git-send-email-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: QwVxNSkZOJijLWQ2J9srNA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
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
Cc: david@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 borntraeger@de.ibm.com, qemu-s390x@nongnu.org, rth@twiddle.net
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
---
CC: rth@twiddle.net
CC: david@redhat.com
CC: cohuck@redhat.com
CC: pasic@linux.ibm.com
CC: borntraeger@de.ibm.com
CC: qemu-s390x@nongnu.org
---
 hw/s390x/s390-virtio-ccw.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index e0e2813..cbdd4ba 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -154,14 +154,12 @@ static void virtio_ccw_register_hcalls(void)
                                    virtio_ccw_hcall_early_printk);
 }
=20
-static void s390_memory_init(ram_addr_t mem_size)
+static void s390_memory_init(MemoryRegion *ram)
 {
     MemoryRegion *sysmem =3D get_system_memory();
-    MemoryRegion *ram =3D g_new(MemoryRegion, 1);
     Error *local_err =3D NULL;
=20
     /* allocate RAM for core */
-    memory_region_allocate_system_memory(ram, NULL, "s390.ram", mem_size);
     memory_region_add_subregion(sysmem, 0, ram);
=20
     /*
@@ -245,7 +243,7 @@ static void ccw_init(MachineState *machine)
=20
     s390_sclp_init();
     /* init memory + setup max page size. Required for the CPU model */
-    s390_memory_init(machine->ram_size);
+    s390_memory_init(machine->ram);
=20
     /* init CPUs (incl. CPU model) early so s390_has_feature() works */
     s390_init_cpus(machine);
@@ -471,6 +469,7 @@ static void ccw_machine_class_init(ObjectClass *oc, voi=
d *data)
     hc->plug =3D s390_machine_device_plug;
     hc->unplug_request =3D s390_machine_device_unplug_request;
     nc->nmi_monitor_handler =3D s390_nmi;
+    mc->default_ram_id =3D "s390.ram";
 }
=20
 static inline bool machine_get_aes_key_wrap(Object *obj, Error **errp)
--=20
2.7.4


