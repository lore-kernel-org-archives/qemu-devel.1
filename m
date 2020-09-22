Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84DFCC4727D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 22:40:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C1E820936
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 22:40:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SrCP1h2k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C1E820936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKqx7-0002fi-6m
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 18:40:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57994)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kKqsr-00048M-5U
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 18:35:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22325)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kKqso-0007bI-FI
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 18:35:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600814133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZMY/wzTC1WX5rSMzZEfkvQygIqZldMtlPzP4tLxY3L4=;
 b=SrCP1h2kq2utpzdO5t0HcRe4cQqyiTShXuOvXoruHakpT+TSGNp8AjwLANZ2GDt4GfTGv+
 EBoe65L8baW4aWUgDgcNSnWDF962E1HLPI/V4xCm3qi+DFoLbUjLsXpqb4mVLRUZajrdxh
 /DuqcBgRbFTP0N99a1IEGk3DdT0sNwE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-490-VLWWGsa4N92iU4kRc2aWCw-1; Tue, 22 Sep 2020 18:35:29 -0400
X-MC-Unique: VLWWGsa4N92iU4kRc2aWCw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9B2731074641;
 Tue, 22 Sep 2020 22:35:28 +0000 (UTC)
Received: from scv.redhat.com (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8445460C05;
 Tue, 22 Sep 2020 22:35:27 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 01/26] qapi/parser.py: refactor parsing routine into method
Date: Tue, 22 Sep 2020 18:35:00 -0400
Message-Id: <20200922223525.4085762-2-jsnow@redhat.com>
In-Reply-To: <20200922223525.4085762-1-jsnow@redhat.com>
References: <20200922223525.4085762-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 02:07:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
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
Cc: Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For the sake of keeping __init__ easier to reason about, with fewer
variables in play.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/parser.py | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index 8be4570c31..55117f5754 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -46,28 +46,34 @@ class QAPIDocError(QAPIError):
 class QAPISchemaParser:
 
     def __init__(self, fname, previously_included=None, incl_info=None):
-        previously_included = previously_included or set()
-        previously_included.add(os.path.abspath(fname))
+        self._fname = fname
+        self._included = previously_included or set()
+        self._included.add(os.path.abspath(self._fname))
+
+        self.cursor = 0
+        self.info = QAPISourceInfo(self._fname, 1, incl_info)
+        self.line_pos = 0
+        self.exprs = []
+        self.docs = []
 
         try:
-            fp = open(fname, 'r', encoding='utf-8')
+            fp = open(self._fname, 'r', encoding='utf-8')
             self.src = fp.read()
         except IOError as e:
             raise QAPISemError(incl_info or QAPISourceInfo(None, None, None),
                                "can't read %s file '%s': %s"
                                % ("include" if incl_info else "schema",
-                                  fname,
+                                  self._fname,
                                   e.strerror))
+        self._parse()
 
+    def _parse(self):
+        cur_doc = None
+
+        # Prime the lexer:
         if self.src == '' or self.src[-1] != '\n':
             self.src += '\n'
-        self.cursor = 0
-        self.info = QAPISourceInfo(fname, 1, incl_info)
-        self.line_pos = 0
-        self.exprs = []
-        self.docs = []
         self.accept()
-        cur_doc = None
 
         while self.tok is not None:
             info = self.info
@@ -86,12 +92,12 @@ def __init__(self, fname, previously_included=None, incl_info=None):
                 if not isinstance(include, str):
                     raise QAPISemError(info,
                                        "value of 'include' must be a string")
-                incl_fname = os.path.join(os.path.dirname(fname),
+                incl_fname = os.path.join(os.path.dirname(self._fname),
                                           include)
                 self.exprs.append({'expr': {'include': incl_fname},
                                    'info': info})
                 exprs_include = self._include(include, info, incl_fname,
-                                              previously_included)
+                                              self._included)
                 if exprs_include:
                     self.exprs.extend(exprs_include.exprs)
                     self.docs.extend(exprs_include.docs)
-- 
2.26.2


