Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81931C4CECE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 18:53:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 537DD20658
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 18:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PTVXv2Ss"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 537DD20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCpQv-0002t0-Gy
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 14:53:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59034)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jCpG8-00015Z-DR
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 14:42:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jCpG7-0005DD-7W
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 14:42:12 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:43245
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jCpG7-0005Bq-32
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 14:42:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584124930;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gB6GZqgn898T5lEn2dO+WgYcEg7ajywrV26pIieifgY=;
 b=PTVXv2SsdQj8yI2wJ4EvG6UqAnFEdhmjjD68UK6dFE1rTSeAdyFsiIHi+X8XHySLg48cb2
 FjdZERQfWAU3i7AhfyArgstI6AU+Ejz2N8M9lEqNU33pNmxtEr657nZEjT3wbF0np0uS1u
 YW5ClfFSvKN0RulDclkO0Jg+znIwOZs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-RPQNmPpNMYiBRpXSDIxj2w-1; Fri, 13 Mar 2020 14:42:07 -0400
X-MC-Unique: RPQNmPpNMYiBRpXSDIxj2w-1
Received: by mail-wm1-f71.google.com with SMTP id f9so1729508wme.7
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 11:42:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=o8NYWim6/Yd9aExraYkJVT9nhkAtGbxd6mTZNaLxBUc=;
 b=UNM+cvT9KmFgaInwNoJHO2e3/lAZfonj99QcHS5yA+WhQrcfX5JjtXGoJ142u84UYL
 Co4OZqFm6ZSCOGSbFcAM1a7gXYzMrYB3kNcNWVUG0yh4QbrEkDWfV7orPnSXe2otzunC
 K5bX558rINwc2ChLPYZ3kWVXAO52O/yRjaG1WgFyYMgn+nCJJxJGsS4b0EVEPsCrQfOE
 TPGD4DbyPiG/j1QXGrjRsjEkJNbPHijpVvkB3Um4f8/YadXMN94A5s/cbz7P86KN7X6+
 DJAnenlvZURKh1JzFfEPPr+ggFXuGE6f/Lzcl74Kxq0sUChi5CdvtJQIS+/v9rQyZX5J
 KIoQ==
X-Gm-Message-State: ANhLgQ3CsP9na/NjQmyPZLKpSzkgDX7xanRkupz/Fw/wm6Mj6GPPhRvw
 pTkraNWW42vfOtQh2j5149eRjEZtKvvmDf4heui0uUA9b55S2Z5dOj3G7zuY4yDOZH+RrEW96q7
 pPtLBRpLhm3FkxnE=
X-Received: by 2002:a05:600c:2c4a:: with SMTP id
 r10mr12491412wmg.32.1584124925415; 
 Fri, 13 Mar 2020 11:42:05 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vschwfV0QpBwrB08rFODD3V2lE2SuNkAUoFXtgXuLIe7krN99M3zz/hJayDJL70d0loTZ2dQA==
X-Received: by 2002:a05:600c:2c4a:: with SMTP id
 r10mr12491370wmg.32.1584124925123; 
 Fri, 13 Mar 2020 11:42:05 -0700 (PDT)
Received: from x1w.redhat.com (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id k18sm30787429wru.94.2020.03.13.11.42.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2020 11:42:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/9] qapi/misc: Move add_client command with chardev code
Date: Fri, 13 Mar 2020 19:41:46 +0100
Message-Id: <20200313184153.11275-3-philmd@redhat.com>
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
X-Received-From: 207.211.31.81
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
 qapi/char.json     | 32 ++++++++++++++++++++++++++++++++
 qapi/misc.json     | 32 --------------------------------
 monitor/qmp-cmds.c |  1 +
 3 files changed, 33 insertions(+), 32 deletions(-)

diff --git a/qapi/char.json b/qapi/char.json
index 6907b2bfdb..8b7baf11eb 100644
--- a/qapi/char.json
+++ b/qapi/char.json
@@ -572,3 +572,35 @@
 { 'event': 'VSERPORT_CHANGE',
   'data': { 'id': 'str',
             'open': 'bool' } }
+
+##
+# @add_client:
+#
+# Allow client connections for VNC, Spice and socket based
+# character devices to be passed in to QEMU via SCM_RIGHTS.
+#
+# @protocol: protocol name. Valid names are "vnc", "spice" or the
+#            name of a character device (eg. from -chardev id=3DXXXX)
+#
+# @fdname: file descriptor name previously passed via 'getfd' command
+#
+# @skipauth: whether to skip authentication. Only applies
+#            to "vnc" and "spice" protocols
+#
+# @tls: whether to perform TLS. Only applies to the "spice"
+#       protocol
+#
+# Returns: nothing on success.
+#
+# Since: 0.14.0
+#
+# Example:
+#
+# -> { "execute": "add_client", "arguments": { "protocol": "vnc",
+#                                              "fdname": "myclient" } }
+# <- { "return": {} }
+#
+##
+{ 'command': 'add_client',
+  'data': { 'protocol': 'str', 'fdname': 'str', '*skipauth': 'bool',
+            '*tls': 'bool' } }
diff --git a/qapi/misc.json b/qapi/misc.json
index c18fe681fb..e84e6823e9 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -39,38 +39,6 @@
 { 'enum': 'LostTickPolicy',
   'data': ['discard', 'delay', 'slew' ] }
=20
-##
-# @add_client:
-#
-# Allow client connections for VNC, Spice and socket based
-# character devices to be passed in to QEMU via SCM_RIGHTS.
-#
-# @protocol: protocol name. Valid names are "vnc", "spice" or the
-#            name of a character device (eg. from -chardev id=3DXXXX)
-#
-# @fdname: file descriptor name previously passed via 'getfd' command
-#
-# @skipauth: whether to skip authentication. Only applies
-#            to "vnc" and "spice" protocols
-#
-# @tls: whether to perform TLS. Only applies to the "spice"
-#       protocol
-#
-# Returns: nothing on success.
-#
-# Since: 0.14.0
-#
-# Example:
-#
-# -> { "execute": "add_client", "arguments": { "protocol": "vnc",
-#                                              "fdname": "myclient" } }
-# <- { "return": {} }
-#
-##
-{ 'command': 'add_client',
-  'data': { 'protocol': 'str', 'fdname': 'str', '*skipauth': 'bool',
-            '*tls': 'bool' } }
-
 ##
 # @NameInfo:
 #
diff --git a/monitor/qmp-cmds.c b/monitor/qmp-cmds.c
index 864cbfa32e..67d95b4af7 100644
--- a/monitor/qmp-cmds.c
+++ b/monitor/qmp-cmds.c
@@ -31,6 +31,7 @@
 #include "sysemu/block-backend.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-block.h"
+#include "qapi/qapi-commands-char.h"
 #include "qapi/qapi-commands-control.h"
 #include "qapi/qapi-commands-machine.h"
 #include "qapi/qapi-commands-misc.h"
--=20
2.21.1


