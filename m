Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F90FA372A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 13:14:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A40E720640
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 13:14:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A40E720640
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL5bz-0005HU-HZ
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 09:14:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60196)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iL5SP-0001BJ-R2
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:04:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iL5SO-00009K-FN
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:04:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46114)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1iL5SL-00007T-DL; Thu, 17 Oct 2019 09:04:41 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A7E1A307D976;
 Thu, 17 Oct 2019 13:04:40 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-117-24.ams2.redhat.com
 [10.36.117.24])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4457D1001B11;
 Thu, 17 Oct 2019 13:04:34 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [RFC PATCH 16/18] qapi: Create 'pragma' module
Date: Thu, 17 Oct 2019 15:02:02 +0200
Message-Id: <20191017130204.16131-17-kwolf@redhat.com>
In-Reply-To: <20191017130204.16131-1-kwolf@redhat.com>
References: <20191017130204.16131-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Thu, 17 Oct 2019 13:04:40 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: kwolf@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org,
 armbru@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We want to share the whitelists between the system emulator schema and
the storage daemon schema, so move all the pragmas from the main schema
file into a separate file that can be included from both.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qapi/pragma.json      | 24 ++++++++++++++++++++++++
 qapi/qapi-schema.json | 25 +------------------------
 qapi/Makefile.objs    |  2 +-
 3 files changed, 26 insertions(+), 25 deletions(-)
 create mode 100644 qapi/pragma.json

diff --git a/qapi/pragma.json b/qapi/pragma.json
new file mode 100644
index 0000000000..cffae27666
--- /dev/null
+++ b/qapi/pragma.json
@@ -0,0 +1,24 @@
+{ 'pragma': { 'doc-required': true } }
+
+# Whitelists to permit QAPI rule violations; think twice before you
+# add to them!
+{ 'pragma': {
+    # Commands allowed to return a non-dictionary:
+    'returns-whitelist': [
+        'human-monitor-command',
+        'qom-get',
+        'query-migrate-cache-size',
+        'query-tpm-models',
+        'query-tpm-types',
+        'ringbuf-read' ],
+    'name-case-whitelist': [
+        'ACPISlotType',             # DIMM, visible through query-acpi-o=
spm-status
+        'CpuInfoMIPS',              # PC, visible through query-cpu
+        'CpuInfoTricore',           # PC, visible through query-cpu
+        'BlockdevVmdkSubformat',    # all members, to match VMDK spec sp=
ellings
+        'BlockdevVmdkAdapterType',  # legacyESX, to match VMDK spec spel=
lings
+        'QapiErrorClass',           # all members, visible through error=
s
+        'UuidInfo',                 # UUID, visible through query-uuid
+        'X86CPURegister32',         # all members, visible indirectly th=
rough qom-get
+        'CpuInfo'                   # CPU, visible through query-cpu
+    ] } }
diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
index be90422ffe..85b4048535 100644
--- a/qapi/qapi-schema.json
+++ b/qapi/qapi-schema.json
@@ -49,30 +49,7 @@
 #
 ##
=20
-{ 'pragma': { 'doc-required': true } }
-
-# Whitelists to permit QAPI rule violations; think twice before you
-# add to them!
-{ 'pragma': {
-    # Commands allowed to return a non-dictionary:
-    'returns-whitelist': [
-        'human-monitor-command',
-        'qom-get',
-        'query-migrate-cache-size',
-        'query-tpm-models',
-        'query-tpm-types',
-        'ringbuf-read' ],
-    'name-case-whitelist': [
-        'ACPISlotType',             # DIMM, visible through query-acpi-o=
spm-status
-        'CpuInfoMIPS',              # PC, visible through query-cpu
-        'CpuInfoTricore',           # PC, visible through query-cpu
-        'BlockdevVmdkSubformat',    # all members, to match VMDK spec sp=
ellings
-        'BlockdevVmdkAdapterType',  # legacyESX, to match VMDK spec spel=
lings
-        'QapiErrorClass',           # all members, visible through error=
s
-        'UuidInfo',                 # UUID, visible through query-uuid
-        'X86CPURegister32',         # all members, visible indirectly th=
rough qom-get
-        'CpuInfo'                   # CPU, visible through query-cpu
-    ] } }
+{ 'include': 'pragma.json' }
=20
 # Documentation generated with qapi-gen.py is in source order, with
 # included sub-schemas inserted at the first include directive
diff --git a/qapi/Makefile.objs b/qapi/Makefile.objs
index 519b6f1a8e..3e04e299ed 100644
--- a/qapi/Makefile.objs
+++ b/qapi/Makefile.objs
@@ -7,7 +7,7 @@ util-obj-y +=3D qapi-util.o
=20
 QAPI_COMMON_MODULES =3D audio authz block-core block char common crypto
 QAPI_COMMON_MODULES +=3D dump error introspect job machine migration mis=
c monitor
-QAPI_COMMON_MODULES +=3D net qdev qom rdma rocker run-state sockets tpm
+QAPI_COMMON_MODULES +=3D net pragma qdev qom rdma rocker run-state socke=
ts tpm
 QAPI_COMMON_MODULES +=3D trace transaction ui
 QAPI_TARGET_MODULES =3D machine-target misc-target
 QAPI_MODULES =3D $(QAPI_COMMON_MODULES) $(QAPI_TARGET_MODULES)
--=20
2.20.1


