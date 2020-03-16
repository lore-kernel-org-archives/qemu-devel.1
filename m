Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D114C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 21:43:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37A6F20658
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 21:43:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HMgGV3PU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37A6F20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDxWD-0007yR-Co
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 17:43:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42315)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jDxHa-0003Yx-6k
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:28:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jDxHZ-0004dC-5o
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:28:22 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:51690)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jDxHZ-0004Wq-0O
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:28:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584394100;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=APH5QeUNY4+QdIZjt0jLIZOSs0GF5eMKvhg6Of9TREg=;
 b=HMgGV3PU/Z9NaRaSulg5sltz9qk45BtLDlJ1ZAGou0VC2dAmKbDRM9f5luipAV1MRPltmU
 5Gu83SppZUkvuH2zZLi/PLiyqLYwq8umcqDFtlengsVufbegbKsHBMj5KrZjzH9mKxgNhD
 nqOpCP6MsS1MafjOiIJKydAuJNQffeA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-138-GQnqhdomP5u6yrQGSzR4Og-1; Mon, 16 Mar 2020 17:28:19 -0400
X-MC-Unique: GQnqhdomP5u6yrQGSzR4Og-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4AA69800D53
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 21:28:18 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 46A3F19C4F;
 Mon, 16 Mar 2020 21:28:16 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 25/61] hw/audio/fmopl: Move ENV_CURVE to .heap to save 32KiB of
 .bss
Date: Mon, 16 Mar 2020 22:26:52 +0100
Message-Id: <1584394048-44994-26-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1584394048-44994-1-git-send-email-pbonzini@redhat.com>
References: <1584394048-44994-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

This buffer is only used by the adlib audio device. Move it to
the .heap to release 32KiB of .bss (size reported on x86_64 host).

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/audio/fmopl.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/audio/fmopl.c b/hw/audio/fmopl.c
index 173a752..356d4df 100644
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
1.8.3.1



