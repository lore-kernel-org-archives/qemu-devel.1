Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27276C10F29
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 00:57:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA428205C9
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 00:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ddvGLv8d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA428205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDe4L-00018i-OP
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 20:57:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50398)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jDdF9-0005em-1a
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 20:04:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jDdF5-0002F0-TI
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 20:04:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42326
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jDdF5-0002Du-Oi
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 20:04:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584317067;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5c3AP4dCqr/JYmuW7VACTlM9zAn3OSBe4Qe02woopcU=;
 b=ddvGLv8d5g7gUHE5i0U+y7+9nzWwgmOhP6sOyoPNIDgYjJYg0WzoPIvao//5RZHAM3mEm7
 HNpeQFE2QF6rIYp2sTXYPJdOdmeHlt4sZh0A5szagjUDHS+eo+IS7T6Kf936REbSU0tabf
 rTRKjltxHnQcnQermL42UJN0PGrvBzs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-28-T1XuSAnXM3KCIwejvaVLGw-1; Sun, 15 Mar 2020 20:04:25 -0400
X-MC-Unique: T1XuSAnXM3KCIwejvaVLGw-1
Received: by mail-wr1-f71.google.com with SMTP id b11so8114713wru.21
 for <qemu-devel@nongnu.org>; Sun, 15 Mar 2020 17:04:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=As7NmJnDnIsu20eII7dWc1UjdLn2Uy7aENYZvKmI5xw=;
 b=D2YCO2wc/aeAZ2wJB43m3XDXSZK6ZYvTN2z5z6mb1FMKlgbp70ii9deMIJvF83YqMm
 D7ZKmnkGNRFdL+4u2DN4lAVkRdiRyujFROMEoJflBaB9wlpKnxROId864N1E0huCgTLl
 eogGtJ5FYBRt1TeoDWTp0fDw6ZXPPPFcRGDahec5bzeH7h2zr8PTiK9PB0R0PlAIRFsF
 HvcPPBf3a+UKOKUDmUPLVhQ7aU++z4/p6gIVXoqbQmRNe3zuMUqiuiMvFQQSPQ8n2h6I
 ZtRa84dN2TqhI+za/ObhdL4LuQi2s7xbYSkhQ6ilEYUtWWyG6MirCsA8Su2DreLNCF8+
 udmQ==
X-Gm-Message-State: ANhLgQ3csy/5n/XCtlLOhJB2If6bqJ3VtEmFSrzzOqu+GTX/pZG7IKk3
 Vekqh0wT+kXRKpC8xHMYP1U6eDmgH6Z8XT3Yc7RBLQ39TTneXAHTP7x3Bc262zVk9DP7bbI0XcT
 iPVemlDfDgYSp2Bw=
X-Received: by 2002:a7b:c62a:: with SMTP id p10mr22230589wmk.46.1584317062935; 
 Sun, 15 Mar 2020 17:04:22 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vttvp5kRhN9QfKl14vBeBOqKErrdHavGr80+m6zOl/+lfkEiMTtgrSQO19sW/NdCLzx3/kFTQ==
X-Received: by 2002:a7b:c62a:: with SMTP id p10mr22230559wmk.46.1584317062758; 
 Sun, 15 Mar 2020 17:04:22 -0700 (PDT)
Received: from localhost.localdomain (191.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.191])
 by smtp.gmail.com with ESMTPSA id j15sm52742816wrp.85.2020.03.15.17.04.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Mar 2020 17:04:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 5/8] qapi/misc: Restrict query-vm-generation-id command to
 machine code
Date: Mon, 16 Mar 2020 01:03:45 +0100
Message-Id: <20200316000348.29692-6-philmd@redhat.com>
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
X-Received-From: 205.139.110.120
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
 qapi/machine.json | 20 ++++++++++++++++++++
 qapi/misc.json    | 21 ---------------------
 hw/acpi/vmgenid.c |  2 +-
 stubs/vmgenid.c   |  2 +-
 4 files changed, 22 insertions(+), 23 deletions(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index c096efbea3..1a2a4b0d48 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -415,6 +415,26 @@
 ##
 { 'command': 'query-target', 'returns': 'TargetInfo' }
=20
+##
+# @GuidInfo:
+#
+# GUID information.
+#
+# @guid: the globally unique identifier
+#
+# Since: 2.9
+##
+{ 'struct': 'GuidInfo', 'data': {'guid': 'str'} }
+
+##
+# @query-vm-generation-id:
+#
+# Show Virtual Machine Generation ID
+#
+# Since: 2.9
+##
+{ 'command': 'query-vm-generation-id', 'returns': 'GuidInfo' }
+
 ##
 # @LostTickPolicy:
 #
diff --git a/qapi/misc.json b/qapi/misc.json
index f70025f34c..8c02870227 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -1383,24 +1383,3 @@
 #
 ##
 { 'command': 'xen-load-devices-state', 'data': {'filename': 'str'} }
-
-##
-# @GuidInfo:
-#
-# GUID information.
-#
-# @guid: the globally unique identifier
-#
-# Since: 2.9
-##
-{ 'struct': 'GuidInfo', 'data': {'guid': 'str'} }
-
-##
-# @query-vm-generation-id:
-#
-# Show Virtual Machine Generation ID
-#
-# Since: 2.9
-##
-{ 'command': 'query-vm-generation-id', 'returns': 'GuidInfo' }
-
diff --git a/hw/acpi/vmgenid.c b/hw/acpi/vmgenid.c
index 2df7623d74..2b26bacaf8 100644
--- a/hw/acpi/vmgenid.c
+++ b/hw/acpi/vmgenid.c
@@ -12,7 +12,7 @@
=20
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-misc.h"
+#include "qapi/qapi-commands-machine.h"
 #include "qemu/module.h"
 #include "hw/acpi/acpi.h"
 #include "hw/acpi/aml-build.h"
diff --git a/stubs/vmgenid.c b/stubs/vmgenid.c
index 568e42b064..bfad656c6c 100644
--- a/stubs/vmgenid.c
+++ b/stubs/vmgenid.c
@@ -1,6 +1,6 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-misc.h"
+#include "qapi/qapi-commands-machine.h"
 #include "qapi/qmp/qerror.h"
=20
 GuidInfo *qmp_query_vm_generation_id(Error **errp)
--=20
2.21.1


