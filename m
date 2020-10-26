Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 007B5C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 14:02:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 971842463C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 14:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eHLtU1jM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 971842463C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX34l-0001KI-9c
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 10:02:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39596)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kX2uo-0005if-I3
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 09:52:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60764)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kX2uW-0001kg-Mf
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 09:52:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603720296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jmqeimzHMB012rfAVLqb0I9/4/X5Fdg6WEMvNReylTc=;
 b=eHLtU1jM8ZiJp61JGhfz7DOEKboWuSHrHmdPis9QoCeTGsFhiqWywg3AK9dHmNJ/DFWxm7
 A60fJwXVi6pEdC620/i/SRVJpDQ04IBPdPTRsGSkMPGBp9q5dWKxDWVfTYNZibl8Tpz175
 rojPvnwgyU7u4ursLpZaigkEiwU7+WM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-0C3LqNcuOGu9WXCpofHOPw-1; Mon, 26 Oct 2020 09:51:33 -0400
X-MC-Unique: 0C3LqNcuOGu9WXCpofHOPw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 430EC876E3D;
 Mon, 26 Oct 2020 13:51:32 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E83006EF78;
 Mon, 26 Oct 2020 13:51:31 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 01/17] build: fix macOS --enable-modules build
Date: Mon, 26 Oct 2020 09:51:15 -0400
Message-Id: <20201026135131.3006712-2-pbonzini@redhat.com>
In-Reply-To: <20201026135131.3006712-1-pbonzini@redhat.com>
References: <20201026135131.3006712-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/25 21:03:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Emmanuel Blot <eblot.ml@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Apple's nm implementation includes empty lines in the output that are not
found in GNU binutils.  This confuses scripts/undefsym.py, though it did
not confuse the scripts/undefsym.sh script that it replaced.  To fix
this, ignore lines that do not have two fields.

Reported-by: Emmanuel Blot <eblot.ml@gmail.com>
Tested-by: Emmanuel Blot <eblot.ml@gmail.com>
Fixes: 604f3e4e90 ("meson: Convert undefsym.sh to undefsym.py", 2020-09-08)
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .cirrus.yml         |  2 +-
 scripts/undefsym.py | 11 +++++------
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/.cirrus.yml b/.cirrus.yml
index 81a2960b1a..900437dd2a 100644
--- a/.cirrus.yml
+++ b/.cirrus.yml
@@ -40,7 +40,7 @@ macos_xcode_task:
   script:
     - mkdir build
     - cd build
-    - ../configure --extra-cflags='-Wno-error=deprecated-declarations'
+    - ../configure --extra-cflags='-Wno-error=deprecated-declarations' --enable-modules
                    --enable-werror --cc=clang || { cat config.log meson-logs/meson-log.txt; exit 1; }
     - gmake -j$(sysctl -n hw.ncpu)
     - gmake check V=1
diff --git a/scripts/undefsym.py b/scripts/undefsym.py
index 69a895cd26..4b6a72d95f 100644
--- a/scripts/undefsym.py
+++ b/scripts/undefsym.py
@@ -15,12 +15,11 @@ def filter_lines_set(stdout, from_staticlib):
     linesSet = set()
     for line in stdout.splitlines():
         tokens = line.split(b' ')
-        if len(tokens) >= 1:
-            if len(tokens) > 1:
-                if from_staticlib and tokens[1] == b'U':
-                    continue
-                if not from_staticlib and tokens[1] != b'U':
-                    continue
+        if len(tokens) >= 2:
+            if from_staticlib and tokens[1] == b'U':
+                continue
+            if not from_staticlib and tokens[1] != b'U':
+                continue
             new_line = b'-Wl,-u,' + tokens[0]
             if not new_line in linesSet:
                 linesSet.add(new_line)
-- 
2.26.2



