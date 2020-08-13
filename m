Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A95C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 10:03:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70BF720781
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 10:03:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b="je7m1KPk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HplBOSZe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70BF720781
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6A58-0001BR-HD
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 06:03:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43682)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qyliss@x220.qyliss.net>)
 id 1k6A3C-0000F4-Nv
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 06:01:34 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:58055)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qyliss@x220.qyliss.net>)
 id 1k6A39-00038X-V2
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 06:01:34 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
 by mailout.west.internal (Postfix) with ESMTP id 390EC999;
 Thu, 13 Aug 2020 05:49:34 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute7.internal (MEProxy); Thu, 13 Aug 2020 05:49:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=
 from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=fm3; bh=FEEaNLmB6GOe5gfKhgL3ys6g6/
 aCgwfXoso39Kjy2R8=; b=je7m1KPkqmRgB+AZaN8pXbKSpff1L5UkRyn7+TJIwe
 lqpWZDXfO2L1v5wy90rwvc7ZzO+2pb0Bxq+2DyCjmtHhb2Niy5RaYcttQmjPTx8d
 GU4bxId5ds8VhmErMkhsu9Tg65LUhL5xDitWlWyW6+2KTp9bGIZx+7gpH+X06zIW
 WWDwv33Aj74Gk4BEHWV2g+m3fkN8xngLN/YVSuhX7Ocvdpad5F5cP4iwT4ZVQ895
 3CaWsPV5HIkzbkuYEfJJYlm+g6/suhXMpJEuSM96nwQGP0RptZqy68ReBGSl2RLx
 dFZQ6oi2wSNnymDUWuWKtzQ8TDmlD748Q7ryoiTnVCiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=FEEaNLmB6GOe5gfKh
 gL3ys6g6/aCgwfXoso39Kjy2R8=; b=HplBOSZea1VyKCVSZSbTCGgjSSNAPCqXs
 qEMdjnimBhjQFrXbfOmLF8tk/Xty6Lv5ukwO/tMJ+wLC2EKDZnzF6sU8akx3codA
 kYZZftWzgV+DzpwMc4KfqaoODM0Ep3UtYRsrf525nllBpCwzv+hXME4aSpVUdfDj
 co4gZrbhMnub+2u5syBkkhOKEz04CVkKwJw7nrKfxASJtOnuHEpItxtSzJtNGm2o
 3Ifjll9tVielLkeuSV11ZiSZLL2F3vVe/F59ajZm+jVwm3CUZqClpoykIAxuU1hI
 tJY5/m+LKvmcdGJOV3e+krikKhPBXqQ2obcm5cKDTOyGF24ugR8rg==
X-ME-Sender: <xms:rAw1X5cZnCdyx00gDNZhkRELdAwrNcps8xpVyEDezpA8bwnAIWENLw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrleeggddvvdcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertd
 dtnecuhfhrohhmpeetlhihshhsrgcutfhoshhsuceohhhisegrlhihshhsrgdrihhsqeen
 ucggtffrrghtthgvrhhnpeehgfdtleeiffeuveegkeeuffehvdevhfetfeehfeffleette
 dvvdegkeduudeggfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeekgedr
 udekgedrvddvledrvdeggeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
 grihhlfhhrohhmpehqhihlihhsshesgidvvddtrdhqhihlihhsshdrnhgvth
X-ME-Proxy: <xmx:rAw1X3Ornu2Q5-YEsvd8HOPf34dH-Osud-vDTcILN6BCrBnozmkFxg>
 <xmx:rAw1Xyiq_Hln3u87FggKhLxvSQxaohT4WxKU2K18hGUb2Z_1731lAg>
 <xmx:rAw1Xy_PN8MSzZnbPDH5keDrpnfGe3hGs_9P_TBz5wJ5yRte1ehs4Q>
 <xmx:rQw1Xz6AJxf6TvXLENf1qOLW037eQw4t3gOPCUMArLMAhrLXsVDZGw>
Received: from x220.qyliss.net (p54b8e5f4.dip0.t-ipconnect.de [84.184.229.244])
 by mail.messagingengine.com (Postfix) with ESMTPA id B4DD93280059;
 Thu, 13 Aug 2020 05:49:32 -0400 (EDT)
Received: by x220.qyliss.net (Postfix, from userid 1000)
 id 98D741E1; Thu, 13 Aug 2020 09:49:30 +0000 (UTC)
From: Alyssa Ross <hi@alyssa.is>
To: qemu-devel@nongnu.org
Subject: [PATCH] docs: clarify absence of set_features in vhost-user
Date: Thu, 13 Aug 2020 09:48:48 +0000
Message-Id: <20200813094847.4288-1-hi@alyssa.is>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: softfail client-ip=64.147.123.19;
 envelope-from=qyliss@x220.qyliss.net; helo=wout3-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 05:51:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, SPF_SOFTFAIL=0.665,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The previous wording was (at least to me) ambiguous about whether a
backend should enable features immediately after they were set using
VHOST_USER_SET_PROTOCOL_FEATURES, or wait for support for protocol
features to be acknowledged if it hasn't been yet before enabling
those features.

This patch attempts to make it clearer that
VHOST_USER_SET_PROTOCOL_FEATURES should immediately enable features,
even if support for protocol features has not yet been acknowledged,
while still also making clear that the frontend SHOULD acknowledge
support for protocol features.

Previous discussion begins here:
<https://lore.kernel.org/qemu-devel/87sgd1ktx9.fsf@alyssa.is/>

Cc: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Alyssa Ross <hi@alyssa.is>
---
 docs/interop/vhost-user.rst | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
index 10e3e3475e..bc78c9947f 100644
--- a/docs/interop/vhost-user.rst
+++ b/docs/interop/vhost-user.rst
@@ -854,9 +854,9 @@ Master message types
   ``VHOST_USER_GET_FEATURES``.
 
 .. Note::
-   Slave that reported ``VHOST_USER_F_PROTOCOL_FEATURES`` must
-   support this message even before ``VHOST_USER_SET_FEATURES`` was
-   called.
+   While QEMU should acknowledge ``VHOST_USER_F_PROTOCOL_FEATURES``, a
+   backend must allow ``VHOST_USER_GET_PROTOCOL_FEATURES`` even if
+   ``VHOST_USER_F_PROTOCOL_FEATURES`` has not been acknowledged yet.
 
 ``VHOST_USER_SET_PROTOCOL_FEATURES``
   :id: 16
@@ -869,8 +869,12 @@ Master message types
   ``VHOST_USER_GET_FEATURES``.
 
 .. Note::
-   Slave that reported ``VHOST_USER_F_PROTOCOL_FEATURES`` must support
-   this message even before ``VHOST_USER_SET_FEATURES`` was called.
+   While QEMU should acknowledge ``VHOST_USER_F_PROTOCOL_FEATURES``, a
+   backend must allow ``VHOST_USER_SET_PROTOCOL_FEATURES`` even if
+   ``VHOST_USER_F_PROTOCOL_FEATURES`` has not been acknowledged yet.
+   The backend must not wait for ``VHOST_USER_SET_FEATURES`` before
+   enabling protocol features requested with
+   ``VHOST_USER_SET_PROTOCOL_FEATURES``.
 
 ``VHOST_USER_SET_OWNER``
   :id: 3
-- 
2.27.0


