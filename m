Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93107C1975A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 23:31:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A71120714
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 23:31:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fgzAOnrf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A71120714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jELfo-0002vN-EM
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 19:31:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53762)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1jELZv-0001JC-Qd
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 19:24:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1jELZu-0006vC-Lj
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 19:24:55 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:41646)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1jELZu-0006su-Hd
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 19:24:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584487494;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iTUxrqKd3xkC2/IG1RLkQg78Qagv6McRiF9KJC8aCZU=;
 b=fgzAOnrfcNXvGWvsyPwV949lrYx+dWQgBgDd5vvg+gpokT3cNr+xWTh6LQJsbMWycg+2OP
 CpbH7YLkSLfG7MCanNjPDKF+5uBdz2HxDH0o3/eIIYaPEK7bexKQnd5pay5MJcLJhvoHRR
 +/OnPkFktyxwOTedF6D3GJZCgXYSP5k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-121-bhdk7CDsOGKtL-pVIdqu2g-1; Tue, 17 Mar 2020 19:24:50 -0400
X-MC-Unique: bhdk7CDsOGKtL-pVIdqu2g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2FC1B10CE782;
 Tue, 17 Mar 2020 23:24:48 +0000 (UTC)
Received: from probe.redhat.com (ovpn-112-191.rdu2.redhat.com [10.10.112.191])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 85CAE60BE0;
 Tue, 17 Mar 2020 23:24:44 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 12/20] hd-geo-test: Clean up use of buf[] in
 create_qcow2_with_mbr()
Date: Tue, 17 Mar 2020 19:23:21 -0400
Message-Id: <20200317232329.22362-13-jsnow@redhat.com>
In-Reply-To: <20200317232329.22362-1-jsnow@redhat.com>
References: <20200317232329.22362-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Sam Eiderman <shmuel.eiderman@oracle.com>, qemu-block@nongnu.org,
 Helge Deller <deller@gmx.de>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 John Snow <jsnow@redhat.com>, David Gibson <david@gibson.dropbear.id.au>,
 Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 qemu-ppc@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Markus Armbruster <armbru@redhat.com>

valgrind reports write unitialized bytes from buf[].  Clear them.

ASan reports we store to misaligned address in buf[].  Use stl_le_p()
for that.

Cc: Sam Eiderman <shmuel.eiderman@oracle.com>
Cc: John Snow <jsnow@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-id: 20200317092354.31831-1-armbru@redhat.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/qtest/hd-geo-test.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/qtest/hd-geo-test.c b/tests/qtest/hd-geo-test.c
index a249800544..48e8e02d6e 100644
--- a/tests/qtest/hd-geo-test.c
+++ b/tests/qtest/hd-geo-test.c
@@ -421,7 +421,7 @@ static char *create_qcow2_with_mbr(MBRpartitions mbr, u=
int64_t sectors)
     char *raw_path =3D strdup(template);
     char *qcow2_path =3D strdup(template);
     char cmd[100 + 2 * PATH_MAX];
-    uint8_t buf[512];
+    uint8_t buf[512] =3D {};
     int i, ret, fd, offset;
     uint64_t qcow2_size =3D sectors * 512;
     uint8_t status, parttype, head, sector, cyl;
@@ -457,8 +457,8 @@ static char *create_qcow2_with_mbr(MBRpartitions mbr, u=
int64_t sectors)
         buf[offset + 0x6] =3D sector;
         buf[offset + 0x7] =3D cyl;
=20
-        (*(uint32_t *)&buf[offset + 0x8]) =3D cpu_to_le32(mbr[i].start_sec=
t);
-        (*(uint32_t *)&buf[offset + 0xc]) =3D cpu_to_le32(mbr[i].nr_sects)=
;
+        stl_le_p(&buf[offset + 0x8], mbr[i].start_sect);
+        stl_le_p(&buf[offset + 0xc], mbr[i].nr_sects);
=20
         offset +=3D 0x10;
     }
--=20
2.21.1


