Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C15C4CEC4
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 11:58:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5D3220644
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 11:58:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="dd0xzO3l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5D3220644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57743 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAYbG-0004qG-SB
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 07:58:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49690)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Paul.Durrant@citrix.com>) id 1iAYaM-0004AL-4S
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 07:57:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Paul.Durrant@citrix.com>) id 1iAYaL-0007Zr-3z
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 07:57:25 -0400
Received: from esa2.hc3370-68.iphmx.com ([216.71.145.153]:23711)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Paul.Durrant@citrix.com>)
 id 1iAYaK-0007Z6-SL; Wed, 18 Sep 2019 07:57:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1568807845;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=nQEHhjPgrkULCQNvBRUJgv1c/SBgiH6iI6S8yIu68OA=;
 b=dd0xzO3logJgsAUWBYaXlwSKry2IgRvU9Hr5VeGXspOq0tLjjMiixWHN
 dQgNa2CG6ktoCnNuvDefynvBHHXJ5DnYPIKNGfdXh2lYSo+vUZLF9Mvg2
 74cSulMcVTByMlibM0ceZT17I9HYZ9gHlpTj1ooL/Qx+59FX3HAEo4K3u 8=;
Authentication-Results: esa2.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none;
 spf=None smtp.pra=paul.durrant@citrix.com;
 spf=Pass smtp.mailfrom=Paul.Durrant@citrix.com;
 spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa2.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 paul.durrant@citrix.com) identity=pra;
 client-ip=162.221.158.21; receiver=esa2.hc3370-68.iphmx.com;
 envelope-from="Paul.Durrant@citrix.com";
 x-sender="paul.durrant@citrix.com"; x-conformance=sidf_compatible
Received-SPF: Pass (esa2.hc3370-68.iphmx.com: domain of
 Paul.Durrant@citrix.com designates 162.221.158.21 as
 permitted sender) identity=mailfrom;
 client-ip=162.221.158.21; receiver=esa2.hc3370-68.iphmx.com;
 envelope-from="Paul.Durrant@citrix.com";
 x-sender="Paul.Durrant@citrix.com";
 x-conformance=sidf_compatible; x-record-type="v=spf1";
 x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
 ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
 ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
 ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83 ~all"
Received-SPF: None (esa2.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 postmaster@mail.citrix.com) identity=helo;
 client-ip=162.221.158.21; receiver=esa2.hc3370-68.iphmx.com;
 envelope-from="Paul.Durrant@citrix.com";
 x-sender="postmaster@mail.citrix.com";
 x-conformance=sidf_compatible
IronPort-SDR: L7PLu0oOZXysHPpCd0PTgePx3JTMhkh70aCwsNRU4CHMWGkwENYX82utJe/Rj+ZF9on+dCcLVS
 +H+pOt9xU8ht+8Cx2vw7516++PqXEYcEB3LgXs3RQMhGlJNAaWjwvxpjW9l4KhpPxLuLrXLuM+
 0PB2HDFP+E08lSGeR833OEa1awIE0OJjHBND7KX0o+0N4p5gJ21kco8B8+GxmJNR26wV6G8uaI
 dM47pBQlIIxoDg8xlontKcemkE2KA1a/iqIOL5o+seeuSC0jU5LjeHO+PHNt2Ll4JyOkmM0NNi
 YlY=
X-SBRS: 2.7
X-MesageID: 5720020
X-Ironport-Server: esa2.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.64,520,1559534400"; 
   d="scan'208";a="5720020"
From: Paul Durrant <paul.durrant@citrix.com>
To: <xen-devel@lists.xenproject.org>, <qemu-devel@nongnu.org>,
 <qemu-block@nongnu.org>
Date: Wed, 18 Sep 2019 12:57:02 +0100
Message-ID: <20190918115702.38959-1-paul.durrant@citrix.com>
X-Mailer: git-send-email 2.20.1.2.gb21ebb671
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.145.153
Subject: [Qemu-devel] [PATCH] xen-block: treat XenbusStateUnknown the same
 as XenbusStateClosed
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>,
 Max Reitz <mreitz@redhat.com>, Paul Durrant <paul.durrant@citrix.com>,
 Anthony Perard <anthony.perard@citrix.com>, Mark Syms <mark.syms@citrix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When a frontend gracefully disconnects from an offline backend, it will
set its own state to XenbusStateClosed. The code in xen-block.c correctly
deals with this and sets the backend into XenbusStateClosed. Unfortunately
it is possible for toolstack to actually delete the frontend area
before the state key has been read, leading to an apparent frontend state
of XenbusStateUnknown. This prevents the backend state from transitioning
to XenbusStateClosed and hence leaves it limbo.

This patch simply treats a frontend state of XenbusStateUnknown the same
as XenbusStateClosed, which will unblock the backend in these circumstances.

Reported-by: Mark Syms <mark.syms@citrix.com>
Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
---
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Anthony Perard <anthony.perard@citrix.com>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>
---
 hw/block/xen-block.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
index f77343db60..879fc310a4 100644
--- a/hw/block/xen-block.c
+++ b/hw/block/xen-block.c
@@ -313,6 +313,7 @@ static void xen_block_frontend_changed(XenDevice *xendev,
         break;
 
     case XenbusStateClosed:
+    case XenbusStateUnknown:
         xen_block_disconnect(xendev, &local_err);
         if (local_err) {
             error_propagate(errp, local_err);
-- 
2.20.1.2.gb21ebb671


