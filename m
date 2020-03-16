Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D0D4C5ACBF
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 01:04:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B8B820674
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 01:04:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HYkUF8PO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B8B820674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDeB8-0004EC-83
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 21:04:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50254)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jDdF1-0005aP-Lj
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 20:04:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jDdF0-0001eh-FY
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 20:04:23 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:34866
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jDdF0-0001Yu-7k
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 20:04:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584317059;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0EBS/JGM5sdypwmOBkqVZGaFaD89p2CN4vt6aH7d1PA=;
 b=HYkUF8POkf4q6e+Ob425IrJsNW7nK0DTkGJ3kyEEeDDqQwBig/3QvEta3wz5pqSv5hbRJh
 hHq7sPB177ojCinBKqzJtacm5mR0qnoQMgLpWllZosHszEhQC514k88X+Ma7hk4bkIgM3D
 5nGqutoxLscJVqadIQU00t2oK+5K0rg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-426-WL07sWO3NtGxl3gx28tsnA-1; Sun, 15 Mar 2020 20:04:18 -0400
X-MC-Unique: WL07sWO3NtGxl3gx28tsnA-1
Received: by mail-wr1-f69.google.com with SMTP id g4so481493wrv.12
 for <qemu-devel@nongnu.org>; Sun, 15 Mar 2020 17:04:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=sZKHWj2M/9wdQufG5pPSxGofUinM5PxKM5oyG6rDjBQ=;
 b=HRuy51KreoUYE5YDRDLc5tc2+6GDcq5rPQizZga6G4kVvSpHGx6uR8v3G4RjLJ0uAF
 a1vgBrrlrmtq75USm4SNrpY8fdfz7vyjHTCACywIB1/IUfgN9OU4uufbDgFvRlc+92gT
 KyejGQjkk/tqAovZEyX6LOcTrFC+pegomN6hEnuQMfdQYBu/jYdm+DNHmoKRtqtzUnuI
 YC7Ul0kj2l4MPFfWzOMUFcq3ymN+iSvVz2V5z0eaBpgkBQ4Lnm6FBIMEURHhtvVsOxaN
 Iipif6o7YoVPgaEfTk6t0BFAGfRBLPqy9M4y8P5/LOgZ6zAjGsuL6b9MmpQI8CrtcYdI
 R1NQ==
X-Gm-Message-State: ANhLgQ2lJ0q1DDYUCAkVwVTxdDF8q6rRwMvn6BB4jhKe6OO80k3zp6Gj
 P+6EReNu3Vpp2bzyg1FzS3NBFdZJWqXD7hC5jZWBjLp1FblSmqX6TJujkat591P3iCugfsm/+Mw
 12YWljim7rC4PiME=
X-Received: by 2002:adf:f14a:: with SMTP id y10mr31395212wro.325.1584317056472; 
 Sun, 15 Mar 2020 17:04:16 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtKqvx1pofLFsHgi5e88usg+4x+zLxOwr4aI+pcqFQa++Zv752HeSdlfFwcnF913ImMvHJEHw==
X-Received: by 2002:adf:f14a:: with SMTP id y10mr31395185wro.325.1584317056249; 
 Sun, 15 Mar 2020 17:04:16 -0700 (PDT)
Received: from localhost.localdomain (191.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.191])
 by smtp.gmail.com with ESMTPSA id n1sm46775573wrj.77.2020.03.15.17.04.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Mar 2020 17:04:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 4/8] qapi/misc: Move query-uuid command with block code
Date: Mon, 16 Mar 2020 01:03:44 +0100
Message-Id: <20200316000348.29692-5-philmd@redhat.com>
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
X-Received-From: 205.139.110.61
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
 qapi/block-core.json | 30 ++++++++++++++++++++++++++++++
 qapi/misc.json       | 30 ------------------------------
 block/iscsi.c        |  2 +-
 stubs/uuid.c         |  2 +-
 4 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 91586fb1fb..5c3fa6c5d0 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -5415,3 +5415,33 @@
 { 'command': 'blockdev-snapshot-delete-internal-sync',
   'data': { 'device': 'str', '*id': 'str', '*name': 'str'},
   'returns': 'SnapshotInfo' }
+
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
+{ 'command': 'query-uuid', 'returns': 'UuidInfo', 'allow-preconfig': true =
}
diff --git a/qapi/misc.json b/qapi/misc.json
index ed28e41229..f70025f34c 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -97,36 +97,6 @@
 ##
 { 'command': 'query-kvm', 'returns': 'KvmInfo' }
=20
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
-{ 'command': 'query-uuid', 'returns': 'UuidInfo', 'allow-preconfig': true =
}
-
 ##
 # @IOThreadInfo:
 #
diff --git a/block/iscsi.c b/block/iscsi.c
index 682abd8e09..68ed5cf3f8 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -42,7 +42,7 @@
 #include "qemu/uuid.h"
 #include "sysemu/replay.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-misc.h"
+#include "qapi/qapi-commands-block-core.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qstring.h"
 #include "crypto/secret.h"
diff --git a/stubs/uuid.c b/stubs/uuid.c
index 67f182fa3a..9ef75fdae4 100644
--- a/stubs/uuid.c
+++ b/stubs/uuid.c
@@ -1,5 +1,5 @@
 #include "qemu/osdep.h"
-#include "qapi/qapi-commands-misc.h"
+#include "qapi/qapi-commands-block-core.h"
 #include "qemu/uuid.h"
=20
 UuidInfo *qmp_query_uuid(Error **errp)
--=20
2.21.1


