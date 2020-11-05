Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70EF0C00A89
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 12:39:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDB012078E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 12:39:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="emY2oqCg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDB012078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaeY5-00061m-75
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 07:39:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45134)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kaePd-0003X0-CN
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 07:30:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20574)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kaePZ-00056U-6v
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 07:30:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604579437;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9EbuzCFRI/brzbam3F5Dv9wfcsYtvuJxZonK6c4pJaQ=;
 b=emY2oqCgs+qqnHeMzHWhcZJs2Fqtqv5Z/WK1tSHWUFgPRqyPXXFEMDJbxVJI4nQa9B05L4
 79aMVPiGFr6vc+lGoGHtatRS8iSe82KCVCWCL+ygDS96rSw2IIOje4aW+24UE1j6kbZO1P
 TszODbZhdefueJkwamfO5gHj7ieuIxY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-94-lvCPdEGRN4yAS6gaoBO6KA-1; Thu, 05 Nov 2020 07:30:35 -0500
X-MC-Unique: lvCPdEGRN4yAS6gaoBO6KA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2240A87950E;
 Thu,  5 Nov 2020 12:30:34 +0000 (UTC)
Received: from localhost (unknown [10.36.110.27])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EA51E19D6C;
 Thu,  5 Nov 2020 12:30:23 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Subject: [PATCH v2 8/9] qapi: make 'if' condition strings simple identifiers
Date: Thu,  5 Nov 2020 16:28:07 +0400
Message-Id: <20201105122808.1182973-9-marcandre.lureau@redhat.com>
In-Reply-To: <20201105122808.1182973-1-marcandre.lureau@redhat.com>
References: <20201105122808.1182973-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=marcandre.lureau@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/04 22:46:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Juan Quintela <quintela@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, jsnow@redhat.com,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Change the 'if' condition strings to be C-agnostic and be simple
identifiers.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 docs/devel/qapi-code-gen.txt                  |  8 +--
 qapi/block-core.json                          | 16 ++---
 qapi/char.json                                |  8 +--
 qapi/machine-target.json                      | 40 ++++++-------
 qapi/migration.json                           | 10 ++--
 qapi/misc-target.json                         | 46 +++++++-------
 qapi/ui.json                                  | 48 +++++++--------
 scripts/qapi/common.py                        |  2 +-
 scripts/qapi/expr.py                          |  4 +-
 .../alternate-branch-if-invalid.err           |  2 +-
 tests/qapi-schema/bad-if-empty.err            |  2 +-
 tests/qapi-schema/bad-if-list.err             |  2 +-
 tests/qapi-schema/bad-if.json                 |  2 +-
 tests/qapi-schema/doc-good.json               |  6 +-
 tests/qapi-schema/doc-good.out                |  6 +-
 tests/qapi-schema/features-missing-name.json  |  2 +-
 tests/qapi-schema/qapi-schema-test.json       | 52 ++++++++--------
 tests/qapi-schema/qapi-schema-test.out        | 60 +++++++++----------
 tests/qapi-schema/union-branch-if-invalid.err |  2 +-
 19 files changed, 159 insertions(+), 159 deletions(-)

diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
index c6438c6aa9..3d22a7ae21 100644
--- a/docs/devel/qapi-code-gen.txt
+++ b/docs/devel/qapi-code-gen.txt
@@ -783,7 +783,7 @@ will then be guarded by #if STRING for each STRING in the COND list.
 Example: a conditional struct
 
  { 'struct': 'IfStruct', 'data': { 'foo': 'int' },
-   'if': ['defined(CONFIG_FOO)', 'defined(HAVE_BAR)'] }
+   'if': ['CONFIG_FOO', 'HAVE_BAR'] }
 
 gets its generated code guarded like this:
 
@@ -802,7 +802,7 @@ member 'bar'
 
 { 'struct': 'IfStruct', 'data':
   { 'foo': 'int',
-    'bar': { 'type': 'int', 'if': 'defined(IFCOND)'} } }
+    'bar': { 'type': 'int', 'if': 'IFCOND'} } }
 
 A union's discriminator may not be conditional.
 
@@ -814,7 +814,7 @@ value 'bar'
 
 { 'enum': 'IfEnum', 'data':
   [ 'foo',
-    { 'name' : 'bar', 'if': 'defined(IFCOND)' } ] }
+    { 'name' : 'bar', 'if': 'IFCOND' } ] }
 
 Likewise, features can be conditional.  This requires the longhand
 form of FEATURE.
@@ -824,7 +824,7 @@ Example: a struct with conditional feature 'allow-negative-numbers'
 { 'struct': 'TestType',
   'data': { 'number': 'int' },
   'features': [ { 'name': 'allow-negative-numbers',
-                  'if' 'defined(IFCOND)' } ] }
+                  'if': 'IFCOND' } ] }
 
 Please note that you are responsible to ensure that the C code will
 compile with an arbitrary combination of conditions, since the
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 4ee81d226a..e285da1fa9 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2813,7 +2813,7 @@
 ##
 { 'enum': 'BlockdevAioOptions',
   'data': [ 'threads', 'native',
-            { 'name': 'io_uring', 'if': 'defined(CONFIG_LINUX_IO_URING)' } ] }
+            { 'name': 'io_uring', 'if': 'CONFIG_LINUX_IO_URING' } ] }
 
 ##
 # @BlockdevCacheOptions:
@@ -2851,7 +2851,7 @@
             'gluster', 'host_cdrom', 'host_device', 'http', 'https', 'iscsi',
             'luks', 'nbd', 'nfs', 'null-aio', 'null-co', 'nvme', 'parallels',
             'qcow', 'qcow2', 'qed', 'quorum', 'raw', 'rbd',
-            { 'name': 'replication', 'if': 'defined(CONFIG_REPLICATION)' },
+            { 'name': 'replication', 'if': 'CONFIG_REPLICATION' },
             'sheepdog',
             'ssh', 'throttle', 'vdi', 'vhdx', 'vmdk', 'vpc', 'vvfat' ] }
 
@@ -2894,10 +2894,10 @@
             '*locking': 'OnOffAuto',
             '*aio': 'BlockdevAioOptions',
             '*drop-cache': {'type': 'bool',
-                            'if': 'defined(CONFIG_LINUX)'},
+                            'if': 'CONFIG_LINUX'},
             '*x-check-cache-dropped': 'bool' },
   'features': [ { 'name': 'dynamic-auto-read-only',
-                  'if': 'defined(CONFIG_POSIX)' } ] }
+                  'if': 'CONFIG_POSIX' } ] }
 
 ##
 # @BlockdevOptionsNull:
@@ -3700,7 +3700,7 @@
 # Since: 2.9
 ##
 { 'enum' : 'ReplicationMode', 'data' : [ 'primary', 'secondary' ],
-  'if': 'defined(CONFIG_REPLICATION)' }
+  'if': 'CONFIG_REPLICATION' }
 
 ##
 # @BlockdevOptionsReplication:
@@ -3719,7 +3719,7 @@
   'base': 'BlockdevOptionsGenericFormat',
   'data': { 'mode': 'ReplicationMode',
             '*top-id': 'str' },
-  'if': 'defined(CONFIG_REPLICATION)' }
+  'if': 'CONFIG_REPLICATION' }
 
 ##
 # @NFSTransport:
@@ -4031,7 +4031,7 @@
       'raw':        'BlockdevOptionsRaw',
       'rbd':        'BlockdevOptionsRbd',
       'replication': { 'type': 'BlockdevOptionsReplication',
-                       'if': 'defined(CONFIG_REPLICATION)' },
+                       'if': 'CONFIG_REPLICATION' },
       'sheepdog':   'BlockdevOptionsSheepdog',
       'ssh':        'BlockdevOptionsSsh',
       'throttle':   'BlockdevOptionsThrottle',
@@ -4333,7 +4333,7 @@
 # Since: 5.1
 ##
 { 'enum': 'Qcow2CompressionType',
-  'data': [ 'zlib', { 'name': 'zstd', 'if': 'defined(CONFIG_ZSTD)' } ] }
+  'data': [ 'zlib', { 'name': 'zstd', 'if': 'CONFIG_ZSTD' } ] }
 
 ##
 # @BlockdevCreateOptionsQcow2:
diff --git a/qapi/char.json b/qapi/char.json
index b4d66ec90b..be28845cf9 100644
--- a/qapi/char.json
+++ b/qapi/char.json
@@ -343,7 +343,7 @@
 { 'struct': 'ChardevSpiceChannel',
   'data': { 'type': 'str' },
   'base': 'ChardevCommon',
-  'if': 'defined(CONFIG_SPICE)' }
+  'if': 'CONFIG_SPICE' }
 
 ##
 # @ChardevSpicePort:
@@ -357,7 +357,7 @@
 { 'struct': 'ChardevSpicePort',
   'data': { 'fqdn': 'str' },
   'base': 'ChardevCommon',
-  'if': 'defined(CONFIG_SPICE)' }
+  'if': 'CONFIG_SPICE' }
 
 ##
 # @ChardevVC:
@@ -415,9 +415,9 @@
             'stdio': 'ChardevStdio',
             'console': 'ChardevCommon',
             'spicevmc': { 'type': 'ChardevSpiceChannel',
-                          'if': 'defined(CONFIG_SPICE)' },
+                          'if': 'CONFIG_SPICE' },
             'spiceport': { 'type': 'ChardevSpicePort',
-                           'if': 'defined(CONFIG_SPICE)' },
+                           'if': 'CONFIG_SPICE' },
             'vc': 'ChardevVC',
             'ringbuf': 'ChardevRingbuf',
             # next one is just for compatibility
diff --git a/qapi/machine-target.json b/qapi/machine-target.json
index f60dccad5d..8ca1655b9d 100644
--- a/qapi/machine-target.json
+++ b/qapi/machine-target.json
@@ -89,7 +89,7 @@
 ##
 { 'struct': 'CpuModelBaselineInfo',
   'data': { 'model': 'CpuModelInfo' },
-  'if': 'defined(TARGET_S390X)' }
+  'if': 'TARGET_S390X' }
 
 ##
 # @CpuModelCompareInfo:
@@ -112,7 +112,7 @@
 { 'struct': 'CpuModelCompareInfo',
   'data': { 'result': 'CpuModelCompareResult',
             'responsible-properties': ['str'] },
-  'if': 'defined(TARGET_S390X)' }
+  'if': 'TARGET_S390X' }
 
 ##
 # @query-cpu-model-comparison:
@@ -156,7 +156,7 @@
 { 'command': 'query-cpu-model-comparison',
   'data': { 'modela': 'CpuModelInfo', 'modelb': 'CpuModelInfo' },
   'returns': 'CpuModelCompareInfo',
-  'if': 'defined(TARGET_S390X)' }
+  'if': 'TARGET_S390X' }
 
 ##
 # @query-cpu-model-baseline:
@@ -200,7 +200,7 @@
   'data': { 'modela': 'CpuModelInfo',
             'modelb': 'CpuModelInfo' },
   'returns': 'CpuModelBaselineInfo',
-  'if': 'defined(TARGET_S390X)' }
+  'if': 'TARGET_S390X' }
 
 ##
 # @CpuModelExpansionInfo:
@@ -213,9 +213,9 @@
 ##
 { 'struct': 'CpuModelExpansionInfo',
   'data': { 'model': 'CpuModelInfo' },
-  'if': { 'any': [ 'defined(TARGET_S390X)',
-                   'defined(TARGET_I386)',
-                   'defined(TARGET_ARM)'] } }
+  'if': { 'any': [ 'TARGET_S390X',
+                   'TARGET_I386',
+                   'TARGET_ARM' ] } }
 
 ##
 # @query-cpu-model-expansion:
@@ -254,9 +254,9 @@
   'data': { 'type': 'CpuModelExpansionType',
             'model': 'CpuModelInfo' },
   'returns': 'CpuModelExpansionInfo',
-  'if': { 'any': [ 'defined(TARGET_S390X)',
-                   'defined(TARGET_I386)',
-                   'defined(TARGET_ARM)' ] } }
+  'if': { 'any': [ 'TARGET_S390X',
+                   'TARGET_I386',
+                   'TARGET_ARM' ] } }
 
 ##
 # @CpuDefinitionInfo:
@@ -320,11 +320,11 @@
             'typename': 'str',
             '*alias-of' : 'str',
             'deprecated' : 'bool' },
-  'if': { 'any': [ 'defined(TARGET_PPC)',
-                   'defined(TARGET_ARM)',
-                   'defined(TARGET_I386)',
-                   'defined(TARGET_S390X)',
-                   'defined(TARGET_MIPS)' ] } }
+  'if': { 'any': [ 'TARGET_PPC',
+                   'TARGET_ARM',
+                   'TARGET_I386',
+                   'TARGET_S390X',
+                   'TARGET_MIPS' ] } }
 
 ##
 # @query-cpu-definitions:
@@ -336,8 +336,8 @@
 # Since: 1.2.0
 ##
 { 'command': 'query-cpu-definitions', 'returns': ['CpuDefinitionInfo'],
-  'if': { 'any': [ 'defined(TARGET_PPC)',
-                   'defined(TARGET_ARM)',
-                   'defined(TARGET_I386)',
-                   'defined(TARGET_S390X)',
-                   'defined(TARGET_MIPS)' ] } }
+  'if': { 'any': [ 'TARGET_PPC',
+                   'TARGET_ARM',
+                   'TARGET_I386',
+                   'TARGET_S390X',
+                   'TARGET_MIPS' ] } }
diff --git a/qapi/migration.json b/qapi/migration.json
index a5da513c9e..275d2ce46e 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -506,7 +506,7 @@
 ##
 { 'enum': 'MultiFDCompression',
   'data': [ 'none', 'zlib',
-            { 'name': 'zstd', 'if': 'defined(CONFIG_ZSTD)' } ] }
+            { 'name': 'zstd', 'if': 'CONFIG_ZSTD' } ] }
 
 ##
 # @BitmapMigrationBitmapAlias:
@@ -1616,7 +1616,7 @@
 ##
 { 'command': 'xen-set-replication',
   'data': { 'enable': 'bool', 'primary': 'bool', '*failover' : 'bool' },
-  'if': 'defined(CONFIG_REPLICATION)' }
+  'if': 'CONFIG_REPLICATION' }
 
 ##
 # @ReplicationStatus:
@@ -1632,7 +1632,7 @@
 ##
 { 'struct': 'ReplicationStatus',
   'data': { 'error': 'bool', '*desc': 'str' },
-  'if': 'defined(CONFIG_REPLICATION)' }
+  'if': 'CONFIG_REPLICATION' }
 
 ##
 # @query-xen-replication-status:
@@ -1650,7 +1650,7 @@
 ##
 { 'command': 'query-xen-replication-status',
   'returns': 'ReplicationStatus',
-  'if': 'defined(CONFIG_REPLICATION)' }
+  'if': 'CONFIG_REPLICATION' }
 
 ##
 # @xen-colo-do-checkpoint:
@@ -1667,7 +1667,7 @@
 # Since: 2.9
 ##
 { 'command': 'xen-colo-do-checkpoint',
-  'if': 'defined(CONFIG_REPLICATION)' }
+  'if': 'CONFIG_REPLICATION' }
 
 ##
 # @COLOStatus:
diff --git a/qapi/misc-target.json b/qapi/misc-target.json
index c1aa592137..6799a4c977 100644
--- a/qapi/misc-target.json
+++ b/qapi/misc-target.json
@@ -23,18 +23,18 @@
 ##
 { 'event': 'RTC_CHANGE',
   'data': { 'offset': 'int' },
-  'if': { 'any': [ 'defined(TARGET_ALPHA)',
-                   'defined(TARGET_ARM)',
-                   'defined(TARGET_HPPA)',
-                   'defined(TARGET_I386)',
-                   'defined(TARGET_MIPS)',
-                   'defined(TARGET_MIPS64)',
-                   'defined(TARGET_MOXIE)',
-                   'defined(TARGET_PPC)',
-                   'defined(TARGET_PPC64)',
-                   'defined(TARGET_S390X)',
-                   'defined(TARGET_SH4)',
-                   'defined(TARGET_SPARC)' ] } }
+  'if': { 'any': [ 'TARGET_ALPHA',
+                   'TARGET_ARM',
+                   'TARGET_HPPA',
+                   'TARGET_I386',
+                   'TARGET_MIPS',
+                   'TARGET_MIPS64',
+                   'TARGET_MOXIE',
+                   'TARGET_PPC',
+                   'TARGET_PPC64',
+                   'TARGET_S390X',
+                   'TARGET_SH4',
+                   'TARGET_SPARC' ] } }
 
 ##
 # @rtc-reset-reinjection:
@@ -53,7 +53,7 @@
 #
 ##
 { 'command': 'rtc-reset-reinjection',
-  'if': 'defined(TARGET_I386)' }
+  'if': 'TARGET_I386' }
 
 
 ##
@@ -80,7 +80,7 @@
 { 'enum': 'SevState',
   'data': ['uninit', 'launch-update', 'launch-secret', 'running',
            'send-update', 'receive-update' ],
-  'if': 'defined(TARGET_I386)' }
+  'if': 'TARGET_I386' }
 
 ##
 # @SevInfo:
@@ -112,7 +112,7 @@
               'state' : 'SevState',
               'handle' : 'uint32'
             },
-  'if': 'defined(TARGET_I386)'
+  'if': 'TARGET_I386'
 }
 
 ##
@@ -133,7 +133,7 @@
 #
 ##
 { 'command': 'query-sev', 'returns': 'SevInfo',
-  'if': 'defined(TARGET_I386)' }
+  'if': 'TARGET_I386' }
 
 
 ##
@@ -147,7 +147,7 @@
 #
 ##
 { 'struct': 'SevLaunchMeasureInfo', 'data': {'data': 'str'},
-  'if': 'defined(TARGET_I386)' }
+  'if': 'TARGET_I386' }
 
 ##
 # @query-sev-launch-measure:
@@ -165,7 +165,7 @@
 #
 ##
 { 'command': 'query-sev-launch-measure', 'returns': 'SevLaunchMeasureInfo',
-  'if': 'defined(TARGET_I386)' }
+  'if': 'TARGET_I386' }
 
 
 ##
@@ -190,7 +190,7 @@
             'cert-chain': 'str',
             'cbitpos': 'int',
             'reduced-phys-bits': 'int'},
-  'if': 'defined(TARGET_I386)' }
+  'if': 'TARGET_I386' }
 
 ##
 # @query-sev-capabilities:
@@ -210,7 +210,7 @@
 #
 ##
 { 'command': 'query-sev-capabilities', 'returns': 'SevCapability',
-  'if': 'defined(TARGET_I386)' }
+  'if': 'TARGET_I386' }
 
 ##
 # @dump-skeys:
@@ -232,7 +232,7 @@
 ##
 { 'command': 'dump-skeys',
   'data': { 'filename': 'str' },
-  'if': 'defined(TARGET_S390X)' }
+  'if': 'TARGET_S390X' }
 
 ##
 # @GICCapability:
@@ -257,7 +257,7 @@
   'data': { 'version': 'int',
             'emulated': 'bool',
             'kernel': 'bool' },
-  'if': 'defined(TARGET_ARM)' }
+  'if': 'TARGET_ARM' }
 
 ##
 # @query-gic-capabilities:
@@ -277,4 +277,4 @@
 #
 ##
 { 'command': 'query-gic-capabilities', 'returns': ['GICCapability'],
-  'if': 'defined(TARGET_ARM)' }
+  'if': 'TARGET_ARM' }
diff --git a/qapi/ui.json b/qapi/ui.json
index 9d6721037f..989fb4ff5e 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -121,7 +121,7 @@
   'data': { 'host': 'str',
             'port': 'str',
             'family': 'NetworkAddressFamily' },
-  'if': 'defined(CONFIG_SPICE)' }
+  'if': 'CONFIG_SPICE' }
 
 ##
 # @SpiceServerInfo:
@@ -135,7 +135,7 @@
 { 'struct': 'SpiceServerInfo',
   'base': 'SpiceBasicInfo',
   'data': { '*auth': 'str' },
-  'if': 'defined(CONFIG_SPICE)' }
+  'if': 'CONFIG_SPICE' }
 
 ##
 # @SpiceChannel:
@@ -161,7 +161,7 @@
   'base': 'SpiceBasicInfo',
   'data': {'connection-id': 'int', 'channel-type': 'int', 'channel-id': 'int',
            'tls': 'bool'},
-  'if': 'defined(CONFIG_SPICE)' }
+  'if': 'CONFIG_SPICE' }
 
 ##
 # @SpiceQueryMouseMode:
@@ -181,7 +181,7 @@
 ##
 { 'enum': 'SpiceQueryMouseMode',
   'data': [ 'client', 'server', 'unknown' ],
-  'if': 'defined(CONFIG_SPICE)' }
+  'if': 'CONFIG_SPICE' }
 
 ##
 # @SpiceInfo:
@@ -220,7 +220,7 @@
   'data': {'enabled': 'bool', 'migrated': 'bool', '*host': 'str', '*port': 'int',
            '*tls-port': 'int', '*auth': 'str', '*compiled-version': 'str',
            'mouse-mode': 'SpiceQueryMouseMode', '*channels': ['SpiceChannel']},
-  'if': 'defined(CONFIG_SPICE)' }
+  'if': 'CONFIG_SPICE' }
 
 ##
 # @query-spice:
@@ -266,7 +266,7 @@
 #
 ##
 { 'command': 'query-spice', 'returns': 'SpiceInfo',
-  'if': 'defined(CONFIG_SPICE)' }
+  'if': 'CONFIG_SPICE' }
 
 ##
 # @SPICE_CONNECTED:
@@ -292,7 +292,7 @@
 { 'event': 'SPICE_CONNECTED',
   'data': { 'server': 'SpiceBasicInfo',
             'client': 'SpiceBasicInfo' },
-  'if': 'defined(CONFIG_SPICE)' }
+  'if': 'CONFIG_SPICE' }
 
 ##
 # @SPICE_INITIALIZED:
@@ -321,7 +321,7 @@
 { 'event': 'SPICE_INITIALIZED',
   'data': { 'server': 'SpiceServerInfo',
             'client': 'SpiceChannel' },
-  'if': 'defined(CONFIG_SPICE)' }
+  'if': 'CONFIG_SPICE' }
 
 ##
 # @SPICE_DISCONNECTED:
@@ -347,7 +347,7 @@
 { 'event': 'SPICE_DISCONNECTED',
   'data': { 'server': 'SpiceBasicInfo',
             'client': 'SpiceBasicInfo' },
-  'if': 'defined(CONFIG_SPICE)' }
+  'if': 'CONFIG_SPICE' }
 
 ##
 # @SPICE_MIGRATE_COMPLETED:
@@ -363,7 +363,7 @@
 #
 ##
 { 'event': 'SPICE_MIGRATE_COMPLETED',
-  'if': 'defined(CONFIG_SPICE)' }
+  'if': 'CONFIG_SPICE' }
 
 ##
 # == VNC
@@ -391,7 +391,7 @@
             'service': 'str',
             'family': 'NetworkAddressFamily',
             'websocket': 'bool' },
-  'if': 'defined(CONFIG_VNC)' }
+  'if': 'CONFIG_VNC' }
 
 ##
 # @VncServerInfo:
@@ -406,7 +406,7 @@
 { 'struct': 'VncServerInfo',
   'base': 'VncBasicInfo',
   'data': { '*auth': 'str' },
-  'if': 'defined(CONFIG_VNC)' }
+  'if': 'CONFIG_VNC' }
 
 ##
 # @VncClientInfo:
@@ -424,7 +424,7 @@
 { 'struct': 'VncClientInfo',
   'base': 'VncBasicInfo',
   'data': { '*x509_dname': 'str', '*sasl_username': 'str' },
-  'if': 'defined(CONFIG_VNC)' }
+  'if': 'CONFIG_VNC' }
 
 ##
 # @VncInfo:
@@ -467,7 +467,7 @@
   'data': {'enabled': 'bool', '*host': 'str',
            '*family': 'NetworkAddressFamily',
            '*service': 'str', '*auth': 'str', '*clients': ['VncClientInfo']},
-  'if': 'defined(CONFIG_VNC)' }
+  'if': 'CONFIG_VNC' }
 
 ##
 # @VncPrimaryAuth:
@@ -479,7 +479,7 @@
 { 'enum': 'VncPrimaryAuth',
   'data': [ 'none', 'vnc', 'ra2', 'ra2ne', 'tight', 'ultra',
             'tls', 'vencrypt', 'sasl' ],
-  'if': 'defined(CONFIG_VNC)' }
+  'if': 'CONFIG_VNC' }
 
 ##
 # @VncVencryptSubAuth:
@@ -494,7 +494,7 @@
             'tls-vnc',   'x509-vnc',
             'tls-plain', 'x509-plain',
             'tls-sasl',  'x509-sasl' ],
-  'if': 'defined(CONFIG_VNC)' }
+  'if': 'CONFIG_VNC' }
 
 ##
 # @VncServerInfo2:
@@ -512,7 +512,7 @@
   'base': 'VncBasicInfo',
   'data': { 'auth'      : 'VncPrimaryAuth',
             '*vencrypt' : 'VncVencryptSubAuth' },
-  'if': 'defined(CONFIG_VNC)' }
+  'if': 'CONFIG_VNC' }
 
 ##
 # @VncInfo2:
@@ -545,7 +545,7 @@
             'auth'      : 'VncPrimaryAuth',
             '*vencrypt' : 'VncVencryptSubAuth',
             '*display'  : 'str' },
-  'if': 'defined(CONFIG_VNC)' }
+  'if': 'CONFIG_VNC' }
 
 ##
 # @query-vnc:
@@ -577,7 +577,7 @@
 #
 ##
 { 'command': 'query-vnc', 'returns': 'VncInfo',
-  'if': 'defined(CONFIG_VNC)' }
+  'if': 'CONFIG_VNC' }
 ##
 # @query-vnc-servers:
 #
@@ -588,7 +588,7 @@
 # Since: 2.3
 ##
 { 'command': 'query-vnc-servers', 'returns': ['VncInfo2'],
-  'if': 'defined(CONFIG_VNC)' }
+  'if': 'CONFIG_VNC' }
 
 ##
 # @change-vnc-password:
@@ -604,7 +604,7 @@
 ##
 { 'command': 'change-vnc-password',
   'data': { 'password': 'str' },
-  'if': 'defined(CONFIG_VNC)' }
+  'if': 'CONFIG_VNC' }
 
 ##
 # @VNC_CONNECTED:
@@ -634,7 +634,7 @@
 { 'event': 'VNC_CONNECTED',
   'data': { 'server': 'VncServerInfo',
             'client': 'VncBasicInfo' },
-  'if': 'defined(CONFIG_VNC)' }
+  'if': 'CONFIG_VNC' }
 
 ##
 # @VNC_INITIALIZED:
@@ -662,7 +662,7 @@
 { 'event': 'VNC_INITIALIZED',
   'data': { 'server': 'VncServerInfo',
             'client': 'VncClientInfo' },
-  'if': 'defined(CONFIG_VNC)' }
+  'if': 'CONFIG_VNC' }
 
 ##
 # @VNC_DISCONNECTED:
@@ -689,7 +689,7 @@
 { 'event': 'VNC_DISCONNECTED',
   'data': { 'server': 'VncServerInfo',
             'client': 'VncClientInfo' },
-  'if': 'defined(CONFIG_VNC)' }
+  'if': 'CONFIG_VNC' }
 
 ##
 # = Input
diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 4d8579280e..5203569340 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -204,7 +204,7 @@ class IfOption(IfPredicate):
         self.option = option
 
     def cgen(self) -> str:
-        return self.option
+        return f"defined({self.option})"
 
     def __repr__(self) -> str:
         return repr(self.option)
diff --git a/scripts/qapi/expr.py b/scripts/qapi/expr.py
index 2290baccb5..6eb86ddc39 100644
--- a/scripts/qapi/expr.py
+++ b/scripts/qapi/expr.py
@@ -217,10 +217,10 @@ def check_if(expr: _JSObject, info: QAPISourceInfo, source: str) -> None:
 
     def normalize(cond: Union[str, List[str], object]) -> IfPredicate:
         if isinstance(cond, str):
-            if not cond.strip():
+            if not cond.isidentifier():
                 raise QAPISemError(
                     info,
-                    "'if' condition '%s' of %s makes no sense"
+                    "'if' option string '%s' of %s is not a valid identifier"
                     % (cond, source))
             return IfOption(cond)
         if isinstance(cond, list):
diff --git a/tests/qapi-schema/alternate-branch-if-invalid.err b/tests/qapi-schema/alternate-branch-if-invalid.err
index d384929c51..e36580845e 100644
--- a/tests/qapi-schema/alternate-branch-if-invalid.err
+++ b/tests/qapi-schema/alternate-branch-if-invalid.err
@@ -1,2 +1,2 @@
 alternate-branch-if-invalid.json: In alternate 'Alt':
-alternate-branch-if-invalid.json:2: 'if' condition ' ' of 'data' member 'branch' makes no sense
+alternate-branch-if-invalid.json:2: 'if' option string ' ' of 'data' member 'branch' is not a valid identifier
diff --git a/tests/qapi-schema/bad-if-empty.err b/tests/qapi-schema/bad-if-empty.err
index a0f3effefb..011aaab017 100644
--- a/tests/qapi-schema/bad-if-empty.err
+++ b/tests/qapi-schema/bad-if-empty.err
@@ -1,2 +1,2 @@
 bad-if-empty.json: In struct 'TestIfStruct':
-bad-if-empty.json:2: 'if' condition '' of struct makes no sense
+bad-if-empty.json:2: 'if' option string '' of struct is not a valid identifier
diff --git a/tests/qapi-schema/bad-if-list.err b/tests/qapi-schema/bad-if-list.err
index c462f11b90..f84b945bea 100644
--- a/tests/qapi-schema/bad-if-list.err
+++ b/tests/qapi-schema/bad-if-list.err
@@ -1,2 +1,2 @@
 bad-if-list.json: In struct 'TestIfStruct':
-bad-if-list.json:2: 'if' condition ' ' of struct makes no sense
+bad-if-list.json:2: 'if' option string ' ' of struct is not a valid identifier
diff --git a/tests/qapi-schema/bad-if.json b/tests/qapi-schema/bad-if.json
index 3edd1a0bf2..67818888de 100644
--- a/tests/qapi-schema/bad-if.json
+++ b/tests/qapi-schema/bad-if.json
@@ -1,3 +1,3 @@
 # check invalid 'if' type
 { 'struct': 'TestIfStruct', 'data': { 'foo': 'int' },
-  'if': { 'value': 'defined(TEST_IF_STRUCT)' } }
+  'if': { 'value': 'TEST_IF_STRUCT' } }
diff --git a/tests/qapi-schema/doc-good.json b/tests/qapi-schema/doc-good.json
index e9af0857db..b4a4175f26 100644
--- a/tests/qapi-schema/doc-good.json
+++ b/tests/qapi-schema/doc-good.json
@@ -61,9 +61,9 @@
 # @two is undocumented
 ##
 { 'enum': 'Enum', 'data':
-  [ { 'name': 'one', 'if': 'defined(IFONE)' }, 'two' ],
+  [ { 'name': 'one', 'if': 'IFONE' }, 'two' ],
   'features': [ 'enum-feat' ],
-  'if': 'defined(IFCOND)' }
+  'if': 'IFCOND' }
 
 ##
 # @Base:
@@ -86,7 +86,7 @@
   'features': [ 'variant1-feat' ],
   'data': { 'var1': { 'type': 'str',
                       'features': [ 'member-feat' ],
-                      'if': 'defined(IFSTR)' } } }
+                      'if': 'IFSTR' } } }
 
 ##
 # @Variant2:
diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.out
index 6b723d2341..f9af1836e1 100644
--- a/tests/qapi-schema/doc-good.out
+++ b/tests/qapi-schema/doc-good.out
@@ -12,15 +12,15 @@ enum QType
 module doc-good.json
 enum Enum
     member one
-        if 'defined(IFONE)'
+        if 'IFONE'
     member two
-    if 'defined(IFCOND)'
+    if 'IFCOND'
     feature enum-feat
 object Base
     member base1: Enum optional=False
 object Variant1
     member var1: str optional=False
-        if 'defined(IFSTR)'
+        if 'IFSTR'
         feature member-feat
     feature variant1-feat
 object Variant2
diff --git a/tests/qapi-schema/features-missing-name.json b/tests/qapi-schema/features-missing-name.json
index 2314f97c00..8772c8f7b3 100644
--- a/tests/qapi-schema/features-missing-name.json
+++ b/tests/qapi-schema/features-missing-name.json
@@ -1,3 +1,3 @@
 { 'struct': 'FeatureStruct0',
   'data': { 'foo': 'int' },
-  'features': [ { 'if': 'defined(NAMELESS_FEATURES)' } ] }
+  'features': [ { 'if': 'NAMELESS_FEATURES' } ] }
diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-schema/qapi-schema-test.json
index 6b3089a553..a84d922bac 100644
--- a/tests/qapi-schema/qapi-schema-test.json
+++ b/tests/qapi-schema/qapi-schema-test.json
@@ -218,41 +218,41 @@
 
 { 'struct': 'TestIfStruct', 'data':
   { 'foo': 'int',
-    'bar': { 'type': 'int', 'if': 'defined(TEST_IF_STRUCT_BAR)'} },
-  'if': 'defined(TEST_IF_STRUCT)' }
+    'bar': { 'type': 'int', 'if': 'TEST_IF_STRUCT_BAR'} },
+  'if': 'TEST_IF_STRUCT' }
 
 { 'enum': 'TestIfEnum', 'data':
-  [ 'foo', { 'name' : 'bar', 'if': 'defined(TEST_IF_ENUM_BAR)' } ],
-  'if': 'defined(TEST_IF_ENUM)' }
+  [ 'foo', { 'name' : 'bar', 'if': 'TEST_IF_ENUM_BAR' } ],
+  'if': 'TEST_IF_ENUM' }
 
 { 'union': 'TestIfUnion', 'data':
   { 'foo': 'TestStruct',
-    'union_bar': { 'type': 'str', 'if': 'defined(TEST_IF_UNION_BAR)'} },
-  'if': ['defined(TEST_IF_UNION)', 'defined(TEST_IF_STRUCT)'] }
+    'union_bar': { 'type': 'str', 'if': 'TEST_IF_UNION_BAR'} },
+  'if': ['TEST_IF_UNION', 'TEST_IF_STRUCT'] }
 
 { 'command': 'TestIfUnionCmd', 'data': { 'union_cmd_arg': 'TestIfUnion' },
-  'if': 'defined(TEST_IF_UNION)' }
+  'if': 'TEST_IF_UNION' }
 
 { 'alternate': 'TestIfAlternate', 'data':
   { 'foo': 'int',
-    'bar': { 'type': 'TestStruct', 'if': 'defined(TEST_IF_ALT_BAR)'} },
-  'if': {'all': ['defined(TEST_IF_ALT)', 'defined(TEST_IF_STRUCT)'] } }
+    'bar': { 'type': 'TestStruct', 'if': 'TEST_IF_ALT_BAR'} },
+  'if': {'all': ['TEST_IF_ALT', 'TEST_IF_STRUCT'] } }
 
 { 'command': 'TestIfAlternateCmd', 'data': { 'alt_cmd_arg': 'TestIfAlternate' },
-  'if': {'all': ['defined(TEST_IF_ALT)', {'not': 'defined(TEST_IF_NOT_ALT)'}] } }
+  'if': {'all': ['TEST_IF_ALT', {'not': 'TEST_IF_NOT_ALT'}] } }
 
 { 'command': 'TestIfCmd', 'data':
   { 'foo': 'TestIfStruct',
-    'bar': { 'type': 'TestIfEnum', 'if': 'defined(TEST_IF_CMD_BAR)' } },
+    'bar': { 'type': 'TestIfEnum', 'if': 'TEST_IF_CMD_BAR' } },
   'returns': 'UserDefThree',
-  'if': ['defined(TEST_IF_CMD)', 'defined(TEST_IF_STRUCT)'] }
+  'if': ['TEST_IF_CMD', 'TEST_IF_STRUCT'] }
 
 { 'command': 'TestCmdReturnDefThree', 'returns': 'UserDefThree' }
 
 { 'event': 'TestIfEvent', 'data':
   { 'foo': 'TestIfStruct',
-    'bar': { 'type': ['TestIfEnum'], 'if': 'defined(TEST_IF_EVT_BAR)' } },
-  'if': ['defined(TEST_IF_EVT)', 'defined(TEST_IF_STRUCT)'] }
+    'bar': { 'type': ['TestIfEnum'], 'if': 'TEST_IF_EVT_BAR' } },
+  'if': ['TEST_IF_EVT', 'TEST_IF_STRUCT'] }
 
 # test 'features'
 
@@ -274,19 +274,19 @@
 
 { 'struct': 'CondFeatureStruct1',
   'data': { 'foo': 'int' },
-  'features': [ { 'name': 'feature1', 'if': 'defined(TEST_IF_FEATURE_1)'} ] }
+  'features': [ { 'name': 'feature1', 'if': 'TEST_IF_FEATURE_1'} ] }
 { 'struct': 'CondFeatureStruct2',
   'data': { 'foo': 'int' },
-  'features': [ { 'name': 'feature1', 'if': 'defined(TEST_IF_FEATURE_1)'},
-                { 'name': 'feature2', 'if': 'defined(TEST_IF_FEATURE_2)'} ] }
+  'features': [ { 'name': 'feature1', 'if': 'TEST_IF_FEATURE_1'},
+                { 'name': 'feature2', 'if': 'TEST_IF_FEATURE_2'} ] }
 { 'struct': 'CondFeatureStruct3',
   'data': { 'foo': 'int' },
-  'features': [ { 'name': 'feature1', 'if': [ 'defined(TEST_IF_COND_1)',
-                                              'defined(TEST_IF_COND_2)'] } ] }
+  'features': [ { 'name': 'feature1', 'if': [ 'TEST_IF_COND_1',
+                                              'TEST_IF_COND_2'] } ] }
 { 'struct': 'CondFeatureStruct4',
   'data': { 'foo': 'int' },
-  'features': [ { 'name': 'feature1', 'if': {'any': ['defined(TEST_IF_COND_1)',
-                                                     'defined(TEST_IF_COND_2)'] } } ] }
+  'features': [ { 'name': 'feature1', 'if': {'any': ['TEST_IF_COND_1',
+                                                     'TEST_IF_COND_2'] } } ] }
 
 { 'enum': 'FeatureEnum1',
   'data': [ 'eins', 'zwei', 'drei' ],
@@ -320,13 +320,13 @@
   'features': [ 'feature1', 'feature2' ] }
 
 { 'command': 'test-command-cond-features1',
-  'features': [ { 'name': 'feature1', 'if': 'defined(TEST_IF_FEATURE_1)'} ] }
+  'features': [ { 'name': 'feature1', 'if': 'TEST_IF_FEATURE_1'} ] }
 { 'command': 'test-command-cond-features2',
-  'features': [ { 'name': 'feature1', 'if': 'defined(TEST_IF_FEATURE_1)'},
-                { 'name': 'feature2', 'if': 'defined(TEST_IF_FEATURE_2)'} ] }
+  'features': [ { 'name': 'feature1', 'if': 'TEST_IF_FEATURE_1'},
+                { 'name': 'feature2', 'if': 'TEST_IF_FEATURE_2'} ] }
 { 'command': 'test-command-cond-features3',
-  'features': [ { 'name': 'feature1', 'if': [ 'defined(TEST_IF_COND_1)',
-                                              'defined(TEST_IF_COND_2)'] } ] }
+  'features': [ { 'name': 'feature1', 'if': [ 'TEST_IF_COND_1',
+                                              'TEST_IF_COND_2' ] } ] }
 
 { 'event': 'TEST-EVENT-FEATURES1',
   'features': [ 'deprecated' ] }
diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/qapi-schema-test.out
index 558427f6fa..24a9f42172 100644
--- a/tests/qapi-schema/qapi-schema-test.out
+++ b/tests/qapi-schema/qapi-schema-test.out
@@ -298,65 +298,65 @@ command __org.qemu_x-command q_obj___org.qemu_x-command-arg -> __org.qemu_x-Unio
 object TestIfStruct
     member foo: int optional=False
     member bar: int optional=False
-        if 'defined(TEST_IF_STRUCT_BAR)'
-    if 'defined(TEST_IF_STRUCT)'
+        if 'TEST_IF_STRUCT_BAR'
+    if 'TEST_IF_STRUCT'
 enum TestIfEnum
     member foo
     member bar
-        if 'defined(TEST_IF_ENUM_BAR)'
-    if 'defined(TEST_IF_ENUM)'
+        if 'TEST_IF_ENUM_BAR'
+    if 'TEST_IF_ENUM'
 object q_obj_TestStruct-wrapper
     member data: TestStruct optional=False
 enum TestIfUnionKind
     member foo
     member union_bar
-        if 'defined(TEST_IF_UNION_BAR)'
-    if IfAll(['defined(TEST_IF_UNION)', 'defined(TEST_IF_STRUCT)'])
+        if 'TEST_IF_UNION_BAR'
+    if IfAll(['TEST_IF_UNION', 'TEST_IF_STRUCT'])
 object TestIfUnion
     member type: TestIfUnionKind optional=False
     tag type
     case foo: q_obj_TestStruct-wrapper
     case union_bar: q_obj_str-wrapper
-        if 'defined(TEST_IF_UNION_BAR)'
-    if IfAll(['defined(TEST_IF_UNION)', 'defined(TEST_IF_STRUCT)'])
+        if 'TEST_IF_UNION_BAR'
+    if IfAll(['TEST_IF_UNION', 'TEST_IF_STRUCT'])
 object q_obj_TestIfUnionCmd-arg
     member union_cmd_arg: TestIfUnion optional=False
-    if 'defined(TEST_IF_UNION)'
+    if 'TEST_IF_UNION'
 command TestIfUnionCmd q_obj_TestIfUnionCmd-arg -> None
     gen=True success_response=True boxed=False oob=False preconfig=False
-    if 'defined(TEST_IF_UNION)'
+    if 'TEST_IF_UNION'
 alternate TestIfAlternate
     tag type
     case foo: int
     case bar: TestStruct
-        if 'defined(TEST_IF_ALT_BAR)'
-    if IfAll(['defined(TEST_IF_ALT)', 'defined(TEST_IF_STRUCT)'])
+        if 'TEST_IF_ALT_BAR'
+    if IfAll(['TEST_IF_ALT', 'TEST_IF_STRUCT'])
 object q_obj_TestIfAlternateCmd-arg
     member alt_cmd_arg: TestIfAlternate optional=False
-    if IfAll(['defined(TEST_IF_ALT)', IfNot('defined(TEST_IF_NOT_ALT)')])
+    if IfAll(['TEST_IF_ALT', IfNot('TEST_IF_NOT_ALT')])
 command TestIfAlternateCmd q_obj_TestIfAlternateCmd-arg -> None
     gen=True success_response=True boxed=False oob=False preconfig=False
-    if IfAll(['defined(TEST_IF_ALT)', IfNot('defined(TEST_IF_NOT_ALT)')])
+    if IfAll(['TEST_IF_ALT', IfNot('TEST_IF_NOT_ALT')])
 object q_obj_TestIfCmd-arg
     member foo: TestIfStruct optional=False
     member bar: TestIfEnum optional=False
-        if 'defined(TEST_IF_CMD_BAR)'
-    if IfAll(['defined(TEST_IF_CMD)', 'defined(TEST_IF_STRUCT)'])
+        if 'TEST_IF_CMD_BAR'
+    if IfAll(['TEST_IF_CMD', 'TEST_IF_STRUCT'])
 command TestIfCmd q_obj_TestIfCmd-arg -> UserDefThree
     gen=True success_response=True boxed=False oob=False preconfig=False
-    if IfAll(['defined(TEST_IF_CMD)', 'defined(TEST_IF_STRUCT)'])
+    if IfAll(['TEST_IF_CMD', 'TEST_IF_STRUCT'])
 command TestCmdReturnDefThree None -> UserDefThree
     gen=True success_response=True boxed=False oob=False preconfig=False
 array TestIfEnumList TestIfEnum
-    if 'defined(TEST_IF_ENUM)'
+    if 'TEST_IF_ENUM'
 object q_obj_TestIfEvent-arg
     member foo: TestIfStruct optional=False
     member bar: TestIfEnumList optional=False
-        if 'defined(TEST_IF_EVT_BAR)'
-    if IfAll(['defined(TEST_IF_EVT)', 'defined(TEST_IF_STRUCT)'])
+        if 'TEST_IF_EVT_BAR'
+    if IfAll(['TEST_IF_EVT', 'TEST_IF_STRUCT'])
 event TestIfEvent q_obj_TestIfEvent-arg
     boxed=False
-    if IfAll(['defined(TEST_IF_EVT)', 'defined(TEST_IF_STRUCT)'])
+    if IfAll(['TEST_IF_EVT', 'TEST_IF_STRUCT'])
 object FeatureStruct0
     member foo: int optional=False
 object FeatureStruct1
@@ -379,21 +379,21 @@ object FeatureStruct4
 object CondFeatureStruct1
     member foo: int optional=False
     feature feature1
-        if 'defined(TEST_IF_FEATURE_1)'
+        if 'TEST_IF_FEATURE_1'
 object CondFeatureStruct2
     member foo: int optional=False
     feature feature1
-        if 'defined(TEST_IF_FEATURE_1)'
+        if 'TEST_IF_FEATURE_1'
     feature feature2
-        if 'defined(TEST_IF_FEATURE_2)'
+        if 'TEST_IF_FEATURE_2'
 object CondFeatureStruct3
     member foo: int optional=False
     feature feature1
-        if IfAll(['defined(TEST_IF_COND_1)', 'defined(TEST_IF_COND_2)'])
+        if IfAll(['TEST_IF_COND_1', 'TEST_IF_COND_2'])
 object CondFeatureStruct4
     member foo: int optional=False
     feature feature1
-        if IfAny(['defined(TEST_IF_COND_1)', 'defined(TEST_IF_COND_2)'])
+        if IfAny(['TEST_IF_COND_1', 'TEST_IF_COND_2'])
 enum FeatureEnum1
     member eins
     member zwei
@@ -434,17 +434,17 @@ command test-command-features3 None -> None
 command test-command-cond-features1 None -> None
     gen=True success_response=True boxed=False oob=False preconfig=False
     feature feature1
-        if 'defined(TEST_IF_FEATURE_1)'
+        if 'TEST_IF_FEATURE_1'
 command test-command-cond-features2 None -> None
     gen=True success_response=True boxed=False oob=False preconfig=False
     feature feature1
-        if 'defined(TEST_IF_FEATURE_1)'
+        if 'TEST_IF_FEATURE_1'
     feature feature2
-        if 'defined(TEST_IF_FEATURE_2)'
+        if 'TEST_IF_FEATURE_2'
 command test-command-cond-features3 None -> None
     gen=True success_response=True boxed=False oob=False preconfig=False
     feature feature1
-        if IfAll(['defined(TEST_IF_COND_1)', 'defined(TEST_IF_COND_2)'])
+        if IfAll(['TEST_IF_COND_1', 'TEST_IF_COND_2'])
 event TEST-EVENT-FEATURES1 None
     boxed=False
     feature deprecated
diff --git a/tests/qapi-schema/union-branch-if-invalid.err b/tests/qapi-schema/union-branch-if-invalid.err
index dd4518233e..b3c44d4068 100644
--- a/tests/qapi-schema/union-branch-if-invalid.err
+++ b/tests/qapi-schema/union-branch-if-invalid.err
@@ -1,2 +1,2 @@
 union-branch-if-invalid.json: In union 'Uni':
-union-branch-if-invalid.json:4: 'if' condition '' of 'data' member 'branch1' makes no sense
+union-branch-if-invalid.json:4: 'if' option string '' of 'data' member 'branch1' is not a valid identifier
-- 
2.29.0


