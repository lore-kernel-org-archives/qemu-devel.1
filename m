Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2839EC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 20:19:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8383207ED
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 20:19:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QgKEDzGh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8383207ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjTg2-0004PH-6v
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 16:19:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55738)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjTA9-0001PU-J9
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:46:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47704
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjTA7-0001M2-Ey
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:46:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591904814;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Mg9ONK0InEVWqpvTKJWUqO2Fsf0hqgK0J0g+zDJ5GR8=;
 b=QgKEDzGhsC6eYEjVrQSRbcrUbgNUCq0Sd7kcnbSV1okIgRtCGKO2QmHirZdFMqP6fOQb5q
 b6a1JAQayLBjie3CmNf37FWPqUO24Z++iGoDKz0wu5iH1nRQAOY0pWg3o1v2Dd091gceDB
 khEe/GQ6snCqe1yCRTPWs4W7m8W9adE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-RY5uj7VXOTuyZSA-2doIeg-1; Thu, 11 Jun 2020 15:46:52 -0400
X-MC-Unique: RY5uj7VXOTuyZSA-2doIeg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5AF1583DE6B;
 Thu, 11 Jun 2020 19:46:50 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CB16860CD3;
 Thu, 11 Jun 2020 19:46:49 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 079/115] configure: Do not ignore malloc value
Date: Thu, 11 Jun 2020 15:44:13 -0400
Message-Id: <20200611194449.31468-80-pbonzini@redhat.com>
In-Reply-To: <20200611194449.31468-1-pbonzini@redhat.com>
References: <20200611194449.31468-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 08:37:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Leonid Bloch <lbloch@janustech.com>, Leonid Bloch <lb.workbox@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Leonid Bloch <lbloch@janustech.com>

Not checking the value of malloc will cause a warning with GCC 10.1,
which may result in configuration failure, with the following line in
config.log:

config-temp/qemu-conf.c:2:18: error: ignoring return value of â€˜mallocâ€™ declared with attribute â€˜warn_unused_resultâ€™ [-Werror=unused-result]
    2 | int main(void) { malloc(1); return 0; }
      |                  ^~~~~~~~~

Signed-off-by: Leonid Bloch <lb.workbox@gmail.com>
Message-Id: <20200524221204.9791-1-lb.workbox@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/configure b/configure
index 53a6dd0297..dbc16b5656 100755
--- a/configure
+++ b/configure
@@ -4587,7 +4587,13 @@ fi
 if test "$tcmalloc" = "yes" ; then
   cat > $TMPC << EOF
 #include <stdlib.h>
-int main(void) { malloc(1); return 0; }
+int main(void) {
+    void *tmp = malloc(1);
+    if (tmp != NULL) {
+        return 0;
+    }
+    return 1;
+}
 EOF
 
   if compile_prog "" "-ltcmalloc" ; then
@@ -4603,7 +4609,13 @@ fi
 if test "$jemalloc" = "yes" ; then
   cat > $TMPC << EOF
 #include <stdlib.h>
-int main(void) { malloc(1); return 0; }
+int main(void) {
+    void *tmp = malloc(1);
+    if (tmp != NULL) {
+        return 0;
+    }
+    return 1;
+}
 EOF
 
   if compile_prog "" "-ljemalloc" ; then
@@ -6164,7 +6176,9 @@ if test "$sanitizers" = "yes" ; then
 #include <stdlib.h>
 int main(void) {
     void *tmp = malloc(10);
-    return *(int *)(tmp + 2);
+    if (tmp != NULL) {
+        return *(int *)(tmp + 2);
+    }
 }
 EOF
   if compile_prog "$CPU_CFLAGS -Werror -fsanitize=undefined" ""; then
-- 
2.26.2



