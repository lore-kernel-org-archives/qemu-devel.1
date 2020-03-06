Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BFAEC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 17:25:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDF5C20658
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 17:25:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U5t/y9cj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDF5C20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAGiy-0002df-Rk
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 12:25:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48771)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jAGZa-00056v-At
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 12:15:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jAGZX-0008E8-6B
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 12:15:42 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28222
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jAGZW-00089V-Rk
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 12:15:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583514937;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vuk8YHYDza90ATlmaEIWbc3X3FXvkSlMAwPxLNGqdu0=;
 b=U5t/y9cjky5HXjRCZWaf9ujdFFn8XHKzKsPKVAMIrmd+8d49pPxObNE2c1FGVeb0WcwUgS
 KiUL5hTanedFtzHjknl09bDATA6x7dV916wD3ZH8eACSyU7mq0L044LIl8Cz7Yi03ZFP/+
 OuZq6Nt4Tuhju6MEfSRvsH4SSNhKVqI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-42-XxMMVn0jNN-In6--St_YUw-1; Fri, 06 Mar 2020 12:15:33 -0500
X-MC-Unique: XxMMVn0jNN-In6--St_YUw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E49178014D1;
 Fri,  6 Mar 2020 17:15:32 +0000 (UTC)
Received: from linux.fritz.box.com (unknown [10.36.118.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ECA1273873;
 Fri,  6 Mar 2020 17:15:31 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 21/29] qapi: Create 'pragma' module
Date: Fri,  6 Mar 2020 18:14:50 +0100
Message-Id: <20200306171458.1848-22-kwolf@redhat.com>
In-Reply-To: <20200306171458.1848-1-kwolf@redhat.com>
References: <20200306171458.1848-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We want to share the whitelists between the system emulator schema and
the storage daemon schema, so move all the pragmas from the main schema
file into a separate file that can be included from both.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-Id: <20200224143008.13362-16-kwolf@redhat.com>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
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
+        'ACPISlotType',             # DIMM, visible through query-acpi-osp=
m-status
+        'CpuInfoMIPS',              # PC, visible through query-cpu
+        'CpuInfoTricore',           # PC, visible through query-cpu
+        'BlockdevVmdkSubformat',    # all members, to match VMDK spec spel=
lings
+        'BlockdevVmdkAdapterType',  # legacyESX, to match VMDK spec spelli=
ngs
+        'QapiErrorClass',           # all members, visible through errors
+        'UuidInfo',                 # UUID, visible through query-uuid
+        'X86CPURegister32',         # all members, visible indirectly thro=
ugh qom-get
+        'CpuInfo'                   # CPU, visible through query-cpu
+    ] } }
diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
index fe980ce437..43b0ba0dea 100644
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
-        'ACPISlotType',             # DIMM, visible through query-acpi-osp=
m-status
-        'CpuInfoMIPS',              # PC, visible through query-cpu
-        'CpuInfoTricore',           # PC, visible through query-cpu
-        'BlockdevVmdkSubformat',    # all members, to match VMDK spec spel=
lings
-        'BlockdevVmdkAdapterType',  # legacyESX, to match VMDK spec spelli=
ngs
-        'QapiErrorClass',           # all members, visible through errors
-        'UuidInfo',                 # UUID, visible through query-uuid
-        'X86CPURegister32',         # all members, visible indirectly thro=
ugh qom-get
-        'CpuInfo'                   # CPU, visible through query-cpu
-    ] } }
+{ 'include': 'pragma.json' }
=20
 # Documentation generated with qapi-gen.py is in source order, with
 # included sub-schemas inserted at the first include directive
diff --git a/qapi/Makefile.objs b/qapi/Makefile.objs
index 20fcc37c2c..cf33fd9cc0 100644
--- a/qapi/Makefile.objs
+++ b/qapi/Makefile.objs
@@ -7,7 +7,7 @@ util-obj-y +=3D qapi-util.o
=20
 QAPI_COMMON_MODULES =3D audio authz block-core block char common control c=
rypto
 QAPI_COMMON_MODULES +=3D dump error introspect job machine migration misc
-QAPI_COMMON_MODULES +=3D net qdev qom rdma rocker run-state sockets tpm
+QAPI_COMMON_MODULES +=3D net pragma qdev qom rdma rocker run-state sockets=
 tpm
 QAPI_COMMON_MODULES +=3D trace transaction ui
 QAPI_TARGET_MODULES =3D machine-target misc-target
 QAPI_MODULES =3D $(QAPI_COMMON_MODULES) $(QAPI_TARGET_MODULES)
--=20
2.20.1


