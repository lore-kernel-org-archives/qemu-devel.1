Return-Path: <SRS0=BZbV=DR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D10EC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 10:17:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D369620782
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 10:17:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Eg8LOUci"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D369620782
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRBw4-0003ea-EX
	for qemu-devel@archiver.kernel.org; Sat, 10 Oct 2020 06:17:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60730)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kRBb7-00086R-PA
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 05:55:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28883)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kRBat-0002jx-D0
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 05:55:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602323714;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1UYXca317QJZ9amM5dAzh2qpCPvTHOyoioIt1dhofyo=;
 b=Eg8LOUcib/O9Zi7mH1n/n8JBBlVbEtGSzW+YT/2ZpmFeuRkDbq1TucyjGv+uH2+3l7iXkP
 rYZSUQ5mfMHDYFeT3lb+wjHc5wltuIJHeb4R0ZtwwwRDCZ5vR9YwvF99/OVKWznjOmykyr
 iLfTZnULy2Q+QwKmHxT7e52MoKh8Wrw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-_z_dXJXWO9GquQ_BYBPtMw-1; Sat, 10 Oct 2020 05:55:11 -0400
X-MC-Unique: _z_dXJXWO9GquQ_BYBPtMw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5CD68802B79;
 Sat, 10 Oct 2020 09:55:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-182.ams2.redhat.com
 [10.36.112.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2C8395C1BB;
 Sat, 10 Oct 2020 09:55:10 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0E7B311275DE; Sat, 10 Oct 2020 11:55:05 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 32/34] qapi/visit.py: assert tag_member contains a
 QAPISchemaEnumType
Date: Sat, 10 Oct 2020 11:55:02 +0200
Message-Id: <20201010095504.796182-33-armbru@redhat.com>
In-Reply-To: <20201010095504.796182-1-armbru@redhat.com>
References: <20201010095504.796182-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/10 02:57:53
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
Cc: peter.maydell@linaro.org, John Snow <jsnow@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: John Snow <jsnow@redhat.com>

This is true by design, but not presently able to be expressed in the
type system. An assertion helps mypy understand our constraints.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Cleber Rosa <crosa@redhat.com>
Message-Id: <20201009161558.107041-35-jsnow@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/visit.py | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
index 708f72c4a1..e00f2a09d7 100644
--- a/scripts/qapi/visit.py
+++ b/scripts/qapi/visit.py
@@ -22,7 +22,7 @@ from .common import (
     mcgen,
 )
 from .gen import QAPISchemaModularCVisitor, ifcontext
-from .schema import QAPISchemaObjectType
+from .schema import QAPISchemaEnumType, QAPISchemaObjectType
 
 
 def gen_visit_decl(name, scalar=False):
@@ -84,15 +84,17 @@ bool visit_type_%(c_name)s_members(Visitor *v, %(c_name)s *obj, Error **errp)
         ret += gen_endif(memb.ifcond)
 
     if variants:
+        tag_member = variants.tag_member
+        assert isinstance(tag_member.type, QAPISchemaEnumType)
+
         ret += mcgen('''
     switch (obj->%(c_name)s) {
 ''',
-                     c_name=c_name(variants.tag_member.name))
+                     c_name=c_name(tag_member.name))
 
         for var in variants.variants:
-            case_str = c_enum_const(variants.tag_member.type.name,
-                                    var.name,
-                                    variants.tag_member.type.prefix)
+            case_str = c_enum_const(tag_member.type.name, var.name,
+                                    tag_member.type.prefix)
             ret += gen_if(var.ifcond)
             if var.type.name == 'q_empty':
                 # valid variant and nothing to do
-- 
2.26.2


