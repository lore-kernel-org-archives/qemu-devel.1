Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 601BBC433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 15:26:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C21E420BED
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 15:26:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dPaMqCa6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C21E420BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGOSc-0008Ig-K5
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 11:26:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40594)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kGOPZ-0003vs-07
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 11:22:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24869
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kGOPW-00081d-R4
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 11:22:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599751374;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7yszzDsAOGK60XcdOIY84wKdPBglL2SraCowKnZF5ac=;
 b=dPaMqCa6c0f9owSEUfLD96LZ9JFrDcMGAQAVC9dDpjcBzSHwud2G3zjx2burV5pRoWPfjv
 iStB/Iba+6TweQsPsUexfUo8eLFTZvTf9y+Kmg3a5VNi9jg7OijbfEmLv7C8xY1XFxk9O7
 MKFZf8jT2teXo4AcAN+Gs/XvQCPaGb8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-221-aN6uMc8PND20KzoO51nRew-1; Thu, 10 Sep 2020 11:22:51 -0400
X-MC-Unique: aN6uMc8PND20KzoO51nRew-1
Received: by mail-wr1-f71.google.com with SMTP id r16so2363149wrm.18
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2020 08:22:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7yszzDsAOGK60XcdOIY84wKdPBglL2SraCowKnZF5ac=;
 b=r9P8GJ9Z7VIRZ3Mc+MNQkWSBBjfir/W33LKgW0O5r/pER6B559MXWN3Mv6Hn9OpLez
 454BaGXtUzdNMQxxMvQ7psYbf9Ja7SMSGcouAHxCm+66CkVGGbrF3EqdICoaY5MPlXlw
 g5IOJXzRpNVTi+Iv+Nbq0t+q+OSZHdrojZrlJcEex5CZMdc5so5tWhOSqa49dv+oUm2l
 n2cM0Qd2+9dlY7qbKOK4epQmzUOISrtncQSlBOknPtfZFnR+thv/1VJ8HGHhBkQQTHrC
 XzeYbvHR4SWpMfok6vuL2ALDGNuHB6WmT82Y+Hel6R4RtnHs6Ci/ysNa7nTt5+abb3H+
 9RQQ==
X-Gm-Message-State: AOAM531TgpUcQERueTRIIrs7RjQP9nxR/dxvByhyVF8x5YWuXqx8yg/5
 7NRReb8XpZRAdEnm/UNJL3eFd+AxXwjsLcaHzA7VpaOHE3cx0ZcyM4kmg90tOIy5CvV5X2WP9Wf
 DtTRXausk0cKfKL4=
X-Received: by 2002:a05:600c:204e:: with SMTP id
 p14mr500477wmg.182.1599751369884; 
 Thu, 10 Sep 2020 08:22:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzQJCp1r0BWDlHaMcpUsiiV2p2eS2FmnLBNc0LKdVy8qnb3keCmsAyaa72/hcSsQproz6aodQ==
X-Received: by 2002:a05:600c:204e:: with SMTP id
 p14mr500459wmg.182.1599751369595; 
 Thu, 10 Sep 2020 08:22:49 -0700 (PDT)
Received: from x1w.redhat.com (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id k24sm3914454wmj.19.2020.09.10.08.22.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2020 08:22:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 4/9] qapi: Restrict balloon-related commands to machine code
Date: Thu, 10 Sep 2020 17:22:20 +0200
Message-Id: <20200910152225.524322-5-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200910152225.524322-1-philmd@redhat.com>
References: <20200910152225.524322-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 08:35:50
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Ben Warren <ben@skyportsystems.com>,
 David Hildenbrand <david@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Lieven <pl@kamp.de>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-block@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Only qemu-system-FOO and qemu-storage-daemon provide QMP
monitors, therefore such declarations and definitions are
irrelevant for user-mode emulation.

Restricting the balloon-related commands to machine.json
allows pulling less declarations/definitions to user-mode.

Reviewed-by: David Hildenbrand <david@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 qapi/machine.json          | 90 ++++++++++++++++++++++++++++++++++++++
 qapi/misc.json             | 90 --------------------------------------
 include/sysemu/balloon.h   |  2 +-
 hw/virtio/virtio-balloon.c |  2 +-
 monitor/hmp-cmds.c         |  1 +
 softmmu/balloon.c          |  2 +-
 6 files changed, 94 insertions(+), 93 deletions(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index a80933c57be..870b8a53f21 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -927,3 +927,93 @@
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
index a667fdf03e5..7a14c50094d 100644
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
index 20a2defe3aa..867687b73ac 100644
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
index 22cb5df717b..b22b5beda3c 100644
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
index 7711726fd22..de01ba20845 100644
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
index b89646f85d5..5eacc16c96a 100644
--- a/softmmu/balloon.c
+++ b/softmmu/balloon.c
@@ -30,7 +30,7 @@
 #include "sysemu/balloon.h"
 #include "trace/trace-root.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-misc.h"
+#include "qapi/qapi-commands-machine.h"
 #include "qapi/qmp/qerror.h"
 
 static QEMUBalloonEvent *balloon_event_fn;
-- 
2.26.2


