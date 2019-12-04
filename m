Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BTC_ID,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B78DBC43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 17:08:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 830722081B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 17:08:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Id6dyCzj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 830722081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icY8z-0007Jj-1B
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 12:08:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43576)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1icY6H-0005Ng-Eq
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 12:06:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1icY6G-00074U-3W
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 12:06:05 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:56317
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1icY6F-0006k1-V3
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 12:06:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575479162;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hpMeJfL69t01dB4rXZUwcJ1cv+AEgkBhVyd3WRXvwJU=;
 b=Id6dyCzjq9JyubOKC0s5mg2nE3zsx2BDwkUXEgNN04BCuUJfjHgcspD+1/BZO6lpJ9t+kA
 bcctx15kjdcchkkGrH3aHEiiqbvVQHGTM2cL3wWLLpupbz4dbI346icNLHqz7YTY1Qp02N
 IrJM+DovloHm0T21BHDrlShrZiZSJtQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-358-sBpHFzriMd-tDBZyFVDzRQ-1; Wed, 04 Dec 2019 12:05:57 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8A0EE801E79
 for <qemu-devel@nongnu.org>; Wed,  4 Dec 2019 17:05:56 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 60EB25D6BB;
 Wed,  4 Dec 2019 17:05:55 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.0 7/8] acpi: cpuhp: add CPHP_GET_CPU_ID_CMD command
Date: Wed,  4 Dec 2019 18:05:46 +0100
Message-Id: <1575479147-6641-8-git-send-email-imammedo@redhat.com>
In-Reply-To: <1575479147-6641-1-git-send-email-imammedo@redhat.com>
References: <1575479147-6641-1-git-send-email-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: sBpHFzriMd-tDBZyFVDzRQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: pbonzini@redhat.com, philmd@redhat.com, lersek@redhat.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Extend CPU hotplug interface to return architecture specific
identifier for current CPU in 2 registers:
 - lower 32 bits existing ACPI_CPU_CMD_DATA_OFFSET_RW
 - upper 32 bits in new ACPI_CPU_CMD_DATA2_OFFSET_R at
   offset 0.

Target user is UEFI firmware, which needs a way to enumerate
all CPUs (including possible CPUs) to allocate and initialize
CPU structures on boot.
(for x86: it needs APIC ID and later command will be used to
retrieve ARM's MPIDR which serves the similar to APIC ID purpose)

The new ACPI_CPU_CMD_DATA2_OFFSET_R register will also be used
to detect presence of modern CPU hotplug, which will be described
in follow up patch.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
v1:
 - s/ACPI_CPU_CMD_DATA2_OFFSET_RW/ACPI_CPU_CMD_DATA2_OFFSET_R/.
---
 docs/specs/acpi_cpu_hotplug.txt | 10 ++++++++--
 hw/acpi/cpu.c                   | 15 +++++++++++++++
 hw/acpi/trace-events            |  1 +
 3 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/docs/specs/acpi_cpu_hotplug.txt b/docs/specs/acpi_cpu_hotplug.=
txt
index 58c16c6..bb33144 100644
--- a/docs/specs/acpi_cpu_hotplug.txt
+++ b/docs/specs/acpi_cpu_hotplug.txt
@@ -44,7 +44,11 @@ keeps the current value.
=20
 read access:
     offset:
-    [0x0-0x3] reserved
+    [0x0-0x3] Command data 2: (DWORD access)
+              if last stored 'Command field' value:
+                  3: upper 32 bits of architecture specific identifying CP=
U value
+                     (n x86 case: 0x0)
+                  other values: reserved
     [0x4] CPU device status fields: (1 byte access)
         bits:
            0: Device is enabled and may be used by guest
@@ -96,7 +100,9 @@ write access:
               2: stores value into OST status register, triggers
                  ACPI_DEVICE_OST QMP event from QEMU to external applicati=
ons
                  with current values of OST event and status registers.
-            other values: reserved
+              3: lower 32 bit of architecture specific identifier
+                 (in x86 case: APIC ID)
+              other values: reserved
=20
     Typical usecases:
         - Get a cpu with pending event
diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
index 87f30a3..87813ce 100644
--- a/hw/acpi/cpu.c
+++ b/hw/acpi/cpu.c
@@ -12,11 +12,13 @@
 #define ACPI_CPU_FLAGS_OFFSET_RW 4
 #define ACPI_CPU_CMD_OFFSET_WR 5
 #define ACPI_CPU_CMD_DATA_OFFSET_RW 8
+#define ACPI_CPU_CMD_DATA2_OFFSET_R 0
=20
 enum {
     CPHP_GET_NEXT_CPU_WITH_EVENT_CMD =3D 0,
     CPHP_OST_EVENT_CMD =3D 1,
     CPHP_OST_STATUS_CMD =3D 2,
+    CPHP_GET_CPU_ID_CMD =3D 3,
     CPHP_CMD_MAX
 };
=20
@@ -74,11 +76,24 @@ static uint64_t cpu_hotplug_rd(void *opaque, hwaddr add=
r, unsigned size)
         case CPHP_GET_NEXT_CPU_WITH_EVENT_CMD:
            val =3D cpu_st->selector;
            break;
+        case CPHP_GET_CPU_ID_CMD:
+           val =3D cdev->arch_id & 0xFFFFFFFF;
+           break;
         default:
            break;
         }
         trace_cpuhp_acpi_read_cmd_data(cpu_st->selector, val);
         break;
+    case ACPI_CPU_CMD_DATA2_OFFSET_R:
+        switch (cpu_st->command) {
+        case CPHP_GET_CPU_ID_CMD:
+           val =3D cdev->arch_id >> 32;
+           break;
+        default:
+           break;
+        }
+        trace_cpuhp_acpi_read_cmd_data2(cpu_st->selector, val);
+        break;
     default:
         break;
     }
diff --git a/hw/acpi/trace-events b/hw/acpi/trace-events
index 96b8273..afbc77d 100644
--- a/hw/acpi/trace-events
+++ b/hw/acpi/trace-events
@@ -23,6 +23,7 @@ cpuhp_acpi_read_flags(uint32_t idx, uint8_t flags) "idx[0=
x%"PRIx32"] flags: 0x%"
 cpuhp_acpi_write_idx(uint32_t idx) "set active cpu idx: 0x%"PRIx32
 cpuhp_acpi_write_cmd(uint32_t idx, uint8_t cmd) "idx[0x%"PRIx32"] cmd: 0x%=
"PRIx8
 cpuhp_acpi_read_cmd_data(uint32_t idx, uint32_t data) "idx[0x%"PRIx32"] da=
ta: 0x%"PRIx32
+cpuhp_acpi_read_cmd_data2(uint32_t idx, uint32_t data) "idx[0x%"PRIx32"] d=
ata: 0x%"PRIx32
 cpuhp_acpi_cpu_has_events(uint32_t idx, bool ins, bool rm) "idx[0x%"PRIx32=
"] inserting: %d, removing: %d"
 cpuhp_acpi_clear_inserting_evt(uint32_t idx) "idx[0x%"PRIx32"]"
 cpuhp_acpi_clear_remove_evt(uint32_t idx) "idx[0x%"PRIx32"]"
--=20
2.7.4


