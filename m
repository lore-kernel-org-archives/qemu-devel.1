Received: from eggs.gnu.org ([2001:4830:134:3::10]:33577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYbEa-00080y-1d
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 12:29:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYbEZ-0008L4-4Y
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 12:29:16 -0500
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:42847)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYbEZ-0008KV-0L
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 12:29:15 -0500
Received: by mail-qk0-x243.google.com with SMTP id d202so15091031qkc.9
	for <qemu-devel@nongnu.org>; Mon, 08 Jan 2018 09:29:14 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon,  8 Jan 2018 14:28:53 -0300
Message-Id: <20180108172904.8772-2-f4bug@amsat.org>
In-Reply-To: <20180108172904.8772-1-f4bug@amsat.org>
References: <20180108172904.8772-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 01/12] slirp: remove QEMU_PACKED from
 structures with don't require it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>, Jan Kiszka <jan.kiszka@siemens.com>, "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

theses structures are not serialized and often store host pointers.

  slirp/ip_input.c:159:43: warning: taking address of packed member 'ip_link' of class or
        structure 'ipq' may result in an unaligned pointer value
        [-Waddress-of-packed-member]
                  for (l = slirp->ipq.ip_link.next; l != &slirp->ipq.ip_link;
                                                          ^~~~~~~~~~~~~~~~~~

Reported-by: John Arbuckle <programmingkidx@gmail.com>
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 slirp/ip.h    | 10 +++++-----
 slirp/slirp.h |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/slirp/ip.h b/slirp/ip.h
index 1df6723357..e29ccd3c9f 100644
--- a/slirp/ip.h
+++ b/slirp/ip.h
@@ -179,11 +179,11 @@ struct	ip_timestamp {
 struct mbuf_ptr {
 	struct mbuf *mptr;
 	uint32_t dummy;
-} QEMU_PACKED;
+};
 #else
 struct mbuf_ptr {
 	struct mbuf *mptr;
-} QEMU_PACKED;
+};
 #endif
 struct qlink {
 	void *next, *prev;
@@ -199,7 +199,7 @@ struct ipovly {
 	uint16_t	ih_len;			/* protocol length */
 	struct	in_addr ih_src;		/* source internet address */
 	struct	in_addr ih_dst;		/* destination internet address */
-} QEMU_PACKED;
+};
 
 /*
  * Ip reassembly queue structure.  Each fragment
@@ -215,7 +215,7 @@ struct ipq {
 	uint8_t	ipq_p;			/* protocol of this fragment */
 	uint16_t	ipq_id;			/* sequence id for reassembly */
 	struct	in_addr ipq_src,ipq_dst;
-} QEMU_PACKED;
+};
 
 /*
  * Ip header, when holding a fragment.
@@ -225,7 +225,7 @@ struct ipq {
 struct	ipasfrag {
 	struct qlink ipf_link;
 	struct ip ipf_ip;
-} QEMU_PACKED;
+};
 
 #define ipf_off      ipf_ip.ip_off
 #define ipf_tos      ipf_ip.ip_tos
diff --git a/slirp/slirp.h b/slirp/slirp.h
index 898ec9516d..9f29b52610 100644
--- a/slirp/slirp.h
+++ b/slirp/slirp.h
@@ -136,7 +136,7 @@ bool arp_table_search(Slirp *slirp, uint32_t ip_addr,
 struct ndpentry {
     unsigned char   eth_addr[ETH_ALEN];     /* sender hardware address */
     struct in6_addr ip_addr;                /* sender IP address       */
-} QEMU_PACKED;
+};
 
 #define NDP_TABLE_SIZE 16
 
-- 
2.15.1
