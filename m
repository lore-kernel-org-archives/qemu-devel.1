Received: from eggs.gnu.org ([2001:4830:134:3::10]:47458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1cWCcw-0003hE-Lb
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 20:43:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1cWCct-0005NJ-AC
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 20:43:58 -0500
Received: from mail-yw0-x233.google.com ([2607:f8b0:4002:c05::233]:35279)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ben@skyportsystems.com>)
	id 1cWCct-0005ND-63
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 20:43:55 -0500
Received: by mail-yw0-x233.google.com with SMTP id l19so177091489ywc.2
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 17:43:55 -0800 (PST)
From: ben@skyportsystems.com
Date: Tue, 24 Jan 2017 17:43:22 -0800
Message-Id: <d99cf50c824283af2ef2cd79f85b406c7094a321.1485308342.git.ben@skyportsystems.com>
In-Reply-To: <cover.1485308342.git.ben@skyportsystems.com>
References: <cover.1485308342.git.ben@skyportsystems.com>
In-Reply-To: <cover.1485308342.git.ben@skyportsystems.com>
References: <cover.1485308342.git.ben@skyportsystems.com>
Subject: [Qemu-devel] [PATCH v4 3/9] docs: VM Generation ID device
 description
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Ben Warren <ben@skyportsystems.com>, Gal Hammer <ghammer@redhat.com>

From: Ben Warren <ben@skyportsystems.com>

This patch is based off an earlier version by Gal Hammer (ghammer@redhat.com)

Signed-off-by: Gal Hammer <ghammer@redhat.com>
Signed-off-by: Ben Warren <ben@skyportsystems.com>
---
 docs/specs/vmgenid.txt | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 docs/specs/vmgenid.txt

diff --git a/docs/specs/vmgenid.txt b/docs/specs/vmgenid.txt
new file mode 100644
index 0000000..d36ed5b
--- /dev/null
+++ b/docs/specs/vmgenid.txt
@@ -0,0 +1,40 @@
+VIRTUAL MACHINE GENERATION ID
+=============================
+
+Copyright (C) 2016 Red Hat, Inc.
+Copyright (C) 2017 Skyport Systems, Inc.
+
+This work is licensed under the terms of the GNU GPL, version 2 or later.
+See the COPYING file in the top-level directory.
+
+===
+
+The VM generation ID (vmgenid) device is an emulated device which
+exposes a 128-bit, cryptographically random, integer value identifier.
+This allows management applications (e.g. libvirt) to notify the guest
+operating system when the virtual machine is executed with a different
+configuration (e.g. snapshot execution or creation from a template).
+
+This is specified on the web at: http://go.microsoft.com/fwlink/?LinkId=260709
+
+---
+
+The vmgenid device is a sysbus device with the ACPI ID "QEMUGVID".
+
+The device has one properties, which can be set using the command line
+argument or the QMP interface:
+ guid - sets the value of the GUID.  A special value "auto" instructs
+        QEMU to generate a new random GUID.
+For example:
+QEMU  -device vmgenid,guid="324e6eaf-d1d1-4bf6-bf41-b9bb6c91fb87"
+
+Or to change guid in runtime use:
+ set-vm-generation-id guid=124e6eaf-d1d1-4bf6-bf41-b9bb6c91fb87
+ set-vm-generation-id guid=auto
+
+According to the specification, any change to the GUID executes an
+ACPI notification. The vmgenid device triggers the \_GPE._E05 handler
+which executes the ACPI Notify operation.
+
+Although not specified in Microsoft's document, it is assumed that the
+device is expected to use the little-endian system.
-- 
2.7.4
