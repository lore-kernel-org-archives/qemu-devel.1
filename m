Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C5CC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 11:12:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19E5324672
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 11:12:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eQ7e4EXZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19E5324672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihtjD-0004Bh-RV
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 06:12:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43522)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1ihtYq-0006oh-Ss
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 06:01:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1ihtYp-00010V-HJ
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 06:01:40 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60890
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1ihtYp-0000y1-At
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 06:01:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576753298;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xHpMM384RdXLzpFE6SjAZkdl42OK3Or+UxwQ8vHaGjs=;
 b=eQ7e4EXZVlf3oSi0mZEditzL1Jt0wc3hd/n29QF7L1RIkIlxY+zkD3hsQyh8Y2ft7hCGdi
 lvExeX1CUaSlcNykuRWCArvrr7ghQN++QuQ0AEP9CsMqMVGbQl2gREHWwA/kh8soLwCZji
 /QNVqEMfQkvQ6D2uYXsIetCwKXUWYnM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-V4CIXPzsOm6JY6G4ARcCYw-1; Thu, 19 Dec 2019 06:01:29 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 289011005514;
 Thu, 19 Dec 2019 11:01:28 +0000 (UTC)
Received: from localhost (ovpn-117-134.ams2.redhat.com [10.36.117.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B32F710013A1;
 Thu, 19 Dec 2019 11:01:27 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 3/6] tests/boot-sector: Fix the bad s390x assembler code
Date: Thu, 19 Dec 2019 12:01:09 +0100
Message-Id: <20191219110112.8343-4-cohuck@redhat.com>
In-Reply-To: <20191219110112.8343-1-cohuck@redhat.com>
References: <20191219110112.8343-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: V4CIXPzsOm6JY6G4ARcCYw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Thomas Huth <thuth@redhat.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

There are currently two bugs in s390x_code[]: First, the initial jump
uses the wrong offset, so it was jumping to 0x10014 instead of 0x10010.
Second, LHI only loads the lower 32-bit of the register.

Everything worked fine as long as the s390-ccw bios code was jumping
here with r3 containing zeroes in the uppermost 48 bit - which just
happened to be the case so far by accident. But we can not rely on this
fact, and indeed one of the recent suggested patches to jump2ipl.c cause
the newer GCCs to put different values into r3. In that case the code
from s390x_code[] crashes very ungracefully.

Thus let's make sure to jump to the right instruction, and use LGHI
instead of LHI to make sure that we always zero out the upper bits
of the register.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20191217150642.27946-1-thuth@redhat.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 tests/boot-sector.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/boot-sector.c b/tests/boot-sector.c
index 7824286b9a4e..9e66c6d0130a 100644
--- a/tests/boot-sector.c
+++ b/tests/boot-sector.c
@@ -75,11 +75,11 @@ static const uint8_t s390x_psw_and_magic[] =3D {
     0x40, 0x40, 0x40, 0x40, 0x40, 0x40, 0x40, 0x40   /* in the s390-ccw bi=
os */
 };
 static const uint8_t s390x_code[] =3D {
-    0xa7, 0xf4, 0x00, 0x0a,                                /* j 0x10010 */
+    0xa7, 0xf4, 0x00, 0x08,                                /* j 0x10010 */
     0x00, 0x00, 0x00, 0x00,
     'S', '3', '9', '0',
     'E', 'P', 0x00, 0x01,
-    0xa7, 0x38, HIGH(SIGNATURE_ADDR), LOW(SIGNATURE_ADDR), /* lhi r3,0x7c1=
0 */
+    0xa7, 0x39, HIGH(SIGNATURE_ADDR), LOW(SIGNATURE_ADDR), /* lghi r3,0x7c=
10 */
     0xa7, 0x48, LOW(SIGNATURE), HIGH(SIGNATURE),           /* lhi r4,0xadd=
e */
     0x40, 0x40, 0x30, 0x00,                                /* sth r4,0(r3)=
 */
     0xa7, 0xf4, 0xff, 0xfa                                 /* j 0x10010 */
--=20
2.21.0


