Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D86AC3F2CD
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 12:47:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 672DA20848
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 12:47:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="arjfed0z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 672DA20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9puE-0000PV-GP
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 07:47:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41629)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j9psn-0006Un-Oi
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 07:45:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j9psm-0001PW-Ou
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 07:45:45 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29636
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j9psm-0001Oy-LV
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 07:45:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583412344;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HfnT8d1lOc8oOW388s3B4mt/9tuFbIC8PeXMCcmaMOk=;
 b=arjfed0zfDmzfwX7S+UVdHfY7DDTi/rdqzG6nXzwk1Z6OB8mjeSo1ZhCvnBxJtR3E3icZJ
 lOvtZUM83lxPVuHRXN7gbImEOB4tS7Txv6i2/lNd6xx5W4CsFGkdiF1WoTjUUAjQ7weGxa
 +i27of4MHO1dnoijeeh03lNRQGMsMdU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-191--E0rBE8jPSKLYV0Jur9KIw-1; Thu, 05 Mar 2020 07:45:40 -0500
X-MC-Unique: -E0rBE8jPSKLYV0Jur9KIw-1
Received: by mail-wr1-f70.google.com with SMTP id m13so2266969wrw.3
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 04:45:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7WthtJEuF/N+eAMadHF0Sd51QGcmnmZoupRAgou8XDo=;
 b=rDdApjMtgSXSD7Ggh0la+DZeeOQta5NJpQPJnbL86TRTWfGaforpK0HBfquAwbplr7
 7Z7KkB6jvsR8qQSledUG0f5I7Q60JCWjVr+QQwn0RCiKHJmCzGpHNulGYyjAB5ZYfcB6
 PBpSLX9f2LI+fP4/Hz9gaEVosD9pKbSL2XAmPIcUU9lJ5BoFE2cGqQ+95ml/5oAPebUQ
 SgY643/KZUGesjEmV5M3jXDn6jaouSBhl9Q/LtpJkJRp1qYUHmhGUP+UFxdybpVkNy0k
 WH8PAg0KpbEJbf3Ck85A7JxDb4jXzh7xF787PwYe94yIjX0/P2pJCQt3xk2RBMlko1OQ
 LWNg==
X-Gm-Message-State: ANhLgQ1Wo0BYPIwOToCPf6wbK6NSLJjcCqcsBHG+v1TkNhlT8JEQTE36
 vZkycfgWUpnmRDACFi22lwPNWZ9eYlXxxxVujODrNMnIFkhX7uvyyB4mHTq6v6jw3ovK8BLGPEw
 A3U4O+9QtVUiK8Pk=
X-Received: by 2002:a1c:6884:: with SMTP id d126mr9090948wmc.38.1583412339471; 
 Thu, 05 Mar 2020 04:45:39 -0800 (PST)
X-Google-Smtp-Source: ADFU+vszSRNbFNB70lPwi1+dJrIysVzEGOnhLy69XyNqvWJZ5pFATslY5R70zu29Mm0icEgl9lXtrw==
X-Received: by 2002:a1c:6884:: with SMTP id d126mr9090927wmc.38.1583412339278; 
 Thu, 05 Mar 2020 04:45:39 -0800 (PST)
Received: from localhost.localdomain (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id m3sm25274864wrx.9.2020.03.05.04.45.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2020 04:45:38 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-trivial@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 2/9] hw/audio/fmopl: Move ENV_CURVE to .heap to save 32KiB
 of .bss
Date: Thu,  5 Mar 2020 13:45:18 +0100
Message-Id: <20200305124525.14555-3-philmd@redhat.com>
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
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
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


