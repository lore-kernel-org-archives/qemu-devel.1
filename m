Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E12AC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 15:14:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BC4520878
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 15:14:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f43K6+SH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BC4520878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdEnm-0005j2-Dh
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 11:14:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54162)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jdEh7-0005ct-Dn
 for qemu-devel@nongnu.org; Mon, 25 May 2020 11:07:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59740
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jdEh6-0006jC-6l
 for qemu-devel@nongnu.org; Mon, 25 May 2020 11:07:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590419231;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3Fp5IE9q19WHuKjT5ra7LTNsYPjlLKFjw0nHzkRyPE4=;
 b=f43K6+SHjGBI6iqPtPQHnjNdZUgIRK2UpABCk27f/Z4y6mEFBzRjmwS9Er0H5hR+pCwkxO
 dQ0XsGKPiUnZdfO216bESUSDo+Unm1OFIGCeVjWyEeuoRmw78ST/UIZTbq+XHCJenGgkYf
 v8ke/TUuITfz6PD+u+FnyK6FS/5M3yk=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-228-0xxLQKKWMf21ioPBFcAS5g-1; Mon, 25 May 2020 11:07:10 -0400
X-MC-Unique: 0xxLQKKWMf21ioPBFcAS5g-1
Received: by mail-ej1-f69.google.com with SMTP id nw19so6424756ejb.10
 for <qemu-devel@nongnu.org>; Mon, 25 May 2020 08:07:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3Fp5IE9q19WHuKjT5ra7LTNsYPjlLKFjw0nHzkRyPE4=;
 b=tiuQWqLZKX8B4OM4YdXqybz1jkmi2xGUKqdbrjnIpz8ZStOeB3oeJZY/sbgLxVCnIg
 D81ewCikxw+XFXmCnT9wExYr7HxiTRRM/yqvPbDcAezCSxTeblKD/5hVDVZkr58vMwT/
 iAD4bjDg0sHXTSXh7SDsXAy5ZXhGc+DH5E8k4SQe09zAgSH8gMHPasY793zsJG4/uodx
 DS4Hjykds0pgXWEjk25ZENTxtrq0b15+/HIqmEXJq9bMWmKdlWH8kt/pydQM/7wJwzdJ
 Fx5BVjrPVFotKoNWWraAZpQkwSC+yex3EuXhBd/CmrvVOU6OLqQOTy6VkSrJRlVrHriw
 dpBw==
X-Gm-Message-State: AOAM5330wGFOd9de/dqYXn7Sf++e2Gwg1bOe1RJgRs88EsyFN8gIyzzo
 JDzFd2u9PFrJaGklmLO2wkV/cZ5dIKSKfPqedTTM/I4y5nJe1zEcqJm4Hei+jc36RnTajw98z0F
 uausk9K2acvjqct4=
X-Received: by 2002:a17:906:dbef:: with SMTP id
 yd15mr18783542ejb.5.1590419228466; 
 Mon, 25 May 2020 08:07:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyc8pIVgB8O+RO+G/FzpLrcqAuivVA+aLfJMVWW2XdLBbHOawNds7BqVTA222UcCOw6X2lDEA==
X-Received: by 2002:a17:906:dbef:: with SMTP id
 yd15mr18783506ejb.5.1590419228178; 
 Mon, 25 May 2020 08:07:08 -0700 (PDT)
Received: from x1w.redhat.com (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id zk10sm15742658ejb.9.2020.05.25.08.07.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2020 08:07:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 4/9] qapi/misc: Restrict balloon-related commands to
 machine code
Date: Mon, 25 May 2020 17:06:35 +0200
Message-Id: <20200525150640.30879-5-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200525150640.30879-1-philmd@redhat.com>
References: <20200525150640.30879-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/25 01:44:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 Ben Warren <ben@skyportsystems.com>, David Hildenbrand <david@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Lieven <pl@kamp.de>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-block@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 qapi/machine.json          | 90 ++++++++++++++++++++++++++++++++++++++
 qapi/misc.json             | 90 --------------------------------------
 include/sysemu/balloon.h   |  2 +-
 balloon.c                  |  2 +-
 hw/virtio/virtio-balloon.c |  2 +-
 monitor/hmp-cmds.c         |  1 +
 6 files changed, 94 insertions(+), 93 deletions(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index ca7d58f0c9..ae42d69495 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -921,3 +921,93 @@
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
index 446fc8ff83..26b5115638 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -186,65 +186,6 @@
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
@@ -753,37 +694,6 @@
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
-# With a 2.5GiB guest this command inflated the ballon to 3GiB.
-#
-##
-{ 'command': 'balloon', 'data': {'value': 'int'} }
-
 ##
 # @human-monitor-command:
 #
diff --git a/include/sysemu/balloon.h b/include/sysemu/balloon.h
index aea0c44985..b3de4b92b9 100644
--- a/include/sysemu/balloon.h
+++ b/include/sysemu/balloon.h
@@ -15,7 +15,7 @@
 #define QEMU_BALLOON_H
 
 #include "exec/cpu-common.h"
-#include "qapi/qapi-types-misc.h"
+#include "qapi/qapi-types-machine.h"
 
 typedef void (QEMUBalloonEvent)(void *opaque, ram_addr_t target);
 typedef void (QEMUBalloonStatus)(void *opaque, BalloonInfo *info);
diff --git a/balloon.c b/balloon.c
index f104b42961..ee9c59252d 100644
--- a/balloon.c
+++ b/balloon.c
@@ -30,7 +30,7 @@
 #include "sysemu/balloon.h"
 #include "trace-root.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-misc.h"
+#include "qapi/qapi-commands-machine.h"
 #include "qapi/qmp/qerror.h"
 
 static QEMUBalloonEvent *balloon_event_fn;
diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index 065cd450f1..ec3aac1e80 100644
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
index 9c61e769ca..376590c073 100644
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
-- 
2.21.3


