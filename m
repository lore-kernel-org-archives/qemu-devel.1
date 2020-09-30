Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 999A7C4727E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 16:52:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2FE9206C9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 16:52:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iWg0VkDQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2FE9206C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNfL6-00083K-6p
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 12:52:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39482)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kNfIp-0006Df-A9
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 12:50:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30598)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kNfIn-00071s-7p
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 12:50:02 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601484600;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t9PkhQUDB8JuhjSbOPN2bvdjEcF2wLsH4GMRziMp5uI=;
 b=iWg0VkDQPs1kdOhsIrFqrfFNHXq9G+hFgW2Pb6ow/ZheOMkGGk0QNHzruHQb2UQ9wvJNq0
 im4OhzbU5RAhynj738XpvbBgadu4V6RPBg8KlEWCZkQIE28lH4IFeXLEB4m4uilf5sNk6z
 3zxpxfWZ5wc8oYq+ARGrV0kN7tpZAME=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-528-kdSimYrTPIq4JdLYGPAHfQ-1; Wed, 30 Sep 2020 12:49:58 -0400
X-MC-Unique: kdSimYrTPIq4JdLYGPAHfQ-1
Received: by mail-wr1-f69.google.com with SMTP id b7so831174wrn.6
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2020 09:49:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=t9PkhQUDB8JuhjSbOPN2bvdjEcF2wLsH4GMRziMp5uI=;
 b=lH2OOSx9q9fXBIGVlS6N75z6lPVvQMibrfcYc8ODIaljBqsIldG2gf2LJ/xVU47rvY
 0TvoSCQT3FtkpE+dUNHfPmn0bfJtgyjWhK2Oba7/JKC/NH3F+nrrmWjXyFwGY07S48a5
 y/ql4PH+zLHNRm8y2+oaI5w9PJWm7RMPUO5BzGBjs7MMPVgUJ8nHprfRq8XfOr2X08Eh
 QSz0AGNY9ZDJRJUOKVIItx4WupwOR677G5qLHSLMgdWLeUv5Wft/o/l/F3vt2iPaQmIr
 EEj8f8OsSIWzEeYbnYpkI35jWge9UY6DT5SQ7iPKaEiugRNpiMnEm79pLFVIzH3gXvlV
 TB5A==
X-Gm-Message-State: AOAM530YwNV2q0StGRVs4r3JtEoNIpf95+R1mI+BlMbDqYB8G4yGn95D
 JDPXdDHwKG+Zap0x4PoDCY15u6hyZIvfLPRYy9XQVoTm8VTUVY5E8oZyOHfEGQ5Ceq+jU2Bjpn+
 VGGn3pHKlo2RkZfs=
X-Received: by 2002:a7b:cb07:: with SMTP id u7mr3874748wmj.57.1601484597005;
 Wed, 30 Sep 2020 09:49:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxr+ox58eHgr/ILmlGB8SkqVhKIHFrE3cjygC8QQU/qJFwgMJvYj8KmrspHkiXM219VdOR7Bw==
X-Received: by 2002:a7b:cb07:: with SMTP id u7mr3874713wmj.57.1601484596741;
 Wed, 30 Sep 2020 09:49:56 -0700 (PDT)
Received: from x1w.redhat.com (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id m18sm4062428wmg.32.2020.09.30.09.49.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2020 09:49:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org,
	Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v3 01/11] qapi: Restrict query-uuid command to block code
Date: Wed, 30 Sep 2020 18:49:39 +0200
Message-Id: <20200930164949.1425294-2-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200930164949.1425294-1-philmd@redhat.com>
References: <20200930164949.1425294-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:31:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.469,
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Peter Lieven <pl@kamp.de>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In commit f68c01470b we restricted the query-uuid command to
machine code, but it is incorrect, as it is also used by the
tools.  Therefore move this command again, but to block.json,
which is shared by machine code and tools.

Fixes: f68c01470b ("qapi: Restrict query-uuid command to machine code")
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 qapi/block.json   | 30 ++++++++++++++++++++++++++++++
 qapi/machine.json | 30 ------------------------------
 block/iscsi.c     |  2 +-
 stubs/uuid.c      |  2 +-
 stubs/meson.build |  4 +++-
 5 files changed, 35 insertions(+), 33 deletions(-)

diff --git a/qapi/block.json b/qapi/block.json
index a009f7d3a2..4ae1716b56 100644
--- a/qapi/block.json
+++ b/qapi/block.json
@@ -11,6 +11,36 @@
 # == Additional block stuff (VM related)
 ##
 
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
 # @BiosAtaTranslation:
 #
diff --git a/qapi/machine.json b/qapi/machine.json
index 756dacb06f..72f014bb5b 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -402,36 +402,6 @@
 ##
 { 'command': 'query-target', 'returns': 'TargetInfo' }
 
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
 # @GuidInfo:
 #
diff --git a/block/iscsi.c b/block/iscsi.c
index e30a7e3606..1effea25ed 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -42,7 +42,7 @@
 #include "qemu/uuid.h"
 #include "sysemu/replay.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-machine.h"
+#include "qapi/qapi-commands-block.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qstring.h"
 #include "crypto/secret.h"
diff --git a/stubs/uuid.c b/stubs/uuid.c
index e5112eb3f6..d6bfb442e0 100644
--- a/stubs/uuid.c
+++ b/stubs/uuid.c
@@ -1,5 +1,5 @@
 #include "qemu/osdep.h"
-#include "qapi/qapi-commands-machine.h"
+#include "qapi/qapi-commands-block.h"
 #include "qemu/uuid.h"
 
 UuidInfo *qmp_query_uuid(Error **errp)
diff --git a/stubs/meson.build b/stubs/meson.build
index e0b322bc28..2e231590e1 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -39,7 +39,9 @@ stub_ss.add(files('target-get-monitor-def.c'))
 stub_ss.add(files('target-monitor-defs.c'))
 stub_ss.add(files('tpm.c'))
 stub_ss.add(files('trace-control.c'))
-stub_ss.add(files('uuid.c'))
+if have_block
+  stub_ss.add(files('uuid.c'))
+endif
 stub_ss.add(files('vmgenid.c'))
 stub_ss.add(files('vmstate.c'))
 stub_ss.add(files('vm-stop.c'))
-- 
2.26.2


