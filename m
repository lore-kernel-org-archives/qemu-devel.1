Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D34C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 12:20:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 769202074F
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 12:20:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qc3KInko"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 769202074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRwp0-0007ru-F8
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 08:20:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52816)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kRwkM-00044I-HO
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 08:16:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33657)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kRwkJ-0004V7-Hs
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 08:16:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602504965;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eGWvxcwdrYMZ1U8s3C0BMwWriO7oH4iIj3hu/+vjyUQ=;
 b=Qc3KInkoCugTosWEXuJjcoGhFXwLCDlZqqJ0kgJpaSuyqouwgM8qVQCl91C6bkq+NkdNSf
 UO2v10sHWNBWYxoQBNZK0+fJT4P38ntZ+OUDU+7u8+gKgKeyw+kIXRncsfQHkngG30IMae
 BeqpTIYu1GcMkNw6Bm8ifBtV3iX8Cnw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-72-Yce9EbOiMNyTHuV3XOuhjg-1; Mon, 12 Oct 2020 08:16:04 -0400
X-MC-Unique: Yce9EbOiMNyTHuV3XOuhjg-1
Received: by mail-wr1-f71.google.com with SMTP id b6so9182701wrn.17
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 05:16:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=eGWvxcwdrYMZ1U8s3C0BMwWriO7oH4iIj3hu/+vjyUQ=;
 b=mU58HUXnxPr7ULqSZV+Y4TMGCllp89cB1TXR4+1MLRHQJrw+4fF4RzNH6yNuZ/E751
 8QPSdXt2nD3UF49cMnfum8zqroFyVHVpswWNNWkGLRy6Dw3KvpKceJqfGqkYRyEL5Jp3
 MvFZYNIIDpvjkzFpz6rxoma9cW4mOupq8R1YKfrx//vWLGh1MltyCl2mhWPwSxX9KQSN
 BFcUDwOp1Fi/FCshnCsz24DTOT4kwBAuKcaqpPNrQuyd9hxZiLXWlHO0Dx0B3/v0XI6k
 ckIbB0CfcRjJBtqQOYv5C4g+aQq2wVKu5dyzVd5ytK+/NfhstcFY9GOxmaGkjJqEnnfb
 9Gtw==
X-Gm-Message-State: AOAM533lLOr334ASMoYnnfDDblj9Xo5MYmdWk60268NgEzZ0NcUce3is
 qfOFlR9N1beEqxNWzHvonzt/4AnUSZnsghiu/1JXUxtwfDetq17/Va2U+/nEveFGKn42YHzImG6
 4kPRAKGf8Uvv8CtQ=
X-Received: by 2002:a1c:bdc4:: with SMTP id
 n187mr11195534wmf.185.1602504962595; 
 Mon, 12 Oct 2020 05:16:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyVoBK3vIdraNkihHbdy1G43EDRyjn8K86gMv0QE7t1U7YCMFjR7hseHjvHb4G0NoNXa5zFGw==
X-Received: by 2002:a1c:bdc4:: with SMTP id
 n187mr11195524wmf.185.1602504962357; 
 Mon, 12 Oct 2020 05:16:02 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id t4sm21334591wra.75.2020.10.12.05.16.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2020 05:16:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Subject: [PATCH v2 5/5] qapi: Restrict Xen migration commands to migration.json
Date: Mon, 12 Oct 2020 14:15:36 +0200
Message-Id: <20201012121536.3381997-6-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201012121536.3381997-1-philmd@redhat.com>
References: <20201012121536.3381997-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/12 02:58:41
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Restricting xen-set-global-dirty-log and xen-load-devices-state
commands migration.json pulls slightly less QAPI-generated code
into user-mode and tools.

Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 qapi/migration.json    | 41 +++++++++++++++++++++++++++++++++++++++++
 qapi/misc.json         | 41 -----------------------------------------
 accel/stubs/xen-stub.c |  2 +-
 hw/i386/xen/xen-hvm.c  |  2 +-
 migration/savevm.c     |  1 -
 5 files changed, 43 insertions(+), 44 deletions(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index 7f5e6fd681a..cb30f4c729b 100644
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
index 363115c1edb..40df513856e 100644
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
index 7ba0b697f49..7054965c480 100644
--- a/accel/stubs/xen-stub.c
+++ b/accel/stubs/xen-stub.c
@@ -7,7 +7,7 @@
 
 #include "qemu/osdep.h"
 #include "sysemu/xen.h"
-#include "qapi/qapi-commands-misc.h"
+#include "qapi/qapi-commands-migration.h"
 
 bool xen_allowed;
 
diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index f3ababf33b6..9519c33c098 100644
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
index d2e141f7b1d..ff33e210eb0 100644
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


