Return-Path: <SRS0=rFyn=Y2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E3D1CA9ED1
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Nov 2019 17:23:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 497DB21897
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Nov 2019 17:23:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 497DB21897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQx7H-0004I1-DD
	for qemu-devel@archiver.kernel.org; Sat, 02 Nov 2019 13:23:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46498)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iQx4q-0002xn-8d
 for qemu-devel@nongnu.org; Sat, 02 Nov 2019 13:20:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iQx4n-0005DZ-SJ
 for qemu-devel@nongnu.org; Sat, 02 Nov 2019 13:20:39 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:43851)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iQx4n-00050Y-H1
 for qemu-devel@nongnu.org; Sat, 02 Nov 2019 13:20:37 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M2NqA-1iOCN81Muk-003spp; Sat, 02 Nov 2019 18:15:16 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/3] dp8393x: fix dp8393x_receive()
Date: Sat,  2 Nov 2019 18:15:10 +0100
Message-Id: <20191102171511.31881-3-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191102171511.31881-1-laurent@vivier.eu>
References: <20191102171511.31881-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:e+bdHzlMe16+ydKTAqZOKD3azelc7xkAVHIm772OZAz+NUSeZAQ
 hPstiR8vtFWpQrvNVxq95EtGJamWpOpf0cWLzsLY4K58YHRmuHwbhxp9pIDqU4uNClnBFiE
 dECf94JMy3LFtyja0jxgYIsVWghfSkDs8nobvLUB1DaJhIXqZsaTwtYc3Z9cYQWIGt0STjK
 uCVQxU1XbTX1lCTf7R9kQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mRHc9lQUneE=:QgNs6PW+8droW1kmxRl4tu
 NBNJOPw4NZi9DHMYFXaeX3Q40g8+XU7rSaRUUTdHrG6NtQ0r1DWaidCWf8MNUiHZ8oErt4MuN
 89yASYMytHVJdATNNIckn/xPmwER+qjd5yQSLhCxkD8srqYdO7u9wEdb6DgEc5O5CMkqNzgu0
 dy5LnnyOrRrY1CkN0LVY36Ij2jI8ePzrISsQTM9rXvhTM7pNuWeuvT5OYvBCQHRUwj+MVdTgl
 lpx/RsUiLgEd4O4DqIOIGt9Zri9D+7fju5NYDdLgMKmjeRZ+JMIjNiPhM1w0MzllWAleOJNWy
 UBC3Y8Je6UlkkKhV4uyFe+0cbMSnAzxLIRGK2Csj/jKntyfPN3thQRUu9NRgPJPq16zkyhumW
 mXCK2xtC6F4LUUhrO99QnaBvTbuXaM+yKwhRLSJGi32sfYQEaE1sGayQSqeh+sRyvdze3K/QX
 CQTytgB/DIH4BOIz0eVqD32IA8r3scYvj97dmcSdRjVAQ25Lk+vf0nRc7fvf+QVHOow2bHfpr
 nrS1PTiFz8acUAqHwsokgQMMwjhJ8Z0h7xcK40lhcBrujpS/dYZXl87Uo4rHnHAbxhfeUKfbR
 E6ulB0nrh6SqXpFEl6gDjCqXNdSI352JTLwszq7g6w4OJIZq3c5rsFbbij/DFYjG5n9y6yDIL
 tVTmPWioL9frXKCVwwsgLVBy7bV2mK1z7HM3Qyxu7TQ45ukpxNUM2wdZUFTmyo+lmD4K7hNyE
 dLoGmd4drWWDJLWOWrIHEJDjGbmOnjzTadzm08uyTbClru+aLdBHVz4bHuQSGgjfCcwwLQJBv
 0PRVnjQe+BkvKzI0DmXnmqhPW5ZKQUUB7BqbMSMeKWFDJfPQZFOYXQhIZnM93ovrn1R9ZeaNH
 MlO7XZi3Vs+EEj1RSEmw==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.133
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
Cc: Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

address_space_rw() access size must be multiplied by the width.

This fixes DHCP for Q800 guest.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/net/dp8393x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
index 85d3f3788e..b8c4473f99 100644
--- a/hw/net/dp8393x.c
+++ b/hw/net/dp8393x.c
@@ -833,7 +833,7 @@ static ssize_t dp8393x_receive(NetClientState *nc, const uint8_t * buf,
     } else {
         dp8393x_put(s, width, 0, 0); /* in_use */
         address_space_rw(&s->as, dp8393x_crda(s) + sizeof(uint16_t) * 6 * width,
-            MEMTXATTRS_UNSPECIFIED, (uint8_t *)s->data, sizeof(uint16_t), 1);
+            MEMTXATTRS_UNSPECIFIED, (uint8_t *)s->data, size, 1);
         s->regs[SONIC_CRDA] = s->regs[SONIC_LLFA];
         s->regs[SONIC_ISR] |= SONIC_ISR_PKTRX;
         s->regs[SONIC_RSC] = (s->regs[SONIC_RSC] & 0xff00) | (((s->regs[SONIC_RSC] & 0x00ff) + 1) & 0x00ff);
-- 
2.21.0


