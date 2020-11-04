Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1EC1C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 00:44:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23F8C22403
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 00:44:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CmDRMu7m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23F8C22403
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ka6uf-0006xs-2b
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 19:44:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35366)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1ka6n3-0006KD-CJ
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 19:36:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60063)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1ka6mx-0004or-Cx
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 19:36:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604450193;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sA6VFb1LRcC1wcG4j9cZhiPji9rUnXMqeMGltu8wD0k=;
 b=CmDRMu7mzrz4MU0fHCNCSt/LeqyunIHaF5T+P4K62vgDouqi2dyulc6oZofsGtAY9csWQl
 L3AFx4ds48nzjqpsKxykU/N5hQTN7AXnGxTM6xwNNoiWeWvrEuiV4LD7zbaf4Wl5LlNHmc
 YQsWHzLOS95r4wgo4wxpdKP9Vco/kBs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-92-HOzc8W9zOiy-RrNPjAnIKA-1; Tue, 03 Nov 2020 19:36:32 -0500
X-MC-Unique: HOzc8W9zOiy-RrNPjAnIKA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E1DBB11BD35A
 for <qemu-devel@nongnu.org>; Wed,  4 Nov 2020 00:36:24 +0000 (UTC)
Received: from scv.redhat.com (ovpn-119-97.rdu2.redhat.com [10.10.119.97])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EA8807512C;
 Wed,  4 Nov 2020 00:36:23 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 10/72] scripts/qom-fuse: use QOMCommand.qom_list()
Date: Tue,  3 Nov 2020 19:35:00 -0500
Message-Id: <20201104003602.1293560-11-jsnow@redhat.com>
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
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 01:02:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

the qom_list method provides a type-safe object that's easier to type
check, so switch to using it.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qmp/qom-fuse | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/scripts/qmp/qom-fuse b/scripts/qmp/qom-fuse
index f9bf85f38217..b1030273efaa 100755
--- a/scripts/qmp/qom-fuse
+++ b/scripts/qmp/qom-fuse
@@ -95,7 +95,7 @@ class QOMFuse(QOMCommand, Operations):
     def is_object(self, path):
         """Is the given QOM path an object?"""
         try:
-            self.qmp.command('qom-list', path=path)
+            self.qom_list(path)
             return True
         except QMPResponseError:
             return False
@@ -106,8 +106,8 @@ class QOMFuse(QOMCommand, Operations):
         if path == '':
             path = '/'
         try:
-            for item in self.qmp.command('qom-list', path=path):
-                if item['name'] == prop:
+            for item in self.qom_list(path):
+                if item.name == prop:
                     return True
             return False
         except QMPResponseError:
@@ -119,11 +119,9 @@ class QOMFuse(QOMCommand, Operations):
         if path == '':
             path = '/'
         try:
-            for item in self.qmp.command('qom-list', path=path):
-                if item['name'] == prop:
-                    if item['type'].startswith('link<'):
-                        return True
-                    return False
+            for item in self.qom_list(path):
+                if item.name == prop and item.link:
+                    return True
             return False
         except QMPResponseError:
             return False
@@ -201,8 +199,8 @@ class QOMFuse(QOMCommand, Operations):
     def readdir(self, path, fh):
         yield '.'
         yield '..'
-        for item in self.qmp.command('qom-list', path=path):
-            yield str(item['name'])
+        for item in self.qom_list(path):
+            yield item.name
 
 
 if __name__ == '__main__':
-- 
2.26.2


