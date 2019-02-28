Received: from eggs.gnu.org ([209.51.188.92]:54662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gzNHk-0004SK-GI
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 10:07:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gzNHh-00070w-By
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 10:07:42 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36566)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gzNHd-0005aT-Qi
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 10:07:39 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1SExdhh140431
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 10:06:15 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qxfs4y0da-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 10:06:14 -0500
Received: from localhost
	by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Thu, 28 Feb 2019 15:06:11 -0000
From: Greg Kurz <groug@kaod.org>
Date: Thu, 28 Feb 2019 16:06:06 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <155136636659.26299.15306206822524053043.stgit@bahia.lan>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] crypto/block: Fix build with gcc 9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, "Daniel P. Berrange" <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

Build fails with gcc 9:

crypto/block-luks.c:689:18: error: taking address of packed member of =E2=
=80=98struct QCryptoBlockLUKSHeader=E2=80=99 may result in an unaligned p=
ointer value [-Werror=3Daddress-of-packed-member]
  689 |     be32_to_cpus(&luks->header.payload_offset);
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
crypto/block-luks.c:690:18: error: taking address of packed member of =E2=
=80=98struct QCryptoBlockLUKSHeader=E2=80=99 may result in an unaligned p=
ointer value [-Werror=3Daddress-of-packed-member]
  690 |     be32_to_cpus(&luks->header.key_bytes);
      |                  ^~~~~~~~~~~~~~~~~~~~~~~
crypto/block-luks.c:691:18: error: taking address of packed member of =E2=
=80=98struct QCryptoBlockLUKSHeader=E2=80=99 may result in an unaligned p=
ointer value [-Werror=3Daddress-of-packed-member]
  691 |     be32_to_cpus(&luks->header.master_key_iterations);
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

... a bunch of similar errors...

crypto/block-luks.c:1288:22: error: taking address of packed member of =E2=
=80=98struct QCryptoBlockLUKSKeySlot=E2=80=99 may result in an unaligned =
pointer value [-Werror=3Daddress-of-packed-member]
 1288 |         be32_to_cpus(&luks->header.key_slots[i].stripes);
      |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

All members of the QCryptoBlockLUKSKeySlot and QCryptoBlockLUKSHeader are
naturally aligned and we already check at build time there isn't any
unwanted padding. Drop the QEMU_PACKED attribute.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 crypto/block-luks.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/crypto/block-luks.c b/crypto/block-luks.c
index 6bac79c3ab6b..5a69b3ce74d3 100644
--- a/crypto/block-luks.c
+++ b/crypto/block-luks.c
@@ -146,7 +146,7 @@ struct QCryptoBlockLUKSKeySlot {
     uint32_t key_offset;
     /* number of anti-forensic stripes */
     uint32_t stripes;
-} QEMU_PACKED;
+};
=20
 QEMU_BUILD_BUG_ON(sizeof(struct QCryptoBlockLUKSKeySlot) !=3D 48);
=20
@@ -191,7 +191,7 @@ struct QCryptoBlockLUKSHeader {
=20
     /* key slots */
     QCryptoBlockLUKSKeySlot key_slots[QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS];
-} QEMU_PACKED;
+};
=20
 QEMU_BUILD_BUG_ON(sizeof(struct QCryptoBlockLUKSHeader) !=3D 592);
=20
