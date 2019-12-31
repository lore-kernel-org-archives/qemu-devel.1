Return-Path: <SRS0=eTrL=2V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A0EC2D0C2
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 13:34:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B634206DA
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 13:34:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B/q6+U1k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B634206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imHfc-0001VC-Jd
	for qemu-devel@archiver.kernel.org; Tue, 31 Dec 2019 08:34:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56275)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1imHCE-0005hA-Jm
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 08:04:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1imHCD-0003ru-Ab
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 08:04:26 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:54319
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1imHCD-0003pc-64
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 08:04:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577797464;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QthNdiSaB3zyJQ7GDULbAQ5mvEHYwqQPwBVC+cEqJr8=;
 b=B/q6+U1knB9Rk+E0dW8eeNrmJYmFaWJxeKiUwAs704ewZpajoVYnAE1Yqus/H7f0KvoOJa
 FcH/jV25hUYb+m7Q+f32GAiXNHEQQUUfmQ7eiKJ9ApbWmPx6NiNSPu9dRUpQaMaPeHhO8r
 OkXS44MLEP8ocKrE+5H7c2HD9jA+XSc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-115-h4eq0nnzO-CYOP0IpjE_uQ-1; Tue, 31 Dec 2019 08:04:23 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3DE1EDB61
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2019 13:04:22 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B9C54620A6
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2019 13:04:21 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 40/86] s390x:s390-virtio-ccw: use memdev for RAM
Date: Tue, 31 Dec 2019 14:03:24 +0100
Message-Id: <1577797450-88458-41-git-send-email-imammedo@redhat.com>
In-Reply-To: <1577797450-88458-1-git-send-email-imammedo@redhat.com>
References: <1577797450-88458-1-git-send-email-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: h4eq0nnzO-CYOP0IpjE_uQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

memory_region_allocate_system_memory() API is going away, so
replace it with memdev allocated MemoryRegion. The later is
initialized by generic code, so board only needs to opt in
to memdev scheme by providing
  MachineClass::default_ram_id
and using MachineState::ram instead of manually initializing
RAM memory region.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
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


