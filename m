Return-Path: <SRS0=5YAC=T2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42EFEC282E3
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2019 15:01:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F20B120815
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2019 15:01:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ao2.it header.i=@ao2.it header.b="DltCLW8X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F20B120815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ao2.it
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56230 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUuer-0002Nc-RT
	for qemu-devel@archiver.kernel.org; Sun, 26 May 2019 11:01:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58201)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <ao2@ao2.it>)
	id 1hUudL-00017c-LF
	for qemu-devel@nongnu.org; Sun, 26 May 2019 11:00:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ao2@ao2.it>) id 1hUuSB-0003F8-3T
	for qemu-devel@nongnu.org; Sun, 26 May 2019 10:48:52 -0400
Received: from mail.ao2.it ([2001:4b98:dc0:41:216:3eff:fe7c:639b]:59056
	helo=ao2.it)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ao2@ao2.it>) id 1hUuSA-00039m-Gw
	for qemu-devel@nongnu.org; Sun, 26 May 2019 10:48:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ao2.it;
	s=20180927; 
	h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
	bh=/dJd9Idb5t9LEOYYSwPyANPLg2VsmDLepPBJ8ZkWXD4=; 
	b=DltCLW8XmusOZT8+leA8gIKVZ99pm2IncH3Ic92TFrhqqdbcC0rzRufIi2vPlSxaSYCVsScysYnpXNvwme0EnUqpEdDVJNC49KgNUPGmG+l30TMZv6JMBcoAXYNdw4vNOqfKcGBHgBjQUb/96yxJ7sX3G5vTm41G7DzCM5TI7Snoe7C2wDfOKhnZScWQuRjc6yJ/bvhDkoDBOYuqT3w4iyXTdmc1jgKAwrG1JUuU6R4rxg0QgCsCGP9wfdHCQo4Mn/uXGiGIMDKu7BswOqeKTBuinyLM1LqZgWNVEKCpR/MrxANM6ZSjLuD1JXbU0OuDY14pQQNBjBUiyxJK2HIUWw==;
Received: from localhost ([::1] helo=jcn)
	by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.84_2) (envelope-from <ao2@ao2.it>)
	id 1hUuRf-0001fE-Mt; Sun, 26 May 2019 16:48:19 +0200
Received: from ao2 by jcn with local (Exim 4.92) (envelope-from <ao2@ao2.it>)
	id 1hUuS0-0007oy-UV; Sun, 26 May 2019 16:48:40 +0200
From: Antonio Ospite <ao2@ao2.it>
To: qemu-devel@nongnu.org
Date: Sun, 26 May 2019 16:47:46 +0200
Message-Id: <20190526144747.30019-2-ao2@ao2.it>
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
Subject: [Qemu-devel] [PATCH v3 1/2] configure: set source_path only once
 and make its definition more robust
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

Since commit 79d77bcd36 (configure: Remove --source-path option,
2019-04-29) source_path cannot be overridden anymore, move it out of the
"default parameters" block since the word "default" may suggest that the
value can change, while in fact it does not.

While at it, only set source_path once and separate the positional
argument of basename with "--" to more robustly cover the case of path
names starting with a dash.

Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Antonio Ospite <antonio.ospite@collabora.com>
---
 configure | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/configure b/configure
index 528b9ff705..9f12120ad9 100755
--- a/configure
+++ b/configure
@@ -276,10 +276,10 @@ ld_has() {
     $ld --help 2>/dev/null | grep ".$1" >/dev/null 2>&1
 }
 
-# default parameters
-source_path=$(dirname "$0")
 # make source path absolute
-source_path=$(cd "$source_path"; pwd)
+source_path=$(cd "$(dirname -- "$0")"; pwd)
+
+# default parameters
 cpu=""
 iasl="iasl"
 interp_prefix="/usr/gnemul/qemu-%M"
-- 
2.20.1


