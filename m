Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A00C3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 01:06:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0EB520842
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 01:05:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JRTeVE8X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0EB520842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9exb-0006Ab-22
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 20:05:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39473)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j9ewe-0004A7-TQ
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 20:05:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j9ewd-0005L2-O6
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 20:05:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21241
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j9ewd-0005Km-Ky
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 20:04:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583370299;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G7z8C3H465JpVsN6Yw+fEi9EeJJjIsNf/qW73pA0nsU=;
 b=JRTeVE8X0F2062/RDKe1zI4YQw7iR2tV9EF7lfvvg+WHj731ipMM+fzZcK9TZGQA49W+IH
 of2CrKOkLDOIiCpksPr/+DApUwUPZIEmSSN3MyrRzZWbfDHQg1BsfInLUMpES9kbbDW2nN
 MJgGcbZOdfPKYYripNNjwEkTinM6KLw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-U59JyTFEM_idYbz-pvR4zw-1; Wed, 04 Mar 2020 20:04:55 -0500
X-MC-Unique: U59JyTFEM_idYbz-pvR4zw-1
Received: by mail-wr1-f69.google.com with SMTP id d7so1641176wrr.0
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2020 17:04:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mERLJkA6KL9WHqzO6Je/w9Mt4U4fyGT4//wl15kUfLY=;
 b=VFo6+gzHubDstvX1N2wN/dyDcN2I+x2MQpZFmrS8Q/mleA7Y7spUrYJgjZieM5tcp8
 czee8HKjooPRN11PMiTu/bFWhXMCJSLvc9o5o7lFRglqfalDCvmXpjOVxoQXRs279KDy
 ikTELU455NSWJaMxthk630oXfvKPsWsJDcDSX8Ct4qZRvQGNK99j0v/oJZ8ii/mlfLdw
 RrEdJKSA6oZiOKlTfdgoqmTHuF34nokO2D/w2VYlMkMst9syUs98zKCAyma4B/3bujNP
 9P1I7gQbtspdxqym/Xsk6qX1vK6yBLidIXs4f+gePR63euyJ198d/VqilFrVZbWk4iQa
 UPbw==
X-Gm-Message-State: ANhLgQ0RIKTVrrVzvNEcju8Bc1+lyNS7/Y6LpnJ8uI+QjWYDj7wDdcbZ
 yEY8v0RttmZxGSQvGujhif65Lx1VfCw6x9tn81etUX+KBTchNRpzywrp3vUid0yQQVvEbbsSlv6
 cm1iSyE2sOqPp6SE=
X-Received: by 2002:adf:80cb:: with SMTP id 69mr6444513wrl.320.1583370294397; 
 Wed, 04 Mar 2020 17:04:54 -0800 (PST)
X-Google-Smtp-Source: ADFU+vvJ90DV5759BkuoDYTgS2LzEz7rlCGQ76Yc2MdMX8Uuwxeu1ZXbzStpDEg3Jd8tWL72k4I3gw==
X-Received: by 2002:adf:80cb:: with SMTP id 69mr6444498wrl.320.1583370294189; 
 Wed, 04 Mar 2020 17:04:54 -0800 (PST)
Received: from localhost.localdomain (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id c23sm4561228wme.39.2020.03.04.17.04.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2020 17:04:53 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/3] hw/net/e1000: Add readops/writeops typedefs
Date: Thu,  5 Mar 2020 02:04:44 +0100
Message-Id: <20200305010446.17029-2-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200305010446.17029-1-philmd@redhat.com>
References: <20200305010446.17029-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>, qemu-trivial@nongnu.org,
 Jason Wang <jasowang@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Express the macreg[] arrays using typedefs.
No logical changes introduced here.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/net/e1000.c       | 6 ++++--
 hw/net/e1000e_core.c | 6 ++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/hw/net/e1000.c b/hw/net/e1000.c
index 0b833d5a15..972d9b5083 100644
--- a/hw/net/e1000.c
+++ b/hw/net/e1000.c
@@ -1150,7 +1150,8 @@ set_ims(E1000State *s, int index, uint32_t val)
 }
=20
 #define getreg(x)    [x] =3D mac_readreg
-static uint32_t (*macreg_readops[])(E1000State *, int) =3D {
+typedef uint32_t (*readops)(E1000State *, int);
+static readops macreg_readops[] =3D {
     getreg(PBA),      getreg(RCTL),     getreg(TDH),      getreg(TXDCTL),
     getreg(WUFC),     getreg(TDT),      getreg(CTRL),     getreg(LEDCTL),
     getreg(MANC),     getreg(MDIC),     getreg(SWSM),     getreg(STATUS),
@@ -1205,7 +1206,8 @@ static uint32_t (*macreg_readops[])(E1000State *, int=
) =3D {
 enum { NREADOPS =3D ARRAY_SIZE(macreg_readops) };
=20
 #define putreg(x)    [x] =3D mac_writereg
-static void (*macreg_writeops[])(E1000State *, int, uint32_t) =3D {
+typedef void (*writeops)(E1000State *, int, uint32_t);
+static writeops macreg_writeops[] =3D {
     putreg(PBA),      putreg(EERD),     putreg(SWSM),     putreg(WUFC),
     putreg(TDBAL),    putreg(TDBAH),    putreg(TXDCTL),   putreg(RDBAH),
     putreg(RDBAL),    putreg(LEDCTL),   putreg(VET),      putreg(FCRUC),
diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
index 94ea34dca5..38bdb90114 100644
--- a/hw/net/e1000e_core.c
+++ b/hw/net/e1000e_core.c
@@ -2855,7 +2855,8 @@ e1000e_set_gcr(E1000ECore *core, int index, uint32_t =
val)
 }
=20
 #define e1000e_getreg(x)    [x] =3D e1000e_mac_readreg
-static uint32_t (*e1000e_macreg_readops[])(E1000ECore *, int) =3D {
+typedef uint32_t (*readops)(E1000ECore *, int);
+static readops e1000e_macreg_readops[] =3D {
     e1000e_getreg(PBA),
     e1000e_getreg(WUFC),
     e1000e_getreg(MANC),
@@ -3061,7 +3062,8 @@ static uint32_t (*e1000e_macreg_readops[])(E1000ECore=
 *, int) =3D {
 enum { E1000E_NREADOPS =3D ARRAY_SIZE(e1000e_macreg_readops) };
=20
 #define e1000e_putreg(x)    [x] =3D e1000e_mac_writereg
-static void (*e1000e_macreg_writeops[])(E1000ECore *, int, uint32_t) =3D {
+typedef void (*writeops)(E1000ECore *, int, uint32_t);
+static writeops e1000e_macreg_writeops[] =3D {
     e1000e_putreg(PBA),
     e1000e_putreg(SWSM),
     e1000e_putreg(WUFC),
--=20
2.21.1


