Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 658FDC433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 22:53:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E777320770
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 22:53:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wairr/tt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E777320770
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIJp4-000537-Q2
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 18:53:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59458)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kIJdd-0007G0-58
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 18:41:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20259)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kIJdb-0002gT-2g
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 18:41:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600209682;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yk7qdnfo2EkoVtbV2vkLhMfyH9Zy0jgdEoRibxlIgcE=;
 b=Wairr/ttjzROSbvkXNn7+lryeOpiSf9+l77WqjRWDuGtdNlHBnPPvd/lhfm0xVy9W4bW4Z
 6d12M4fOEZoz4SibaCfejvJCm968sNeIm7RxOFNfKxuZDnM9qvt/Mdd7o8G6uxgQfnNSbB
 rW1/dQ7Oos7HJgq76uIUx1ylqG5MU5Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-469-ia1w7tamPdOejf3_fwA3rw-1; Tue, 15 Sep 2020 18:41:19 -0400
X-MC-Unique: ia1w7tamPdOejf3_fwA3rw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 05C8718BE19A;
 Tue, 15 Sep 2020 22:41:02 +0000 (UTC)
Received: from scv.redhat.com (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1704D81F4F;
 Tue, 15 Sep 2020 22:41:00 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 16/37] qapi: establish mypy type-checking baseline
Date: Tue, 15 Sep 2020 18:40:06 -0400
Message-Id: <20200915224027.2529813-17-jsnow@redhat.com>
In-Reply-To: <20200915224027.2529813-1-jsnow@redhat.com>
References: <20200915224027.2529813-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 02:10:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
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
Cc: John Snow <jsnow@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix two very minor issues, and then establish a mypy type-checking
baseline.

Like pylint, this should be run from the folder above:

 > mypy --config-file=qapi/mypy.ini qapi/

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/doc.py    |  3 +-
 scripts/qapi/mypy.ini  | 65 ++++++++++++++++++++++++++++++++++++++++++
 scripts/qapi/schema.py |  3 +-
 3 files changed, 69 insertions(+), 2 deletions(-)
 create mode 100644 scripts/qapi/mypy.ini

diff --git a/scripts/qapi/doc.py b/scripts/qapi/doc.py
index cbf7076ed9..70f7cdfaa6 100644
--- a/scripts/qapi/doc.py
+++ b/scripts/qapi/doc.py
@@ -5,7 +5,8 @@
 """This script produces the documentation of a qapi schema in texinfo format"""
 
 import re
-from .gen import QAPIGenDoc, QAPISchemaVisitor
+from .gen import QAPIGenDoc
+from .schema import QAPISchemaVisitor
 
 
 MSG_FMT = """
diff --git a/scripts/qapi/mypy.ini b/scripts/qapi/mypy.ini
new file mode 100644
index 0000000000..a0f2365a53
--- /dev/null
+++ b/scripts/qapi/mypy.ini
@@ -0,0 +1,65 @@
+[mypy]
+strict = True
+strict_optional = False
+disallow_untyped_calls = False
+python_version = 3.6
+
+[mypy-qapi.commands]
+disallow_untyped_defs = False
+disallow_incomplete_defs = False
+check_untyped_defs = False
+
+[mypy-qapi.doc]
+disallow_subclassing_any = False
+disallow_untyped_defs = False
+disallow_incomplete_defs = False
+
+[mypy-qapi.error]
+disallow_untyped_defs = False
+disallow_incomplete_defs = False
+check_untyped_defs = False
+
+[mypy-qapi.events]
+disallow_untyped_defs = False
+disallow_incomplete_defs = False
+check_untyped_defs = False
+
+[mypy-qapi.expr]
+disallow_untyped_defs = False
+disallow_incomplete_defs = False
+check_untyped_defs = False
+
+[mypy-qapi.gen]
+disallow_untyped_defs = False
+disallow_incomplete_defs = False
+check_untyped_defs = False
+
+[mypy-qapi.introspect]
+disallow_untyped_defs = False
+disallow_incomplete_defs = False
+check_untyped_defs = False
+
+[mypy-qapi.parser]
+disallow_untyped_defs = False
+disallow_incomplete_defs = False
+check_untyped_defs = False
+
+[mypy-qapi.schema]
+disallow_untyped_defs = False
+disallow_incomplete_defs = False
+check_untyped_defs = False
+
+[mypy-qapi.source]
+disallow_untyped_defs = False
+disallow_incomplete_defs = False
+check_untyped_defs = False
+
+[mypy-qapi.types]
+disallow_untyped_defs = False
+disallow_incomplete_defs = False
+check_untyped_defs = False
+
+[mypy-qapi.visit]
+disallow_untyped_defs = False
+disallow_incomplete_defs = False
+check_untyped_defs = False
diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index b4921b46c9..bb0cd717f1 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -17,6 +17,7 @@
 import os
 import re
 from collections import OrderedDict
+from typing import Optional
 
 from .common import c_name, POINTER_SUFFIX
 from .error import QAPIError, QAPISemError
@@ -25,7 +26,7 @@
 
 
 class QAPISchemaEntity:
-    meta = None
+    meta: Optional[str] = None
 
     def __init__(self, name, info, doc, ifcond=None, features=None):
         assert name is None or isinstance(name, str)
-- 
2.26.2


