Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0142DC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 05:25:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1D7020720
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 05:25:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aYFmkv+j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1D7020720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtlXJ-0004LJ-Vq
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 01:25:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50698)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jtlUX-0007Gf-4G
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 01:22:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33757
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jtlUV-0008D0-Dp
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 01:22:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594358550;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gqk7ovbcZenmmjkGeGLVpvHvzhizoBYcL+O5A5dVKHI=;
 b=aYFmkv+jUFV9WRUj9Oi4OxKiFMQp565imDPzwIgm/9G+3DKJ+nA2pSeFLvaE4O05G7JOUC
 KuHo0T4xvOU+0VSBZJdTpekBph/QTcTjNRpwIMDx+BW2goCnLg+fMt83g90aflacGHtG+h
 QSlGtfQB3OS9/rB2j5l5LEVPY9YPGr4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-foNoyNiLN2CjLKF0rVRpNg-1; Fri, 10 Jul 2020 01:22:29 -0400
X-MC-Unique: foNoyNiLN2CjLKF0rVRpNg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 13DB51082;
 Fri, 10 Jul 2020 05:22:28 +0000 (UTC)
Received: from probe.redhat.com (ovpn-118-196.rdu2.redhat.com [10.10.118.196])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1495B920C2;
 Fri, 10 Jul 2020 05:22:26 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 05/16] python/qmp.py: add casts to JSON deserialization
Date: Fri, 10 Jul 2020 01:22:09 -0400
Message-Id: <20200710052220.3306-6-jsnow@redhat.com>
In-Reply-To: <20200710052220.3306-1-jsnow@redhat.com>
References: <20200710052220.3306-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=jsnow@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/10 00:55:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
---
 python/qemu/qmp.py | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/python/qemu/qmp.py b/python/qemu/qmp.py
index ef3c919b76..1ae36050a4 100644
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
+            resp: QMPMessage = json.loads(data)
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


