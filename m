Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF95C43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 13:15:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B772E20663
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 13:15:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JhmO5szM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B772E20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieIsi-00053L-J3
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 08:15:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45065)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1ieImy-0006kx-Su
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 08:09:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1ieImw-0006Vw-Mo
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 08:09:24 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47064
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1ieImw-0006TX-In
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 08:09:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575896960;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NUT0d0GnH83DN8tXNv0Pikp7gHUonN+Nyize4nt1XkU=;
 b=JhmO5szMjoL6VSO0u5juQqrwyXB1+Cz68yUwfB5om1MQNl8UvgSpvWCxK4kPMLC3cyZYqU
 sfgxUsCG0J9572e6XSBhXOarB1qI8voytAIjNlT3c7+8oel18rAScW672TVZw0+KO+pcL1
 3PMhpm4os9aGRedrYcShudAAlRRuP2Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436-QCKrq1MoN9CvRmOErzDzfQ-1; Mon, 09 Dec 2019 08:09:16 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 12C98107ACC5
 for <qemu-devel@nongnu.org>; Mon,  9 Dec 2019 13:09:16 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9B8065D9D6;
 Mon,  9 Dec 2019 13:09:12 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.0 v2 7/9] acpi: cpuhp: introduce 'Command data 2' field
Date: Mon,  9 Dec 2019 14:09:00 +0100
Message-Id: <1575896942-331151-8-git-send-email-imammedo@redhat.com>
In-Reply-To: <1575896942-331151-1-git-send-email-imammedo@redhat.com>
References: <1575896942-331151-1-git-send-email-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: QCKrq1MoN9CvRmOErzDzfQ-1
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

No functional change in practice, patch only aims to properly
document (in spec and code) intended usage of the reserved space.

The new field is to be used for 2 purposes:
  - detection of modern CPU hotplug interface using
    CPHP_GET_NEXT_CPU_WITH_EVENT_CMD command.
    procedure will be described in follow up patch:
      "acpi: cpuhp: spec: add typical usecases"
  - for returning upper 32 bits of architecture specific CPU ID,
    for new CPHP_GET_CPU_ID_CMD command added by follow up patch:
      "acpi: cpuhp: add CPHP_GET_CPU_ID_CMD command"

Change is backward compatible with 4.2 and older machines, as field was
unconditionally reserved and always returned 0x0 if modern CPU hotplug
interface was enabled.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 docs/specs/acpi_cpu_hotplug.txt |  5 ++++-
 hw/acpi/cpu.c                   | 11 +++++++++++
 hw/acpi/trace-events            |  1 +
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/docs/specs/acpi_cpu_hotplug.txt b/docs/specs/acpi_cpu_hotplug.=
txt
index 8fb9ad2..9879f9e 100644
--- a/docs/specs/acpi_cpu_hotplug.txt
+++ b/docs/specs/acpi_cpu_hotplug.txt
@@ -44,7 +44,10 @@ keeps the current value.
=20
 read access:
     offset:
-    [0x0-0x3] reserved
+    [0x0-0x3] Command data 2: (DWORD access)
+              if value last stored in 'Command field':
+                0: reads as 0x0
+                other values: reserved
     [0x4] CPU device status fields: (1 byte access)
         bits:
            0: Device is enabled and may be used by guest
diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
index 87f30a3..d475c06 100644
--- a/hw/acpi/cpu.c
+++ b/hw/acpi/cpu.c
@@ -12,6 +12,7 @@
 #define ACPI_CPU_FLAGS_OFFSET_RW 4
 #define ACPI_CPU_CMD_OFFSET_WR 5
 #define ACPI_CPU_CMD_DATA_OFFSET_RW 8
+#define ACPI_CPU_CMD_DATA2_OFFSET_R 0
=20
 enum {
     CPHP_GET_NEXT_CPU_WITH_EVENT_CMD =3D 0,
@@ -79,6 +80,16 @@ static uint64_t cpu_hotplug_rd(void *opaque, hwaddr addr=
, unsigned size)
         }
         trace_cpuhp_acpi_read_cmd_data(cpu_st->selector, val);
         break;
+    case ACPI_CPU_CMD_DATA2_OFFSET_R:
+        switch (cpu_st->command) {
+        case CPHP_GET_NEXT_CPU_WITH_EVENT_CMD:
+           val =3D 0;
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


