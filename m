Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA76C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 16:05:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4782D206D3
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 16:05:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fD2+4Ue4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4782D206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixYno-0005c1-DF
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 11:05:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40150)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1ixXz2-0005h3-79
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 10:13:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1ixXz1-00064g-2U
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 10:13:24 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:32614
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1ixXz0-000642-Ux
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 10:13:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580483602;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ptI/lk1uvICFg8vCxGj0QRW2065nqGMLPXBASMM/wzY=;
 b=fD2+4Ue4659avJA+KKfJNc2qq7lfy25Eki25rPsSe1FrGNiTkjqE70LZ46p9GF7PghK/lf
 OArUtQ4hDGdqUuvr4BCvwLN38k3S8ZNUGUFWm6OKR4xWOokzkdZq3C59pVTCkehBHaUTAd
 KlqhjKyWAXsoXKHMQ+FHRXHPDvPPXjM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-UTW2UgICPH6Z1-Rvl5bQ7A-1; Fri, 31 Jan 2020 10:13:19 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3E9B11402
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2020 15:13:18 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BA16B89E7A
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2020 15:13:17 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 57/80] ppc/e500: drop RAM size fixup
Date: Fri, 31 Jan 2020 16:09:27 +0100
Message-Id: <1580483390-131164-58-git-send-email-imammedo@redhat.com>
In-Reply-To: <1580483390-131164-1-git-send-email-imammedo@redhat.com>
References: <1580483390-131164-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: UTW2UgICPH6Z1-Rvl5bQ7A-1
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

If user provided non-sense RAM size, board will complain and
continue running with max RAM size supported.
Also RAM is going to be allocated by generic code, so it won't be
possible for board to fix things up for user.

Make it error message and exit to force user fix CLI,
instead of accepting non-sense CLI values.

While at it, replace usage of global ram_size with
machine->ram_size

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
---
v2:
 * fix format string cousing build failure on 32-bit host
   (Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>)
---
 hw/ppc/e500.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 886442e..960024b 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -906,12 +906,14 @@ void ppce500_init(MachineState *machine)
=20
     env =3D firstenv;
=20
-    /* Fixup Memory size on a alignment boundary */
-    ram_size &=3D ~(RAM_SIZES_ALIGN - 1);
-    machine->ram_size =3D ram_size;
+    if (!QEMU_IS_ALIGNED(machine->ram_size, RAM_SIZES_ALIGN)) {
+        error_report("RAM size must be multiple of %" PRIu64, RAM_SIZES_AL=
IGN);
+        exit(EXIT_FAILURE);
+    }
=20
     /* Register Memory */
-    memory_region_allocate_system_memory(ram, NULL, "mpc8544ds.ram", ram_s=
ize);
+    memory_region_allocate_system_memory(ram, NULL, "mpc8544ds.ram",
+                                         machine->ram_size);
     memory_region_add_subregion(address_space_mem, 0, ram);
=20
     dev =3D qdev_create(NULL, "e500-ccsr");
@@ -1083,7 +1085,7 @@ void ppce500_init(MachineState *machine)
         kernel_base =3D cur_base;
         kernel_size =3D load_image_targphys(machine->kernel_filename,
                                           cur_base,
-                                          ram_size - cur_base);
+                                          machine->ram_size - cur_base);
         if (kernel_size < 0) {
             error_report("could not load kernel '%s'",
                          machine->kernel_filename);
@@ -1097,7 +1099,7 @@ void ppce500_init(MachineState *machine)
     if (machine->initrd_filename) {
         initrd_base =3D (cur_base + INITRD_LOAD_PAD) & ~INITRD_PAD_MASK;
         initrd_size =3D load_image_targphys(machine->initrd_filename, init=
rd_base,
-                                          ram_size - initrd_base);
+                                          machine->ram_size - initrd_base)=
;
=20
         if (initrd_size < 0) {
             error_report("could not load initial ram disk '%s'",
@@ -1115,7 +1117,7 @@ void ppce500_init(MachineState *machine)
      * ensures enough space between kernel and initrd.
      */
     dt_base =3D (loadaddr + payload_size + DTC_LOAD_PAD) & ~DTC_PAD_MASK;
-    if (dt_base + DTB_MAX_SIZE > ram_size) {
+    if (dt_base + DTB_MAX_SIZE > machine->ram_size) {
             error_report("not enough memory for device tree");
             exit(1);
     }
--=20
2.7.4


