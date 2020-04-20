Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B78C3815B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 13:30:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C55F520735
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 13:30:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZLWG7Wks"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C55F520735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQWVL-0001JJ-Kr
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 09:30:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59568 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jQWTT-0007Pw-2P
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 09:28:37 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jQWTR-0002o7-Vd
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 09:28:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58529
 helo=us-smtp-1.mimecast.com)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jQWTR-0002hO-86
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 09:28:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587389311;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=09TJwsmOuS2nlb9BQG9YMwh8nZNuEZc4zt/gXYeOK3M=;
 b=ZLWG7Wks3Q6v0+Gb+ZnvPG9STmrJIE4/nL2rlCmZYWGgUwi+eW9vn/JIDzvDfyOdqIieEj
 EQyB3u+tJwp2xBwK42U2o9PzW5FZvQ/AxiMzVWneJgKSpt3frEIH9aVafwH3Qet+4XqPKH
 ePOR4+lCn2APvPhVl+smHtjH+1tA7Vs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-16-4-4F3Zd-OGqlF1O7b0-fYg-1; Mon, 20 Apr 2020 09:28:30 -0400
X-MC-Unique: 4-4F3Zd-OGqlF1O7b0-fYg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D7060107ACCD;
 Mon, 20 Apr 2020 13:28:28 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3C64F5DA76;
 Mon, 20 Apr 2020 13:28:27 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1D36611358BD; Mon, 20 Apr 2020 15:28:26 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/4] sam460ex: Revert change to SPD memory type for <= 128 MiB
Date: Mon, 20 Apr 2020 15:28:23 +0200
Message-Id: <20200420132826.8879-2-armbru@redhat.com>
In-Reply-To: <20200420132826.8879-1-armbru@redhat.com>
References: <20200420132826.8879-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs1p.gnu.org: First seen = 2020/04/20
 04:32:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Requesting 32 or 64 MiB of RAM with the sam460ex machine type produces
a useless warning:

    qemu-system-ppc: warning: Memory size is too small for SDRAM type, adju=
sting type

This is because sam460ex_init() asks spd_data_generate() for DDR2,
which is impossible, so spd_data_generate() corrects it to DDR.

The warning goes back to commit 08fd99179a "sam460ex: Clean up SPD
EEPROM creation".  Turns out that commit changed memory type and
number of banks to

    RAM size    #banks  type    bank size
     128 MiB         1   DDR2     128 MiB
      64 MiB         2   DDR       32 MiB
      32 MiB         1   DDR       32 MiB

from

    RAM size    #banks  type    bank size
     128 MiB         2   SDR       64 MiB
      64 MiB         2   SDR       32 MiB
      32 MiB         2   SDR       16 MiB

Reverting that change also gets rid of the warning.

I doubt physical Sam460ex boards can take SDR or DDR modules, though.

The commit changed SPD contents in other places, too.  So does commit
fb1b0fcc03 "target/mips: fulong2e: Dynamically generate SPD EEPROM
data" for machine type fulong2e.  I'm not reverting these changes.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/ppc/sam460ex.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index 898453cf30..856bc0b5a3 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -335,7 +335,8 @@ static void sam460ex_init(MachineState *machine)
     dev =3D sysbus_create_simple(TYPE_PPC4xx_I2C, 0x4ef600700, uic[0][2]);
     i2c =3D PPC4xx_I2C(dev)->bus;
     /* SPD EEPROM on RAM module */
-    spd_data =3D spd_data_generate(DDR2, ram_sizes[0], &err);
+    spd_data =3D spd_data_generate(ram_sizes[0] < 256 * MiB ? SDR : DDR2,
+                                 ram_sizes[0], &err);
     if (err) {
         warn_report_err(err);
     }
--=20
2.21.1


