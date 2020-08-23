Return-Path: <SRS0=gE17=CB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19083C433E1
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2020 08:33:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE6C22074D
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2020 08:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AGcGq1G0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE6C22074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9lRB-00087F-Ve
	for qemu-devel@archiver.kernel.org; Sun, 23 Aug 2020 04:33:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48934)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1k9lQV-0007ej-SU
 for qemu-devel@nongnu.org; Sun, 23 Aug 2020 04:32:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22106
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1k9lQT-00023D-53
 for qemu-devel@nongnu.org; Sun, 23 Aug 2020 04:32:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598171546;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type;
 bh=7XF5L7EjFt5FvEK1b9JfyjrMR+afqRtPfd2sKmLQsxE=;
 b=AGcGq1G0onlkzoyd/TppWZH4pFX5G9EVnmYXNAO1mNRvWfOIPmsFjUUu5KV25AA66ZVlNu
 4t1Wm+zhr7C6fv2BLLdpdWN4sb0kgu2f/LwnBxbNukXSzwNWSH0ppdZnLrXaf4NgEMftZJ
 hfxypfc7DFHr4hz239fUeq8Byes6AzY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-oRWwSqY7ODO6CDYSZV016w-1; Sun, 23 Aug 2020 04:32:22 -0400
X-MC-Unique: oRWwSqY7ODO6CDYSZV016w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7BEC380EF8C
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2020 08:32:21 +0000 (UTC)
Received: from thuth.com (ovpn-112-57.ams2.redhat.com [10.36.112.57])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B76BB2AAA5;
 Sun, 23 Aug 2020 08:32:17 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH] meson: Build qemu-nbd on macOS again
Date: Sun, 23 Aug 2020 10:32:15 +0200
Message-Id: <20200823083215.14952-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/23 04:32:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Before switching to the meson build system, we used to compile qemu-nbd
for macOS, too, which is especially important for running the iotests
there. Commit b7c70bf2c5 disabled it by accident, since it did not take
into consideration that the $bsd variable in the configure script was
also set to "yes" on macOS. Fix it by enabling qemu-nbd on all systems
but Windows now instead (which was likely the original intention of the
old code in the configure script).

Fixes: b7c70bf2c5 ("meson: qemu-{img,io,nbd}")
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index df5bf728b5..d79f849768 100644
--- a/meson.build
+++ b/meson.build
@@ -1075,7 +1075,7 @@ if have_tools
   qemu_io = executable('qemu-io', files('qemu-io.c'),
              dependencies: [block, qemuutil], install: true)
   qemu_block_tools += [qemu_img, qemu_io]
-  if targetos == 'linux' or targetos == 'sunos' or targetos.endswith('bsd')
+  if targetos != 'windows'
     qemu_nbd = executable('qemu-nbd', files('qemu-nbd.c'),
                dependencies: [block, qemuutil], install: true)
     qemu_block_tools += [qemu_nbd]
-- 
2.18.2


