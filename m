Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19934C4727C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 11:51:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C1ED20B1F
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 11:51:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ywx7ybpa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C1ED20B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNx7Q-0001wc-77
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 07:51:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50416)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kNx5c-0001MR-Fa
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 07:49:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42151)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kNx5Z-0002dd-NB
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 07:49:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601552971;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type;
 bh=wmMdZWoT/bkSJT7jVnilCAZXevjFm+2Va7U/XLGk3GY=;
 b=Ywx7ybpaoszY2GbmbXrpvLAB3PzpLaSdJQkGR3vr5xbXyvNcrCZmviIvepBPyZ0ua2LVMX
 n5lRde4TRBkMZYCDqo/EFjLVKIc6q4g9fHDV65UnK5mY2m4OsEjfgdA+7K7RmlUgpiJNPP
 hHm6X2wEcLCVsxuX1idYYcg45j0Xtr8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-87BSCpqTMtWzkY26ebhLOw-1; Thu, 01 Oct 2020 07:49:30 -0400
X-MC-Unique: 87BSCpqTMtWzkY26ebhLOw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4533A18BA280;
 Thu,  1 Oct 2020 11:49:29 +0000 (UTC)
Received: from thuth.com (ovpn-112-107.ams2.redhat.com [10.36.112.107])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 977C960C07;
 Thu,  1 Oct 2020 11:49:27 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] cirrus.yml: Avoid base-devel group to speed up the build
Date: Thu,  1 Oct 2020 13:49:19 +0200
Message-Id: <20201001114919.159268-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 02:15:30
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
Cc: Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?q?=E7=BD=97=E5=8B=87=E5=88=9A?= <luoyonggang@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The base-devel group pulls in a lot of stuff like various automake
versions that we do not really need for building QEMU. Let's directly
specify our requirements instead, then the job has to download way
less files and finishes more quickly (at least 5 minutes for me).

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 .cirrus.yml | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/.cirrus.yml b/.cirrus.yml
index d58782ce67..9f7d2c0a78 100644
--- a/.cirrus.yml
+++ b/.cirrus.yml
@@ -70,8 +70,7 @@ windows_msys2_task:
     - taskkill /F /IM gpg-agent.exe
     - C:\tools\msys64\usr\bin\bash.exe -lc "pacman --noconfirm -Su"
     - C:\tools\msys64\usr\bin\bash.exe -lc "pacman --noconfirm -S --needed
-        base-devel
-        git
+        diffutils git grep make pkg-config sed
         mingw-w64-x86_64-python
         mingw-w64-x86_64-python-setuptools
         mingw-w64-x86_64-toolchain
@@ -81,7 +80,6 @@ windows_msys2_task:
         mingw-w64-x86_64-gtk3
         mingw-w64-x86_64-glib2
         mingw-w64-x86_64-ninja
-        mingw-w64-x86_64-make
         mingw-w64-x86_64-lzo2
         mingw-w64-x86_64-zstd
         mingw-w64-x86_64-libjpeg-turbo
-- 
2.18.2


