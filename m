Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FBBBC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 12:16:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F3F6217F4
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 12:16:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ephoh5Px"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F3F6217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iubPk-0006LX-Js
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 07:16:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35706)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iuasV-0006OY-3I
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:42:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iuasT-0004ZF-Vi
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:42:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25646
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iuasT-0004Yu-RP
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:42:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579779745;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BodJZ2/t7zg+j82vxZS/xF8BVbdEormj2ANyrNQn15g=;
 b=ephoh5PxaU/7x88z0zEY8lY2QfhJI2mCXBjdnUDc3J4fvc3AdRqIYfa7u6Voku0+S5zAiu
 nyLoekT6k5pfMGUdRfX6gigKiPm5yhAKDs67vm2G6LJCDyNfPm634LQuFgziYCaix1S85r
 6lC8NA5wI+hGJTLC+ZCJfmnEtoiFm30=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-86-OqESnZ9KNqet1hcScIcWtg-1; Thu, 23 Jan 2020 06:42:23 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B5F251005516
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 11:42:22 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 38FCF10016EB
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 11:42:22 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH REPOST v3 40/80] hw/hppa/machine: Restrict the total memory
 size to 3GB
Date: Thu, 23 Jan 2020 12:38:05 +0100
Message-Id: <1579779525-20065-41-git-send-email-imammedo@redhat.com>
In-Reply-To: <1579779525-20065-1-git-send-email-imammedo@redhat.com>
References: <1579779525-20065-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: OqESnZ9KNqet1hcScIcWtg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

The hardware expects DIMM slots of 1 or 2 GB, allowing up to
4 GB of memory. We want to accept the same amount of memory the
hardware can deal with. DIMMs of 768MB are not available.

However we have to deal with a firmware limitation: currently
SeaBIOS only supports 32-bit, and expects the RAM size in a
32-bit register. When using a 4GB configuration, the 32-bit
register get truncated and we report a size of 0MB to SeaBIOS,
which ends halting the machine:

  $ qemu-system-hppa -m 4g -serial stdio

  SeaBIOS: Machine configured with too little memory (0 MB), minimum is 16 =
MB.

  SeaBIOS wants SYSTEM HALT.

The easiest way is to restrict the machine to 3GB of memory.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: Helge Deller <deller@gmx.de>
Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/hppa/machine.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 6775d87..119ae4d 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -90,12 +90,11 @@ static void machine_hppa_init(MachineState *machine)
         g_free(name);
     }
=20
-    /* Limit main memory. */
-    if (ram_size > FIRMWARE_START) {
-        machine->ram_size =3D ram_size =3D FIRMWARE_START;
-    }
-
     /* Main memory region. */
+    if (machine->ram_size > 3 * GiB) {
+        error_report("RAM size is currently restricted to 3GB");
+        exit(EXIT_FAILURE);
+    }
     ram_region =3D g_new(MemoryRegion, 1);
     memory_region_allocate_system_memory(ram_region, OBJECT(machine),
                                          "ram", ram_size);
--=20
2.7.4


