Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB1CCC4741F
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 22:36:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62CE120715
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 22:36:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X1/PZ2Bi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62CE120715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKqto-00061k-Bl
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 18:36:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58042)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kKqst-0004CR-6t
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 18:35:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59417)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kKqsr-0007cQ-Bt
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 18:35:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600814136;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nyuvQY54G53HH6uqI9lGJUDHNNFkR+Pw2q847xGGx5c=;
 b=X1/PZ2Bi64jY1OPWIqDTJyPUu/xAjuTjxo1nlpe09TpBtK7J1yneYiaBWSC5nmbZpTGCZ4
 5upf/j3iGwIZTzmzSoZZKQQ7DCfrv7mE47EN7N+zbTI3nFm3ED58f2MwSmowhvP9nfO1iI
 lOmDo4myw1/GJ7hSb6DcPCzCRClCheM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-cKbZRuhAOtesMk6PVosQXQ-1; Tue, 22 Sep 2020 18:35:32 -0400
X-MC-Unique: cKbZRuhAOtesMk6PVosQXQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A9FEC425E0;
 Tue, 22 Sep 2020 22:35:31 +0000 (UTC)
Received: from scv.redhat.com (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D6E4160BF4;
 Tue, 22 Sep 2020 22:35:30 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 04/26] qapi/source.py: Add default arguments to QAPISourceInfo
Date: Tue, 22 Sep 2020 18:35:03 -0400
Message-Id: <20200922223525.4085762-5-jsnow@redhat.com>
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
Cc: Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The parser tries to create an object as QAPISourceInfo(None, None,
None). Add some defaults to QAPISourceInfo such that we don't need to
pass explicit as many explicit nothings.

Having the defaults nearby the code in source.py also helps remind us
that they might be unset.

Using a numerical 0 to mean "no line" is nicer to type than using None
for the same.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/parser.py | 2 +-
 scripts/qapi/source.py | 7 +++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index d0f35fe03e..db4e9ae872 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -67,7 +67,7 @@ def __init__(self, fname, previously_included=None, incl_info=None):
             with open(self._fname, 'r', encoding='utf-8') as fp:
                 self.src = fp.read()
         except IOError as e:
-            raise QAPISemError(incl_info or QAPISourceInfo(None, None, None),
+            raise QAPISemError(incl_info or QAPISourceInfo(None),
                                "can't read %s file '%s': %s"
                                % ("include" if incl_info else "schema",
                                   self._fname,
diff --git a/scripts/qapi/source.py b/scripts/qapi/source.py
index ba991d798f..d1de9e36b1 100644
--- a/scripts/qapi/source.py
+++ b/scripts/qapi/source.py
@@ -30,7 +30,10 @@ def __init__(self) -> None:
 class QAPISourceInfo:
     T = TypeVar('T', bound='QAPISourceInfo')
 
-    def __init__(self: T, fname: str, line: int, parent: Optional[T]):
+    def __init__(self: T,
+                 fname: str,
+                 line: int = 0,
+                 parent: Optional[T] = None):
         self.fname = fname
         self.line = line
         self.parent = parent
@@ -53,7 +56,7 @@ def loc(self) -> str:
         if self.fname is None:
             return sys.argv[0]
         ret = self.fname
-        if self.line is not None:
+        if self.line:
             ret += ':%d' % self.line
         return ret
 
-- 
2.26.2


