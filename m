Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15A2BC2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 09:29:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D540722522
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 09:29:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a8Q/7wj+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D540722522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itpqi-0006Hm-3a
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 04:29:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58325)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrezanin@redhat.com>) id 1itppr-0005QJ-I1
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 04:28:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrezanin@redhat.com>) id 1itppq-0001pu-KH
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 04:28:35 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:31093
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mrezanin@redhat.com>) id 1itppq-0001pc-GV
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 04:28:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579598913;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:in-reply-to:references:references:references;
 bh=pYodZQXMhVcIrB+en2M7QyjxGrpL1f1tVGXYrbtpSS8=;
 b=a8Q/7wj+7zycuKqrljd8Hp2rHMqnHdfEvRZvjJ996k1DI2oK5BfV+74pgMAVaUZcMZUsiF
 IYQYFXLGaYyD32vTrisRlIFmBYUSzueZTmSh8NWgMEbeyBwer5/q/urUIuHkZ9wvmCcxIx
 xyZMlKvBtPkqkZbW7ifKkMh/1dFBjMI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-276-GUwCQjCsNrKSYU1FQZsDcA-1; Tue, 21 Jan 2020 04:28:21 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 90CF4DB62;
 Tue, 21 Jan 2020 09:28:20 +0000 (UTC)
Received: from workimage.localdomain (ovpn-204-25.brq.redhat.com
 [10.40.204.25])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9F1915DA66;
 Tue, 21 Jan 2020 09:28:19 +0000 (UTC)
From: mrezanin@redhat.com
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] aspeed/i2c: Prevent uninitialized warning
Date: Tue, 21 Jan 2020 10:28:14 +0100
Message-Id: <07957dcab31f65de3dd30efa91e6b9152ac79879.1579598240.git.mrezanin@redhat.com>
In-Reply-To: <cover.1579598240.git.mrezanin@redhat.com>
References: <cover.1579598240.git.mrezanin@redhat.com>
In-Reply-To: <cover.1579598240.git.mrezanin@redhat.com>
References: <cover.1579598240.git.mrezanin@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: GUwCQjCsNrKSYU1FQZsDcA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Miroslav Rezanina <mrezanin@redhat.com>

Compiler reports uninitialized warning for cmd_flags variable.

Adding NULL initialization to prevent this warning.

Signed-off-by: Miroslav Rezanina <mrezanin@redhat.com>
---
 hw/i2c/aspeed_i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
index 2da04a4..445182a 100644
--- a/hw/i2c/aspeed_i2c.c
+++ b/hw/i2c/aspeed_i2c.c
@@ -400,7 +400,7 @@ static bool aspeed_i2c_check_sram(AspeedI2CBus *bus)
=20
 static void aspeed_i2c_bus_cmd_dump(AspeedI2CBus *bus)
 {
-    g_autofree char *cmd_flags;
+    g_autofree char *cmd_flags =3D NULL;
     uint32_t count;
=20
     if (bus->cmd & (I2CD_RX_BUFF_ENABLE | I2CD_RX_BUFF_ENABLE)) {
--=20
1.8.3.1


