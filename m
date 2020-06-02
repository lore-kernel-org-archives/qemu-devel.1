Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AE10C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 21:50:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6631D206E2
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 21:50:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B7EOXjSm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6631D206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgEni-0002ED-IJ
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 17:50:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47346)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jgEjE-00052Q-Qn
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 17:45:50 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:36194
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jgEjD-0008Oc-S3
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 17:45:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591134347;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UuN7kDO+yFdxcmAFajdCQ051EB+5vcNmJCYoCn0GDFg=;
 b=B7EOXjSmfEFB7oeoRAhweVYL/Hd1mXqG416cxzqlrMz7LedCYPY18g41xsj+DIAMfwbOeF
 816dX7V1kLF0IQzrMe8QUBgv9J0sTIe8+HOAU5SiBDjiVQN58Q+KbLaNAJv4Tc4oJhUVlw
 Alx4Dhpzx9Ff7ZGGCAgPqRAtgOrkNQY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-295-AreIRHF_PaOpChfV0AQ7dg-1; Tue, 02 Jun 2020 17:45:45 -0400
X-MC-Unique: AreIRHF_PaOpChfV0AQ7dg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6D1EF80058E;
 Tue,  2 Jun 2020 21:45:44 +0000 (UTC)
Received: from probe.redhat.com (ovpn-112-142.rdu2.redhat.com [10.10.112.142])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E7A3461987;
 Tue,  2 Jun 2020 21:45:41 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 06/16] python/qmp.py: add QMPProtocolError
Date: Tue,  2 Jun 2020 17:45:18 -0400
Message-Id: <20200602214528.12107-7-jsnow@redhat.com>
In-Reply-To: <20200602214528.12107-1-jsnow@redhat.com>
References: <20200602214528.12107-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/02 15:54:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

In the case that we receive a reply but are unable to understand it, use
this exception name to indicate that case.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 python/qemu/qmp.py | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/python/qemu/qmp.py b/python/qemu/qmp.py
index 5f3558e3066..1aefc00c93b 100644
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


