Received: from eggs.gnu.org ([2001:4830:134:3::10]:59870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lepton@google.com>) id 1eCZEF-0005Jz-RP
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 17:53:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lepton@google.com>) id 1eCZEF-0007fg-6Y
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 17:53:51 -0500
Received: from mail-it0-x244.google.com ([2607:f8b0:4001:c0b::244]:55121)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lepton@google.com>) id 1eCZEF-0007f8-1E
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 17:53:51 -0500
Received: by mail-it0-x244.google.com with SMTP id 72so8475476itk.3
	for <qemu-devel@nongnu.org>; Wed, 08 Nov 2017 14:53:50 -0800 (PST)
From: Tao Wu <lepton@google.com>
Date: Wed,  8 Nov 2017 14:53:40 -0800
Message-Id: <20171108225340.10194-1-lepton@google.com>
In-Reply-To: <20170508195404.j33kcmqncrb7fziv@var.youpi.perso.aquilenet.fr>
References: <20170508195404.j33kcmqncrb7fziv@var.youpi.perso.aquilenet.fr>
Subject: [Qemu-devel] [PATCH] slirp: don't zero ti_i since we access it
 later.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: samuel.thibault@gnu.org, Tao Wu <lepton@google.com>

The current code looks buggy, we zero ti_i while we access
ti_dst/ti_src later.

Signed-off-by: Tao Wu <lepton@google.com>
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
2.15.0.448.gf294e3d99a-goog
