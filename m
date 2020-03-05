Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC2DC3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 12:50:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83D3A20848
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 12:50:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KpjgaBvN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83D3A20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9pxN-0007DN-Le
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 07:50:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41701)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j9psz-00073M-1j
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 07:45:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j9psx-0001Wi-Op
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 07:45:56 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:34958
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j9psx-0001WY-KY
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 07:45:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583412355;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JfaE+0axlKWiznACDUVr5NFMk2fsnhKxXDiz+PMDV4Y=;
 b=KpjgaBvN/geU6cdjF4P4+omH8MwS0MNBgj6JKGdzemTQEaTtSnJfeBHhzm/l4DU7Ok+Pkd
 lZbDj/V29baTT2/otwXt25KEASd6hqS+Gv/2VHtM/glfx6ZkJk3YGYNrWrFvb3AjC55EY3
 ah6xLMAvdRH/3E5ovs3PyY6+KOjIKnc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-_0KXLWMnN2qr69nfToXtVQ-1; Thu, 05 Mar 2020 07:45:51 -0500
X-MC-Unique: _0KXLWMnN2qr69nfToXtVQ-1
Received: by mail-wr1-f70.google.com with SMTP id s10so494158wrr.21
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 04:45:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=42bbadqUAgxtcc+IIT/30qYCAcYJc9y0Vsbx4Pz3gIU=;
 b=Ecxn/RpEdytcNdeunmcLEY0BT/uZRhnzE8+7jgGtf7qtBslLcOe70To2TkDkQCP2Wf
 RZdqO2PBcKejleVBoYRxoVak93jMgeHCza+iAC0zdNjF+ud/vtEpsoLmHGWQUB8qA+6l
 Wy1Fzzzy5wU1wbwAiOUc3lCsl16ALg4ADvx4Rj47o+9ugx122RLe7DwWElKdb+BrXbMI
 Q6BFZpUqIJGvcrORdiLLWniv1RyFai2gtPtPnGIBsbFYrBn5evgU0izeX4WpEN4CLexo
 ohWVstE/hsvaXYD9J0YrJR9XI+wDcB2u0VejH4kx3i2HJdPFa09UMZrCHnXwvfioe1bU
 qViA==
X-Gm-Message-State: ANhLgQ3+5qdlm+L2MKh39rzkhDLWEN87T1L1344Ju6DcIB0yTJCBRnn4
 MUokVZxH//k+wmD0LX6zwlcz8JaTnIPSGFNaE12zXy9YpUWdRu/edFmb78EKnt61vZKQgL3JWek
 63NDsK55kx3it6VE=
X-Received: by 2002:a1c:e146:: with SMTP id y67mr9108383wmg.81.1583412350052; 
 Thu, 05 Mar 2020 04:45:50 -0800 (PST)
X-Google-Smtp-Source: ADFU+vthWhcpjJ0QtztZkI8eKhbEYA0N0BtUoJ9LPdGVIeSPURfmP7IqY9VKyto/DkMvQ6hUEDzqPA==
X-Received: by 2002:a1c:e146:: with SMTP id y67mr9108368wmg.81.1583412349872; 
 Thu, 05 Mar 2020 04:45:49 -0800 (PST)
Received: from localhost.localdomain (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id j14sm44924328wrn.32.2020.03.05.04.45.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2020 04:45:49 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-trivial@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 4/9] hw/net/e1000: Add readops/writeops typedefs
Date: Thu,  5 Mar 2020 13:45:20 +0100
Message-Id: <20200305124525.14555-5-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200305124525.14555-1-philmd@redhat.com>
References: <20200305124525.14555-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Express the macreg[] arrays using typedefs.
No logical changes introduced here.

Reviewed-by: Dmitry Fleytman <dmitry.fleytman@gmail.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
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


