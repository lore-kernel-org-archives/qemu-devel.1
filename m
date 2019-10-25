Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F3D1CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 23:50:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB3F421D7F
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 23:50:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="BFLu6xzm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB3F421D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO9Lk-00037r-Is
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 19:50:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49967)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=194c68654=alistair.francis@wdc.com>)
 id 1iO91G-0005JZ-4y
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 19:29:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=194c68654=alistair.francis@wdc.com>)
 id 1iO91E-0004c9-UU
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 19:29:21 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:36814)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=194c68654=alistair.francis@wdc.com>)
 id 1iO91E-0004Yx-Mj; Fri, 25 Oct 2019 19:29:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1572046160; x=1603582160;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=KQTJlLwPnIbWndGHCjHYlEHieDoaNSr+5kuGlRAEudA=;
 b=BFLu6xzm5r2IlB/4saZJCytuBn93sj+/oWIQTd1YQ3GTEyHutytVsTPn
 LKkI7ISfFRUl+Qp2mxymxJ6eDlJRLtce5zj54lE3W2JEUBw2Uu9i11uaF
 ZWvwz1EaZpSSd8OJPKbrHSR+5cgBuvoLqGCih3HR/2fZ/o7sy/079Y57r
 y/Zxdh9VXPQDhofj5P0858dzYkL9uksAUv+vJ9d3xOrgRsvzplHz6K+Ig
 1ccnFCaMS2XdcrK5GRYdDZFrC3XnnPu+6Y2+6G+m/97/i32djqAPexha2
 EnaQYPdom7e8Uma/avuIlM3hGdZ4BWk3DwtHY9VgvEtofQL/neZUDZIWj w==;
IronPort-SDR: iJAyVlYGIEV3X6lQ8woaTgSSjjqSHoflvrumC2+kEjF6x+0KY1oDaoGMdMrMUG7hS+LiW64kGr
 hwbmWzqWf/gB9Pa0YFDTEVvMM/pyjqIGNW3LXl+r0WX/7+J8biFpm6nkknjAnjOwNvtu0gutLY
 c25hFVD6VhsQWmipi4I6Nj907dWtiYnKMkEGbn6i6AR0j36/SVZK7lzrvUx5rUQ3/AxtTPzGGW
 c1Y88vHO81NjwAJQJrWR424NllAtTF9W5OU7pxyAUnTlWpZ3u/o02nowgH/PFZHFcBgPWkuD+i
 4ME=
X-IronPort-AV: E=Sophos;i="5.68,230,1569254400"; d="scan'208";a="122956695"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 26 Oct 2019 07:29:20 +0800
IronPort-SDR: C4LiGyJ7geaswhy86vHBGFz9KJKuq7WVVLGdy1KNtUyi65SGKzJgaPwA0P0ZFvKkToDLCN0ugK
 Mu4aRRa95YzOImHiFJi8GV8N4DXgDDZ3PeTVUg9bi3HIKkE4Lt47rBSV7y6mBdtHdzb7mD58PN
 ERjDjURSiQm503JlzLwNmVKw6cmVaw+l1qrBcbUQV0qbpv54PSCuOW8T6OkfkOzWBVZll1oWkR
 s0eAB7vDUsdC9p6Sm2Eq2hq8cU/P3NSfSy4c4sO32NX0aqB0G/wUJt+cWnW6jFFAZhxlIXhsfF
 3AB9SyT2h6jVWtngu8k613kO
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Oct 2019 16:24:46 -0700
IronPort-SDR: uDhf2LHIXUQk6Fzq+ZvygT4BaBLCIWTPfNP960Cy70gQSrbtCD+yjy9SmzphEwwUD6L8bLoR03
 mXIOcZ6Q/di7VrOy6qvDjtFJe85ks9HVZP1JQN6D0L5qeXQddBO7aQFAvCuBTVQHkrJYC7+gOr
 0zkwpNMjAyvO+Xq/iafearY/7iOW5+C7agQdsGO/nUdf/RetWN84ye6ugfEYcS43vS9c1WQbJZ
 RzX4HSYmoD6CP2m+woLgtVYM0HFo7YRsAaVTvA8nkZwXVUyexczNcPdJ69R3qzlyv4ZfSk2a9F
 dw8=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.58])
 by uls-op-cesaip01.wdc.com with ESMTP; 25 Oct 2019 16:29:20 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v2 22/27] target/riscv: Respect MPRV and SPRV for floating
 point ops
Date: Fri, 25 Oct 2019 16:24:25 -0700
Message-Id: <6e97814eb37a0f5c56ef86a6c4ae5ac07d25b88b.1572045716.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1572045716.git.alistair.francis@wdc.com>
References: <cover.1572045716.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 216.71.154.45
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
Cc: alistair23@gmail.com, palmer@sifive.com, alistair.francis@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

mark_fs_dirty() is the only place in translate.c that uses the
virt_enabled bool. Let's respect the contents of MSTATUS.MPRV and
HSTATUS.SPRV when setting the bool as this is used for performing
floating point operations when V=0.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/translate.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 19771904f4..ea19ba9c5d 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -750,7 +750,21 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->mstatus_fs = ctx->base.tb->flags & TB_FLAGS_MSTATUS_FS;
     ctx->priv_ver = env->priv_ver;
 #if !defined(CONFIG_USER_ONLY)
-    ctx->virt_enabled = riscv_cpu_virt_enabled(env);
+    if (riscv_has_ext(env, RVH)) {
+        ctx->virt_enabled = riscv_cpu_virt_enabled(env);
+        if (env->priv_ver == PRV_M &&
+            get_field(*env->mstatus, MSTATUS_MPRV) &&
+            get_field(*env->mstatus, MSTATUS_MPV)) {
+            ctx->virt_enabled = true;
+        } else if (env->priv == PRV_S &&
+                   !riscv_cpu_virt_enabled(env) &&
+                   get_field(env->hstatus, HSTATUS_SPRV) &&
+                   get_field(env->hstatus, HSTATUS_SPV)) {
+            ctx->virt_enabled = true;
+        }
+    } else {
+        ctx->virt_enabled = false;
+    }
 #else
     ctx->virt_enabled = false;
 #endif
-- 
2.23.0


