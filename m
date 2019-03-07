Received: from eggs.gnu.org ([209.51.188.92]:36139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1h1rZ1-0008Nc-A9
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 06:51:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1h1rZ0-0003Vz-KB
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 06:51:51 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Thu,  7 Mar 2019 12:51:34 +0100
Message-Id: <20190307115143.780-5-samuel.thibault@ens-lyon.org>
In-Reply-To: <20190307115143.780-1-samuel.thibault@ens-lyon.org>
References: <20190307115143.780-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULLv2 03/12] slirp: check sscanf result when
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
Cc: William Bowling <will@wbowling.info>, stefanha@redhat.com, jan.kiszka@siemens.com, peter.maydell@linaro.org, qemu-stable@nongnu.org, secalert@redhat.com, Samuel Thibault <samuel.thibault@ens-lyon.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

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
---
 slirp/tcp_subr.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/slirp/tcp_subr.c b/slirp/tcp_subr.c
index 262a42d6c8..ef9d99c154 100644
--- a/slirp/tcp_subr.c
+++ b/slirp/tcp_subr.c
@@ -664,12 +664,12 @@ tcp_emu(struct socket *so, struct mbuf *m)
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
2.20.1
