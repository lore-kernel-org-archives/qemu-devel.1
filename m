Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CDB7C2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 10:39:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 786B621D7D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 10:39:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="iLJ/0kpW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 786B621D7D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL2B3-0006fQ-J9
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 06:39:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49740)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony.perard@citrix.com>)
 id 1kL29Y-0005dX-VR
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 06:37:37 -0400
Received: from esa1.hc3370-68.iphmx.com ([216.71.145.142]:25836)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony.perard@citrix.com>)
 id 1kL29W-0006QK-Mx
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 06:37:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1600857455;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=msUig27mTYZE9KmmEugMa0dsch9CglyKdJI6a0SK5RE=;
 b=iLJ/0kpWGUy7ee9/VW3a/JVikftvVUmXO/gzkIg+JPYYVPiWxJpeKpPm
 kyS2qnJv2rES63Hl5leAt3e1ofkCaYD7qAzSf5F9idmQ2BeJA5SxBFJXz
 forOXDSf52fd8Bq8VERJGCq05NsBJXKgsoNn0VbL9AkyNf4MODeUbqtIP 0=;
Authentication-Results: esa1.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none
IronPort-SDR: 1jQZJ8I2e9ARIcKICOUOiIMqfTW6KquCVcg+7/S+Pd4cKZzrMEnmzX27GjqqZqyBeMVZ6JwJRK
 i2RaGw0MPQnsrbpjsoExmIeJ82GqwnnWY2rYzGLkLKqbETmrCs/AHzOt0dpzQoZy9fpgWWJtUz
 RSyBl2x3CZW2O7tPeLZTEjU5qK0ODYUjHlIgvh4XNde9JacA68LChnZZd20VJsIk0D/CZ/h82Z
 D/mfu41gnLzfITodaCYp8kiOIb7e4CETT6aIH8suJ3vadloPrDSckjI7Tb4U6ENq6JCQ6SqrH4
 lE4=
X-SBRS: 2.7
X-MesageID: 27694055
X-Ironport-Server: esa1.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.77,293,1596513600"; d="scan'208";a="27694055"
To: <qemu-devel@nongnu.org>
CC: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost
 <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa
 <crosa@redhat.com>, Anthony PERARD <anthony.perard@citrix.com>
Subject: [PATCH] Add execute bit back to scripts/tracetool.py
Date: Wed, 23 Sep 2020 11:36:20 +0100
Message-ID: <20200923103620.1980151-1-anthony.perard@citrix.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=216.71.145.142;
 envelope-from=anthony.perard@citrix.com; helo=esa1.hc3370-68.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 06:37:31
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Reply-to: Anthony PERARD <anthony.perard@citrix.com>
From: Anthony PERARD via <qemu-devel@nongnu.org>

Commit a81df1b68b65 ("libqemuutil, qapi, trace: convert to meson")
removed it without explanation and it is useful to be able to run a
script without having to figure out which interpreter to use.

Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
---
 scripts/tracetool.py | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 mode change 100644 => 100755 scripts/tracetool.py

diff --git a/scripts/tracetool.py b/scripts/tracetool.py
old mode 100644
new mode 100755
-- 
Anthony PERARD


