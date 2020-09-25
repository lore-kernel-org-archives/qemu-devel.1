Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A83BCC4346E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 00:46:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13B61238D6
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 00:46:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RZCspB+L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13B61238D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLbt0-0001SK-1x
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 20:46:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51096)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kLbbz-0000rt-75
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 20:29:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28037)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kLbbu-00009Q-QZ
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 20:29:18 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600993754;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XBSqE+opm+aIyVTm4B6tgJWmGKe1lqAup8qByI8y/+Q=;
 b=RZCspB+Luv6pFWKXXVSMWbE/YeP4Xk2SyM14/sX4ZRKV71iNM3iLRN/1Rl8M+R3BqGtQnw
 g4AI21orV2keETNydiR3+cnN7W9w26e4QBp+oRRJj8KJznYWS2oasyPvG+ZSjgjc8NBxVp
 wnRIjLbgenT0qQzfEax15S1XuT/NNvM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-ERnVmA4tPI-DTvjQ-fsRDA-1; Thu, 24 Sep 2020 20:29:11 -0400
X-MC-Unique: ERnVmA4tPI-DTvjQ-fsRDA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 66EDC801002
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 00:29:10 +0000 (UTC)
Received: from scv.redhat.com (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C2B8E5D9DD;
 Fri, 25 Sep 2020 00:29:09 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 10/47] qapi: Prefer explicit relative imports
Date: Thu, 24 Sep 2020 20:28:23 -0400
Message-Id: <20200925002900.465855-11-jsnow@redhat.com>
In-Reply-To: <20200925002900.465855-1-jsnow@redhat.com>
References: <20200925002900.465855-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
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
Cc: John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

All of the QAPI include statements are changed to be package-aware, as
explicit relative imports.

A quirk of Python packages is that the name of the package exists only
*outside* of the package. This means that to a module inside of the qapi
folder, there is inherently no such thing as the "qapi" package. The
reason these imports work is because the "qapi" package exists in the
context of the caller -- the execution shim, where sys.path includes a
directory that has a 'qapi' folder in it.

When we write "from qapi import sibling", we are NOT referencing the folder
'qapi', but rather "any package named qapi in sys.path". If you should
so happen to have a 'qapi' package in your path, it will use *that*
package.

When we write "from .sibling import foo", we always reference explicitly
our sibling module; guaranteeing consistency in *where* we are importing
these modules from.

This can be useful when working with virtual environments and packages
in development mode. In development mode, a package is installed as a
series of symlinks that forwards to your same source files. The problem
arises because code quality checkers will follow "import qapi.x" to the
"installed" version instead of the sibling file and -- even though they
are the same file -- they have different module paths, and this causes
cyclic import problems, false positive type mismatch errors, and more.

It can also be useful when dealing with hierarchical packages, e.g. if
we allow qemu.core.qmp, qemu.qapi.parser, etc.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Cleber Rosa <crosa@redhat.com>
---
 scripts/qapi/commands.py   |  4 ++--
 scripts/qapi/doc.py        |  2 +-
 scripts/qapi/events.py     |  8 ++++----
 scripts/qapi/expr.py       |  4 ++--
 scripts/qapi/gen.py        |  4 ++--
 scripts/qapi/introspect.py |  8 ++++----
 scripts/qapi/main.py       | 16 ++++++++--------
 scripts/qapi/parser.py     |  4 ++--
 scripts/qapi/schema.py     |  8 ++++----
 scripts/qapi/types.py      |  6 +++---
 scripts/qapi/visit.py      |  6 +++---
 11 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/scripts/qapi/commands.py b/scripts/qapi/commands.py
index 3cf9e1110b..ce5926146a 100644
--- a/scripts/qapi/commands.py
+++ b/scripts/qapi/commands.py
@@ -13,8 +13,8 @@
 See the COPYING file in the top-level directory.
 """
 
-from qapi.common import *
-from qapi.gen import QAPIGenCCode, QAPISchemaModularCVisitor, ifcontext
+from .common import *
+from .gen import QAPIGenCCode, QAPISchemaModularCVisitor, ifcontext
 
 
 def gen_command_decl(name, arg_type, boxed, ret_type):
diff --git a/scripts/qapi/doc.py b/scripts/qapi/doc.py
index d12eda9e1e..b764a8ccc0 100644
--- a/scripts/qapi/doc.py
+++ b/scripts/qapi/doc.py
@@ -5,7 +5,7 @@
 """This script produces the documentation of a qapi schema in texinfo format"""
 
 import re
-from qapi.gen import QAPIGenDoc, QAPISchemaVisitor
+from .gen import QAPIGenDoc, QAPISchemaVisitor
 
 
 _MSG = '''
diff --git a/scripts/qapi/events.py b/scripts/qapi/events.py
index b544af5a1c..0467272438 100644
--- a/scripts/qapi/events.py
+++ b/scripts/qapi/events.py
@@ -12,10 +12,10 @@
 See the COPYING file in the top-level directory.
 """
 
-from qapi.common import *
-from qapi.gen import QAPISchemaModularCVisitor, ifcontext
-from qapi.schema import QAPISchemaEnumMember
-from qapi.types import gen_enum, gen_enum_lookup
+from .common import *
+from .gen import QAPISchemaModularCVisitor, ifcontext
+from .schema import QAPISchemaEnumMember
+from .types import gen_enum, gen_enum_lookup
 
 
 def build_event_send_proto(name, arg_type, boxed):
diff --git a/scripts/qapi/expr.py b/scripts/qapi/expr.py
index 2942520399..03b31ecfc1 100644
--- a/scripts/qapi/expr.py
+++ b/scripts/qapi/expr.py
@@ -16,8 +16,8 @@
 
 import re
 from collections import OrderedDict
-from qapi.common import c_name
-from qapi.error import QAPISemError
+from .common import c_name
+from .error import QAPISemError
 
 
 # Names must be letters, numbers, -, and _.  They must start with letter,
diff --git a/scripts/qapi/gen.py b/scripts/qapi/gen.py
index 3d25a8cff4..f82ce9b661 100644
--- a/scripts/qapi/gen.py
+++ b/scripts/qapi/gen.py
@@ -17,8 +17,8 @@
 import re
 from contextlib import contextmanager
 
-from qapi.common import *
-from qapi.schema import QAPISchemaVisitor
+from .common import *
+from .schema import QAPISchemaVisitor
 
 
 class QAPIGen:
diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
index 23652be810..2a34cd1e8e 100644
--- a/scripts/qapi/introspect.py
+++ b/scripts/qapi/introspect.py
@@ -10,10 +10,10 @@
 See the COPYING file in the top-level directory.
 """
 
-from qapi.common import *
-from qapi.gen import QAPISchemaMonolithicCVisitor
-from qapi.schema import (QAPISchemaArrayType, QAPISchemaBuiltinType,
-                         QAPISchemaType)
+from .common import *
+from .gen import QAPISchemaMonolithicCVisitor
+from .schema import (QAPISchemaArrayType, QAPISchemaBuiltinType,
+                     QAPISchemaType)
 
 
 def _make_tree(obj, ifcond, features, extra=None):
diff --git a/scripts/qapi/main.py b/scripts/qapi/main.py
index 18c246bbb4..3f8338ade8 100644
--- a/scripts/qapi/main.py
+++ b/scripts/qapi/main.py
@@ -11,14 +11,14 @@
 import re
 import sys
 
-from qapi.commands import gen_commands
-from qapi.doc import gen_doc
-from qapi.error import QAPIError
-from qapi.events import gen_events
-from qapi.introspect import gen_introspect
-from qapi.schema import QAPISchema
-from qapi.types import gen_types
-from qapi.visit import gen_visit
+from .commands import gen_commands
+from .doc import gen_doc
+from .error import QAPIError
+from .events import gen_events
+from .introspect import gen_introspect
+from .schema import QAPISchema
+from .types import gen_types
+from .visit import gen_visit
 
 
 DEFAULT_OUTPUT_DIR = ''
diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index 00738cea8c..76d28c1ce9 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -18,8 +18,8 @@
 import re
 from collections import OrderedDict
 
-from qapi.error import QAPIParseError, QAPISemError
-from qapi.source import QAPISourceInfo
+from .error import QAPIParseError, QAPISemError
+from .source import QAPISourceInfo
 
 
 class QAPISchemaParser:
diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index 78309a00f0..a835ee6fde 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -18,10 +18,10 @@
 import re
 from collections import OrderedDict
 
-from qapi.common import c_name, pointer_suffix
-from qapi.error import QAPIError, QAPISemError
-from qapi.expr import check_exprs
-from qapi.parser import QAPISchemaParser
+from .common import c_name, pointer_suffix
+from .error import QAPIError, QAPISemError
+from .expr import check_exprs
+from .parser import QAPISchemaParser
 
 
 class QAPISchemaEntity:
diff --git a/scripts/qapi/types.py b/scripts/qapi/types.py
index 3640f17cd6..ca9a5aacb3 100644
--- a/scripts/qapi/types.py
+++ b/scripts/qapi/types.py
@@ -13,9 +13,9 @@
 # See the COPYING file in the top-level directory.
 """
 
-from qapi.common import *
-from qapi.gen import QAPISchemaModularCVisitor, ifcontext
-from qapi.schema import QAPISchemaEnumMember, QAPISchemaObjectType
+from .common import *
+from .gen import QAPISchemaModularCVisitor, ifcontext
+from .schema import QAPISchemaEnumMember, QAPISchemaObjectType
 
 
 # variants must be emitted before their container; track what has already
diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
index cdabc5fa28..7850f6e848 100644
--- a/scripts/qapi/visit.py
+++ b/scripts/qapi/visit.py
@@ -13,9 +13,9 @@
 See the COPYING file in the top-level directory.
 """
 
-from qapi.common import *
-from qapi.gen import QAPISchemaModularCVisitor, ifcontext
-from qapi.schema import QAPISchemaObjectType
+from .common import *
+from .gen import QAPISchemaModularCVisitor, ifcontext
+from .schema import QAPISchemaObjectType
 
 
 def gen_visit_decl(name, scalar=False):
-- 
2.26.2


