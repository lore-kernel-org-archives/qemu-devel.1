Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF6FC41621
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 06:19:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EE112076A
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 06:19:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EE112076A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGcun-0002Em-CT
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 02:19:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46082)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <volker.ruemelin@t-online.de>) id 1jGcu6-0001q9-Fm
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 02:19:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <volker.ruemelin@t-online.de>) id 1jGcu5-0000ng-Ck
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 02:19:10 -0400
Received: from mailout04.t-online.de ([194.25.134.18]:34342)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <volker.ruemelin@t-online.de>)
 id 1jGcu5-0000lT-6t
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 02:19:09 -0400
Received: from fwd06.aul.t-online.de (fwd06.aul.t-online.de [172.20.26.150])
 by mailout04.t-online.de (Postfix) with SMTP id 392CC41BADFA;
 Tue, 24 Mar 2020 07:19:06 +0100 (CET)
Received: from linpower.localnet
 (TWfXKUZSgh-qC9Pqk75CBSp5AMWVhwG5RYzIRcAu35kWBp1YYHu1gDzjUk6inBgQ7S@[93.236.151.78])
 by fwd06.t-online.de
 with (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384 encrypted)
 esmtp id 1jGcts-2IEPPU0; Tue, 24 Mar 2020 07:18:56 +0100
Received: by linpower.localnet (Postfix, from userid 1000)
 id DA3E7200F49; Tue, 24 Mar 2020 07:18:55 +0100 (CET)
From: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH] hw/audio/fmopl: fix segmentation fault
Date: Tue, 24 Mar 2020 07:18:55 +0100
Message-Id: <20200324061855.5951-1-vr_qemu@t-online.de>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-ID: TWfXKUZSgh-qC9Pqk75CBSp5AMWVhwG5RYzIRcAu35kWBp1YYHu1gDzjUk6inBgQ7S
X-TOI-MSGID: 61372906-d5a0-48ce-8152-3dbf625e179d
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 194.25.134.18
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Current code allocates the memory for ENV_CURVE too late. Move
allocation to OPLOpenTable() and deallocation to OPLCloseTable().

To reproduce the bug start qemu with -soundhw adlib.

Fixes 2eea51bd01 "hw/audio/fmopl: Move ENV_CURVE to .heap to save
32KiB of .bss"

Signed-off-by: Volker R=C3=BCmelin <vr_qemu@t-online.de>
---
 hw/audio/fmopl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/audio/fmopl.c b/hw/audio/fmopl.c
index 356d4dfbca..8a71a569fa 100644
--- a/hw/audio/fmopl.c
+++ b/hw/audio/fmopl.c
@@ -627,6 +627,7 @@ static int OPLOpenTable( void )
 		free(AMS_TABLE);
 		return 0;
 	}
+    ENV_CURVE =3D g_new(int32_t, 2 * EG_ENT + 1);
 	/* make total level table */
 	for (t =3D 0;t < EG_ENT-1 ;t++){
 		rate =3D ((1<<TL_BITS)-1)/pow(10,EG_STEP*t/20);	/* dB -> voltage */
@@ -694,6 +695,7 @@ static int OPLOpenTable( void )
=20
 static void OPLCloseTable( void )
 {
+    g_free(ENV_CURVE);
 	free(TL_TABLE);
 	free(SIN_TABLE);
 	free(AMS_TABLE);
@@ -1090,7 +1092,6 @@ FM_OPL *OPLCreate(int clock, int rate)
 	OPL->clock =3D clock;
 	OPL->rate  =3D rate;
 	OPL->max_ch =3D max_ch;
-    ENV_CURVE =3D g_new(int32_t, 2 * EG_ENT + 1);
 	/* init grobal tables */
 	OPL_initialize(OPL);
 	/* reset chip */
@@ -1128,7 +1129,6 @@ void OPLDestroy(FM_OPL *OPL)
 #endif
 	OPL_UnLockTable();
 	free(OPL);
-    g_free(ENV_CURVE);
 }
=20
 /* ----------  Option handlers ----------       */
--=20
2.16.4


