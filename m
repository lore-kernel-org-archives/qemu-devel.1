Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3899EC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 21:50:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0088E206E2
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 21:50:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QuZ0DBvw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0088E206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgEnl-0002Jz-0U
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 17:50:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47338)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jgEjC-0004yt-Ou
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 17:45:46 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:45675
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jgEjB-0008NF-8z
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 17:45:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591134344;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5Qf8v0ok6NoZn3ONyeNpiiry8fEwaJOYjh5wGIbsVw4=;
 b=QuZ0DBvwZGt4T+oFHuOpWK7BqbbY85UxvjMB6zrbwmX9Zse56tuZ2XF2o4XDsM3YHk3vXA
 OMhMBQDQkMM5BhQ+hhOFL4UocknC4uE010HwzERG8HmvzU2PZZRX8lVA8q4kg2RCRtjbOR
 NE3WSvVAtKNqY2/LdlRlKDAqhw4fdps=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-fnYXv3SsPaKMIBdzcUX9hw-1; Tue, 02 Jun 2020 17:45:42 -0400
X-MC-Unique: fnYXv3SsPaKMIBdzcUX9hw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B186F8018AB;
 Tue,  2 Jun 2020 21:45:41 +0000 (UTC)
Received: from probe.redhat.com (ovpn-112-142.rdu2.redhat.com [10.10.112.142])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 943206116F;
 Tue,  2 Jun 2020 21:45:39 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 05/16] python/qmp.py: add casts to JSON deserialization
Date: Tue,  2 Jun 2020 17:45:17 -0400
Message-Id: <20200602214528.12107-6-jsnow@redhat.com>
In-Reply-To: <20200602214528.12107-1-jsnow@redhat.com>
References: <20200602214528.12107-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=jsnow@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/02 03:23:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

mypy and python type hints are not powerful enough to properly describe
JSON messages in Python 3.6. The best we can do, generally, is describe
them as Dict[str, Any].

Add casts to coerce this type for static analysis; but do NOT enforce
this type at runtime in any way.

Note: Python 3.8 adds a TypedDict construct which allows for the
description of more arbitrary Dictionary shapes. There is a third-party
module, "Pydantic", which is compatible with 3.6 that can be used
instead of the JSON library that parses JSON messages to fully-typed
Python objects, and may be preferable in some cases.

(That is well beyond the scope of this commit or series.)

Signed-off-by: John Snow <jsnow@redhat.com>
---
 python/qemu/qmp.py | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/python/qemu/qmp.py b/python/qemu/qmp.py
index ef3c919b76c..5f3558e3066 100644
--- a/python/qemu/qmp.py
+++ b/python/qemu/qmp.py
@@ -13,6 +13,7 @@
 import logging
 from typing import (
     Any,
+    cast,
     Dict,
     Optional,
     TextIO,
@@ -130,7 +131,10 @@ def __json_read(self, only_event=False):
             data = self.__sockfile.readline()
             if not data:
                 return None
-            resp = json.loads(data)
+            # By definition, any JSON received from QMP is a QMPMessage,
+            # and we are asserting only at static analysis time that it
+            # has a particular shape.
+            resp = cast(QMPMessage, json.loads(data))
             if 'event' in resp:
                 self.logger.debug("<<< %s", resp)
                 self.__events.append(resp)
@@ -262,7 +266,7 @@ def command(self, cmd, **kwds):
         ret = self.cmd(cmd, kwds)
         if 'error' in ret:
             raise QMPResponseError(ret)
-        return ret['return']
+        return cast(QMPReturnValue, ret['return'])
 
     def pull_event(self, wait=False):
         """
-- 
2.21.3


