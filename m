Received: from eggs.gnu.org ([209.51.188.92]:40453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gm0zS-0007xU-D8
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:41:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gm0zO-0001hT-GQ
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:41:36 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:40150)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gm0z9-0000sS-3w
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:41:24 -0500
Received: by mail-wr1-x444.google.com with SMTP id p4so28576619wrt.7
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 10:39:31 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 Jan 2019 18:18:22 +0000
Message-Id: <20190122181822.1505-3-peter.maydell@linaro.org>
In-Reply-To: <20190122181822.1505-1-peter.maydell@linaro.org>
References: <20190122181822.1505-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 2/2] slirp: Don't mark struct ipq or struct
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
Cc: patches@linaro.org, Samuel Thibault <samuel.thibault@ens-lyon.org>, Jan Kiszka <jan.kiszka@siemens.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

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
---
 slirp/ip.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/slirp/ip.h b/slirp/ip.h
index 243b6c8b249..20614f3b53e 100644
--- a/slirp/ip.h
+++ b/slirp/ip.h
@@ -217,7 +217,7 @@ struct ipq {
 	uint8_t	ipq_p;			/* protocol of this fragment */
 	uint16_t	ipq_id;			/* sequence id for reassembly */
 	struct	in_addr ipq_src,ipq_dst;
-} QEMU_PACKED;
+};
 
 /*
  * Ip header, when holding a fragment.
@@ -227,7 +227,10 @@ struct ipq {
 struct	ipasfrag {
 	struct qlink ipf_link;
 	struct ip ipf_ip;
-} QEMU_PACKED;
+};
+
+QEMU_BUILD_BUG_ON(offsetof(struct ipq, frag_link) !=
+                  offsetof(struct ipasfrag, ipf_link));
 
 #define ipf_off      ipf_ip.ip_off
 #define ipf_tos      ipf_ip.ip_tos
-- 
2.20.1
