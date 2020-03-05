Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 025D0C3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 10:55:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9776208C3
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 10:55:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9776208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9o9e-0001kW-0E
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 05:55:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50638)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kuhn.chenqun@huawei.com>) id 1j9o8c-0000Rl-GP
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 05:53:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kuhn.chenqun@huawei.com>) id 1j9o8b-00027q-H7
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 05:53:58 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:60830 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1j9o8Z-0001z8-7r; Thu, 05 Mar 2020 05:53:55 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id C6E3C4963A861A13CF41;
 Thu,  5 Mar 2020 18:53:44 +0800 (CST)
Received: from huawei.com (10.133.205.93) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Thu, 5 Mar 2020
 18:53:37 +0800
From: Chen Qun <kuhn.chenqun@huawei.com>
To: <qemu-devel@nongnu.org>, <qemu-trivial@nongnu.org>
Subject: [PATCH v2] hw/net/imx_fec: write TGSR and TCSR3 in imx_enet_write()
Date: Thu, 5 Mar 2020 18:53:25 +0800
Message-ID: <20200305105325.31264-1-kuhn.chenqun@huawei.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [10.133.205.93]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.32
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
Cc: peter.maydell@linaro.org, zhang.zhanghailiang@huawei.com,
 jasowang@redhat.com, qemu-arm@nongnu.org, peter.chubb@nicta.com.au,
 Euler Robot <euler.robot@huawei.com>, Chen Qun <kuhn.chenqun@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The current code causes clang static code analyzer generate warning:
hw/net/imx_fec.c:858:9: warning: Value stored to 'value' is never read
        value =3D value & 0x0000000f;
        ^       ~~~~~~~~~~~~~~~~~~
hw/net/imx_fec.c:864:9: warning: Value stored to 'value' is never read
        value =3D value & 0x000000fd;
        ^       ~~~~~~~~~~~~~~~~~~

According to the definition of the function, the two =E2=80=9Cvalue=E2=80=
=9D assignments
 should be written to registers.

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
---
v1->v2:
  The register 'ENET_TGSR' write-1-to-clear timer flag.
  The register 'ENET_TCSRn' 7bit(TF) write-1-to-clear timer flag.
---
 hw/net/imx_fec.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/net/imx_fec.c b/hw/net/imx_fec.c
index 6a124a154a..322cbdcc17 100644
--- a/hw/net/imx_fec.c
+++ b/hw/net/imx_fec.c
@@ -855,13 +855,15 @@ static void imx_enet_write(IMXFECState *s, uint32_t=
 index, uint32_t value)
         break;
     case ENET_TGSR:
         /* implement clear timer flag */
-        value =3D value & 0x0000000f;
+        s->regs[index] ^=3D s->regs[index] & value;
+        s->regs[index] &=3D 0x0000000f;
         break;
     case ENET_TCSR0:
     case ENET_TCSR1:
     case ENET_TCSR2:
     case ENET_TCSR3:
-        value =3D value & 0x000000fd;
+        s->regs[index] =3D (value & 0x00000080) ? (0x0000007d & value) :
+                         (value & 0x000000fd);
         break;
     case ENET_TCCR0:
     case ENET_TCCR1:
--=20
2.23.0



