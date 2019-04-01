Received: from eggs.gnu.org ([209.51.188.92]:43289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB47e-0004Io-K8
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:05:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB47Z-0005RN-7G
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:05:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40018)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1hB47J-0004yT-Cz
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:05:22 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x31L4urC140260
	for <qemu-devel@nongnu.org>; Mon, 1 Apr 2019 17:05:03 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2rksqasrj5-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 17:05:01 -0400
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 1 Apr 2019 22:03:11 +0100
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon,  1 Apr 2019 16:00:04 -0500
In-Reply-To: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
References: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20190401210011.16009-91-mdroth@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 90/97] slirp: check sscanf result when
 emulating ident
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, William Bowling <will@wbowling.info>, secalert@redhat.com, Samuel Thibault <samuel.thibault@ens-lyon.org>

From: William Bowling <will@wbowling.info>

When emulating ident in tcp_emu, if the strchr checks passed but the
sscanf check failed, two uninitialized variables would be copied and
sent in the reply, so move this code inside the if(sscanf()) clause.

Signed-off-by: William Bowling <will@wbowling.info>
Cc: qemu-stable@nongnu.org
Cc: secalert@redhat.com
Message-Id: <1551476756-25749-1-git-send-email-will@wbowling.info>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
(cherry picked from commit d3222975c7d6cda9e25809dea05241188457b113)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 slirp/tcp_subr.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/slirp/tcp_subr.c b/slirp/tcp_subr.c
index 8d0f94b75f..473c8b04e6 100644
--- a/slirp/tcp_subr.c
+++ b/slirp/tcp_subr.c
@@ -662,12 +662,12 @@ tcp_emu(struct socket *so, struct mbuf *m)
 							break;
 						}
 					}
+					so_rcv->sb_cc =3D snprintf(so_rcv->sb_data,
+								 so_rcv->sb_datalen,
+								 "%d,%d\r\n", n1, n2);
+					so_rcv->sb_rptr =3D so_rcv->sb_data;
+					so_rcv->sb_wptr =3D so_rcv->sb_data + so_rcv->sb_cc;
 				}
-                                so_rcv->sb_cc =3D snprintf(so_rcv->sb_da=
ta,
-                                                         so_rcv->sb_data=
len,
-                                                         "%d,%d\r\n", n1=
, n2);
-				so_rcv->sb_rptr =3D so_rcv->sb_data;
-				so_rcv->sb_wptr =3D so_rcv->sb_data + so_rcv->sb_cc;
 			}
 			m_free(m);
 			return 0;
--=20
2.17.1
