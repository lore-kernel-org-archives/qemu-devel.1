Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E946C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 13:12:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEEC12083B
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 13:12:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="e/sRlyVQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEEC12083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgqgG-0004wI-45
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 09:12:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41488)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <damien.hedde@greensocs.com>) id 1hgqGN-0008Pd-E9
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 08:46:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1hgqGK-0001Zn-TH
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 08:45:59 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:36920)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1hgqGK-0001Qz-4T
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 08:45:56 -0400
Received: from kouign-amann.bar.greensocs.com (unknown [172.16.11.117])
 by beetle.greensocs.com (Postfix) with ESMTPS id 88A5896F53;
 Fri, 28 Jun 2019 12:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1561725939;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+jjwPWtFxt7ePzzf+2PHr+LueKDt8+NJ5t9Cx/GeY1g=;
 b=e/sRlyVQVWtXqYF9JyV7LTN79hDrgnuk6Elgp+LmPncFLOqHJBobew+d2F9rKf6s2fMreE
 4DpQG1LAPjjp1XkbNaTnFe+VIxgtALZABtqEqG7xm+G5iQ2c++MCRnXhcbVHrEIksXdI6j
 rJOnGTi4bqowopS5ii+oHp1pm67xDCI=
From: Damien Hedde <damien.hedde@greensocs.com>
To: qemu-devel@nongnu.org
Date: Fri, 28 Jun 2019 14:45:30 +0200
Message-Id: <20190628124534.10679-2-damien.hedde@greensocs.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190628124534.10679-1-damien.hedde@greensocs.com>
References: <20190628124534.10679-1-damien.hedde@greensocs.com>
MIME-Version: 1.0
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1561725939;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+jjwPWtFxt7ePzzf+2PHr+LueKDt8+NJ5t9Cx/GeY1g=;
 b=0zcU5pI5cjVhFy+XhOW3HpjuJKTSTXZ4Jrpeugqq+GW4jV0Ag0Rv2ODte3WAD7P4Mr4ktH
 m3ss7b2LHYoLQ7XjHLdYZzA/ZrCy2xP6cWfuXLtu3FxZPFIdzZ9nT3/7zj9sV7Qh8fUsDw
 EAE9ISsdzi5WNnsAdj7ywGgsZhePTQM=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1561725939; a=rsa-sha256; cv=none;
 b=gQ/hhAG9GgqSEOf2ts5c+5FvRqJvHZdfi/W2vjDVqcRDMX50zmnA2tylROQcJI8zoTbIvj
 yAQHRbD8xN09wOYyOLNjQP+uCqW8FiaAdqpywjUVFNXm1jIMWMnk0IGs80WZXq4gD097Iy
 t79rcMY1N9E9SPYNvtzxCe6P80YZl7A=
ARC-Authentication-Results: i=1;
	beetle.greensocs.com;
	none
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.135.226.135
Subject: [Qemu-devel] [RFC PATCH 1/5] introduce [p]mem(read|write) qmp
 commands
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
Cc: Damien Hedde <damien.hedde@greensocs.com>, ehabkost@redhat.com,
 mark.burton@greensocs.com, armbru@redhat.com, sakisp@xilinx.com,
 edgari@xilinx.com, crosa@redhat.com, pbonzini@redhat.com,
 luc.michel@greensocs.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This introduces memread, memwrite, pmemread and pmemwrite qmp commands.

The memread and memwrite read virtual memory from a given cpu point of
view. If no cpu index is specified, the cpu-id 0 is used.

The pmemread and pmemwrite directly read physical memory.

The data is passed/returned in a list of bytes. The maximum length is set=
 to 8, they can be used to 64bits.

This is based on the work of Frederic Konrad.

Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
---
 cpus.c         | 126 +++++++++++++++++++++++++++++++++++++++++++++++++
 qapi/misc.json | 119 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 245 insertions(+)

diff --git a/cpus.c b/cpus.c
index 1af51b73dd..7aae35c098 100644
--- a/cpus.c
+++ b/cpus.c
@@ -2484,3 +2484,129 @@ void dump_drift_info(void)
         qemu_printf("Max guest advance   NA\n");
     }
 }
+
+static Bytes *memread(int64_t addr, int64_t size, CPUState *cpu, Error *=
*errp)
+{
+    uint32_t l =3D 0;
+    uint8List *prev =3D NULL;
+    Bytes *res;
+    uint8_t buf[8];
+
+    if (size <=3D 0 || size > sizeof(buf)) {
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "size",
+                   "out of range");
+        return NULL;
+    }
+
+    if (cpu) {
+        if (cpu_memory_rw_debug(cpu, addr, buf, size, 0) !=3D 0) {
+            error_setg(errp, "Invalid addr 0x%016" PRIx64 "/size %" PRId=
64
+                             " specified", addr, size);
+            return NULL;
+        }
+    } else {
+        MemTxResult r =3D address_space_read(&address_space_memory, addr=
,
+                                           MEMTXATTRS_UNSPECIFIED, buf, =
l);
+        if (r !=3D MEMTX_OK) {
+            error_setg(errp, "Invalid addr 0x%016" PRIx64 "/size %" PRId=
64
+                             " specified", addr, size);
+            return NULL;
+        }
+    }
+
+    res =3D g_new0(Bytes, 1);
+    while (l < size) {
+        uint8List *cur =3D g_new0(uint8List, 1);
+        cur->value =3D buf[l++];
+        if (!prev) {
+            res->bytes =3D cur;
+        } else {
+            prev->next =3D cur;
+        }
+        prev =3D cur;
+    }
+
+    return res;
+
+}
+
+Bytes *qmp_memread(int64_t addr, int64_t size,
+                   bool has_cpu, int64_t cpu_index, Error **errp)
+{
+    CPUState *cpu;
+
+    if (!has_cpu) {
+        cpu_index =3D 0;
+    }
+
+    cpu =3D qemu_get_cpu(cpu_index);
+    if (cpu =3D=3D NULL) {
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "cpu-index",
+                   "a CPU number");
+        return NULL;
+    }
+
+    return memread(addr, size, cpu, errp);
+}
+
+Bytes *qmp_pmemread(int64_t addr, int64_t size, Error **errp)
+{
+    return memread(addr, size, NULL, errp);
+}
+
+static void memwrite(int64_t addr, uint8List *bytes, CPUState *cpu,
+                     Error **errp)
+{
+    uint32_t l =3D 0;
+    uint8_t buf[8];
+
+    while (bytes !=3D NULL) {
+        if (l >=3D sizeof(buf)) {
+            error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "bytes",
+                       "too long");
+            return;
+        }
+        buf[l++] =3D bytes->value;
+        bytes =3D bytes->next;
+    }
+
+    if (cpu) {
+        if (cpu_memory_rw_debug(cpu, addr, buf, l, 1) !=3D 0) {
+            error_setg(errp, "Invalid addr 0x%016" PRIx64 "/size %" PRIu=
32
+                             " specified", addr, l);
+            return;
+        }
+    } else {
+        MemTxResult r =3D address_space_write(&address_space_memory, add=
r,
+                                            MEMTXATTRS_UNSPECIFIED, buf,=
 l);
+        if (r !=3D MEMTX_OK) {
+            error_setg(errp, "Invalid addr 0x%016" PRIx64 "/size %" PRId=
64
+                             " specified", addr, size);
+            return;
+        }
+    }
+}
+
+void qmp_memwrite(int64_t addr, uint8List *bytes,
+                  bool has_cpu, int64_t cpu_index, Error **errp)
+{
+    CPUState *cpu;
+
+    if (!has_cpu) {
+        cpu_index =3D 0;
+    }
+
+    cpu =3D qemu_get_cpu(cpu_index);
+    if (cpu =3D=3D NULL) {
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "cpu-index",
+                   "a CPU number");
+        return;
+    }
+
+    memwrite(addr, bytes, cpu, errp);
+}
+
+void qmp_pmemwrite(int64_t addr, uint8List *bytes, Error **errp)
+{
+    memwrite(addr, bytes, NULL, errp);
+}
diff --git a/qapi/misc.json b/qapi/misc.json
index dc4cf9da20..3aca91b4ac 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -3047,3 +3047,122 @@
   'data': 'NumaOptions',
   'allow-preconfig': true
 }
+
+##
+# @Bytes:
+#
+# An array of bytes.
+#
+# @bytes: the list of bytes
+#
+# Since: 4.1
+##
+{ 'struct': 'Bytes', 'data': {'bytes': ['uint8'] } }
+
+##
+# @memread:
+#
+# Read a portion of guest memory.
+#
+# @addr: the virtual address of the guest to read from
+#
+# @size: the size of memory region to read (max is 8)
+#
+# @cpu-index: the index of the virtual CPU to use for translating the
+#                       virtual address (defaults to CPU 0)
+#
+# Returns: The read bytes
+#
+# Since: 4.1
+#
+# Example:
+#
+# -> { "execute": "memread",
+#      "arguments": { "addr": 10,
+#                     "size": 4 } }
+# <- { "return": { 'bytes' : [10, 78, 231, 7] } }
+#
+##
+{ 'command': 'memread',
+  'data': {'addr': 'int', 'size': 'int', '*cpu-index': 'int'},
+  'returns' : 'Bytes'
+}
+
+##
+# @memwrite:
+#
+# Write a portion of guest memory.
+#
+# @addr: the virtual address of the guest to write to
+#
+# @bytes: the bytes to write into memory region (max length is 8)
+#
+# @cpu-index: the index of the virtual CPU to use for translating the
+#                       virtual address (defaults to CPU 0)
+#
+# Since: 4.1
+#
+# Returns: nothing on success.
+#
+# Example:
+#
+# -> { "execute": "memread",
+#      "arguments": { "addr": 10,
+#                     "bytes": [10, 78, 231, 7] } }
+# <- { "return": {} }
+#
+##
+{ 'command': 'memwrite',
+  'data': {'addr': 'int', 'bytes': ['uint8'], '*cpu-index': 'int'}
+}
+
+##
+# @pmemread:
+#
+# Read a portion of guest memory.
+#
+# @addr: the physical address of the guest to read from
+#
+# @size: the size of memory region to read (max is 8)
+#
+# Returns: The read bytes
+#
+# Since: 4.1
+#
+# Example:
+#
+# -> { "execute": "memread",
+#      "arguments": { "addr": 10,
+#                     "size": 4 } }
+# <- { "return": { 'bytes' : [10, 78, 231, 7] } }
+#
+##
+{ 'command': 'pmemread',
+  'data': {'addr': 'int', 'size': 'int'},
+  'returns' : 'Bytes'
+}
+
+##
+# @pmemwrite:
+#
+# Write a portion of guest memory.
+#
+# @addr: the physical address of the guest to write to
+#
+# @bytes: the bytes to write into memory region (max length is 8)
+#
+# Since: 4.1
+#
+# Returns: nothing on success.
+#
+# Example:
+#
+# -> { "execute": "memread",
+#      "arguments": { "addr": 10,
+#                     "bytes": [10, 78, 231, 7] } }
+# <- { "return": {} }
+#
+##
+{ 'command': 'pmemwrite',
+  'data': {'addr': 'int', 'bytes': ['uint8']}
+}
--=20
2.22.0


