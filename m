Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E71E9C43331
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 11:01:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3EBF20714
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 11:01:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hKiLqM8G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3EBF20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH3md-000335-OE
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 07:01:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37955)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jH3kK-0000Kz-J5
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:58:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1jH3kJ-0006iI-Bq
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:58:52 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:46408)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1jH3kJ-0006hq-71
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:58:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585133930;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zFiF4MhS5uVnJJBp8JB56GIwKfGYSvvTknJEdz9kuOc=;
 b=hKiLqM8GEOJEEpHxSxmGLlWbVzyk7I2X2Moh32z2gObVUuwNZuS7/RPOP9aexKa6J9qN7F
 0qRVKbtJo9q3a0cADR5aevBiVjpdeC0KW9XcmUP9uxNkLyBW8whaE3DGPX4umFiwNc2D3E
 2pPw28kbCOfVcwopva8zBJiYiLsPRvc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-88-CeU_V0ngNZ-VsfH7DfjtWw-1; Wed, 25 Mar 2020 06:58:48 -0400
X-MC-Unique: CeU_V0ngNZ-VsfH7DfjtWw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EC7DF189D6D2;
 Wed, 25 Mar 2020 10:58:47 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-49.ams2.redhat.com
 [10.36.112.49])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D6D9796FAA;
 Wed, 25 Mar 2020 10:58:44 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id E0EC09D13; Wed, 25 Mar 2020 11:58:43 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 2/2] hw/audio/fmopl: fix segmentation fault
Date: Wed, 25 Mar 2020 11:58:43 +0100
Message-Id: <20200325105843.17387-3-kraxel@redhat.com>
In-Reply-To: <20200325105843.17387-1-kraxel@redhat.com>
References: <20200325105843.17387-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Volker R=C3=BCmelin <vr_qemu@t-online.de>

Current code allocates the memory for ENV_CURVE too late. Move
allocation to OPLOpenTable() and deallocation to OPLCloseTable().

To reproduce the bug start qemu with -soundhw adlib.

Fixes 2eea51bd01 "hw/audio/fmopl: Move ENV_CURVE to .heap to save
32KiB of .bss"

Signed-off-by: Volker R=C3=BCmelin <vr_qemu@t-online.de>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-id: 20200324061855.5951-1-vr_qemu@t-online.de
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/audio/fmopl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/audio/fmopl.c b/hw/audio/fmopl.c
index 356d4dfbcaa6..8a71a569fab0 100644
--- a/hw/audio/fmopl.c
+++ b/hw/audio/fmopl.c
@@ -627,6 +627,7 @@ static int OPLOpenTable( void )
 =09=09free(AMS_TABLE);
 =09=09return 0;
 =09}
+    ENV_CURVE =3D g_new(int32_t, 2 * EG_ENT + 1);
 =09/* make total level table */
 =09for (t =3D 0;t < EG_ENT-1 ;t++){
 =09=09rate =3D ((1<<TL_BITS)-1)/pow(10,EG_STEP*t/20);=09/* dB -> voltage *=
/
@@ -694,6 +695,7 @@ static int OPLOpenTable( void )
=20
 static void OPLCloseTable( void )
 {
+    g_free(ENV_CURVE);
 =09free(TL_TABLE);
 =09free(SIN_TABLE);
 =09free(AMS_TABLE);
@@ -1090,7 +1092,6 @@ FM_OPL *OPLCreate(int clock, int rate)
 =09OPL->clock =3D clock;
 =09OPL->rate  =3D rate;
 =09OPL->max_ch =3D max_ch;
-    ENV_CURVE =3D g_new(int32_t, 2 * EG_ENT + 1);
 =09/* init grobal tables */
 =09OPL_initialize(OPL);
 =09/* reset chip */
@@ -1128,7 +1129,6 @@ void OPLDestroy(FM_OPL *OPL)
 #endif
 =09OPL_UnLockTable();
 =09free(OPL);
-    g_free(ENV_CURVE);
 }
=20
 /* ----------  Option handlers ----------       */
--=20
2.18.2


