Received: from eggs.gnu.org ([209.51.188.92]:50160)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gw9vv-0003CR-Hu
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 13:15:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gw9vh-0005QO-1j
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 13:15:44 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:53498 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gw9vf-0004ui-SP
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 13:15:40 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Tue, 19 Feb 2019 19:14:11 +0100
Message-Id: <1550600059-5789-2-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1550600059-5789-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1550600059-5789-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 1/9] hw/misc: mips_itu: Fix 32/64 bit issue
 in a line involving shift operator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, amarkovic@wavecomp.com, peter.maydell@linaro.org, arikalo@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Fix 32/64 bit issue in a line involving shift operator. "1 << ..."
calculation of size is done as a 32-bit signed integer which may
then be unintentionally sign-extended into the 64-bit result. The
problem was discovered by Coverity (CID 1398648). Using "1ULL"
instead of "1" on the LHS of the shift fixes this problem.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/misc/mips_itu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/misc/mips_itu.c b/hw/misc/mips_itu.c
index 1257d8f..3afdbe6 100644
--- a/hw/misc/mips_itu.c
+++ b/hw/misc/mips_itu.c
@@ -94,7 +94,7 @@ void itc_reconfigure(MIPSITUState *tag)
=20
     if (tag->saar_present) {
         address =3D ((*(uint64_t *) tag->saar) & 0xFFFFFFFFE000ULL) << 4=
;
-        size =3D 1 << ((*(uint64_t *) tag->saar >> 1) & 0x1f);
+        size =3D 1ULL << ((*(uint64_t *) tag->saar >> 1) & 0x1f);
         is_enabled =3D *(uint64_t *) tag->saar & 1;
     }
=20
--=20
2.7.4
