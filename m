Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06201C43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 13:18:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C28682068E
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 13:18:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MkIz07HG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C28682068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieIvk-00078G-C8
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 08:18:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45066)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1ieImy-0006ky-TR
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 08:09:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1ieImw-0006Vb-J5
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 08:09:23 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48737
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1ieImw-0006UU-F2
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 08:09:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575896962;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hrv7w8oWl4v3zXpCbYG5A0WNpbhVP5sF5WD50lFPsPw=;
 b=MkIz07HGSllncnM3y980ppHC0Ol8SFkk33QWGNIOZ3n2+S/GaWnnM9RSdH1YBogWnH8k0s
 gCWAJ4/9jM9soxd98Rd8QusBrHl9O9jXW7IZLrDCraKh6k3wRNah3ofL9Rjzphxdh5AtgX
 ehrAS14idLUuzLfSRIBuIGM2GJ7m8GA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-154-VTTKusSIPR6YK4w95mlRhA-1; Mon, 09 Dec 2019 08:09:19 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EBAC88017DF
 for <qemu-devel@nongnu.org>; Mon,  9 Dec 2019 13:09:18 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C59515D9D6;
 Mon,  9 Dec 2019 13:09:17 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.0 v2 9/9] acpi: cpuhp: add CPHP_GET_CPU_ID_CMD command
Date: Mon,  9 Dec 2019 14:09:02 +0100
Message-Id: <1575896942-331151-10-git-send-email-imammedo@redhat.com>
In-Reply-To: <1575896942-331151-1-git-send-email-imammedo@redhat.com>
References: <1575896942-331151-1-git-send-email-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: VTTKusSIPR6YK4w95mlRhA-1
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
Cc: pbonzini@redhat.com, philmd@redhat.com, lersek@redhat.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Firmware can enumerate present at boot APs by broadcasting wakeup IPI,
so that woken up secondary CPUs could register them-selves.
However in CPU hotplug case, it would need to know architecture
specific CPU IDs for possible and hotplugged CPUs so it could
prepare environment for and wake hotplugged AP.

Reuse and extend existing CPU hotplug interface to return architecture
specific ID for currently selected CPU in 2 registers:
 - lower 32 bits in ACPI_CPU_CMD_DATA_OFFSET_RW
 - upper 32 bits in ACPI_CPU_CMD_DATA2_OFFSET_R

On x86, firmware will use CPHP_GET_CPU_ID_CMD for fetching the APIC ID
when handling hotplug SMI.

Later, CPHP_GET_CPU_ID_CMD will be used on ARM to retrieve MPIDR,
which serves the similar to APIC ID purpose.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
v1:
 - s/ACPI_CPU_CMD_DATA2_OFFSET_RW/ACPI_CPU_CMD_DATA2_OFFSET_R/.
v2:
 - ACPI_CPU_CMD_DATA2_OFFSET_R moved into separate patch
   that adds 'Command data 2' field separately
 - ammend commit message
---
 docs/specs/acpi_cpu_hotplug.txt | 3 +++
 hw/acpi/cpu.c                   | 7 +++++++
 2 files changed, 10 insertions(+)

diff --git a/docs/specs/acpi_cpu_hotplug.txt b/docs/specs/acpi_cpu_hotplug.=
txt
index cb99cf3..a8ce5e7 100644
--- a/docs/specs/acpi_cpu_hotplug.txt
+++ b/docs/specs/acpi_cpu_hotplug.txt
@@ -47,6 +47,7 @@ read access:
     [0x0-0x3] Command data 2: (DWORD access)
               if value last stored in 'Command field':
                 0: reads as 0x0
+                3: upper 32 bits of architecture specific CPU ID value
                 other values: reserved
     [0x4] CPU device status fields: (1 byte access)
         bits:
@@ -61,6 +62,8 @@ read access:
     [0x8] Command data: (DWORD access)
           contains 0 unless value last stored in 'Command field' is one of=
:
               0: contains 'CPU selector' value of a CPU with pending event=
[s]
+              3: lower 32 bits of architecture specific CPU ID value
+                 (in x86 case: APIC ID)
=20
 write access:
     offset:
diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
index d475c06..e2c957c 100644
--- a/hw/acpi/cpu.c
+++ b/hw/acpi/cpu.c
@@ -18,6 +18,7 @@ enum {
     CPHP_GET_NEXT_CPU_WITH_EVENT_CMD =3D 0,
     CPHP_OST_EVENT_CMD =3D 1,
     CPHP_OST_STATUS_CMD =3D 2,
+    CPHP_GET_CPU_ID_CMD =3D 3,
     CPHP_CMD_MAX
 };
=20
@@ -75,6 +76,9 @@ static uint64_t cpu_hotplug_rd(void *opaque, hwaddr addr,=
 unsigned size)
         case CPHP_GET_NEXT_CPU_WITH_EVENT_CMD:
            val =3D cpu_st->selector;
            break;
+        case CPHP_GET_CPU_ID_CMD:
+           val =3D cdev->arch_id & 0xFFFFFFFF;
+           break;
         default:
            break;
         }
@@ -85,6 +89,9 @@ static uint64_t cpu_hotplug_rd(void *opaque, hwaddr addr,=
 unsigned size)
         case CPHP_GET_NEXT_CPU_WITH_EVENT_CMD:
            val =3D 0;
            break;
+        case CPHP_GET_CPU_ID_CMD:
+           val =3D cdev->arch_id >> 32;
+           break;
         default:
            break;
         }
--=20
2.7.4


