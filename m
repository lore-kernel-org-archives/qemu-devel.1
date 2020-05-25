Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0754EC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 15:13:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 845182073B
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 15:13:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g007vQu0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 845182073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdEmv-0004Ul-ER
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 11:13:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54200)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jdEhN-0005zY-0I
 for qemu-devel@nongnu.org; Mon, 25 May 2020 11:07:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23350
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jdEhK-0006kp-Ly
 for qemu-devel@nongnu.org; Mon, 25 May 2020 11:07:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590419245;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n688Ug1E8U30t03slUDUg6yxWEE8HYKLjx2cTAsTob0=;
 b=g007vQu0BZql8fgrUT6ghYEfJs6G5Hv0559k7YcRuHnHbt9Ad02vt/IDxTud/vibZnMN0v
 FOG9Hemh2uOXf+yW/4IOWLBTrTBh2xfOlNBhrVz39iyY8zvVq4HQWZIQP4DJvr0rd070Ij
 Xl9wIcB/n1FA2ZyGHWv9yeJ8do+vRSk=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-251-cw1wLKcjOSiOmJFj3fFdTA-1; Mon, 25 May 2020 11:07:21 -0400
X-MC-Unique: cw1wLKcjOSiOmJFj3fFdTA-1
Received: by mail-ed1-f72.google.com with SMTP id dk23so7610239edb.15
 for <qemu-devel@nongnu.org>; Mon, 25 May 2020 08:07:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=n688Ug1E8U30t03slUDUg6yxWEE8HYKLjx2cTAsTob0=;
 b=ktz5emDnglm6jAhxL/3t73O2drw5Lw/KqQcVxjfhRx31zHq1XxWKQmZJTKkUIbU0xr
 Me4G0eUNq7lP+EPEq+h2QdNZoOqfSEXhyzQSf3dhdiQuzVJigsafPLt8WXGDM2IjeLCK
 sinSVxzjD/NMH5VmEB+eE/1KzIaSJGsUv+/aIlpgRxpEw5RYOt/f3WeCiPxB8Yb9E3f9
 I5WSsBtXqDqheo9+3SbtsotUQNuxZiUFxRVwWXrrKM3PfpgUWcLeLCDIAXjtBnMRN20q
 pFqIJ9jdD0S7YwpQQ/LYQwpbGBR2rHAUMeSZGCbOuowT8tOhd3ferYRXsVpFY6ugAnmt
 1XnQ==
X-Gm-Message-State: AOAM5301lqGU8HmvpJoFb8X1jg6LdtH8/44ubbJ6+C5Jc7by2bsznYw2
 TjLsvMdsCT5LpgHmn4tDUkFr8wmFbqDrKJ91J9urRXo7YAkTxsu71u/yPbYWDKcObFEHdhkJb7S
 cnAzWtdvZ7tBxkFQ=
X-Received: by 2002:aa7:cf08:: with SMTP id a8mr16348985edy.354.1590419240546; 
 Mon, 25 May 2020 08:07:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwKoxs/SJXYi/TLCv0wflQV/CK5x/44Yia7Jst0UMdeq6YgpiiqiwLEKojAiD1/lUaXeOrW0Q==
X-Received: by 2002:aa7:cf08:: with SMTP id a8mr16348949edy.354.1590419240312; 
 Mon, 25 May 2020 08:07:20 -0700 (PDT)
Received: from x1w.redhat.com (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id 32sm14950014edf.43.2020.05.25.08.07.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2020 08:07:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 6/9] qapi/misc: Move query-uuid command to machine code
Date: Mon, 25 May 2020 17:06:37 +0200
Message-Id: <20200525150640.30879-7-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200525150640.30879-1-philmd@redhat.com>
References: <20200525150640.30879-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/25 08:28:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 qapi/machine.json | 30 ++++++++++++++++++++++++++++++
 qapi/misc.json    | 30 ------------------------------
 block/iscsi.c     |  2 +-
 stubs/uuid.c      |  2 +-
 4 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index 545ecb9a55..7420c4f5ee 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -421,6 +421,36 @@
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
index b43fe7c602..49ca97f712 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -97,36 +97,6 @@
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
index a8b76979d8..efec25f7ed 100644
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
2.21.3


