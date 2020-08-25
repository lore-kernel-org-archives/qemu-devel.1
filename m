Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A526DC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 10:40:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FA28205CB
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 10:40:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="csWdgNlO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FA28205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAWNP-0004zx-Od
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 06:40:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58926)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kAWM4-0002Rk-3J
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 06:39:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43688)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kAWM2-0007LL-BW
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 06:39:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598351941;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8rs4O5WDQdaLYpdEr+vncfMb2NC49pMpaugYuqYsPek=;
 b=csWdgNlOMsHiSw2zyHxmrIRiM/ncEKRnJx2/eomXwpgonHn7pt73AKYhS+d7aRFowtdnYs
 tjB838IsiNm1JhuCd+BGuE2hS2DYqqSiOAvlaibX+7biD7ND+E03N3k0rNJh+7SlCI4YZP
 pSp6sZe/Z8KGb8p+QyIYdAkjA07vvks=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185--xxK4bjCM6aOKgE2VofByA-1; Tue, 25 Aug 2020 06:38:59 -0400
X-MC-Unique: -xxK4bjCM6aOKgE2VofByA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CF54180732F;
 Tue, 25 Aug 2020 10:38:58 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-114-231.ams2.redhat.com
 [10.36.114.231])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 46FBB5C1CF;
 Tue, 25 Aug 2020 10:38:57 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 3/3] nbd: disable signals and forking on Windows builds
Date: Tue, 25 Aug 2020 11:38:50 +0100
Message-Id: <20200825103850.119911-4-berrange@redhat.com>
In-Reply-To: <20200825103850.119911-1-berrange@redhat.com>
References: <20200825103850.119911-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 02:03:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.956,
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Disabling these parts are sufficient to get the qemu-nbd program
compiling in a Windows build.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 meson.build | 7 ++-----
 qemu-nbd.c  | 5 +++++
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/meson.build b/meson.build
index df5bf728b5..1071871605 100644
--- a/meson.build
+++ b/meson.build
@@ -1074,12 +1074,9 @@ if have_tools
              dependencies: [authz, block, crypto, io, qom, qemuutil], install: true)
   qemu_io = executable('qemu-io', files('qemu-io.c'),
              dependencies: [block, qemuutil], install: true)
-  qemu_block_tools += [qemu_img, qemu_io]
-  if targetos == 'linux' or targetos == 'sunos' or targetos.endswith('bsd')
-    qemu_nbd = executable('qemu-nbd', files('qemu-nbd.c'),
+  qemu_nbd = executable('qemu-nbd', files('qemu-nbd.c'),
                dependencies: [block, qemuutil], install: true)
-    qemu_block_tools += [qemu_nbd]
-  endif
+  qemu_block_tools += [qemu_img, qemu_io, qemu_nbd]
 
   subdir('storage-daemon')
   subdir('contrib/rdmacm-mux')
diff --git a/qemu-nbd.c b/qemu-nbd.c
index dc6ef089af..33476a1000 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -899,6 +899,7 @@ int main(int argc, char **argv)
 #endif
 
     if ((device && !verbose) || fork_process) {
+#ifndef WIN32
         int stderr_fd[2];
         pid_t pid;
         int ret;
@@ -962,6 +963,10 @@ int main(int argc, char **argv)
              */
             exit(errors);
         }
+#else /* WIN32 */
+        error_report("Unable to fork into background on Windows hosts");
+        exit(EXIT_FAILURE);
+#endif /* WIN32 */
     }
 
     if (device != NULL && sockpath == NULL) {
-- 
2.26.2


