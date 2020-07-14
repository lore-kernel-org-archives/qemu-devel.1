Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53F4BC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 22:32:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC8C72072D
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 22:32:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bppqArzs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC8C72072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvTTj-0000dF-5M
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 18:32:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50648)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jvTKV-0002OW-AG
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 18:23:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50702
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jvTKQ-0004xx-Cm
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 18:23:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594765389;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Akupi2/psErTNl648GD773WL1cQbHEfDPZG4YPkFXLs=;
 b=bppqArzsDqcBwpInWR6vq2doUZNlZagkRfUaIi45Qko7XQn0566YvKoL++iFhtM7mUKkhp
 QRWRZexkZeyvT2NaXex9XUSjo3yToK66xuB59ClXopQvHFEqR24lGIRFZVFXrbSP5bxdNG
 eAQ88EER4ZbBEOEKmUmYo73Z0tMs8zs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-462-yyqF41_9PEWTeYW7Tzf-kQ-1; Tue, 14 Jul 2020 18:23:08 -0400
X-MC-Unique: yyqF41_9PEWTeYW7Tzf-kQ-1
Received: by mail-wm1-f71.google.com with SMTP id s134so94655wme.6
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2020 15:23:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Akupi2/psErTNl648GD773WL1cQbHEfDPZG4YPkFXLs=;
 b=F9F9OuyOThagS1Ga6X/yOwNDqX6XOOQi9J0gSORy1Xys4wDdMNE9INd5eWl992AZUL
 GrPfEFYvHltZG24T7bRRiILEJNhRbmMYl9gBkIJ1fjb2yKpLOSUjRZSferNvnOuh3R4D
 GtGxM7UmTmOSgFBMfAC6iCY5NWSw+fHkSCvLYNj4bWsmzwm58re6Xew4xFg452gNHkVR
 7+qUr7T1MXa36pRRVxmGVW7wUQRIl0B94b3gLtDWaneASr+EeL9FrpiGIdujD2VGvgbb
 ad8wZ6xfT0KfyUt89N17KJ65Trj2Uy99glg5a4NHiiP+HZS02HrsPJFnJq7dOqOG3lwO
 wYSA==
X-Gm-Message-State: AOAM531n1v94I6kCvcYlm05Cmc+sHC+Jq3516ng+ZKqSJtPubO/Jtqrp
 by5XbTvAfYymiWmrXgbQsBuFut9SMHcT/cZlUeD7CTg6DLr+8OswYu3dOIl+dB7BcplXsLMgn8m
 p0TFF88r0xgVTo7U=
X-Received: by 2002:a05:600c:313:: with SMTP id
 q19mr5112983wmd.9.1594765385249; 
 Tue, 14 Jul 2020 15:23:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzl1qd4y1/guXy5rG6B2MQmlkEIjFWiigjiGR1tZNete2GxbwUixFCefgmCOIC3Bxi6hpAqSA==
X-Received: by 2002:a05:600c:313:: with SMTP id
 q19mr5112971wmd.9.1594765385077; 
 Tue, 14 Jul 2020 15:23:05 -0700 (PDT)
Received: from localhost.localdomain
 (138.red-83-57-170.dynamicip.rima-tde.net. [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id w17sm200963wra.42.2020.07.14.15.23.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2020 15:23:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 19/19] python/qmp.py: add QMPProtocolError
Date: Wed, 15 Jul 2020 00:21:32 +0200
Message-Id: <20200714222132.10815-20-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200714222132.10815-1-philmd@redhat.com>
References: <20200714222132.10815-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 01:42:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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

In the case that we receive a reply but are unable to understand it,
use this exception name to indicate that case.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Message-Id: <20200710052220.3306-7-jsnow@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 python/qemu/qmp.py | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/python/qemu/qmp.py b/python/qemu/qmp.py
index 1ae36050a4..7935dababb 100644
--- a/python/qemu/qmp.py
+++ b/python/qemu/qmp.py
@@ -62,6 +62,12 @@ class QMPTimeoutError(QMPError):
     """
 
 
+class QMPProtocolError(QMPError):
+    """
+    QMP protocol error; unexpected response
+    """
+
+
 class QMPResponseError(QMPError):
     """
     Represents erroneous QMP monitor reply
@@ -266,6 +272,10 @@ def command(self, cmd, **kwds):
         ret = self.cmd(cmd, kwds)
         if 'error' in ret:
             raise QMPResponseError(ret)
+        if 'return' not in ret:
+            raise QMPProtocolError(
+                "'return' key not found in QMP response '{}'".format(str(ret))
+            )
         return cast(QMPReturnValue, ret['return'])
 
     def pull_event(self, wait=False):
-- 
2.21.3


