Return-Path: <SRS0=NdIa=7N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E026C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 16:47:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD0352074A
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 16:47:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TSu9kky/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD0352074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfR7I-0005Zm-T7
	for qemu-devel@archiver.kernel.org; Sun, 31 May 2020 12:47:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55320)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jfR0H-0002dh-D9
 for qemu-devel@nongnu.org; Sun, 31 May 2020 12:40:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29260
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jfR0D-0006tG-DR
 for qemu-devel@nongnu.org; Sun, 31 May 2020 12:40:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590943200;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZGJCD3WtpxESapRsldRYyPkWs2bF0ehM3T5fdkPvFFk=;
 b=TSu9kky/5xdS9F+dCqW/bNd8nnphs8gjD2hzz42LaISvch537aUNHyIIewvfI9W8sHSYzk
 EwggN1GgaNVRu2yKgk0N1eRxRyMI7YVXC4OLIHkOR6II8Hg6iHj/phY+zpJ0n6CVoQZ7jR
 pIx9cD1wH3LK0eoDwaF3jzgtnV3ySag=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-at6wA1JqMreU_Jt8MehhQw-1; Sun, 31 May 2020 12:39:57 -0400
X-MC-Unique: at6wA1JqMreU_Jt8MehhQw-1
Received: by mail-wr1-f71.google.com with SMTP id s7so3619086wrm.16
 for <qemu-devel@nongnu.org>; Sun, 31 May 2020 09:39:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZGJCD3WtpxESapRsldRYyPkWs2bF0ehM3T5fdkPvFFk=;
 b=iVSQq9+C2npHNSNNy/u+s/vNZHESmq80uEmgtwN9PnieXQAEL81UZHMmGrkyEbjJnd
 Hn6yMVUqevd57wNbyRtDoagzwu8UN9XhD4l+F66cHIP2Bi8CKnnMcSdLpupWjvxe1BIs
 hyldv8ibKQ2wNwGBixECKJlhflsRgNwp2T/Ekt3deOwbqvsdATLvEu2jldtGDdcWZB6p
 AkMjiPf3Fy+kmVLPPorfHpoj0+89UFIoZ8NR/N8dmaagm15FikeqIX4vIcp3z9r6Xr+4
 FNzJPkhI7QaqQUh2xiIAE41x5W6SKAVP1Aapzw9uReFlaXU6+CnIMOH+YWoC6fJh+7qC
 SgPw==
X-Gm-Message-State: AOAM532It77JBfTr/H/UxRBWoMpP+TTLSSD8CYIZaCegk8W0hjHGK+SG
 iQhqpbhr5k8R+7Pqv/ShpVmvdDexD5CE5x3EnjZlvrVIJZR711hx5yl0+mhJU/gOPKNn/2PjyhJ
 3k3Hk3AozNjvTSD4=
X-Received: by 2002:a7b:c201:: with SMTP id x1mr17564255wmi.58.1590943195858; 
 Sun, 31 May 2020 09:39:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyOEXwNNL/vFr901ND3jDCNFYuC5Y9R8OiJUy3KhCsCICPZclc2nGHqbOnLRtzqs9ghv2iSEA==
X-Received: by 2002:a7b:c201:: with SMTP id x1mr17564238wmi.58.1590943195679; 
 Sun, 31 May 2020 09:39:55 -0700 (PDT)
Received: from localhost.localdomain (43.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.43])
 by smtp.gmail.com with ESMTPSA id d13sm8387945wmb.39.2020.05.31.09.39.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 May 2020 09:39:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 13/25] python/qemu: fix socket.makefile() typing
Date: Sun, 31 May 2020 18:38:34 +0200
Message-Id: <20200531163846.25363-14-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200531163846.25363-1-philmd@redhat.com>
References: <20200531163846.25363-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/31 11:09:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: John Snow <jsnow@redhat.com>

Note:

A bug in typeshed (https://github.com/python/typeshed/issues/3977)
misinterprets the type of makefile(). Work around this by explicitly
stating that we are opening a text-mode file.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200514055403.18902-13-jsnow@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 python/qemu/qmp.py   | 10 +++++++---
 python/qemu/qtest.py | 12 ++++++++----
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/python/qemu/qmp.py b/python/qemu/qmp.py
index 6ae7693965..73d49050ed 100644
--- a/python/qemu/qmp.py
+++ b/python/qemu/qmp.py
@@ -11,6 +11,10 @@
 import errno
 import socket
 import logging
+from typing import (
+    Optional,
+    TextIO,
+)
 
 
 class QMPError(Exception):
@@ -61,7 +65,7 @@ def __init__(self, address, server=False, nickname=None):
         self.__events = []
         self.__address = address
         self.__sock = self.__get_sock()
-        self.__sockfile = None
+        self.__sockfile: Optional[TextIO] = None
         self._nickname = nickname
         if self._nickname:
             self.logger = logging.getLogger('QMP').getChild(self._nickname)
@@ -157,7 +161,7 @@ def connect(self, negotiate=True):
         @raise QMPCapabilitiesError if fails to negotiate capabilities
         """
         self.__sock.connect(self.__address)
-        self.__sockfile = self.__sock.makefile()
+        self.__sockfile = self.__sock.makefile(mode='r')
         if negotiate:
             return self.__negotiate_capabilities()
         return None
@@ -180,7 +184,7 @@ def accept(self, timeout=15.0):
         """
         self.__sock.settimeout(timeout)
         self.__sock, _ = self.__sock.accept()
-        self.__sockfile = self.__sock.makefile()
+        self.__sockfile = self.__sock.makefile(mode='r')
         return self.__negotiate_capabilities()
 
     def cmd_obj(self, qmp_cmd):
diff --git a/python/qemu/qtest.py b/python/qemu/qtest.py
index 7943487c2b..4c88590eb0 100644
--- a/python/qemu/qtest.py
+++ b/python/qemu/qtest.py
@@ -19,6 +19,7 @@
 
 import socket
 import os
+from typing import Optional, TextIO
 
 from .machine import QEMUMachine
 
@@ -40,7 +41,7 @@ class QEMUQtestProtocol:
     def __init__(self, address, server=False):
         self._address = address
         self._sock = self._get_sock()
-        self._sockfile = None
+        self._sockfile: Optional[TextIO] = None
         if server:
             self._sock.bind(self._address)
             self._sock.listen(1)
@@ -59,7 +60,7 @@ def connect(self):
         @raise socket.error on socket connection errors
         """
         self._sock.connect(self._address)
-        self._sockfile = self._sock.makefile()
+        self._sockfile = self._sock.makefile(mode='r')
 
     def accept(self):
         """
@@ -68,7 +69,7 @@ def accept(self):
         @raise socket.error on socket connection errors
         """
         self._sock, _ = self._sock.accept()
-        self._sockfile = self._sock.makefile()
+        self._sockfile = self._sock.makefile(mode='r')
 
     def cmd(self, qtest_cmd):
         """
@@ -76,6 +77,7 @@ def cmd(self, qtest_cmd):
 
         @param qtest_cmd: qtest command text to be sent
         """
+        assert self._sockfile is not None
         self._sock.sendall((qtest_cmd + "\n").encode('utf-8'))
         resp = self._sockfile.readline()
         return resp
@@ -83,7 +85,9 @@ def cmd(self, qtest_cmd):
     def close(self):
         """Close this socket."""
         self._sock.close()
-        self._sockfile.close()
+        if self._sockfile:
+            self._sockfile.close()
+            self._sockfile = None
 
     def settimeout(self, timeout):
         """Set a timeout, in seconds."""
-- 
2.21.3


