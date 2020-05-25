Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3925CC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 15:10:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 006172073B
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 15:10:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VXOjxdxw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 006172073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdEkS-0001ND-2x
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 11:10:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54180)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jdEhC-0005j4-QS
 for qemu-devel@nongnu.org; Mon, 25 May 2020 11:07:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23486
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jdEhC-0006kP-0q
 for qemu-devel@nongnu.org; Mon, 25 May 2020 11:07:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590419237;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xXt/e940KwQ6c6w6CifCzHczNy+4pbZbPt9Qx0gk/SI=;
 b=VXOjxdxwMe6K37nMF0LPawEYjyuxo6Hzr0Q4WCBOQL7V0wrepAVLJHwlVH9r17W8JU3u4+
 S6oEjfavU3f2a71nRn951s9UjAb7UZhdRT+QFvKfZUZ95fv5MjH0sc9Y5eqpAVHfZAYf4l
 /QmAmKB61RZz6bYdmHtCyWTxyjoofj8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-Bff5hubuOL6SqKWPZ1yn6Q-1; Mon, 25 May 2020 11:07:16 -0400
X-MC-Unique: Bff5hubuOL6SqKWPZ1yn6Q-1
Received: by mail-ej1-f72.google.com with SMTP id g9so5685208ejs.20
 for <qemu-devel@nongnu.org>; Mon, 25 May 2020 08:07:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xXt/e940KwQ6c6w6CifCzHczNy+4pbZbPt9Qx0gk/SI=;
 b=BL70TmCi83PYMLMYFxssHqduoJr2eejpbGU9HcblaLaKn/dzOuIcYoLlu8/qM0izNy
 /XB9zHltKfaKd7liBb+jnnaV8GLYRQL4QN9huz04HpgYj3+3wFcuNBBoe7/g1z4H5RVh
 s4TVNpqbCxxNf96lpYsJ/3SKTWLiD2HGluwEYkbxUWnf6cundsebEmU5XiD1kFywqRsm
 H8hzp2V1+H1trLKhPNOV43Ydd9lYE9kZkz/30bNzJEVDQKiv53eaucsyJy2v/+Nl6kRm
 Nx45g5Z70guSBMTkUtUDyqIRPDQSKyd7c1TkB0tO4rdS6KqfSCljhGsFJtIwv+epfnUH
 XcIA==
X-Gm-Message-State: AOAM531BV5SHp2O8IGCD79gQpoL4Y+hf4LugQKaY69Gi6mJ0svGQMVGG
 cLsQIH3HL19kKnfqaR5I2P47oPBqodKPEGZl7dzcQ9Fa3rrHA4ZpdO+MSKGyGBfm16KyHRP5pQX
 2Ze0VffW+M1XF9fg=
X-Received: by 2002:a17:906:eda3:: with SMTP id
 sa3mr20114332ejb.253.1590419234481; 
 Mon, 25 May 2020 08:07:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyR6LUhcd2XfqLF3HQVcuZ0/RkFmoE0jg4G8feEeQRKeyoKJLqbAZEXBP3TgEeNE03L6u9V2A==
X-Received: by 2002:a17:906:eda3:: with SMTP id
 sa3mr20114307ejb.253.1590419234225; 
 Mon, 25 May 2020 08:07:14 -0700 (PDT)
Received: from x1w.redhat.com (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id u17sm6696494ejr.44.2020.05.25.08.07.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2020 08:07:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 5/9] qapi/misc: Restrict query-vm-generation-id command to
 machine code
Date: Mon, 25 May 2020 17:06:36 +0200
Message-Id: <20200525150640.30879-6-philmd@redhat.com>
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

Acked-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 qapi/machine.json | 20 ++++++++++++++++++++
 qapi/misc.json    | 21 ---------------------
 hw/acpi/vmgenid.c |  2 +-
 stubs/vmgenid.c   |  2 +-
 4 files changed, 22 insertions(+), 23 deletions(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index ae42d69495..545ecb9a55 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -421,6 +421,26 @@
 ##
 { 'command': 'query-target', 'returns': 'TargetInfo' }
 
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
index 26b5115638..b43fe7c602 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -1414,24 +1414,3 @@
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
 
 GuidInfo *qmp_query_vm_generation_id(Error **errp)
-- 
2.21.3


