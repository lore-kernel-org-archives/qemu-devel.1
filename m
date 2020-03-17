Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2599DC10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 09:25:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4911205ED
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 09:24:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RH48OyPT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4911205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE8T5-0007mK-5o
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 05:24:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57862)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jE8SA-0007MJ-59
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 05:24:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jE8S9-0001oC-38
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 05:24:02 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:50106)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jE8S8-0001lY-V0
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 05:24:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584437040;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=EIBdypXFTMkRP+eena4ORdcoOpUWs6fVNXve8+H7Hu4=;
 b=RH48OyPTU3WrbIQZNj1l7XXTPbINk9sBtWR9VzWsyLvG9fzygXnPRrDf9Ntx3+59bxjDDS
 ojOHiBCSf5XmqgZuKo95/zCYAw6FTvhQyJji/Anl1h6+oWCpVhwkTyO9q3cnENgsFATrwO
 u6AC/BRKMd2VGXVz3IKEnD8dxUwI6mE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-6np56R6WNE-iQXhmzZhwaw-1; Tue, 17 Mar 2020 05:23:57 -0400
X-MC-Unique: 6np56R6WNE-iQXhmzZhwaw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 122C7800EB6;
 Tue, 17 Mar 2020 09:23:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-130.ams2.redhat.com
 [10.36.112.130])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D3D3C5DA76;
 Tue, 17 Mar 2020 09:23:55 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A88D91138404; Tue, 17 Mar 2020 10:23:54 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] hd-geo-test: Clean up use of buf[] in create_qcow2_with_mbr()
Date: Tue, 17 Mar 2020 10:23:54 +0100
Message-Id: <20200317092354.31831-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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
Cc: John Snow <jsnow@redhat.com>, Sam Eiderman <shmuel.eiderman@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

valgrind reports write unitialized bytes from buf[].  Clear them.

ASan reports we store to misaligned address in buf[].  Use stl_le_p()
for that.

Cc: Sam Eiderman <shmuel.eiderman@oracle.com>
Cc: John Snow <jsnow@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
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


