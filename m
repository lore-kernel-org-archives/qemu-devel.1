Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC33C3F2D7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 22:19:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 741E020848
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 22:19:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EC66bnap"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 741E020848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9cMd-00029s-IU
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 17:19:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32987)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j9cLR-0008TB-5k
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 17:18:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j9cLP-0006e3-7g
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 17:18:25 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:24703
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j9cLP-0006dH-41
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 17:18:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583360302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HfnT8d1lOc8oOW388s3B4mt/9tuFbIC8PeXMCcmaMOk=;
 b=EC66bnapAmehsR4VB3RZNyVUCRPC3PYiujP9vxs3ZXguQGxTIe+V0sNXKUEezAS1krpxAD
 VP2aEpAN+0B8wrzuxWpVNZdytKIFEU4o3tG/wFiJFHpwK9w99eJMxv4TBba8obmyoyPEhQ
 FkACEBbOcql09rJ7zQEE/W/AV6zjBeo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-dWEvxEqFOrGvEW--I5etOQ-1; Wed, 04 Mar 2020 17:18:21 -0500
X-MC-Unique: dWEvxEqFOrGvEW--I5etOQ-1
Received: by mail-wr1-f70.google.com with SMTP id b12so1463859wro.4
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2020 14:18:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7WthtJEuF/N+eAMadHF0Sd51QGcmnmZoupRAgou8XDo=;
 b=Wvp9MGwesigHjt8922uAlQbgACSjvfkVvXk62xCRGNcm2eUKQdbE7l2TmbK8nKym3R
 CGldigWebki7r8ewBN6MsCii300wzxaH6o1pwdMBY7o2n/KvlZRZVfB1e84/gYsfrcat
 Nl4Y0UAn7PseW8uFTQL+PQWHW2PeLCCSUKcSLuZOMBWU7dnQ52kd6J3s4JwrnV2F1kmB
 cUNAUC9Hs0WnTbqADfWyGKF401MwNCIdoUN7n4a9YQpre+2mCziyGXwWhyQUI91Nfqsm
 E8db8BZ0Ui58ioxUIPKOx5e38As/SXUsQBJJexhrwBUaXUtoFzzSZn2v0PskwVDtn3rq
 uC3A==
X-Gm-Message-State: ANhLgQ0lweqIkjoEatisnw704zkEHEBMQzRRFU93YJRcDJ3XjoTWIggI
 BpJku6aq86O2Lj04jV2iKp03ay7mbkiwAGZKKHfTzvZJ3tiHAlfDGk/WRmOHUWXjGMXWvzoY1HY
 wSqkY+ttOA/RFKcM=
X-Received: by 2002:a1c:7c05:: with SMTP id x5mr5409982wmc.67.1583360299678;
 Wed, 04 Mar 2020 14:18:19 -0800 (PST)
X-Google-Smtp-Source: ADFU+vslSkLYmU0p/p71iLp1NDP15gsZCNYU3xL69nA9zpOzAMa1N/ZkbHvZSvLrf1G1vtro/6DR/w==
X-Received: by 2002:a1c:7c05:: with SMTP id x5mr5409970wmc.67.1583360299484;
 Wed, 04 Mar 2020 14:18:19 -0800 (PST)
Received: from localhost.localdomain (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id g129sm7333661wmg.12.2020.03.04.14.18.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2020 14:18:19 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/6] hw/audio/fmopl: Move ENV_CURVE to .heap to save 32KiB of
 .bss
Date: Wed,  4 Mar 2020 23:18:03 +0100
Message-Id: <20200304221807.25212-3-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200304221807.25212-1-philmd@redhat.com>
References: <20200304221807.25212-1-philmd@redhat.com>
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
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This buffer is only used by the adlib audio device. Move it to
the .heap to release 32KiB of .bss (size reported on x86_64 host).

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/audio/fmopl.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/audio/fmopl.c b/hw/audio/fmopl.c
index 173a7521f2..356d4dfbca 100644
--- a/hw/audio/fmopl.c
+++ b/hw/audio/fmopl.c
@@ -186,7 +186,7 @@ static int32_t *VIB_TABLE;
=20
 /* envelope output curve table */
 /* attack + decay + OFF */
-static int32_t ENV_CURVE[2*EG_ENT+1];
+static int32_t *ENV_CURVE;
=20
 /* multiple table */
 #define ML 2
@@ -1090,6 +1090,7 @@ FM_OPL *OPLCreate(int clock, int rate)
 =09OPL->clock =3D clock;
 =09OPL->rate  =3D rate;
 =09OPL->max_ch =3D max_ch;
+    ENV_CURVE =3D g_new(int32_t, 2 * EG_ENT + 1);
 =09/* init grobal tables */
 =09OPL_initialize(OPL);
 =09/* reset chip */
@@ -1127,6 +1128,7 @@ void OPLDestroy(FM_OPL *OPL)
 #endif
 =09OPL_UnLockTable();
 =09free(OPL);
+    g_free(ENV_CURVE);
 }
=20
 /* ----------  Option handlers ----------       */
--=20
2.21.1


