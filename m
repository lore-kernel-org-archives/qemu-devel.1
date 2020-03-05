Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83CC1C3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 01:07:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 478502084E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 01:07:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KdNLQCu9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 478502084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9ez1-0008K5-Go
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 20:07:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39499)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j9ewi-0004Fs-HD
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 20:05:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j9ewh-0005Ru-Ar
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 20:05:04 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:27096
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j9ewh-0005Ra-74
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 20:05:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583370302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fUQHY5u6EmUZcs/PU9+tDJ55yHeFQYfslboPGYA34ns=;
 b=KdNLQCu96CatU9N1m980YNtcqOlE3U+sk7Xl3YLhsLeiVZOvNscyZl+xMW11TEwm8yyUIh
 +ug1YQcme/qD0lpigwKc/aDL27z+hXAajoToK4rGUDgd0ZrM4a7CYZetNtMHTKOK8KKQtw
 bQAqFpKE49BWd+e1IOshVg/5NFMcNyM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-396-rg6fAo8ZObuf3AErZAN0mg-1; Wed, 04 Mar 2020 20:05:01 -0500
X-MC-Unique: rg6fAo8ZObuf3AErZAN0mg-1
Received: by mail-wr1-f70.google.com with SMTP id q18so1629918wrw.5
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2020 17:05:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LqA3yPl/c3LrUeLcESiAMq8nwyp7UScHu+TeSWu0joQ=;
 b=l9zhCiDhwov1997NE35fj3lzYlKpNjP9YN8/FbCaipFhKoFeg+xIfL2iDG75NMgVCQ
 fwh66mhf3cCrLpZZfLbsIlNu0B8AYW9YiytEAzTrAN2Gt2v8N5z1nyKpRydn0YmSuuld
 0734OJ+FiR1a/BoYVLTv9PF/dKRtSpnzIULUG92ttz5sMLZOvPY+w8wdqTWguGdTT1oK
 yX4hgibZO5RVidvwya1ySYWQFtm5eIcbg2ScjgPC9EbRDSm7ZIdbdHWcSp6InL2PBZlx
 yXoxOas2VMTjOFfiusaZsxd+iZ8uZahs8bflKr0zDZH3w69a8FdAkwhaU39LfmZyAZoA
 Xp2A==
X-Gm-Message-State: ANhLgQ18/ZPpSayXOMScxhqNBujeO8Fx6pE+W0twpkR9sjgpbHnduyfL
 92zcAIUZiyBphztZjGVrpQ5sgMkKvxaVcWy1TsgSunnMcajX71seWqiXmk4huao3E1ohWAEkppN
 nGrgU+7vsHY+VKdA=
X-Received: by 2002:a1c:2504:: with SMTP id l4mr6259424wml.72.1583370299729;
 Wed, 04 Mar 2020 17:04:59 -0800 (PST)
X-Google-Smtp-Source: ADFU+vsStLSEQ4P3ixqLsg5jOfE+knNZffWOwnVpTYXDptRIv35kd+x19v2hzB4MxmdF/78jFpo+5g==
X-Received: by 2002:a1c:2504:: with SMTP id l4mr6259406wml.72.1583370299545;
 Wed, 04 Mar 2020 17:04:59 -0800 (PST)
Received: from localhost.localdomain (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id p17sm39232183wre.89.2020.03.04.17.04.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2020 17:04:59 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/3] hw/net/e1000: Move macreg[] arrays to .rodata to save
 1MiB of .data
Date: Thu,  5 Mar 2020 02:04:45 +0100
Message-Id: <20200305010446.17029-3-philmd@redhat.com>
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
X-Received-From: 205.139.110.61
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

Each array consumes 256KiB of .data. As we do not reassign entries,
we can move it to the .rodata section, and save a total of 1MiB of
.data (size reported on x86_64 host).

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/net/e1000.c       | 4 ++--
 hw/net/e1000e_core.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/net/e1000.c b/hw/net/e1000.c
index 972d9b5083..9233248c9a 100644
--- a/hw/net/e1000.c
+++ b/hw/net/e1000.c
@@ -1151,7 +1151,7 @@ set_ims(E1000State *s, int index, uint32_t val)
=20
 #define getreg(x)    [x] =3D mac_readreg
 typedef uint32_t (*readops)(E1000State *, int);
-static readops macreg_readops[] =3D {
+static const readops macreg_readops[] =3D {
     getreg(PBA),      getreg(RCTL),     getreg(TDH),      getreg(TXDCTL),
     getreg(WUFC),     getreg(TDT),      getreg(CTRL),     getreg(LEDCTL),
     getreg(MANC),     getreg(MDIC),     getreg(SWSM),     getreg(STATUS),
@@ -1207,7 +1207,7 @@ enum { NREADOPS =3D ARRAY_SIZE(macreg_readops) };
=20
 #define putreg(x)    [x] =3D mac_writereg
 typedef void (*writeops)(E1000State *, int, uint32_t);
-static writeops macreg_writeops[] =3D {
+static const writeops macreg_writeops[] =3D {
     putreg(PBA),      putreg(EERD),     putreg(SWSM),     putreg(WUFC),
     putreg(TDBAL),    putreg(TDBAH),    putreg(TXDCTL),   putreg(RDBAH),
     putreg(RDBAL),    putreg(LEDCTL),   putreg(VET),      putreg(FCRUC),
diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
index 38bdb90114..df957e0c1a 100644
--- a/hw/net/e1000e_core.c
+++ b/hw/net/e1000e_core.c
@@ -2856,7 +2856,7 @@ e1000e_set_gcr(E1000ECore *core, int index, uint32_t =
val)
=20
 #define e1000e_getreg(x)    [x] =3D e1000e_mac_readreg
 typedef uint32_t (*readops)(E1000ECore *, int);
-static readops e1000e_macreg_readops[] =3D {
+static const readops e1000e_macreg_readops[] =3D {
     e1000e_getreg(PBA),
     e1000e_getreg(WUFC),
     e1000e_getreg(MANC),
@@ -3063,7 +3063,7 @@ enum { E1000E_NREADOPS =3D ARRAY_SIZE(e1000e_macreg_r=
eadops) };
=20
 #define e1000e_putreg(x)    [x] =3D e1000e_mac_writereg
 typedef void (*writeops)(E1000ECore *, int, uint32_t);
-static writeops e1000e_macreg_writeops[] =3D {
+static const writeops e1000e_macreg_writeops[] =3D {
     e1000e_putreg(PBA),
     e1000e_putreg(SWSM),
     e1000e_putreg(WUFC),
--=20
2.21.1


