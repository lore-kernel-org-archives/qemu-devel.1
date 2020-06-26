Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE6DC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 20:42:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B4BA204EC
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 20:42:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U1eM6dGM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B4BA204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jovBY-0008NL-DR
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 16:42:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33698)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jovAQ-0006cm-6N
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 16:41:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54378
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jovAN-0005oB-9S
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 16:41:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593204102;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oNhPhaxByI3BTfZupYYGTKC0C0PPGE+d9nTXAs0uWH4=;
 b=U1eM6dGMYAjSKl7l0fJzVV69NTWl1XZZKAxNVKhCu1hkVotTomRbal4qJJBL1b0otXCOfM
 5MleoDFTzk7PJJNDcvDUt+nqg7FtI/gPsPQ81UUGGDRohsAane/dGn774e0/1GP6m0dtWg
 UxQU2ff/TNh04TNv4I0TgDp7vHtFC2I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-159-P_zF_z9WOnyt823INcb2DA-1; Fri, 26 Jun 2020 16:41:40 -0400
X-MC-Unique: P_zF_z9WOnyt823INcb2DA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C0149BFC1;
 Fri, 26 Jun 2020 20:41:39 +0000 (UTC)
Received: from probe.redhat.com (ovpn-119-184.rdu2.redhat.com [10.10.119.184])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EC26F19C58;
 Fri, 26 Jun 2020 20:41:38 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 04/16] python/qmp.py: Do not return None from cmd_obj
Date: Fri, 26 Jun 2020 16:41:21 -0400
Message-Id: <20200626204133.14500-5-jsnow@redhat.com>
In-Reply-To: <20200626204133.14500-1-jsnow@redhat.com>
References: <20200626204133.14500-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=jsnow@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 15:42:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

This makes typing the qmp library difficult, as it necessitates wrapping
Optional[] around the type for every return type up the stack. At some
point, it becomes difficult to discern or remember why it's None instead
of the expected object.

Use the python exception system to tell us exactly why we didn't get an
object. Remove this special-cased return.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
---
 python/qemu/qmp.py | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/python/qemu/qmp.py b/python/qemu/qmp.py
index aa8a666b8a..ef3c919b76 100644
--- a/python/qemu/qmp.py
+++ b/python/qemu/qmp.py
@@ -225,22 +225,18 @@ def accept(self, timeout=15.0):
         self.__sockfile = self.__sock.makefile(mode='r')
         return self.__negotiate_capabilities()
 
-    def cmd_obj(self, qmp_cmd):
+    def cmd_obj(self, qmp_cmd: QMPMessage) -> QMPMessage:
         """
         Send a QMP command to the QMP Monitor.
 
         @param qmp_cmd: QMP command to be sent as a Python dict
-        @return QMP response as a Python dict or None if the connection has
-                been closed
+        @return QMP response as a Python dict
         """
         self.logger.debug(">>> %s", qmp_cmd)
-        try:
-            self.__sock.sendall(json.dumps(qmp_cmd).encode('utf-8'))
-        except OSError as err:
-            if err.errno == errno.EPIPE:
-                return None
-            raise err
+        self.__sock.sendall(json.dumps(qmp_cmd).encode('utf-8'))
         resp = self.__json_read()
+        if resp is None:
+            raise QMPConnectError("Unexpected empty reply from server")
         self.logger.debug("<<< %s", resp)
         return resp
 
-- 
2.21.3


