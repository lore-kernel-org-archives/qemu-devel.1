Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A23C43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 13:19:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0F3B2068E
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 13:19:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KPg5iIbX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0F3B2068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieIwb-0007rv-RG
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 08:19:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45097)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1ieIn1-0006p3-Ip
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 08:09:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1ieIn0-0006dG-2Y
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 08:09:27 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46840
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1ieImz-0006bt-Uz
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 08:09:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575896965;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B7uZeO4NcyE8AIY+HXwj6iY7M5kyj0Ki4tjCJ8qqRSA=;
 b=KPg5iIbXAcbIMZhsKXFoLYDk+/geCtkPFcPUmmy/reErmZ1Ce/spSkgUlEBHjKxuuyhkyT
 QHnBPN3IhjPJzC0oamAvvTg15UQLh0TLh7JDyG4boMv0bYV0g5QwZDSvBGK6wnXmgPH33W
 bQojGVCnlC0idX4Ky6tgTd59A5SRGd8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-151-oCvewKo4NNy6_3WeX1hJ7Q-1; Mon, 09 Dec 2019 08:09:18 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7C88318AAFA1
 for <qemu-devel@nongnu.org>; Mon,  9 Dec 2019 13:09:17 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 56D525D9D6;
 Mon,  9 Dec 2019 13:09:16 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.0 v2 8/9] acpi: cpuhp: spec: add typical usecases
Date: Mon,  9 Dec 2019 14:09:01 +0100
Message-Id: <1575896942-331151-9-git-send-email-imammedo@redhat.com>
In-Reply-To: <1575896942-331151-1-git-send-email-imammedo@redhat.com>
References: <1575896942-331151-1-git-send-email-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: oCvewKo4NNy6_3WeX1hJ7Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
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
Cc: pbonzini@redhat.com, philmd@redhat.com, lersek@redhat.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Document work-flows for
  * enabling/detecting modern CPU hotplug interface
  * finding a CPU with pending 'insert/remove' event
  * enumerating present and possible CPUs

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
v2:
 - fix indent of "other values" that's just above
   being added "Typical usecases:" section
 - unindent "Typical usecases" to put it into right scope
   (Laszlo)
 - squash in ammended (using CPHP_GET_NEXT_CPU_WITH_EVENT_CMD)
   "acpi: cpuhp: spec: document procedure for  enabling modern CPU hotplug"
   (Laszlo)
---
 docs/specs/acpi_cpu_hotplug.txt | 51 +++++++++++++++++++++++++++++++++++++=
+---
 1 file changed, 48 insertions(+), 3 deletions(-)

diff --git a/docs/specs/acpi_cpu_hotplug.txt b/docs/specs/acpi_cpu_hotplug.=
txt
index 9879f9e..cb99cf3 100644
--- a/docs/specs/acpi_cpu_hotplug.txt
+++ b/docs/specs/acpi_cpu_hotplug.txt
@@ -15,14 +15,14 @@ CPU present bitmap for:
   PIIX-PM  (IO port 0xaf00-0xaf1f, 1-byte access)
   One bit per CPU. Bit position reflects corresponding CPU APIC ID. Read-o=
nly.
   The first DWORD in bitmap is used in write mode to switch from legacy
-  to new CPU hotplug interface, write 0 into it to do switch.
+  to modern CPU hotplug interface, write 0 into it to do switch.
 ---------------------------------------------------------------
 QEMU sets corresponding CPU bit on hot-add event and issues SCI
 with GPE.2 event set. CPU present map is read by ACPI BIOS GPE.2 handler
 to notify OS about CPU hot-add events. CPU hot-remove isn't supported.
=20
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-ACPI CPU hotplug interface registers:
+Modern ACPI CPU hotplug interface registers:
 -------------------------------------
 Register block base address:
     ICH9-LPC IO port 0x0cd8
@@ -67,6 +67,7 @@ write access:
     [0x0-0x3] CPU selector: (DWORD access)
               selects active CPU device. All following accesses to other
               registers will read/store data from/to selected CPU.
+              Valid values: [0 .. max_cpus)
     [0x4] CPU device control fields: (1 byte access)
         bits:
             0: reserved, OSPM must clear it before writing to register.
@@ -98,4 +99,48 @@ write access:
               2: stores value into OST status register, triggers
                  ACPI_DEVICE_OST QMP event from QEMU to external applicati=
ons
                  with current values of OST event and status registers.
-            other values: reserved
+              other values: reserved
+
+Typical usecases:
+    - (x86) Detecting and enabling modern CPU hotplug interface.
+      QEMU starts with legacy CPU hotplug interface enabled. Detecting and
+      switching to modern interface is based on the 2 legacy CPU hotplug f=
eatures:
+        1. Writes into CPU bitmap are ignored.
+        2. CPU bitmap always has bit#0 set, corresponding to boot CPU.
+
+      Use following steps to detect and enable modern CPU hotplug interfac=
e:
+        1. Store 0x0 to the 'CPU selector' register,
+           attempting to switch to modern mode
+        2. Store 0x0 to the 'CPU selector' register,
+           to ensure valid selector value
+        3. Store 0x0 to the 'Command field' register,
+        4. Read the 'Command data 2' register.
+           If read value is 0x0, the modern interface is enabled.
+           Otherwise legacy or no CPU hotplug interface available
+
+    - Get a cpu with pending event
+      1. Store 0x0 to the 'CPU selector' register.
+      2. Store 0x0 to the 'Command field' register.
+      3. Read the 'CPU device status fields' register.
+      4. If both bit#1 and bit#2 are clear in the value read, there is no =
CPU
+         with a pending event and selected CPU remains unchanged.
+      5. Otherwise, read the 'Command data' register. The value read is th=
e
+         selector of the CPU with the pending event (which is already
+         selected).
+
+    - Enumerate CPUs present/non present CPUs
+      01. Set the present CPU count to 0.
+      02. Set the iterator to 0.
+      03. Store 0x0 to the 'CPU selector' register, to ensure that it's in
+          a valid state and that access to other registers won't be ignore=
d.
+      04. Store 0x0 to the 'Command field' register to make 'Command data'
+          register return 'CPU selector' value of selected CPU
+      05. Read the 'CPU device status fields' register.
+      06. If bit#0 is set, increment the present CPU count.
+      07. Increment the iterator.
+      08. Store the iterator to the 'CPU selector' register.
+      09. Read the 'Command data' register.
+      10. If the value read is not zero, goto 05.
+      11. Otherwise store 0x0 to the 'CPU selector' register, to put it
+          into a valid state and exit.
+          The iterator at this point equals "max_cpus".
--=20
2.7.4


