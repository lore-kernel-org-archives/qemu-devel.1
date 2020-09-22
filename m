Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3448AC2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 21:34:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6E6F20757
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 21:34:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WXQSGRcE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6E6F20757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKpvh-000290-NA
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 17:34:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37404)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kKpQE-0002WC-HC
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 17:01:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21752)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kKpQB-0004eK-3j
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 17:01:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600808514;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZqSJckFwaigPqII7TYtgwKO5VF0wvwDzqsNfM47vfmM=;
 b=WXQSGRcEEyOhdiHCzhO8JikHB1QrW5nVmTPuXgMzSLkXBTUHSIvpa9S6m0pQzm0hfauF3Q
 g6yzHC2Bu6NU1cWFEVH5/C8nuW4ATuf7ttqsb34ZKNzI+6e42OHWfc9vvFdE2o1w+wF4a0
 4cM9PHm2X4GttWd/9Qz6txR2lMXjq3Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-463-0cQZgwQWPmmCy0RCxfOLag-1; Tue, 22 Sep 2020 17:01:50 -0400
X-MC-Unique: 0cQZgwQWPmmCy0RCxfOLag-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0ACD6107465F;
 Tue, 22 Sep 2020 21:01:49 +0000 (UTC)
Received: from scv.redhat.com (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5611E71775;
 Tue, 22 Sep 2020 21:01:45 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: Markus Armbruster <armbru@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 30/38] qapi/introspect.py: Add a typed 'extra' structure
Date: Tue, 22 Sep 2020 17:00:53 -0400
Message-Id: <20200922210101.4081073-31-jsnow@redhat.com>
In-Reply-To: <20200922210101.4081073-1-jsnow@redhat.com>
References: <20200922210101.4081073-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 15:47:47
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Typing arbitrarily shaped dicts with mypy is difficult prior to Python
3.8; using explicit structures is nicer.

Since we always define an Extra type now, the return type of _make_tree
simplifies and always returns the tuple.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/introspect.py | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
index b036fcf9ce..41ca8afc67 100644
--- a/scripts/qapi/introspect.py
+++ b/scripts/qapi/introspect.py
@@ -10,6 +10,8 @@
 See the COPYING file in the top-level directory.
 """
 
+from typing import (NamedTuple, Optional, Sequence)
+
 from .common import (
     c_name,
     gen_endif,
@@ -21,16 +23,21 @@
                      QAPISchemaType)
 
 
-def _make_tree(obj, ifcond, features, extra=None):
-    if extra is None:
-        extra = {}
-    if ifcond:
-        extra['if'] = ifcond
+class Extra(NamedTuple):
+    """
+    Extra contains data that isn't intended for output by introspection.
+    """
+    comment: Optional[str] = None
+    ifcond: Sequence[str] = tuple()
+
+
+def _make_tree(obj, ifcond, features,
+               extra: Optional[Extra] = None):
+    comment = extra.comment if extra else None
+    extra = Extra(comment, ifcond)
     if features:
-        obj['features'] = [(f.name, {'if': f.ifcond}) for f in features]
-    if extra:
-        return (obj, extra)
-    return obj
+        obj['features'] = [(f.name, Extra(None, f.ifcond)) for f in features]
+    return (obj, extra)
 
 
 def _tree_to_qlit(obj, level=0, suppress_first_indent=False):
@@ -40,8 +47,8 @@ def indent(level):
 
     if isinstance(obj, tuple):
         ifobj, extra = obj
-        ifcond = extra.get('if')
-        comment = extra.get('comment')
+        ifcond = extra.ifcond
+        comment = extra.comment
         ret = ''
         if comment:
             ret += indent(level) + '/* %s */\n' % comment
@@ -168,7 +175,7 @@ def _gen_tree(self, name, mtype, obj, ifcond, features):
             if not self._unmask:
                 # Output a comment to make it easy to map masked names
                 # back to the source when reading the generated output.
-                extra = {'comment': '"%s" = %s' % (self._name(name), name)}
+                extra = Extra(comment=f'"{self._name(name)}" = {name}')
             name = self._name(name)
         obj['name'] = name
         obj['meta-type'] = mtype
-- 
2.26.2


