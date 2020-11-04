Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B31BC2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 00:58:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6D31223C7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 00:58:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZQi46AsI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6D31223C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ka77j-0005jK-Kc
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 19:58:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35678)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1ka6nS-0006gp-9T
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 19:37:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22076)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1ka6nP-0004to-Rx
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 19:37:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604450223;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bV7rjoOGdrBoWybEf7CQupU8d6G60XJruZ5XB4Mr7DU=;
 b=ZQi46AsIMw2ZKOKyEx9dGzEKiAEB2Fj6Zq3Sj7U0nu+L50k0GOBbVlhOzOkSGoNBgVDuGL
 2h351s/9/I5DnCqdgYvFVzL8i2yPY7xkGivPl35DF8vd+5kPJTtkfYYtV/Do/8FRgg0LSk
 eSv8RedJC+1wg8w8U1nqXjrwPnVtR3I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-117-rgta2XnUMMy8ew_zC0FSEQ-1; Tue, 03 Nov 2020 19:37:01 -0500
X-MC-Unique: rgta2XnUMMy8ew_zC0FSEQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AE19780A1B6
 for <qemu-devel@nongnu.org>; Wed,  4 Nov 2020 00:36:52 +0000 (UTC)
Received: from scv.redhat.com (ovpn-119-97.rdu2.redhat.com [10.10.119.97])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C906655766;
 Wed,  4 Nov 2020 00:36:51 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 34/72] scripts/qmp-shell: use @classmethod where appropriate
Date: Tue,  3 Nov 2020 19:35:24 -0500
Message-Id: <20201104003602.1293560-35-jsnow@redhat.com>
In-Reply-To: <20201104003602.1293560-1-jsnow@redhat.com>
References: <20201104003602.1293560-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Methods with no self-use should belong to the class.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qmp/qmp-shell | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/scripts/qmp/qmp-shell b/scripts/qmp/qmp-shell
index 6767a01eaaed..69359ec8ad7f 100755
--- a/scripts/qmp/qmp-shell
+++ b/scripts/qmp/qmp-shell
@@ -101,7 +101,8 @@ class FuzzyJSON(ast.NodeTransformer):
     '''This extension of ast.NodeTransformer filters literal "true/false/null"
     values in an AST and replaces them by proper "True/False/None" values that
     Python can properly evaluate.'''
-    def visit_Name(self, node):
+    @classmethod
+    def visit_Name(cls, node):
         if node.id == 'true':
             node.id = 'True'
         if node.id == 'false':
@@ -124,7 +125,8 @@ class QMPShell(qmp.QEMUMonitorProtocol):
         self._histfile = os.path.join(os.path.expanduser('~'),
                                       '.qmp-shell_history')
 
-    def __get_address(self, arg):
+    @classmethod
+    def __get_address(cls, arg):
         """
         Figure out if the argument is in the port:host form, if it's not it's
         probably a file path.
@@ -171,7 +173,8 @@ class QMPShell(qmp.QEMUMonitorProtocol):
         except Exception as e:
             print("Failed to save history file '%s'; %s" % (self._histfile, e))
 
-    def __parse_value(self, val):
+    @classmethod
+    def __parse_value(cls, val):
         try:
             return int(val)
         except ValueError:
-- 
2.26.2


