Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C35F3C4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 13:45:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 559D0206CA
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 13:45:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MQBD7F11"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 559D0206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOLMp-0005WY-Gr
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 09:44:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49266)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kOLI2-0007co-5e
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 09:40:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30572)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kOLHy-0005Td-0Y
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 09:40:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601645996;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8IRn/Y0aJt1eGijTbQmkn/6JoyPalvnCOEAPCHm0k58=;
 b=MQBD7F11kpTxjsik9FV6v8rcS/d9u9imMaejaRE/Bxo/GCKTGsv0NS3RkRWzB26fpurtiF
 ppSTEh9sI0MYvAL97aZy/g05cmU4HsvU/KxLrvfpaRITcMoQdfoeBViwIjsdMEdeG6//kC
 3WJxhDOFSI0uwC82k17eJCSKScBXZGI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-480-VpEtMgYnNqybgH_jj2vP7g-1; Fri, 02 Oct 2020 09:39:55 -0400
X-MC-Unique: VpEtMgYnNqybgH_jj2vP7g-1
Received: by mail-wm1-f72.google.com with SMTP id t8so433910wmj.6
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2020 06:39:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8IRn/Y0aJt1eGijTbQmkn/6JoyPalvnCOEAPCHm0k58=;
 b=oMyAjpTp8yRVbK7SeuNosyQxJtWymcy2FYlui+CSlXuAX8v1aFw8pAm0kvwNzbSLfo
 UT4hu3TDo70ncaXVqRoNSbL5pCmOUnYqzZ3QXuI2K1M1pWqpZVCkiCL5iP46k4zPysEW
 fWWY/Fhsum5RPcwkxbihmRHdMjlO6YnLYnC9xY/oEWzUzEkKIMybwwiWrdHxQAgd/1f/
 uAjMRH1p033e5LdT+SLlWg87CMgHLuWvrHU+43+D4UlL3+ozN5fXseSS74UcNS980uwX
 FiqBreU9nYvDzIrNksWptp6bH6rMaKICNpyhhCky7ASrckm4KPVY83VBnRA7+xB54ysi
 5Jdw==
X-Gm-Message-State: AOAM531W1JmSkz8b1pn7L4Esdf2cMG476NHUh57B0R8SHop3ewiOAzL9
 YtDb9JRQhqKhQi6aS9arpH8l90RTIWlHkMxlTlE0Z25ztjfD8I52xuggqL7ACokBupukHx8o0VU
 j6EH21ZuNhs2zmkY=
X-Received: by 2002:a5d:43cf:: with SMTP id v15mr3203828wrr.269.1601645993157; 
 Fri, 02 Oct 2020 06:39:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyrtjDxbvNT2qZx2AnpZX/U8SDHXTxctCni5ZD+jg0EWfaGOVq2AOPJli+/iQHk1imFPhnyVw==
X-Received: by 2002:a5d:43cf:: with SMTP id v15mr3203803wrr.269.1601645992898; 
 Fri, 02 Oct 2020 06:39:52 -0700 (PDT)
Received: from localhost.localdomain (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id f6sm1818116wro.5.2020.10.02.06.39.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2020 06:39:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 5/5] qapi: Restrict Xen migration commands to migration.json
Date: Fri,  2 Oct 2020 15:39:23 +0200
Message-Id: <20201002133923.1716645-6-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201002133923.1716645-1-philmd@redhat.com>
References: <20201002133923.1716645-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 23:37:29
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
 Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Paul Durrant <paul@xen.org>, Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Restricting xen-set-global-dirty-log and xen-load-devices-state
commands migration.json pulls slightly less QAPI-generated code
into user-mode and tools.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 qapi/migration.json    | 41 +++++++++++++++++++++++++++++++++++++++++
 qapi/misc.json         | 41 -----------------------------------------
 accel/stubs/xen-stub.c |  2 +-
 hw/i386/xen/xen-hvm.c  |  2 +-
 migration/savevm.c     |  1 -
 5 files changed, 43 insertions(+), 44 deletions(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index 7f5e6fd681..cb30f4c729 100644
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
index 9813893269..afe936b45b 100644
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
@@ -606,24 +586,3 @@
 ##
 { 'enum': 'ReplayMode',
   'data': [ 'none', 'record', 'play' ] }
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
index 34e4b71052..1fdf3f76c2 100644
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


