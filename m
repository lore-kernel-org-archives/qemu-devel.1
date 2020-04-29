Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB5AC83004
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 07:26:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 683A92076B
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 07:26:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FnQXsSqB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 683A92076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTh7A-0000NL-92
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 03:26:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46196)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jTh20-0007tx-5i
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 03:22:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jTh1i-0003yO-P4
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 03:21:19 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:39127
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jTh1g-0003v1-Ih
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 03:21:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588144857;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ohrMlQSDYve0v0icgLJtlOnRxnFckFAJJHmPNmaC5mg=;
 b=FnQXsSqBcgXmyW5GtwAh+L3jfJRg5fvuFjVp3leP+NzneLHg5XMTJP0zs7rPFbA8CSFvlW
 0U4u/Oif+mLMQ/iQ+2XRtMoenBC19Dc0RocMt4COXrvWJbzOeUpLYOkw3+JTgjIiqWciHL
 amKA7kUX237b4EdUVeAte5Kz0TltdMg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-289-j-bjr4kxPu2lXHGk3_CWBA-1; Wed, 29 Apr 2020 03:20:55 -0400
X-MC-Unique: j-bjr4kxPu2lXHGk3_CWBA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0B2081895A28
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 07:20:55 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D04AD600DB;
 Wed, 29 Apr 2020 07:20:54 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 60E9211358D6; Wed, 29 Apr 2020 09:20:49 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 25/32] sam460ex: Suppress useless warning on -m 32 and -m 64
Date: Wed, 29 Apr 2020 09:20:41 +0200
Message-Id: <20200429072048.29963-26-armbru@redhat.com>
In-Reply-To: <20200429072048.29963-1-armbru@redhat.com>
References: <20200429072048.29963-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 01:28:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
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
EEPROM creation".

Make sam460ex_init() pass the correct SDRAM type to get rid of the
warning.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20200422134815.1584-2-armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/ppc/sam460ex.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index 898453cf30..1e3eaac0db 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -335,7 +335,8 @@ static void sam460ex_init(MachineState *machine)
     dev =3D sysbus_create_simple(TYPE_PPC4xx_I2C, 0x4ef600700, uic[0][2]);
     i2c =3D PPC4xx_I2C(dev)->bus;
     /* SPD EEPROM on RAM module */
-    spd_data =3D spd_data_generate(DDR2, ram_sizes[0], &err);
+    spd_data =3D spd_data_generate(ram_sizes[0] < 128 * MiB ? DDR : DDR2,
+                                 ram_sizes[0], &err);
     if (err) {
         warn_report_err(err);
     }
--=20
2.21.1


