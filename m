Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2381DC2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 01:07:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF7CD223AB
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 01:07:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cy6hZFJe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF7CD223AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ka7Gt-0000k7-RH
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 20:07:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35904)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1ka6nn-0007Jh-U2
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 19:37:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42734)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1ka6nh-0004wT-RU
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 19:37:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604450241;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/HV2sRxuoFz1HvSs6hteE0GNcYJLYO0K0NRKl1Vz7YA=;
 b=cy6hZFJeBy8+4tkNSvVMT8/6ewz6aJDH7vxb7sbjAQB4WOC1z468nopeCy82NJ70qLDRnw
 hNNzOTSqNOnvGdMPJwhClXYgoORbm9hVhRgPHbvmokvKlsNrABdvtvzYcWbKJaGloqc9VV
 xV+79psfrktglHu05sFaZg6fn2qe5Js=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-335-0ytIZ5k2N52LVveGeyiUnA-1; Tue, 03 Nov 2020 19:37:19 -0500
X-MC-Unique: 0ytIZ5k2N52LVveGeyiUnA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 236121891E84
 for <qemu-devel@nongnu.org>; Wed,  4 Nov 2020 00:37:18 +0000 (UTC)
Received: from scv.redhat.com (ovpn-119-97.rdu2.redhat.com [10.10.119.97])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1A41955766;
 Wed,  4 Nov 2020 00:37:16 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 53/72] scripts/qmp-shell: Fix "FuzzyJSON" parser
Date: Tue,  3 Nov 2020 19:35:43 -0500
Message-Id: <20201104003602.1293560-54-jsnow@redhat.com>
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

I'm not sure when this regressed (Or maybe if it was ever working right
to begin with?), but the Python AST requires you to change "Names" to
"Constants" in order to truly convert `false` to `False`.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qmp/qmp-shell | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/scripts/qmp/qmp-shell b/scripts/qmp/qmp-shell
index aa148517a864..847d34890f97 100755
--- a/scripts/qmp/qmp-shell
+++ b/scripts/qmp/qmp-shell
@@ -95,18 +95,19 @@ class QMPShellError(Exception):
 class FuzzyJSON(ast.NodeTransformer):
     """
     This extension of ast.NodeTransformer filters literal "true/false/null"
-    values in an AST and replaces them by proper "True/False/None" values that
-    Python can properly evaluate.
+    values in a Python AST and replaces them by proper "True/False/None" values
+    that Python can properly evaluate.
     """
 
     @classmethod
-    def visit_Name(cls, node):  # pylint: disable=invalid-name
+    def visit_Name(cls,  # pylint: disable=invalid-name
+                   node: ast.Name) -> ast.AST:
         if node.id == 'true':
-            node.id = 'True'
+            return ast.Constant(value=True)
         if node.id == 'false':
-            node.id = 'False'
+            return ast.Constant(value=False)
         if node.id == 'null':
-            node.id = 'None'
+            return ast.Constant(value=None)
         return node
 
 
@@ -174,10 +175,9 @@ class QMPShell(qmp.QEMUMonitorProtocol):
             # Try once again as FuzzyJSON:
             try:
                 tree = ast.parse(val, mode='eval')
-                return ast.literal_eval(FuzzyJSON().visit(tree))
-            except SyntaxError:
-                pass
-            except ValueError:
+                transformed = FuzzyJSON().visit(tree)
+                return ast.literal_eval(transformed)
+            except (SyntaxError, ValueError):
                 pass
         return val
 
-- 
2.26.2


