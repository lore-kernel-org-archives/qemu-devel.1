Received: from eggs.gnu.org ([2001:4830:134:3::10]:57199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1eCr9E-0005J3-A5
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 13:01:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1eCr98-0002L0-FG
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 13:01:52 -0500
Received: from hera.aquilenet.fr ([141.255.128.1]:58938)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1eCr98-0002KQ-91
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 13:01:46 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Thu,  9 Nov 2017 19:01:42 +0100
Message-Id: <20171109180142.13923-2-samuel.thibault@ens-lyon.org>
In-Reply-To: <20171109180142.13923-1-samuel.thibault@ens-lyon.org>
References: <20171109180142.13923-1-samuel.thibault@ens-lyon.org>
Subject: [Qemu-devel] [PULL 1/1] slirp: don't zero the whole ti_i when m ==
 NULL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Tao Wu <lepton@google.com>, stefanha@redhat.com, jan.kiszka@siemens.com, Samuel Thibault <samuel.thibault@ens-lyon.org>

From: Tao Wu <lepton@google.com>

98c63057d2144fb81681580cd84c13c93794c96e ('slirp: Factorizing
tcpiphdr structure with an union') introduced a memset call to clear
possibly-undefined fields in ti. This however overwrites src/dst/pr which
are used below.

So let us clear only the unused fields.

This should fix some rare cases (some RST cases, keep alive probes)
where packets would be sent to 0.0.0.0.

Signed-off-by: Tao Wu <lepton@google.com>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 slirp/tcp_subr.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/slirp/tcp_subr.c b/slirp/tcp_subr.c
index dc8b4bbb50..da0d53743f 100644
--- a/slirp/tcp_subr.c
+++ b/slirp/tcp_subr.c
@@ -148,7 +148,16 @@ tcp_respond(struct tcpcb *tp, struct tcpiphdr *ti, struct mbuf *m,
 		m->m_data += IF_MAXLINKHDR;
 		*mtod(m, struct tcpiphdr *) = *ti;
 		ti = mtod(m, struct tcpiphdr *);
-		memset(&ti->ti, 0, sizeof(ti->ti));
+		switch (af) {
+		case AF_INET:
+		    ti->ti.ti_i4.ih_x1 = 0;
+		    break;
+		case AF_INET6:
+		    ti->ti.ti_i6.ih_x1 = 0;
+		    break;
+		default:
+		    g_assert_not_reached();
+		}
 		flags = TH_ACK;
 	} else {
 		/*
-- 
2.14.2
