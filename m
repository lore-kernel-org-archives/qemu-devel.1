Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ACF1C4727D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 21:42:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1D9C2371F
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 21:42:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I/3KszU1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1D9C2371F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKq2y-0004gS-En
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 17:42:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41236)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kKpgG-0007eH-3o
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 17:18:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34417)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kKpgE-0006em-7V
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 17:18:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600809509;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+N9SVxzI3ShYNgvFdCqrNQXI9sy069vyoh7g1hqMmJc=;
 b=I/3KszU1IRdV8NVkccWu8K5ArFDoWFz5RdpfOZ8C1KAfBKTwd+CKcKOOrapBvpZeYkHJxZ
 WfMKtgtr8au9KaT2zyz31WdmSKNYx+EJDXIoxLO3mrLhXkGHYGRMBzUZj4NH+QF09zIX9f
 m/FPaQKTnxVYrFL9j55uy6OUkgTcQSs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-54-_l_knxG5OpS-cFYJ0bTo-w-1; Tue, 22 Sep 2020 17:18:13 -0400
X-MC-Unique: _l_knxG5OpS-cFYJ0bTo-w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2172880ED9A;
 Tue, 22 Sep 2020 21:18:12 +0000 (UTC)
Received: from scv.redhat.com (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 683555DE50;
 Tue, 22 Sep 2020 21:18:11 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 04/14] qapi/doc.py: assert correct types in member_func
 callbacks
Date: Tue, 22 Sep 2020 17:17:52 -0400
Message-Id: <20200922211802.4083666-5-jsnow@redhat.com>
In-Reply-To: <20200922211802.4083666-1-jsnow@redhat.com>
References: <20200922211802.4083666-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 02:07:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These each take a specific subtype; assert that they got that correct
subtype.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/doc.py | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/scripts/qapi/doc.py b/scripts/qapi/doc.py
index c645876b24..62b8f34707 100644
--- a/scripts/qapi/doc.py
+++ b/scripts/qapi/doc.py
@@ -8,7 +8,11 @@
 from typing import Optional
 
 from .gen import QAPIGenDoc
-from .schema import QAPISchemaVisitor, QAPISchemaObjectTypeMember
+from .schema import (
+    QAPISchemaEnumMember,
+    QAPISchemaObjectTypeMember,
+    QAPISchemaVisitor,
+)
 
 MSG_FMT = """
 @deftypefn {type} {{}} {name}
@@ -136,12 +140,14 @@ def texi_if(ifcond, prefix='\n', suffix='\n'):
 
 def texi_enum_value(value, desc, suffix):
     """Format a table of members item for an enumeration value"""
+    assert isinstance(value, QAPISchemaEnumMember)
     return '@item @code{%s}\n%s%s' % (
         value.name, desc, texi_if(value.ifcond, prefix='@*'))
 
 
 def texi_member(member, desc, suffix):
     """Format a table of members item for an object type member"""
+    assert isinstance(member, QAPISchemaObjectTypeMember)
     typ = member.type.doc_type()
     membertype = ': ' + typ if typ else ''
     return '@item @code{%s%s}%s%s\n%s%s' % (
-- 
2.26.2


