Return-Path: <SRS0=5YAC=T2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00CF9C282E3
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2019 15:03:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9A3C20815
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2019 15:03:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ao2.it header.i=@ao2.it header.b="Jjnlaihg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9A3C20815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ao2.it
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56244 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUugj-0003ml-1W
	for qemu-devel@archiver.kernel.org; Sun, 26 May 2019 11:03:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58201)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <ao2@ao2.it>)
	id 1hUudN-00017c-Qg
	for qemu-devel@nongnu.org; Sun, 26 May 2019 11:00:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ao2@ao2.it>) id 1hUuSA-0003Er-SB
	for qemu-devel@nongnu.org; Sun, 26 May 2019 10:48:51 -0400
Received: from mail.ao2.it ([2001:4b98:dc0:41:216:3eff:fe7c:639b]:59058
	helo=ao2.it)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ao2@ao2.it>) id 1hUuSA-00039n-Gv
	for qemu-devel@nongnu.org; Sun, 26 May 2019 10:48:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ao2.it;
	s=20180927; 
	h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
	bh=L5J+dSdjLsPO2TI1jfaBAO2x1P444tZo5GX3+5PiF2M=; 
	b=Jjnlaihg+A7nTpKtStZ0npd9zbqcLyK71HcQjBKE9qGAWp/Ob6BqNKTz1Wq+iryDUnvbCuikYbc/ByZe2/7ef8YM4/TxYQrnftrGitl9fNstK3OiL/8uS8sYXQKJqcJFinUN3F9SRjP3OW/MvSctRl5F9TDI+9ajKhQIbOb5UZSkKsBcbkrQzUiPdc8fYRzFVTPguIkAWnosCexr6yS9jydHFtSTs2eLN7TiVjYnn6pMsp7w9EztvaqA8CiagXHcjxuhPL4+/w6oskM3DwXMzzYL5+KTC8ISzEMrHp1NqoiG0QOX+nMucHpKps3KJ58crrMAXheaBZ7vZ/9xDrKdCA==;
Received: from localhost ([::1] helo=jcn)
	by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.84_2) (envelope-from <ao2@ao2.it>)
	id 1hUuRf-0001fD-K0; Sun, 26 May 2019 16:48:19 +0200
Received: from ao2 by jcn with local (Exim 4.92) (envelope-from <ao2@ao2.it>)
	id 1hUuS1-0007p0-1D; Sun, 26 May 2019 16:48:41 +0200
From: Antonio Ospite <ao2@ao2.it>
To: qemu-devel@nongnu.org
Date: Sun, 26 May 2019 16:47:47 +0200
Message-Id: <20190526144747.30019-3-ao2@ao2.it>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190526144747.30019-1-ao2@ao2.it>
References: <20190526144747.30019-1-ao2@ao2.it>
MIME-Version: 1.0
X-Face: z*RaLf`X<@C75u6Ig9}{oW$H; 1_\2t5)({*|jhM<pyWR#k60!#=#>/Vb;
	]yA5<GWI5`6u&+ ; 6b'@y|8w"wB;
	4/e!7wYYrcqdJFY,~%Gk_4]cq$Ei/7<j&N3ah(m`ku?pX.&+~:_/wC~dwn^)MizBG
	!pE^+iDQQ1yC6^,)YDKkxDd!T>\I~93>J<_`<4)A{':UrE
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 2001:4b98:dc0:41:216:3eff:fe7c:639b
Subject: [Qemu-devel] [PATCH v3 2/2] configure: disallow spaces and colons
 in source path and build path
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Antonio Ospite <antonio.ospite@collabora.com>,
	Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Antonio Ospite <antonio.ospite@collabora.com>

The configure script breaks when the qemu source directory is in a path
containing white spaces, in particular the list of targets is not
correctly generated when calling "./configure --help" because of how the
default_target_list variable is built.

In addition to that, *building* qemu from a directory with spaces breaks
some assumptions in the Makefiles, even if the original source path does
not contain spaces like in the case of an out-of-tree build, or when
symlinks are involved.

To avoid these issues, refuse to run the configure script and the
Makefile if there are spaces or colons in the source path or the build
path, taking as inspiration what the kbuild system in linux does.

Buglink: https://bugs.launchpad.net/qemu/+bug/1817345

Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Antonio Ospite <antonio.ospite@collabora.com>
---
 Makefile  | 4 ++++
 configure | 5 +++++
 2 files changed, 9 insertions(+)

diff --git a/Makefile b/Makefile
index e02b88bcb1..bed1323a45 100644
--- a/Makefile
+++ b/Makefile
@@ -1,5 +1,9 @@
 # Makefile for QEMU.
 
+ifneq ($(words $(subst :, ,$(CURDIR))), 1)
+  $(error main directory cannot contain spaces nor colons)
+endif
+
 # Always point to the root of the build tree (needs GNU make).
 BUILD_DIR=$(CURDIR)
 
diff --git a/configure b/configure
index 9f12120ad9..2833d73ccc 100755
--- a/configure
+++ b/configure
@@ -279,6 +279,11 @@ ld_has() {
 # make source path absolute
 source_path=$(cd "$(dirname -- "$0")"; pwd)
 
+if printf %s\\n "$source_path" "$PWD" | grep -q "[[:space:]:]";
+then
+  error_exit "main directory cannot contain spaces nor colons"
+fi
+
 # default parameters
 cpu=""
 iasl="iasl"
-- 
2.20.1


