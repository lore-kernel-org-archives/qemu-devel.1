Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98DC9C4363D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 03:38:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7171207FF
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 03:38:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AS6cgCum"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7171207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kV4wu-00014h-Ni
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 23:38:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42922)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kV4s9-0004RH-0i
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 23:33:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51426)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kV4s7-0001b7-3h
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 23:33:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603251186;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vwRWr8Z078fLGPEk6jG64vGfcx35hoT6jcr6yINAhMc=;
 b=AS6cgCumI8xPwodVqYcoNg/URL/4RzEoVL9Vlsx4YFHF2q22XP7C4WDUJQTi+5IRTFhKxt
 vA7WObiF9Pa6hA65Iz/IhNN8X3MNVFao1b7L+it+OfW6EZH9TP9QO5PPdx5s9juHlzj+/8
 +N/RORr5sQiSErlzfsElvoKcLaNlkdg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-480-aiO3ciLmMDmLqnsVqhyljQ-1; Tue, 20 Oct 2020 23:33:01 -0400
X-MC-Unique: aiO3ciLmMDmLqnsVqhyljQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C613880402B;
 Wed, 21 Oct 2020 03:33:00 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-182.ams2.redhat.com
 [10.36.112.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6CA435B4A3;
 Wed, 21 Oct 2020 03:33:00 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8686811275C4; Wed, 21 Oct 2020 05:32:57 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 5/5] qapi: Restrict Xen migration commands to migration.json
Date: Wed, 21 Oct 2020 05:32:57 +0200
Message-Id: <20201021033257.2126624-6-armbru@redhat.com>
In-Reply-To: <20201021033257.2126624-1-armbru@redhat.com>
References: <20201021033257.2126624-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 22:12:28
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Restricting xen-set-global-dirty-log and xen-load-devices-state
commands migration.json pulls slightly less QAPI-generated code
into user-mode and tools.

Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20201012121536.3381997-6-philmd@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/migration.json    | 41 +++++++++++++++++++++++++++++++++++++++++
 qapi/misc.json         | 41 -----------------------------------------
 accel/stubs/xen-stub.c |  2 +-
 hw/i386/xen/xen-hvm.c  |  2 +-
 migration/savevm.c     |  1 -
 5 files changed, 43 insertions(+), 44 deletions(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index 974021a5c8..a5da513c9e 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1551,6 +1551,47 @@
 { 'command': 'xen-save-devices-state',
   'data': {'filename': 'str', '*live':'bool' } }
 
+##
+# @xen-set-global-dirty-log:
+#
+# Enable or disable the global dirty log mode.
+#
+# @enable: true to enable, false to disable.
+#
+# Returns: nothing
+#
+# Since: 1.3
+#
+# Example:
+#
+# -> { "execute": "xen-set-global-dirty-log",
+#      "arguments": { "enable": true } }
+# <- { "return": {} }
+#
+##
+{ 'command': 'xen-set-global-dirty-log', 'data': { 'enable': 'bool' } }
+
+##
+# @xen-load-devices-state:
+#
+# Load the state of all devices from file. The RAM and the block devices
+# of the VM are not loaded by this command.
+#
+# @filename: the file to load the state of the devices from as binary
+#            data. See xen-save-devices-state.txt for a description of the binary
+#            format.
+#
+# Since: 2.7
+#
+# Example:
+#
+# -> { "execute": "xen-load-devices-state",
+#      "arguments": { "filename": "/tmp/resume" } }
+# <- { "return": {} }
+#
+##
+{ 'command': 'xen-load-devices-state', 'data': {'filename': 'str'} }
+
 ##
 # @xen-set-replication:
 #
diff --git a/qapi/misc.json b/qapi/misc.json
index 363115c1ed..40df513856 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -287,26 +287,6 @@
   'data': {'device': 'str', 'target': 'str', '*arg': 'str'},
   'features': [ 'deprecated' ] }
 
-##
-# @xen-set-global-dirty-log:
-#
-# Enable or disable the global dirty log mode.
-#
-# @enable: true to enable, false to disable.
-#
-# Returns: nothing
-#
-# Since: 1.3
-#
-# Example:
-#
-# -> { "execute": "xen-set-global-dirty-log",
-#      "arguments": { "enable": true } }
-# <- { "return": {} }
-#
-##
-{ 'command': 'xen-set-global-dirty-log', 'data': { 'enable': 'bool' } }
-
 ##
 # @getfd:
 #
@@ -588,24 +568,3 @@
  'data': { '*option': 'str' },
  'returns': ['CommandLineOptionInfo'],
  'allow-preconfig': true }
-
-##
-# @xen-load-devices-state:
-#
-# Load the state of all devices from file. The RAM and the block devices
-# of the VM are not loaded by this command.
-#
-# @filename: the file to load the state of the devices from as binary
-#            data. See xen-save-devices-state.txt for a description of the binary
-#            format.
-#
-# Since: 2.7
-#
-# Example:
-#
-# -> { "execute": "xen-load-devices-state",
-#      "arguments": { "filename": "/tmp/resume" } }
-# <- { "return": {} }
-#
-##
-{ 'command': 'xen-load-devices-state', 'data': {'filename': 'str'} }
diff --git a/accel/stubs/xen-stub.c b/accel/stubs/xen-stub.c
index 7ba0b697f4..7054965c48 100644
--- a/accel/stubs/xen-stub.c
+++ b/accel/stubs/xen-stub.c
@@ -7,7 +7,7 @@
 
 #include "qemu/osdep.h"
 #include "sysemu/xen.h"
-#include "qapi/qapi-commands-misc.h"
+#include "qapi/qapi-commands-migration.h"
 
 bool xen_allowed;
 
diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index f3ababf33b..9519c33c09 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -24,7 +24,7 @@
 #include "hw/xen/xen-bus.h"
 #include "hw/xen/xen-x86.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-misc.h"
+#include "qapi/qapi-commands-migration.h"
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
 #include "qemu/range.h"
diff --git a/migration/savevm.c b/migration/savevm.c
index d2e141f7b1..ff33e210eb 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -42,7 +42,6 @@
 #include "postcopy-ram.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-migration.h"
-#include "qapi/qapi-commands-misc.h"
 #include "qapi/qmp/qerror.h"
 #include "qemu/error-report.h"
 #include "sysemu/cpus.h"
-- 
2.26.2


