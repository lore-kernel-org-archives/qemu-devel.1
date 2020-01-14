Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7382C33CB1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 10:40:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A0DF24672
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 10:40:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A0DF24672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irJcC-000294-AO
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 05:40:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43155)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1irJXa-00053c-Sz
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 05:35:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1irJXX-0003hO-6I
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 05:35:18 -0500
Received: from 15.mo1.mail-out.ovh.net ([188.165.38.232]:40241)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1irJXX-0003h0-0V
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 05:35:15 -0500
Received: from player798.ha.ovh.net (unknown [10.108.16.135])
 by mo1.mail-out.ovh.net (Postfix) with ESMTP id D992A1A9492
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2020 11:35:12 +0100 (CET)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player798.ha.ovh.net (Postfix) with ESMTPSA id 9D929E4CFF14;
 Tue, 14 Jan 2020 10:35:03 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 3/5] ftgmac100: check RX and TX buffer alignment
Date: Tue, 14 Jan 2020 11:34:31 +0100
Message-Id: <20200114103433.30534-4-clg@kaod.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200114103433.30534-1-clg@kaod.org>
References: <20200114103433.30534-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 11051833489830087441
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrvdejvddgudeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepveorughrihgtucfnvgcuifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpkedvrdeigedrvdehtddrudejtdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeelkedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgepud
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 188.165.38.232
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
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These buffers should be aligned on 16 bytes.

Ignore invalid RX and TX buffer addresses and log an error. All
incoming and outgoing traffic will be dropped because no valid RX or
TX descriptors will be available.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/net/ftgmac100.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/hw/net/ftgmac100.c b/hw/net/ftgmac100.c
index 86ac25894a89..051f7b7af2d6 100644
--- a/hw/net/ftgmac100.c
+++ b/hw/net/ftgmac100.c
@@ -198,6 +198,8 @@ typedef struct {
     uint32_t        des3;
 } FTGMAC100Desc;
=20
+#define FTGMAC100_DESC_ALIGNMENT 16
+
 /*
  * Specific RTL8211E MII Registers
  */
@@ -722,6 +724,12 @@ static void ftgmac100_write(void *opaque, hwaddr add=
r,
         s->itc =3D value;
         break;
     case FTGMAC100_RXR_BADR: /* Ring buffer address */
+        if (!QEMU_IS_ALIGNED(value, FTGMAC100_DESC_ALIGNMENT)) {
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad RX buffer alignment =
0x%"
+                          HWADDR_PRIx "\n", __func__, value);
+            return;
+        }
+
         s->rx_ring =3D value;
         s->rx_descriptor =3D s->rx_ring;
         break;
@@ -731,6 +739,11 @@ static void ftgmac100_write(void *opaque, hwaddr add=
r,
         break;
=20
     case FTGMAC100_NPTXR_BADR: /* Transmit buffer address */
+        if (!QEMU_IS_ALIGNED(value, FTGMAC100_DESC_ALIGNMENT)) {
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad TX buffer alignment =
0x%"
+                          HWADDR_PRIx "\n", __func__, value);
+            return;
+        }
         s->tx_ring =3D value;
         s->tx_descriptor =3D s->tx_ring;
         break;
--=20
2.21.1


