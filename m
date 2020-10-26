Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C730FC4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 20:13:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4685921BE5
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 20:13:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VlcDo2hY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4685921BE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX8rc-00070d-74
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 16:13:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33986)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kX8P4-00075Q-Pd
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 15:43:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22086)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kX8P0-0003BT-Nz
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 15:43:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603741413;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=on5YqcSIhfWljRLv4oDXCK2tq8+YrnQBZVCFBdMkehY=;
 b=VlcDo2hYebsVfNQ9yZMu2JE3JcXWdj935P7POTu8b/c76yAcKZKPnWA2xVpE3rnl12Tt62
 qyZ52qGRfnuFbkS5mk73e6vpSe/nQLdBh8jnEnToFHDE1Imm/vADZKtJ2Ysj/gfuDahQc9
 HamP/UpV8hW9DZ13XDp4titItUjINIQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-RFifaAU8MNeEnWIOAEavlQ-1; Mon, 26 Oct 2020 15:43:30 -0400
X-MC-Unique: RFifaAU8MNeEnWIOAEavlQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C319A1084CA3
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 19:43:17 +0000 (UTC)
Received: from scv.redhat.com (ovpn-118-238.rdu2.redhat.com [10.10.118.238])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B67A25B4AE;
 Mon, 26 Oct 2020 19:43:16 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v2 10/11] qapi/introspect.py: improve readability of
 _tree_to_qlit
Date: Mon, 26 Oct 2020 15:42:50 -0400
Message-Id: <20201026194251.11075-11-jsnow@redhat.com>
In-Reply-To: <20201026194251.11075-1-jsnow@redhat.com>
References: <20201026194251.11075-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 02:39:09
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
Cc: John Snow <jsnow@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Subjective, but I find getting rid of the comprehensions helps. Also,
divide the sections into scalar and non-scalar sections, and remove
old-style string formatting.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/introspect.py | 37 +++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
index a261e402d69..d4f28485ba5 100644
--- a/scripts/qapi/introspect.py
+++ b/scripts/qapi/introspect.py
@@ -100,7 +100,7 @@ def indent(level: int) -> str:
 
         ret = ''
         if obj.comment:
-            ret += indent(level) + '/* %s */\n' % obj.comment
+            ret += indent(level) + f"/* {obj.comment} */\n"
         if obj.ifcond:
             ret += gen_if(obj.ifcond)
         ret += _tree_to_qlit(obj.value, level, suppress_first_indent)
@@ -111,31 +111,36 @@ def indent(level: int) -> str:
     ret = ''
     if not suppress_first_indent:
         ret += indent(level)
+
+    # Scalars:
     if obj is None:
         ret += 'QLIT_QNULL'
     elif isinstance(obj, str):
-        ret += 'QLIT_QSTR(' + to_c_string(obj) + ')'
+        ret += f"QLIT_QSTR({to_c_string(obj)})"
+    elif isinstance(obj, bool):
+        ret += "QLIT_QBOOL({:s})".format(str(obj).lower())
+
+    # Non-scalars:
     elif isinstance(obj, list):
-        elts = [_tree_to_qlit(elt, level + 1).strip('\n')
-                for elt in obj]
-        elts.append(indent(level + 1) + "{}")
         ret += 'QLIT_QLIST(((QLitObject[]) {\n'
-        ret += '\n'.join(elts) + '\n'
+        for value in obj:
+            ret += _tree_to_qlit(value, level + 1).strip('\n') + '\n'
+        ret += indent(level + 1) + '{}\n'
         ret += indent(level) + '}))'
     elif isinstance(obj, dict):
-        elts = []
-        for key, value in sorted(obj.items()):
-            elts.append(indent(level + 1) + '{ %s, %s }' %
-                        (to_c_string(key),
-                         _tree_to_qlit(value, level + 1, True)))
-        elts.append(indent(level + 1) + '{}')
         ret += 'QLIT_QDICT(((QLitDictEntry[]) {\n'
-        ret += ',\n'.join(elts) + '\n'
+        for key, value in sorted(obj.items()):
+            ret += indent(level + 1) + "{{ {:s}, {:s} }},\n".format(
+                to_c_string(key),
+                _tree_to_qlit(value, level + 1, suppress_first_indent=True)
+            )
+        ret += indent(level + 1) + '{}\n'
         ret += indent(level) + '}))'
-    elif isinstance(obj, bool):
-        ret += 'QLIT_QBOOL(%s)' % ('true' if obj else 'false')
     else:
-        assert False                # not implemented
+        raise NotImplementedError(
+            f"type '{type(obj).__name__}' not implemented"
+        )
+
     if level > 0:
         ret += ','
     return ret
-- 
2.26.2


