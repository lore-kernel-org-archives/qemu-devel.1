Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 251DCC10DCE
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 00:48:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E39EC206BE
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 00:48:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LMgCKsd9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E39EC206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDdvl-0005Sb-Qg
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 20:48:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50201)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jDdF0-0005ZS-81
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 20:04:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jDdEt-0001Rn-WC
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 20:04:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46703
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jDdEt-0001Oi-Qs
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 20:04:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584317053;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ddEZPCXoZ/JJwclVnylPamC5y16AdeWmnXaUuY275K4=;
 b=LMgCKsd9Pati0OtPKdPKq/EZhKSElZDbjpFVurYiRbfELnzArdAY/+9KNOU1PJK8iRdcef
 4Fy+gWVTUvaf58fpdOjzQH+oliSMxWxNlIevotkX3+ahx1d6GiRRAjT5/PrgVtg4/XvbYK
 SCwc4QutszXE6KOOtWBkTJWd7jHwZaw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-139-bUplY67hOcWQtT9cZA6ruQ-1; Sun, 15 Mar 2020 20:04:12 -0400
X-MC-Unique: bUplY67hOcWQtT9cZA6ruQ-1
Received: by mail-wm1-f69.google.com with SMTP id y7so5030297wmd.4
 for <qemu-devel@nongnu.org>; Sun, 15 Mar 2020 17:04:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=u3sG3DGW9hNabk2FFKm+3ce53WBbirexmD/101s1zcw=;
 b=q52oVSdUv4f9mFIIh8xUTjbmz+kZym1PcdJ2hvnFcAh3DVz6amrDmY5CZ5m3awsjgT
 wCgNA+F9j/GcDSLw9KUoaoPmtbyi06P6qLaP632wR3cLBYu6dd7FfUV12FUGoPEG/yCq
 Mvc/kTfOmo5Hply+JWztio30h620SbQ7CSbJo0YBsTSLaghnlesbHjvBFEmRQDBrhTbA
 u4OMIXUABOxLBTpP35ZAdq14w137MD9UYygL4ZRJjyD9++EPlZCPiJ1oa1qjCyx1MypE
 1j6pTfqVLvZvzaZ/w5ACK/VZyuAWJ9NfqiYXo5eazq/sNNYdvvlYcxdjF2WnW5l9270i
 GZJw==
X-Gm-Message-State: ANhLgQ36uUyNabEj1TFZUdU6LPlOCr/fUueTMx3zHXjwEn4yGmUpNgv1
 wCUa8rCsI418Z6YbtlDtpuHdFYoYxcsVtF6AGxV/CMzQAcOySkLLOBLvXQQYaJCZqNDhpLNgpqf
 BT1X8nsNUpquVnJE=
X-Received: by 2002:a1c:f21a:: with SMTP id s26mr24064644wmc.39.1584317050608; 
 Sun, 15 Mar 2020 17:04:10 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtQZLB6MP+S7/5gnyZNa3D57/+K7FrKQ9lMWEQIEr+7YBs6WQo2VJi5RL2DNqPAYbxqe0LEoQ==
X-Received: by 2002:a1c:f21a:: with SMTP id s26mr24064596wmc.39.1584317050293; 
 Sun, 15 Mar 2020 17:04:10 -0700 (PDT)
Received: from localhost.localdomain (191.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.191])
 by smtp.gmail.com with ESMTPSA id c85sm28373383wmd.48.2020.03.15.17.04.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Mar 2020 17:04:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 3/8] qapi/misc: Restrict balloon-related commands to
 machine code
Date: Mon, 16 Mar 2020 01:03:43 +0100
Message-Id: <20200316000348.29692-4-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200316000348.29692-1-philmd@redhat.com>
References: <20200316000348.29692-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
 "Michael S. Tsirkin" <mst@redhat.com>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Peter Lieven <pl@kamp.de>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 qapi/machine.json          | 83 ++++++++++++++++++++++++++++++++++++++
 qapi/misc.json             | 83 --------------------------------------
 include/sysemu/balloon.h   |  2 +-
 balloon.c                  |  2 +-
 hw/virtio/virtio-balloon.c |  2 +-
 monitor/hmp-cmds.c         |  1 +
 6 files changed, 87 insertions(+), 86 deletions(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index 07ffc07ba2..c096efbea3 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -915,3 +915,86 @@
   'data': 'NumaOptions',
   'allow-preconfig': true
 }
+
+##
+# @balloon:
+#
+# Request the balloon driver to change its balloon size.
+#
+# @value: the target size of the balloon in bytes
+#
+# Returns: - Nothing on success
+#          - If the balloon driver is enabled but not functional because t=
he KVM
+#            kernel module cannot support it, KvmMissingCap
+#          - If no balloon device is present, DeviceNotActive
+#
+# Notes: This command just issues a request to the guest.  When it returns=
,
+#        the balloon size may not have changed.  A guest can change the ba=
lloon
+#        size independent of this command.
+#
+# Since: 0.14.0
+#
+# Example:
+#
+# -> { "execute": "balloon", "arguments": { "value": 536870912 } }
+# <- { "return": {} }
+#
+##
+{ 'command': 'balloon', 'data': {'value': 'int'} }
+
+##
+# @BalloonInfo:
+#
+# Information about the guest balloon device.
+#
+# @actual: the number of bytes the balloon currently contains
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
+#          - If the balloon driver is enabled but not functional because t=
he KVM
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
+# @actual: actual level of the guest memory balloon in bytes
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
index 2725d835ad..ed28e41229 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -186,63 +186,6 @@
 { 'command': 'query-iothreads', 'returns': ['IOThreadInfo'],
   'allow-preconfig': true }
=20
-##
-# @BalloonInfo:
-#
-# Information about the guest balloon device.
-#
-# @actual: the number of bytes the balloon currently contains
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
-#          - If the balloon driver is enabled but not functional because t=
he KVM
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
-# @actual: actual level of the guest memory balloon in bytes
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
@@ -751,32 +694,6 @@
 ##
 { 'command': 'inject-nmi' }
=20
-##
-# @balloon:
-#
-# Request the balloon driver to change its balloon size.
-#
-# @value: the target size of the balloon in bytes
-#
-# Returns: - Nothing on success
-#          - If the balloon driver is enabled but not functional because t=
he KVM
-#            kernel module cannot support it, KvmMissingCap
-#          - If no balloon device is present, DeviceNotActive
-#
-# Notes: This command just issues a request to the guest.  When it returns=
,
-#        the balloon size may not have changed.  A guest can change the ba=
lloon
-#        size independent of this command.
-#
-# Since: 0.14.0
-#
-# Example:
-#
-# -> { "execute": "balloon", "arguments": { "value": 536870912 } }
-# <- { "return": {} }
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
=20
 #include "exec/cpu-common.h"
-#include "qapi/qapi-types-misc.h"
+#include "qapi/qapi-types-machine.h"
=20
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
=20
 static QEMUBalloonEvent *balloon_event_fn;
diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index a4729f7fc9..07ad36b143 100644
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
index 58724031ea..97cd340b2e 100644
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
--=20
2.21.1


