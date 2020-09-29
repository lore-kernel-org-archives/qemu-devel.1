Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E1EC4727F
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 20:27:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9F812076D
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 20:27:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ddhBCiRz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9F812076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNMDF-0003GJ-KU
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 16:27:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59720)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kNM6C-0001po-Hk
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 16:19:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39257)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kNM64-0003Uh-HY
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 16:19:44 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601410775;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rVmHTDVApisUCQ44I1PLnIyMhzm7R6MJCbuFfCkfsGQ=;
 b=ddhBCiRzZi4D10BfVYf2h8EMIdP74RnGFVBj6wb8A8xJbLmoj7NGRgsBffmrDYtV5hLQZB
 tHEUFEQ/pCtULLpZFxZ8soFmqpQWNj4zmPuGMdeIdprXcuMZYGYTFhlm7Tpf2R/MI3XHf3
 hg+iV9uH3fRuKWOi5R2LoXnqGHf+zsg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-mH8VvQNPNQeS1Am1SKP_IA-1; Tue, 29 Sep 2020 16:19:32 -0400
X-MC-Unique: mH8VvQNPNQeS1Am1SKP_IA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E4CC71040C21;
 Tue, 29 Sep 2020 20:19:31 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-101.ams2.redhat.com
 [10.36.112.101])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0E9F519D61;
 Tue, 29 Sep 2020 20:19:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 97C3A1138611; Tue, 29 Sep 2020 22:19:26 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 03/29] qapi: Restrict balloon-related commands to machine code
Date: Tue, 29 Sep 2020 22:19:00 +0200
Message-Id: <20200929201926.2155622-4-armbru@redhat.com>
In-Reply-To: <20200929201926.2155622-1-armbru@redhat.com>
References: <20200929201926.2155622-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 02:22:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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
Cc: peter.maydell@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Only qemu-system-FOO and qemu-storage-daemon provide QMP
monitors, therefore such declarations and definitions are
irrelevant for user-mode emulation.

Restricting the balloon-related commands to machine.json pulls less
QAPI-generated code into user-mode.

Reviewed-by: David Hildenbrand <david@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200913195348.1064154-4-philmd@redhat.com>
[Commit message tweaked]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/machine.json          | 90 ++++++++++++++++++++++++++++++++++++++
 qapi/misc.json             | 90 --------------------------------------
 include/sysemu/balloon.h   |  2 +-
 hw/virtio/virtio-balloon.c |  2 +-
 monitor/hmp-cmds.c         |  1 +
 softmmu/balloon.c          |  2 +-
 6 files changed, 94 insertions(+), 93 deletions(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index 8e2164a0b6..2accb3c4d2 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -945,3 +945,93 @@
   'data': 'NumaOptions',
   'allow-preconfig': true
 }
+
+##
+# @balloon:
+#
+# Request the balloon driver to change its balloon size.
+#
+# @value: the target logical size of the VM in bytes
+#         We can deduce the size of the balloon using this formula:
+#            logical_vm_size = vm_ram_size - balloon_size
+#         From it we have: balloon_size = vm_ram_size - @value
+#
+# Returns: - Nothing on success
+#          - If the balloon driver is enabled but not functional because the KVM
+#            kernel module cannot support it, KvmMissingCap
+#          - If no balloon device is present, DeviceNotActive
+#
+# Notes: This command just issues a request to the guest.  When it returns,
+#        the balloon size may not have changed.  A guest can change the balloon
+#        size independent of this command.
+#
+# Since: 0.14.0
+#
+# Example:
+#
+# -> { "execute": "balloon", "arguments": { "value": 536870912 } }
+# <- { "return": {} }
+#
+# With a 2.5GiB guest this command inflated the ballon to 3GiB.
+#
+##
+{ 'command': 'balloon', 'data': {'value': 'int'} }
+
+##
+# @BalloonInfo:
+#
+# Information about the guest balloon device.
+#
+# @actual: the logical size of the VM in bytes
+#          Formula used: logical_vm_size = vm_ram_size - balloon_size
+#
+# Since: 0.14.0
+#
+##
+{ 'struct': 'BalloonInfo', 'data': {'actual': 'int' } }
+
+##
+# @query-balloon:
+#
+# Return information about the balloon device.
+#
+# Returns: - @BalloonInfo on success
+#          - If the balloon driver is enabled but not functional because the KVM
+#            kernel module cannot support it, KvmMissingCap
+#          - If no balloon device is present, DeviceNotActive
+#
+# Since: 0.14.0
+#
+# Example:
+#
+# -> { "execute": "query-balloon" }
+# <- { "return": {
+#          "actual": 1073741824,
+#       }
+#    }
+#
+##
+{ 'command': 'query-balloon', 'returns': 'BalloonInfo' }
+
+##
+# @BALLOON_CHANGE:
+#
+# Emitted when the guest changes the actual BALLOON level. This value is
+# equivalent to the @actual field return by the 'query-balloon' command
+#
+# @actual: the logical size of the VM in bytes
+#          Formula used: logical_vm_size = vm_ram_size - balloon_size
+#
+# Note: this event is rate-limited.
+#
+# Since: 1.2
+#
+# Example:
+#
+# <- { "event": "BALLOON_CHANGE",
+#      "data": { "actual": 944766976 },
+#      "timestamp": { "seconds": 1267020223, "microseconds": 435656 } }
+#
+##
+{ 'event': 'BALLOON_CHANGE',
+  'data': { 'actual': 'int' } }
diff --git a/qapi/misc.json b/qapi/misc.json
index a667fdf03e..7a14c50094 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -187,65 +187,6 @@
 { 'command': 'query-iothreads', 'returns': ['IOThreadInfo'],
   'allow-preconfig': true }
 
-##
-# @BalloonInfo:
-#
-# Information about the guest balloon device.
-#
-# @actual: the logical size of the VM in bytes
-#          Formula used: logical_vm_size = vm_ram_size - balloon_size
-#
-# Since: 0.14.0
-#
-##
-{ 'struct': 'BalloonInfo', 'data': {'actual': 'int' } }
-
-##
-# @query-balloon:
-#
-# Return information about the balloon device.
-#
-# Returns: - @BalloonInfo on success
-#          - If the balloon driver is enabled but not functional because the KVM
-#            kernel module cannot support it, KvmMissingCap
-#          - If no balloon device is present, DeviceNotActive
-#
-# Since: 0.14.0
-#
-# Example:
-#
-# -> { "execute": "query-balloon" }
-# <- { "return": {
-#          "actual": 1073741824,
-#       }
-#    }
-#
-##
-{ 'command': 'query-balloon', 'returns': 'BalloonInfo' }
-
-##
-# @BALLOON_CHANGE:
-#
-# Emitted when the guest changes the actual BALLOON level. This value is
-# equivalent to the @actual field return by the 'query-balloon' command
-#
-# @actual: the logical size of the VM in bytes
-#          Formula used: logical_vm_size = vm_ram_size - balloon_size
-#
-# Note: this event is rate-limited.
-#
-# Since: 1.2
-#
-# Example:
-#
-# <- { "event": "BALLOON_CHANGE",
-#      "data": { "actual": 944766976 },
-#      "timestamp": { "seconds": 1267020223, "microseconds": 435656 } }
-#
-##
-{ 'event': 'BALLOON_CHANGE',
-  'data': { 'actual': 'int' } }
-
 ##
 # @PciMemoryRange:
 #
@@ -756,37 +697,6 @@
 ##
 { 'command': 'inject-nmi' }
 
-##
-# @balloon:
-#
-# Request the balloon driver to change its balloon size.
-#
-# @value: the target logical size of the VM in bytes
-#         We can deduce the size of the balloon using this formula:
-#            logical_vm_size = vm_ram_size - balloon_size
-#         From it we have: balloon_size = vm_ram_size - @value
-#
-# Returns: - Nothing on success
-#          - If the balloon driver is enabled but not functional because the KVM
-#            kernel module cannot support it, KvmMissingCap
-#          - If no balloon device is present, DeviceNotActive
-#
-# Notes: This command just issues a request to the guest.  When it returns,
-#        the balloon size may not have changed.  A guest can change the balloon
-#        size independent of this command.
-#
-# Since: 0.14.0
-#
-# Example:
-#
-# -> { "execute": "balloon", "arguments": { "value": 536870912 } }
-# <- { "return": {} }
-#
-# With a 2.5GiB guest this command inflated the balloon to 3GiB.
-#
-##
-{ 'command': 'balloon', 'data': {'value': 'int'} }
-
 ##
 # @human-monitor-command:
 #
diff --git a/include/sysemu/balloon.h b/include/sysemu/balloon.h
index 20a2defe3a..867687b73a 100644
--- a/include/sysemu/balloon.h
+++ b/include/sysemu/balloon.h
@@ -15,7 +15,7 @@
 #define QEMU_BALLOON_H
 
 #include "exec/cpu-common.h"
-#include "qapi/qapi-types-misc.h"
+#include "qapi/qapi-types-machine.h"
 
 typedef void (QEMUBalloonEvent)(void *opaque, ram_addr_t target);
 typedef void (QEMUBalloonStatus)(void *opaque, BalloonInfo *info);
diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index 22cb5df717..b22b5beda3 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -24,7 +24,7 @@
 #include "hw/virtio/virtio-balloon.h"
 #include "exec/address-spaces.h"
 #include "qapi/error.h"
-#include "qapi/qapi-events-misc.h"
+#include "qapi/qapi-events-machine.h"
 #include "qapi/visitor.h"
 #include "trace.h"
 #include "qemu/error-report.h"
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index 7711726fd2..de01ba2084 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -32,6 +32,7 @@
 #include "qapi/qapi-commands-block.h"
 #include "qapi/qapi-commands-char.h"
 #include "qapi/qapi-commands-control.h"
+#include "qapi/qapi-commands-machine.h"
 #include "qapi/qapi-commands-migration.h"
 #include "qapi/qapi-commands-misc.h"
 #include "qapi/qapi-commands-net.h"
diff --git a/softmmu/balloon.c b/softmmu/balloon.c
index 23452295cd..e0e8969a4b 100644
--- a/softmmu/balloon.c
+++ b/softmmu/balloon.c
@@ -29,7 +29,7 @@
 #include "sysemu/kvm.h"
 #include "sysemu/balloon.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-misc.h"
+#include "qapi/qapi-commands-machine.h"
 #include "qapi/qmp/qerror.h"
 #include "trace.h"
 
-- 
2.26.2


