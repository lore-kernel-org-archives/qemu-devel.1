Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E3DC388F9
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 18:56:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77C01221FB
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 18:56:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NBpTA9Z8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77C01221FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVJHn-0002aU-Df
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 14:56:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42606)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kVJDw-000605-0j
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 14:52:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38062)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kVJDq-0008BN-2v
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 14:52:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603306341;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AneD+Ri8IbWtHxHDLQSwdEj4j9U8MUGPrlXvAoTn0ms=;
 b=NBpTA9Z8o3iF9SUy6GAKG4LTzTWCXzxqi8SC9bGoN7m9aREzrw0NQEo0SpYNxEVMufnwCg
 YPhA+g0lwIBVTXBZYXfcS4TZ2cLSRlUaTQcYQnb56H2azQu8SJfizfj2OXVJ1WsWNyMfq0
 nA37HokDMHclQsWwhB4/fN7oDES/1Qk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-549-75-M8prSNny-nucF6nTYiA-1; Wed, 21 Oct 2020 14:52:19 -0400
X-MC-Unique: 75-M8prSNny-nucF6nTYiA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8A3FA1084C9A
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 18:52:18 +0000 (UTC)
Received: from scv.redhat.com (ovpn-116-160.rdu2.redhat.com [10.10.116.160])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 80C4F10027A5;
 Wed, 21 Oct 2020 18:52:17 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 10/15] scripts/qom-fuse: use QOMCommand.qom_list()
Date: Wed, 21 Oct 2020 14:52:03 -0400
Message-Id: <20201021185208.1611145-11-jsnow@redhat.com>
In-Reply-To: <20201021185208.1611145-1-jsnow@redhat.com>
References: <20201021185208.1611145-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/21 02:16:02
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
Cc: Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>
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
index f9bf85f382..b1030273ef 100755
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


