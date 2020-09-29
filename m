Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 581FAC4727F
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 20:28:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB4672076B
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 20:28:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KihsvI+9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB4672076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNMEx-0005PG-KM
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 16:28:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59838)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kNM6I-0001v3-79
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 16:19:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34277)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kNM69-0003W1-C2
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 16:19:49 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601410780;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IpaPO/xyASpAHb6Tn9VNSQDlYnAL6prIqxyflpicY3k=;
 b=KihsvI+9oCO2SxK5M3ppljGX8phcjVb0IbDgeOAS2Fn8MH/EeresYQSdnIWX9DOz1SpHLU
 Sl7Gr1x12IYbqLtCQkXwkadB0ePaeGBq3rmmTmLXBY5w+6DQneO7W/U6YJgQOtWw+kYdCm
 HrshslLA5oRJ94OOWmRc4HIs367xD94=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-boDGIgE1PdehE1ACTDIkBg-1; Tue, 29 Sep 2020 16:19:30 -0400
X-MC-Unique: boDGIgE1PdehE1ACTDIkBg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CAF3D801AE5;
 Tue, 29 Sep 2020 20:19:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-101.ams2.redhat.com
 [10.36.112.101])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9C5E66198E;
 Tue, 29 Sep 2020 20:19:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9EEFB11384A5; Tue, 29 Sep 2020 22:19:26 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 05/29] qapi: Restrict query-uuid command to machine code
Date: Tue, 29 Sep 2020 22:19:02 +0200
Message-Id: <20200929201926.2155622-6-armbru@redhat.com>
In-Reply-To: <20200929201926.2155622-1-armbru@redhat.com>
References: <20200929201926.2155622-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Only qemu-system-FOO and qemu-storage-daemon provide QMP
monitors, therefore such declarations and definitions are
irrelevant for user-mode emulation.

Restricting the query-uuid command to machine.json pulls less
QAPI-generated code into user-mode.

Acked-by: Markus Armbruster <armbru@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200913195348.1064154-6-philmd@redhat.com>
[Commit message tweaked]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/machine.json | 30 ++++++++++++++++++++++++++++++
 qapi/misc.json    | 30 ------------------------------
 block/iscsi.c     |  2 +-
 stubs/uuid.c      |  2 +-
 4 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index 15c8d606ab..5e5ddd7a5e 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -402,6 +402,36 @@
 ##
 { 'command': 'query-target', 'returns': 'TargetInfo' }
 
+##
+# @UuidInfo:
+#
+# Guest UUID information (Universally Unique Identifier).
+#
+# @UUID: the UUID of the guest
+#
+# Since: 0.14.0
+#
+# Notes: If no UUID was specified for the guest, a null UUID is returned.
+##
+{ 'struct': 'UuidInfo', 'data': {'UUID': 'str'} }
+
+##
+# @query-uuid:
+#
+# Query the guest UUID information.
+#
+# Returns: The @UuidInfo for the guest
+#
+# Since: 0.14.0
+#
+# Example:
+#
+# -> { "execute": "query-uuid" }
+# <- { "return": { "UUID": "550e8400-e29b-41d4-a716-446655440000" } }
+#
+##
+{ 'command': 'query-uuid', 'returns': 'UuidInfo', 'allow-preconfig': true }
+
 ##
 # @GuidInfo:
 #
diff --git a/qapi/misc.json b/qapi/misc.json
index edcc91e106..05db6295fe 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -98,36 +98,6 @@
 ##
 { 'command': 'query-kvm', 'returns': 'KvmInfo' }
 
-##
-# @UuidInfo:
-#
-# Guest UUID information (Universally Unique Identifier).
-#
-# @UUID: the UUID of the guest
-#
-# Since: 0.14.0
-#
-# Notes: If no UUID was specified for the guest, a null UUID is returned.
-##
-{ 'struct': 'UuidInfo', 'data': {'UUID': 'str'} }
-
-##
-# @query-uuid:
-#
-# Query the guest UUID information.
-#
-# Returns: The @UuidInfo for the guest
-#
-# Since: 0.14.0
-#
-# Example:
-#
-# -> { "execute": "query-uuid" }
-# <- { "return": { "UUID": "550e8400-e29b-41d4-a716-446655440000" } }
-#
-##
-{ 'command': 'query-uuid', 'returns': 'UuidInfo', 'allow-preconfig': true }
-
 ##
 # @IOThreadInfo:
 #
diff --git a/block/iscsi.c b/block/iscsi.c
index bd2122a3a4..e30a7e3606 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -42,7 +42,7 @@
 #include "qemu/uuid.h"
 #include "sysemu/replay.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-misc.h"
+#include "qapi/qapi-commands-machine.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qstring.h"
 #include "crypto/secret.h"
diff --git a/stubs/uuid.c b/stubs/uuid.c
index 67f182fa3a..e5112eb3f6 100644
--- a/stubs/uuid.c
+++ b/stubs/uuid.c
@@ -1,5 +1,5 @@
 #include "qemu/osdep.h"
-#include "qapi/qapi-commands-misc.h"
+#include "qapi/qapi-commands-machine.h"
 #include "qemu/uuid.h"
 
 UuidInfo *qmp_query_uuid(Error **errp)
-- 
2.26.2


