Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC81C433E3
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 14:30:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5470C20771
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 14:30:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hgfpyk96"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5470C20771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jycEl-00025F-JR
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 10:30:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45244)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jycCH-0006Ts-Sx
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 10:27:45 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:51017
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jycCG-0006x2-27
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 10:27:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595514462;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SxgpzSARUKg0APZeWeak/iVUy1+FhCYqHcriF0jmv2s=;
 b=Hgfpyk96xtxf8zHcmVmdTMzYQiWJ3dw9w3avu9io3iYGSrxPUZP9aBcp0lxARKpEiFyTTW
 NNIWMWN5wwumvcfVN+3quYUOhR/hCIEtEfZ7CEmYtVgtFp0Vq6XiCjnw9mFnTUzwKPJbmI
 pvmtZMvXiPmo2VnUS73H2A3qXOvUsrk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-68-cEPslwJ9N_W8pw3ZMJydGg-1; Thu, 23 Jul 2020 10:27:40 -0400
X-MC-Unique: cEPslwJ9N_W8pw3ZMJydGg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EAF9C1DE9
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2020 14:27:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BD75919D7B;
 Thu, 23 Jul 2020 14:27:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 58EAC10A5B7A; Thu, 23 Jul 2020 16:27:38 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/3] scripts/qmp/qom-fuse: Fix getattr(), read() for files in /
Date: Thu, 23 Jul 2020 16:27:38 +0200
Message-Id: <20200723142738.1868568-4-armbru@redhat.com>
In-Reply-To: <20200723142738.1868568-1-armbru@redhat.com>
References: <20200723142738.1868568-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 02:33:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

path, prop = "type".rsplit('/', 1) sets path to "", which doesn't
work.  Correct to "/".

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qmp/qom-fuse | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/scripts/qmp/qom-fuse b/scripts/qmp/qom-fuse
index 405e6ebd67..7c7cff8edf 100755
--- a/scripts/qmp/qom-fuse
+++ b/scripts/qmp/qom-fuse
@@ -45,8 +45,10 @@ class QOMFS(Operations):
             return False
 
     def is_property(self, path):
+        path, prop = path.rsplit('/', 1)
+        if path == '':
+            path = '/'
         try:
-            path, prop = path.rsplit('/', 1)
             for item in self.qmp.command('qom-list', path=path):
                 if item['name'] == prop:
                     return True
@@ -55,8 +57,10 @@ class QOMFS(Operations):
             return False
 
     def is_link(self, path):
+        path, prop = path.rsplit('/', 1)
+        if path == '':
+            path = '/'
         try:
-            path, prop = path.rsplit('/', 1)
             for item in self.qmp.command('qom-list', path=path):
                 if item['name'] == prop:
                     if item['type'].startswith('link<'):
@@ -71,6 +75,8 @@ class QOMFS(Operations):
             return -ENOENT
 
         path, prop = path.rsplit('/', 1)
+        if path == '':
+            path = '/'
         try:
             data = self.qmp.command('qom-get', path=path, property=prop)
             data += '\n' # make values shell friendly
-- 
2.26.2


