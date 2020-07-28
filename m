Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E5D5C433EB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 07:45:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C78521D95
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 07:45:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gD8qBXVE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C78521D95
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0KIj-0004t9-E9
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 03:45:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40724)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1k0KHe-00039d-Tk
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 03:44:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38527
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1k0KHd-0003wR-5N
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 03:44:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595922260;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=Dja6d3cLOAj8e/J65kFx1u0KL10LuZLmQtBJcYPRfRo=;
 b=gD8qBXVEE8TFAYn/Q6O9ZtJjsWOF7270GvBrFaoejXxKuGGfabv9xEjeGEcmIh0u3j5D83
 Mv1JLHr25M+axffj1EYpmjJKX3hsTu+x/euLS7s63Cn3R5P7gFKNaMSaSDTSxck2ie10nq
 PCR91kzvlT0Jv7fBS+54+TIKjxBRWvY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-277-z_qZXuFUOwudNDa2mhO-wg-1; Tue, 28 Jul 2020 03:44:18 -0400
X-MC-Unique: z_qZXuFUOwudNDa2mhO-wg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F3D7D100AA25;
 Tue, 28 Jul 2020 07:44:16 +0000 (UTC)
Received: from thuth.com (ovpn-112-161.ams2.redhat.com [10.36.112.161])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1FB6A726B6;
 Tue, 28 Jul 2020 07:44:14 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2 3/4] cirrus.yml: Compile macOS with -Werror
Date: Tue, 28 Jul 2020 09:44:04 +0200
Message-Id: <20200728074405.13118-4-thuth@redhat.com>
In-Reply-To: <20200728074405.13118-1-thuth@redhat.com>
References: <20200728074405.13118-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=207.211.31.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 23:55:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Ed Maste <emaste@freebsd.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Compiler warnings currently go unnoticed in our macOS builds, since -Werror
is only enabled for Linux and MinGW builds by default. So let's enable them
here now, too.
Unfortunately, the sasl header is marked as deprecated in the macOS headers
and thus generates a lot of deprecation warnings. Thus we have to also use
-Wno-error=deprecated-declarations to be able to compile the code here.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 .cirrus.yml | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/.cirrus.yml b/.cirrus.yml
index b50da72eec..86a059c12f 100644
--- a/.cirrus.yml
+++ b/.cirrus.yml
@@ -24,7 +24,9 @@ macos_task:
   script:
     - mkdir build
     - cd build
-    - ../configure --python=/usr/local/bin/python3 || { cat config.log; exit 1; }
+    - ../configure --python=/usr/local/bin/python3 --enable-werror
+                   --extra-cflags='-Wno-error=deprecated-declarations'
+                   || { cat config.log; exit 1; }
     - gmake -j$(sysctl -n hw.ncpu)
     - gmake check
 
@@ -37,6 +39,7 @@ macos_xcode_task:
   script:
     - mkdir build
     - cd build
-    - ../configure --cc=clang || { cat config.log; exit 1; }
+    - ../configure --extra-cflags='-Wno-error=deprecated-declarations'
+                   --enable-werror --cc=clang || { cat config.log; exit 1; }
     - gmake -j$(sysctl -n hw.ncpu)
     - gmake check
-- 
2.18.1


