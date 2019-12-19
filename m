Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CEABC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 18:14:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15140227BF
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 18:14:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15140227BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ii0Je-0002IL-FK
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 13:14:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37758)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1ii0Ha-0008Pb-3y
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 13:12:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1ii0HX-0001ml-Rx
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 13:12:16 -0500
Received: from 4.mo7.mail-out.ovh.net ([178.32.122.254]:42614)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1ii0HX-0001dC-Ka
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 13:12:15 -0500
Received: from player734.ha.ovh.net (unknown [10.108.16.68])
 by mo7.mail-out.ovh.net (Postfix) with ESMTP id E09A2147AA3
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 19:12:13 +0100 (CET)
Received: from kaod.org (lfbn-tou-1-1227-223.w90-76.abo.wanadoo.fr
 [90.76.50.223]) (Authenticated sender: clg@kaod.org)
 by player734.ha.ovh.net (Postfix) with ESMTPSA id 63298D6D6255;
 Thu, 19 Dec 2019 18:12:08 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH v2 01/13] ppc/pnv: Modify the powerdown notifier to get the
 PowerNV machine
Date: Thu, 19 Dec 2019 19:11:43 +0100
Message-Id: <20191219181155.32530-2-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191219181155.32530-1-clg@kaod.org>
References: <20191219181155.32530-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 13654069647169588198
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrvdduuddguddtkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpeevrogurhhitgcunfgvucfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdeltddrjeeirdehtddrvddvfeenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeefgedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 178.32.122.254
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
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org,
 Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use container_of() instead of qdev_get_machine()

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/ppc/pnv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index f77e7ca84ede..855254f28263 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -561,7 +561,7 @@ static void *pnv_dt_create(MachineState *machine)
=20
 static void pnv_powerdown_notify(Notifier *n, void *opaque)
 {
-    PnvMachineState *pnv =3D PNV_MACHINE(qdev_get_machine());
+    PnvMachineState *pnv =3D container_of(n, PnvMachineState, powerdown_=
notifier);
=20
     if (pnv->bmc) {
         pnv_bmc_powerdown(pnv->bmc);
--=20
2.21.0


