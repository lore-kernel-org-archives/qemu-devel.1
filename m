Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67641C2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 22:06:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F026C208A9
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 22:06:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HTi5a4JF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F026C208A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKqR3-0002IN-0g
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 18:06:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41206)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kKpgD-0007WU-0r
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 17:18:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55146)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kKpgB-0006eH-3A
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 17:18:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600809506;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ebOceglSTdw4GEvJBey9gnPjX8dXLi8jeI5/H6dHIc8=;
 b=HTi5a4JFbVnKu9+WY1ZWVKQZX62P/2zxQi8cS5b64Vjs+Q6T5c2oOj2+5IzYxlsfEdaNSQ
 WXElc/oRySWOcrzTgw5UB0PGNyqOsnTIELLE83vMQIEYUausn3zvnVTtJyFC5T7Vfib3Q/
 OTo2Vbip5e3MJkhZUzRCqq22KAqpy7U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-486-ZLPmkTHmOgqyJwScLfBRBA-1; Tue, 22 Sep 2020 17:18:22 -0400
X-MC-Unique: ZLPmkTHmOgqyJwScLfBRBA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1C69181CBEB;
 Tue, 22 Sep 2020 21:18:21 +0000 (UTC)
Received: from scv.redhat.com (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D42CD5DA7B;
 Tue, 22 Sep 2020 21:18:19 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 11/14] qapi/doc.py: Don't use private attributes of QAPIGen
 property
Date: Tue, 22 Sep 2020 17:17:59 -0400
Message-Id: <20200922211802.4083666-12-jsnow@redhat.com>
In-Reply-To: <20200922211802.4083666-1-jsnow@redhat.com>
References: <20200922211802.4083666-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
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

Use the new __bool__ method to do the same without exposing the private
attribute.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/doc.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/qapi/doc.py b/scripts/qapi/doc.py
index 5f2b0cd51d..2914e93b1c 100644
--- a/scripts/qapi/doc.py
+++ b/scripts/qapi/doc.py
@@ -344,7 +344,7 @@ def visit_event(self,
         self._gen.add(texi_msg('Event', doc, ifcond, members))
 
     def symbol(self, doc: QAPIDoc, entity: QAPISchemaEntity) -> None:
-        if self._gen._body:
+        if self._gen:
             self._gen.add('\n')
         self.cur_doc = doc
         entity.visit(self)
@@ -352,7 +352,7 @@ def symbol(self, doc: QAPIDoc, entity: QAPISchemaEntity) -> None:
 
     def freeform(self, doc: QAPIDoc) -> None:
         assert not doc.args
-        if self._gen._body:
+        if self._gen:
             self._gen.add('\n')
         self._gen.add(texi_body(doc) + texi_sections(doc, None))
 
-- 
2.26.2


