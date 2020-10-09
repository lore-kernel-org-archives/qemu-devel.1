Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C97C433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 16:18:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 155A72227E
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 16:18:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AWei3Cgh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 155A72227E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQv6S-0005qo-21
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 12:18:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34364)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kQv46-0003vX-Ak
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 12:16:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21859)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kQv42-0003FH-Cg
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 12:16:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602260173;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XgT1fGOUL4jL/DLtb47u7sZvwkz25A0LYeYu8H3PXls=;
 b=AWei3Cgh4DnqD5DIU1S7KWpcPDUrDABG4XKtc2IcqUp4Tw5CKMclJ2Z1F26pnSzKSotIXA
 XSydkads5Bua0P/V5d3DCUcCzDmlohoWco4+PtajsISyApEs6e0NaTuTbme3q17T0eoXsY
 7cF1Lp2hwQqlkAAt1zeWn6893VH9L10=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-338-pD6x0s0UNoKmO7ZhM0VZFA-1; Fri, 09 Oct 2020 12:16:09 -0400
X-MC-Unique: pD6x0s0UNoKmO7ZhM0VZFA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BB6FB18A8234;
 Fri,  9 Oct 2020 16:16:08 +0000 (UTC)
Received: from scv.redhat.com (ovpn-112-203.rdu2.redhat.com [10.10.112.203])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E63A919936;
 Fri,  9 Oct 2020 16:16:07 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 06/36] qapi: Remove wildcard includes
Date: Fri,  9 Oct 2020 12:15:28 -0400
Message-Id: <20201009161558.107041-7-jsnow@redhat.com>
In-Reply-To: <20201009161558.107041-1-jsnow@redhat.com>
References: <20201009161558.107041-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 02:34:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, John Snow <jsnow@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Wildcard includes become hard to manage when refactoring and dealing
with circular dependencies with strictly typed mypy.

flake8 also flags each one as a warning, as it is not smart enough to
know which names exist in the imported file.

Remove them and include things explicitly by name instead.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Cleber Rosa <crosa@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 scripts/qapi/commands.py   |  2 +-
 scripts/qapi/events.py     |  7 ++++++-
 scripts/qapi/gen.py        | 12 +++++++++---
 scripts/qapi/introspect.py |  7 ++++++-
 scripts/qapi/types.py      |  8 +++++++-
 scripts/qapi/visit.py      | 10 +++++++++-
 6 files changed, 38 insertions(+), 8 deletions(-)

diff --git a/scripts/qapi/commands.py b/scripts/qapi/commands.py
index 1f43a0a34ef..e06c10afcd0 100644
--- a/scripts/qapi/commands.py
+++ b/scripts/qapi/commands.py
@@ -13,7 +13,7 @@
 See the COPYING file in the top-level directory.
 """
 
-from .common import *
+from .common import build_params, c_name, mcgen
 from .gen import QAPIGenCCode, QAPISchemaModularCVisitor, ifcontext
 
 
diff --git a/scripts/qapi/events.py b/scripts/qapi/events.py
index 04672724388..6b3afa14d72 100644
--- a/scripts/qapi/events.py
+++ b/scripts/qapi/events.py
@@ -12,7 +12,12 @@
 See the COPYING file in the top-level directory.
 """
 
-from .common import *
+from .common import (
+    build_params,
+    c_enum_const,
+    c_name,
+    mcgen,
+)
 from .gen import QAPISchemaModularCVisitor, ifcontext
 from .schema import QAPISchemaEnumMember
 from .types import gen_enum, gen_enum_lookup
diff --git a/scripts/qapi/gen.py b/scripts/qapi/gen.py
index fc57fdca5b9..1fed712b43b 100644
--- a/scripts/qapi/gen.py
+++ b/scripts/qapi/gen.py
@@ -11,13 +11,19 @@
 # This work is licensed under the terms of the GNU GPL, version 2.
 # See the COPYING file in the top-level directory.
 
-
+from contextlib import contextmanager
 import errno
 import os
 import re
-from contextlib import contextmanager
 
-from .common import *
+from .common import (
+    c_fname,
+    gen_endif,
+    gen_if,
+    guardend,
+    guardstart,
+    mcgen,
+)
 from .schema import QAPISchemaVisitor
 
 
diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
index 6c82d9d95f5..42016a7e668 100644
--- a/scripts/qapi/introspect.py
+++ b/scripts/qapi/introspect.py
@@ -10,7 +10,12 @@
 See the COPYING file in the top-level directory.
 """
 
-from .common import *
+from .common import (
+    c_name,
+    gen_endif,
+    gen_if,
+    mcgen,
+)
 from .gen import QAPISchemaMonolithicCVisitor
 from .schema import (QAPISchemaArrayType, QAPISchemaBuiltinType,
                      QAPISchemaType)
diff --git a/scripts/qapi/types.py b/scripts/qapi/types.py
index ca9a5aacb39..53b47f9e58a 100644
--- a/scripts/qapi/types.py
+++ b/scripts/qapi/types.py
@@ -13,7 +13,13 @@
 # See the COPYING file in the top-level directory.
 """
 
-from .common import *
+from .common import (
+    c_enum_const,
+    c_name,
+    gen_endif,
+    gen_if,
+    mcgen,
+)
 from .gen import QAPISchemaModularCVisitor, ifcontext
 from .schema import QAPISchemaEnumMember, QAPISchemaObjectType
 
diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
index 7850f6e8480..ea277e7704b 100644
--- a/scripts/qapi/visit.py
+++ b/scripts/qapi/visit.py
@@ -13,7 +13,15 @@
 See the COPYING file in the top-level directory.
 """
 
-from .common import *
+from .common import (
+    c_enum_const,
+    c_name,
+    gen_endif,
+    gen_if,
+    mcgen,
+    pop_indent,
+    push_indent,
+)
 from .gen import QAPISchemaModularCVisitor, ifcontext
 from .schema import QAPISchemaObjectType
 
-- 
2.26.2


