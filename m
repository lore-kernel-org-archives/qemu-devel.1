Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E11DFC433E8
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 22:33:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A75122072D
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 22:33:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZpSXrWer"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A75122072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvTUq-0002JR-0q
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 18:33:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50612)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jvTKO-0002Fv-4K
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 18:23:08 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:30883
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jvTKM-0004xL-9c
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 18:23:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594765385;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tLWK+z3sBfoVdzNValfBnDhtm+6ZIPj+zWa7w6Apw00=;
 b=ZpSXrWerRXKgq0Dpk4sEsfzQtsFGZX8NXycIBYPac5/uBVwjcKo4lF3//zVbm4zTqoZtkU
 pbRjcdebIocmKQ++cWNlMqio2ANbxNfyi+7cDMqWXRHtvAVJ+/x5mr8CpFH0RtF5RA425Z
 wTBM0lxRzKPJlBSNNjVz3zTaj03/Dlg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-173-TTmAkOahO2Wqn05wJq-rNg-1; Tue, 14 Jul 2020 18:23:01 -0400
X-MC-Unique: TTmAkOahO2Wqn05wJq-rNg-1
Received: by mail-wm1-f71.google.com with SMTP id b13so88907wme.9
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2020 15:23:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tLWK+z3sBfoVdzNValfBnDhtm+6ZIPj+zWa7w6Apw00=;
 b=sc2QmlExdJesGGH4OVEwfa+RGHVddLvrI1zwIeopH/McOuYYtudygzef+P009eryqm
 jzjqQQkmWA2T7daJYkB/FPCdvXEIs1KtNAqhe1NItgTN0fVngRLb2PuhCkA2TUubec9Q
 9CZDEbp4zqnkjP9FXjNHQJ22aZZD3YtJ3pjr2ObZ4qLhF2sgX0cMpKGcgkwTVZ59KQfK
 Nd/En3DGwv8JGB/mGLnicoaA8cp/+Y1y4gRrHZlC3hv+AHP3DX6QUuhLOU471nf6Fdx0
 1YpmrOE6Fmem1h+nFhBgV88asJ1Bc0HOmzHwSd6nK1TAntFbbZvvbxFhzOubyx3oxkp6
 xwqg==
X-Gm-Message-State: AOAM5314zO2y7WIXIyKudPIiemqYXvc9Y0eDieXLjKkkIjG4Ey/iTCoG
 xy/b5Ea+ooJDuPEdmvAaXycwmGUrn/pZS9yTZXFPP9VZzITxjWnqytt2F5iOTzo438BqXb4q1wu
 YBm03OOgBDiakNTs=
X-Received: by 2002:a5d:68cc:: with SMTP id p12mr7956197wrw.111.1594765380392; 
 Tue, 14 Jul 2020 15:23:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzXwdQYJTrYyPvnX9mGohdnRt46wLiYrJEF/n445vpnAkkfl891rxpU1uqXlUGjqUTxpTvFQg==
X-Received: by 2002:a5d:68cc:: with SMTP id p12mr7956185wrw.111.1594765380185; 
 Tue, 14 Jul 2020 15:23:00 -0700 (PDT)
Received: from localhost.localdomain
 (138.red-83-57-170.dynamicip.rima-tde.net. [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id a15sm192887wrh.54.2020.07.14.15.22.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2020 15:22:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 18/19] python/qmp.py: add casts to JSON deserialization
Date: Wed, 15 Jul 2020 00:21:31 +0200
Message-Id: <20200714222132.10815-19-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200714222132.10815-1-philmd@redhat.com>
References: <20200714222132.10815-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 12:02:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
 John Snow <jsnow@redhat.com>, Ahmed Karaman <ahmedkhaledkaraman@gmail.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: John Snow <jsnow@redhat.com>

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
Message-Id: <20200710052220.3306-6-jsnow@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
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


