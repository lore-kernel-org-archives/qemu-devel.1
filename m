Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35DCCC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 20:26:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 031A220751
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 20:26:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MhJ7kFSi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 031A220751
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCqsg-0001Km-35
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 16:26:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34200)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jCqrm-0000jC-6F
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 16:25:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jCqrk-0002Vf-0V
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 16:25:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29674
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jCqrj-0002QH-LC
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 16:25:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584131105;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vo3+ii3JGks+EREaSuL0QZJtIf7IDcvFuLgdh6GeUCY=;
 b=MhJ7kFSiqSmhhIzWmmqRTZe7KuPtgW8Z2uKRXjcQKyJ+XcMg6U297zLgXPbn1LDV9haFH2
 q0bB77zfAL0MyLSK72NkscnIXCP5lrE/vsnR+woO2vNIAoxrwLnoaqnFdAT6hXwCxOHHIL
 A3PdZHCKlaSxADB+qoG36F/LXB4/iJk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-d9n7Kzs7PRiCuNEndPOyMQ-1; Fri, 13 Mar 2020 14:42:40 -0400
X-MC-Unique: d9n7Kzs7PRiCuNEndPOyMQ-1
Received: by mail-wr1-f71.google.com with SMTP id n11so4230144wrs.13
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 11:42:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Vd+1ataaoa8axdg0o2XU+CePXzHrmwk/HaCKtdgaSRE=;
 b=Jx2T3iZrQuyHzoDw8AFreP4V5HdYP01WeYd0OReHBqoC3MPQwIFRGyOGhVZamNkfh7
 Muw9ZEwZI5KqwAOAGq3qzK1vSxISc52DUJyih6M4tQCiGHG4qpSiGwkRvWeqw3vLFHSx
 y/SIRC7xqpfu2jTiRKYdMpkIh4bXoglQLiL4O5MVOU/y/fuufkwgFTTaiG2lY5dqfi5C
 gZ0aLVe33iyNpRUK7DvcI+BPhIW6woI1l5LOqUhWg3YbhdyagC4mlo71se2YUodVz0Xo
 FV8ByXLlfryp8hrnDPK2IZxA+I6qMnra1hnandIf4BYw9K3p2Bc6sn6yGVin01PPz1IX
 7/aQ==
X-Gm-Message-State: ANhLgQ3wgj1vceeZbYhrmFRnxSJnLD6gR33FJIaeeYehWY7+g32w/1BP
 jHIvc4MOiyoUiUbLNid7p8r0BsLmYd1bGSBwS1FO4mGbws6+iMmHM57ax7wFgD4M9ppiIwlftvj
 2xO4HTDbqdgc6NzU=
X-Received: by 2002:a1c:4d13:: with SMTP id o19mr12143245wmh.186.1584124945481; 
 Fri, 13 Mar 2020 11:42:25 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vv3STGOfMaDr6dWOTdSGIngDWsSE4G8BpfwXSJXFtNpvajRbbCC1M/j4/nvrw7oPhnIjU6CTQ==
X-Received: by 2002:a1c:4d13:: with SMTP id o19mr12143225wmh.186.1584124945261; 
 Fri, 13 Mar 2020 11:42:25 -0700 (PDT)
Received: from x1w.redhat.com (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id e1sm70015939wrx.90.2020.03.13.11.42.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2020 11:42:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 6/9] qapi/misc: Restrict query-vm-generation-id command to
 machine code
Date: Fri, 13 Mar 2020 19:41:50 +0100
Message-Id: <20200313184153.11275-7-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200313184153.11275-1-philmd@redhat.com>
References: <20200313184153.11275-1-philmd@redhat.com>
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
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Ben Warren <ben@skyportsystems.com>, Peter Lieven <pl@kamp.de>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Igor Mammedov <imammedo@redhat.com>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Richard Henderson <rth@twiddle.net>
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
index 18cd0719f3..8e0902caf4 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -1351,24 +1351,3 @@
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


