Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BAFBC28CC7
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 09:08:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05B6527137
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 09:08:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05B6527137
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60018 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXixP-0005fY-4T
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 05:08:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hXivW-0004FI-Rx
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 05:06:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hXivU-00024r-J7
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 05:06:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55984)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>)
	id 1hXivU-00022G-8p; Mon, 03 Jun 2019 05:06:44 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1C85BC05678B;
	Mon,  3 Jun 2019 09:06:43 +0000 (UTC)
Received: from t460s.redhat.com (unknown [10.36.117.0])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C57D860C7F;
	Mon,  3 Jun 2019 09:06:40 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon,  3 Jun 2019 11:06:14 +0200
Message-Id: <20190603090635.10631-2-david@redhat.com>
In-Reply-To: <20190603090635.10631-1-david@redhat.com>
References: <20190603090635.10631-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.32]);
	Mon, 03 Jun 2019 09:06:43 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 01/22] s390x/tcg: Store only the necessary
 amount of doublewords for STFLE
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Stefan Liebler <stli@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
	Denys Vlasenko <dvlasenk@redhat.com>, David Hildenbrand <david@redhat.com>,
	Andreas Krebbel <Andreas.Krebbel@de.ibm.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Pino Toscano <ptoscano@redhat.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The PoP (z14, 7-382) says:
    Doublewords to the right of the doubleword in which the
    highest-numbered facility bit is assigned for a model
    may or may not be stored.

However, stack protection in certain binaries can't deal with that.
"gzip" example code:

f1b4:       a7 08 00 03             lhi     %r0,3
f1b8:       b2 b0 f0 a0             stfle   160(%r15)
f1bc:       e3 20 f0 b2 00 90       llgc    %r2,178(%r15)
f1c2:       c0 2b 00 00 00 01       nilf    %r2,1
f1c8:       b2 4f 00 10             ear     %r1,%a0
f1cc:       b9 14 00 22             lgfr    %r2,%r2
f1d0:       eb 11 00 20 00 0d       sllg    %r1,%r1,32
f1d6:       b2 4f 00 11             ear     %r1,%a1
f1da:       d5 07 f0 b8 10 28       clc     184(8,%r15),40(%r1)
f1e0:       a7 74 00 06             jne     f1ec <file_read@@Base+0x1bc>
f1e4:       eb ef f1 30 00 04       lmg     %r14,%r15,304(%r15)
f1ea:       07 fe                   br      %r14
f1ec:       c0 e5 ff ff 9d 6e       brasl   %r14,2cc8 <__stack_chk_fail@p=
lt>

In QEMU, we currently have:
    max_bytes =3D 24
the code asks for (3 + 1) doublewords =3D=3D 32 bytes.

If we write 32 bytes instead of only 24, and return "2 + 1" doublewords
("one less than the number of doulewords needed to contain all of the
 facility bits"), the example code detects a stack corruption.

In my opinion, the code is wrong. However, it seems to work fine on
real machines. So let's limit storing to the minimum of the requested
and the maximum doublewords.

Cc: Stefan Liebler <stli@linux.ibm.com>
Cc: Andreas Krebbel <Andreas.Krebbel@de.ibm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/misc_helper.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
index 34476134a4..10aa617cf9 100644
--- a/target/s390x/misc_helper.c
+++ b/target/s390x/misc_helper.c
@@ -678,7 +678,13 @@ uint32_t HELPER(stfle)(CPUS390XState *env, uint64_t =
addr)
=20
     prepare_stfl();
     max_bytes =3D ROUND_UP(used_stfl_bytes, 8);
-    for (i =3D 0; i < count_bytes; ++i) {
+
+    /*
+     * The PoP says that doublewords beyond the highest-numbered facilit=
y
+     * bit may or may not be stored.  However, existing hardware appears=
 to
+     * not store the words, and existing software depend on that.
+     */
+    for (i =3D 0; i < MIN(count_bytes, max_bytes); ++i) {
         cpu_stb_data_ra(env, addr + i, stfl_bytes[i], ra);
     }
=20
--=20
2.21.0


