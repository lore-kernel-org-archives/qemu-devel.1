Received: from eggs.gnu.org ([2001:4830:134:3::10]:58690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fOR8g-0003ny-HM
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:13:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fOR8f-0000Kb-E9
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:13:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45850 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fOR8f-0000Jq-89
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:13:25 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 31 May 2018 19:12:32 +0200
Message-Id: <20180531171253.21012-33-pbonzini@redhat.com>
In-Reply-To: <20180531171253.21012-1-pbonzini@redhat.com>
References: <20180531171253.21012-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 32/53] memfd: Avoid Coverity warning about
 integer overflow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

From: Peter Maydell <peter.maydell@linaro.org>

Coverity complains about qemu_memfd_create() (CID 1385858) because
we calculate a bit position htsize which could be up to 63, but
then use it in "1 << htsize" which is a 32-bit integer calculation
and could push the 1 off the top of the value.

Silence the complaint bu using "1ULL"; this isn't a bug in
practice since a hugetlbsize of 4GB is not very plausible.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20180515172729.24564-1-peter.maydell@linaro.org>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 util/memfd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/util/memfd.c b/util/memfd.c
index b3ecbac19e..d248a53c3c 100644
--- a/util/memfd.c
+++ b/util/memfd.c
@@ -66,7 +66,7 @@ int qemu_memfd_create(const char *name, size_t size, bo=
ol hugetlb,
 {
     int htsize =3D hugetlbsize ? ctz64(hugetlbsize) : 0;
=20
-    if (htsize && 1 << htsize !=3D hugetlbsize) {
+    if (htsize && 1ULL << htsize !=3D hugetlbsize) {
         error_setg(errp, "Hugepage size must be a power of 2");
         return -1;
     }
--=20
2.17.0
