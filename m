Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82775C04AAA
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 08:28:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F2842087F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 08:28:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ao2.it header.i=@ao2.it header.b="v8Iky5DF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F2842087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ao2.it
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36523 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMTYj-0001Jx-Ic
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 04:28:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55086)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <ao2@ao2.it>)
	id 1hMTXu-0000yg-SN
	for qemu-devel@nongnu.org; Fri, 03 May 2019 04:27:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ao2@ao2.it>) id 1hMTXt-0006vt-Pz
	for qemu-devel@nongnu.org; Fri, 03 May 2019 04:27:54 -0400
Received: from mail.ao2.it ([2001:4b98:dc0:41:216:3eff:fe7c:639b]:39650
	helo=ao2.it)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ao2@ao2.it>) id 1hMTXt-0006uv-EB
	for qemu-devel@nongnu.org; Fri, 03 May 2019 04:27:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ao2.it;
	s=20180927; 
	h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
	bh=O/x1pmBYyHhH6YBHV9mpou5EYK1MlQCzx8xBUn4MzGw=; 
	b=v8Iky5DF6I55sWTtvOWAGdxtxKUyzD+k2H6V5wowpf0cboKr1rLThiHtpCBErJa/GpXh8fOg76W9R9VVNjbVuGyTsDBpUcXDFhZ70USUSpKplFLnaeYlTuC96xihubgZUn+TsImz11oVxssVL32UXg8jM0iy7hoG3RpXqPQh3qyS+S1NJ0ZqLHIPSUP6/SSxYRhhTP6KaIO6vRZyyIAm7k7YfAsQIP+j3tp/ERrYuXa/eevJK7j7TpGk49o6+fL7rEyqAR65kPdC/7HmgI8hGFx1oLEjVJ0pAevZfMIh5b0Fc/P3VocexHMTBYHBcNUTOElyAYrEG9nmi5vbxGlpgQ==;
Received: from localhost ([::1] helo=jcn)
	by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.84_2) (envelope-from <ao2@ao2.it>)
	id 1hMTXl-0001Ll-K1; Fri, 03 May 2019 10:27:45 +0200
Received: from ao2 by jcn with local (Exim 4.92) (envelope-from <ao2@ao2.it>)
	id 1hMTXm-0004Ig-Eq; Fri, 03 May 2019 10:27:46 +0200
From: Antonio Ospite <ao2@ao2.it>
To: qemu-devel@nongnu.org
Date: Fri,  3 May 2019 10:27:27 +0200
Message-Id: <20190503082728.16485-2-ao2@ao2.it>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190503082728.16485-1-ao2@ao2.it>
References: <20190503082728.16485-1-ao2@ao2.it>
MIME-Version: 1.0
X-Face: z*RaLf`X<@C75u6Ig9}{oW$H; 1_\2t5)({*|jhM<pyWR#k60!#=#>/Vb;
	]yA5<GWI5`6u&+ ; 6b'@y|8w"wB;
	4/e!7wYYrcqdJFY,~%Gk_4]cq$Ei/7<j&N3ah(m`ku?pX.&+~:_/wC~dwn^)MizBG
	!pE^+iDQQ1yC6^,)YDKkxDd!T>\I~93>J<_`<4)A{':UrE
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 2001:4b98:dc0:41:216:3eff:fe7c:639b
Subject: [Qemu-devel] [PATCH v2 1/2] configure: set source_path only once
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Antonio Ospite <ao2@ao2.it>,
	Antonio Ospite <antonio.ospite@collabora.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190503082727.sy2Vx2Qd9R7M4XDyeywwA97HmHTlNucEmQYYuqH3mYA@z>

From: Antonio Ospite <antonio.ospite@collabora.com>

Since commit 79d77bcd36 (configure: Remove --source-path option,
2019-04-29) source_path cannot be overridden anymore, move it out of the
"default parameters" block since the word "default" may suggest that the
value can change, while in fact it does not.

While at it, only set source_path once and separate the positional
argument of basename with "--" to more robustly cover the case of path
names starting with a dash.

Signed-off-by: Antonio Ospite <antonio.ospite@collabora.com>
---
 configure | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/configure b/configure
index 60719ddcc5..9832cbca5c 100755
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


