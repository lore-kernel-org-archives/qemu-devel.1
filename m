Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC46CC433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 09:45:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8617420738
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 09:45:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cStJEsr+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8617420738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kA92B-0003LX-Pa
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 05:44:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45588)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kA91Z-0002T3-3I
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 05:44:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60579)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kA91X-0004Gl-Aw
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 05:44:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598262257;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type;
 bh=UiJBbZ3PUCsKbd9iJzGthse/IhpIXZrPFMOI26xk0b8=;
 b=cStJEsr+s0EVsXY6aMhKLqzfJh+pmXDvwBpjuSD0ooui4kHP1QjmloToK5wFpgGhn+SD4k
 ThVMUPHxE1o5AYQYKCrL3IC1eSf9CDrgY9MFbmGuTSyI/8HbnYaCKRPEOM7tGyFGaS0uo+
 av/oFCYlH2oWzf8kjRMrCHDOuirZcJ0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-URPO2bZLPMesRhi6Afk2oQ-1; Mon, 24 Aug 2020 05:44:14 -0400
X-MC-Unique: URPO2bZLPMesRhi6Afk2oQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C438A64083;
 Mon, 24 Aug 2020 09:44:13 +0000 (UTC)
Received: from thuth.com (ovpn-114-8.ams2.redhat.com [10.36.114.8])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 562215BAC3;
 Mon, 24 Aug 2020 09:44:12 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Ed Maste <emaste@freebsd.org>,
	qemu-devel@nongnu.org
Subject: [PATCH] cirrus.yml: Exclude some targets in the FreeBSD job to speed
 up the build
Date: Mon, 24 Aug 2020 11:44:10 +0200
Message-Id: <20200824094410.6201-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=216.205.24.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/24 04:38:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The FreeBSD jobs currently hit the 1h time limit in the Cirrus-CI.
We've got to exclude some build targets here to make sure that the job
finishes in time again. The targets that are excluded should not hurt
much, since e.g. all the code from i386-softmmu is covered again by
x86_64-softmmu.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 Not sure why the FreeBSD builds suddenly got slower and hit the 1h
 time limit now. Looking at https://cirrus-ci.com/github/qemu/qemu
 it seems like the FreeBSD jobs were already taking ca. 48 minutes
 since quite a while, but since the Meson build system has been merged,
 they now always hit the 1h limit. Could it be that Meson is slow on
 FreeBSD?
 
 I hope disabling some of the "redundant" targets is ok for everybody
 to get this working again. Alternatively, we could also introduce a
 second FreeBSD job and run half of the targets in one job, and half
 of the targets in the other job if that's preferred?
 
 .cirrus.yml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/.cirrus.yml b/.cirrus.yml
index 0742aaf8a3..bd3329b663 100644
--- a/.cirrus.yml
+++ b/.cirrus.yml
@@ -12,7 +12,9 @@ freebsd_12_task:
   script:
     - mkdir build
     - cd build
-    - ../configure --enable-werror || { cat config.log; exit 1; }
+    - ../configure --enable-werror --target-list-exclude='mips64el-softmmu
+        mips-softmmu arm-softmmu i386-softmmu ppc-softmmu riscv32-softmmu
+        sh4eb-softmmu xtensaeb-softmmu' || { cat config.log; exit 1; }
     - gmake -j8
     - gmake V=1 check
 
-- 
2.18.2


