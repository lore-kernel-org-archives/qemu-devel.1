Received: from eggs.gnu.org ([209.51.188.92]:52526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gnjCC-0001OQ-FX
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 07:05:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gnjCB-0007Qu-Af
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 07:05:52 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:46440)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gnjCB-0007Ow-2c
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 07:05:51 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Sun, 27 Jan 2019 13:04:58 +0100
Message-Id: <20190127120526.15457-4-samuel.thibault@ens-lyon.org>
In-Reply-To: <20190127120526.15457-1-samuel.thibault@ens-lyon.org>
References: <20190127120526.15457-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 03/31] slirp: Don't mark struct ipq or struct
 ipasfrag as packed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, stefanha@redhat.com, jan.kiszka@siemens.com, Eric Blake <eblake@redhat.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>

From: Peter Maydell <peter.maydell@linaro.org>

There is no reason to mark the struct ipq and struct ipasfrag as
packed: they are naturally aligned anyway, and are not representing
any on-the-wire packet format.  Indeed they vary in size depending on
the size of pointers on the host system, because the 'struct qlink'
members include 'void *' fields.

Dropping the 'packed' annotation fixes clang -Waddress-of-packed-member
warnings and probably lets the compiler generate better code too.

The only thing we do care about in the layout of the struct is
that the frag_link matches up with the ipf_link of the struct
ipasfrag, as documented in the comment on that struct; assert
at build time that this is the case.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 slirp/ip.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/slirp/ip.h b/slirp/ip.h
index 243b6c8b24..20614f3b53 100644
--- a/slirp/ip.h
+++ b/slirp/ip.h
@@ -217,7 +217,7 @@ struct ipq {
 	uint8_t	ipq_p;			/* protocol of this fragment */
 	uint16_t	ipq_id;			/* sequence id for reassembly */
 	struct	in_addr ipq_src,ipq_dst;
-} QEMU_PACKED;
+};
=20
 /*
  * Ip header, when holding a fragment.
@@ -227,7 +227,10 @@ struct ipq {
 struct	ipasfrag {
 	struct qlink ipf_link;
 	struct ip ipf_ip;
-} QEMU_PACKED;
+};
+
+QEMU_BUILD_BUG_ON(offsetof(struct ipq, frag_link) !=3D
+                  offsetof(struct ipasfrag, ipf_link));
=20
 #define ipf_off      ipf_ip.ip_off
 #define ipf_tos      ipf_ip.ip_tos
--=20
2.20.1
