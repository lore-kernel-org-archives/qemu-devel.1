Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66BDCC32771
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 06:06:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3012024655
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 06:06:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UhiqXg00"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3012024655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iu9A5-0007bL-Co
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 01:06:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60048)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iu8yp-000382-AZ
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 00:55:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iu8yl-00062s-Sx
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 00:55:07 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54182
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iu8yl-00062g-Ok
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 00:55:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579672503;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e6oF8ptLJSLl44PBoGi3WUQj8MqGR3g9tIutmWvq7mo=;
 b=UhiqXg00+4m7kQss8ADPYOd9FtUMlmDH5a8qylVnGxzdPTpy3ObRtqpSB1J+PWCKJxMcqJ
 oCUNo0bHS9QqD/T6bgAso22TkpOQiV2QImVE5GXo+y64B9at7DhmxEHBwQ6K+LJg/ry3MY
 DL1hyH4Oi/V0tomiAj8Xan9uBb67ixU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-j5dODfXyPTKeQBrDKtHMlg-1; Wed, 22 Jan 2020 00:52:09 -0500
Received: by mail-wr1-f71.google.com with SMTP id f15so2574345wrr.2
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 21:52:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=e+M60MZmw7NUe0xGRZqvTtNyN03f8rI9bLRMhM9s7VE=;
 b=fUEyQxMxIX5n2/6Ow5ZbTrnLLLszeKaNuTa4DHpws85Yns7kgd8ez9Cj9/4fPKHnh+
 61K5+fmjVoggIAYg3a90D9jZon1L8wncNSKyisb2HkBLJzQr2cGUJmNFehPFVpCkTMsx
 nj/YSJMQfyWT3iK9mqIrIq+s+v56+E4EgZz3kRo09+ZuoN9bZsmkS3xtRalfjJWt5bxK
 hbaLIDph2rfVWV3MtIPdKU/MZCCV5GPIbn8RYcS+RgVzZPf91TXvBVtfrroYrQLzBk9f
 wEyBiF8E5SzPcJDBW1et59wmddz7EhTW5C2Y9+IvTst/6KrlB1ONKDPm+sWGP+9bU+tp
 zwSw==
X-Gm-Message-State: APjAAAWgHyLrrH2reAF69rDA3sT0YxJ8GmFqshoECZbE9LYEKzq/FioS
 Zhtt8m2RXDcqzbrEzBYKca4GvMxgOuLETyYBSaHgIpSBVIjTz9tEDle3SdU83gbu5pB6oTKCXrW
 bInWJETh492ANIxo=
X-Received: by 2002:adf:a746:: with SMTP id e6mr9011703wrd.329.1579672328245; 
 Tue, 21 Jan 2020 21:52:08 -0800 (PST)
X-Google-Smtp-Source: APXvYqyZGZhfi5cSW135aQDcfYrg1Tze217waWTrmf2dO4TP3H98PyupYZ7VaRELggtTnlNCZ8LCxA==
X-Received: by 2002:adf:a746:: with SMTP id e6mr9011679wrd.329.1579672328008; 
 Tue, 21 Jan 2020 21:52:08 -0800 (PST)
Received: from redhat.com (bzq-79-176-0-156.red.bezeqint.net. [79.176.0.156])
 by smtp.gmail.com with ESMTPSA id
 z21sm2573980wml.5.2020.01.21.21.52.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2020 21:52:07 -0800 (PST)
Date: Wed, 22 Jan 2020 00:52:05 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 07/17] acpi: cpuhp: spec: add typical usecases
Message-ID: <20200122055115.429945-8-mst@redhat.com>
References: <20200122055115.429945-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200122055115.429945-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: j5dODfXyPTKeQBrDKtHMlg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Laszlo Ersek <lersek@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Igor Mammedov <imammedo@redhat.com>

Document work-flows for
  * enabling/detecting modern CPU hotplug interface
  * finding a CPU with pending 'insert/remove' event
  * enumerating present and possible CPUs

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <1575896942-331151-9-git-send-email-imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
---
 docs/specs/acpi_cpu_hotplug.txt | 51 +++++++++++++++++++++++++++++++--
 1 file changed, 48 insertions(+), 3 deletions(-)

diff --git a/docs/specs/acpi_cpu_hotplug.txt b/docs/specs/acpi_cpu_hotplug.=
txt
index 9879f9ef7e..cb99cf3c8e 100644
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
MST


