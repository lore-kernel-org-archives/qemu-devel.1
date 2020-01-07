Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58CF5C33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 15:52:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 272512077B
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 15:52:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XWLHup4+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 272512077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ior9c-00015s-8z
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 10:52:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49011)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1ioquv-0002O4-OS
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 10:37:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1ioquu-0000hk-J2
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 10:37:13 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21902
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1ioquu-0000hS-F6
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 10:37:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578411432;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zb86pkcQTkRb+tLn+Pn0ONVbfqPk0TR4wnSFZFvBwvo=;
 b=XWLHup4+aD98Cil33u1ZETG1vO8cCPYgqD2PXTnuW2+9AUFeicfe7awiwp+XLKMkWYh30V
 oebitHI2FwHpP2whDnZKEKL1wquLgxOkAt9ToLXQGrMtSQAymW8CR9PruX7cNkjeY5RQLf
 IHc1zSxdfnhkvKWfeDfK48JNNr4R4G0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-QJD0ZEtHOuGCCetrAGhSQw-1; Tue, 07 Jan 2020 10:37:08 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AFEBC100728A;
 Tue,  7 Jan 2020 15:37:07 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 266C460C88;
 Tue,  7 Jan 2020 15:37:03 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 43/86] hppa: allow max ram size upto 4Gb
Date: Tue,  7 Jan 2020 16:34:38 +0100
Message-Id: <1578411278-162603-1-git-send-email-imammedo@redhat.com>
In-Reply-To: <1577797450-88458-44-git-send-email-imammedo@redhat.com>
References: <1577797450-88458-44-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: QJD0ZEtHOuGCCetrAGhSQw-1
X-Mimecast-Spam-Score: 0
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
Cc: svens@stackframe.org, deller@gmx.de, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Real hardware allows to plug in up to 4Gb RAM into memory slots.
So allow user specify up to 4Gb and map all of it into guest
address space.

PS:
  * guest will still see 3840m being reported in
    cpu[0]->env.gr[26] and won't be avare of remaining
    ~248Mb, as it doesn't have other means to discover
    RAM above firmware ROM.
  * use local ram_size to avoid changing global one
    which shouldn't be changed boards and will be removed
    in the future

Requested-by: Helge Deller <deller@gmx.de>
Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
v2:
  - make main ram -1 prio, so it wouldn't conflict with other regions
    starting from 0xf9000000
    (Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>)
  - avoid type size comparision error on migw32 host with ram_addr_t
  - simplify code a bit using local ram_size var.
  - rewrite commit message
v3:
  - drop "hppa: drop RAM size fixup"
  - rewrite commit message
  - use 64-bit local ram_size to workaround always false
    condition "if (ram_size > 4 * GiB)" when building on
    32-bit host (mingw-32) as it's preffered over ifdefs.
---
 hw/hppa/machine.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 5d0de26..d63b61e 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -73,10 +73,9 @@ static void machine_hppa_init(MachineState *machine)
     MemoryRegion *ram_region;
     MemoryRegion *cpu_region;
     long i;
+    uint64_t ram_size =3D machine->ram_size;
     unsigned int smp_cpus =3D machine->smp.cpus;
=20
-    ram_size =3D machine->ram_size;
-
     /* Create CPUs.  */
     for (i =3D 0; i < smp_cpus; i++) {
         char *name =3D g_strdup_printf("cpu%ld-io-eir", i);
@@ -91,15 +90,17 @@ static void machine_hppa_init(MachineState *machine)
     }
=20
     /* Limit main memory. */
-    if (ram_size > FIRMWARE_START) {
-        machine->ram_size =3D ram_size =3D FIRMWARE_START;
+    if (ram_size > 4 * GiB) {
+        error_report("RAM size more than 4Gb is not supported");
+        exit(EXIT_FAILURE);
     }
+    ram_size =3D ram_size > FIRMWARE_START ? FIRMWARE_START : ram_size;
=20
     /* Main memory region. */
     ram_region =3D g_new(MemoryRegion, 1);
     memory_region_allocate_system_memory(ram_region, OBJECT(machine),
                                          "ram", ram_size);
-    memory_region_add_subregion(addr_space, 0, ram_region);
+    memory_region_add_subregion_overlap(addr_space, 0, ram_region, -1);
=20
     /* Init Dino (PCI host bus chip).  */
     pci_bus =3D dino_init(addr_space, &rtc_irq, &serial_irq);
@@ -246,6 +247,8 @@ static void machine_hppa_init(MachineState *machine)
 static void hppa_machine_reset(MachineState *ms)
 {
     unsigned int smp_cpus =3D ms->smp.cpus;
+    uint64_t ram_size =3D ms->ram_size > FIRMWARE_START ? FIRMWARE_START :
+                                                        ms->ram_size;
     int i;
=20
     qemu_devices_reset();
--=20
2.7.4


