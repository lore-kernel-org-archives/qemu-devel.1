Received: from eggs.gnu.org ([2001:4830:134:3::10]:43686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eyGa4-00026N-Bu
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 08:41:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eyGa3-0006Rs-Gw
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 08:41:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57156 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1eyGa3-0006RY-Cc
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 08:41:31 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue, 20 Mar 2018 12:41:17 +0000
Message-Id: <20180320124117.40573-3-dgilbert@redhat.com>
In-Reply-To: <20180320124117.40573-1-dgilbert@redhat.com>
References: <20180320124117.40573-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/2] hmp: free sev info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, jixiang_zhang@h3c.com

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Found thanks to ASAN:

Direct leak of 16 byte(s) in 1 object(s) allocated from:
    #0 0x7efe20417a38 in __interceptor_calloc (/lib64/libasan.so.4+0xdea3=
8)
    #1 0x7efe1f7b2f75 in g_malloc0 ../glib/gmem.c:124
    #2 0x7efe1f7b3249 in g_malloc0_n ../glib/gmem.c:355
    #3 0x558272879162 in sev_get_info /home/elmarco/src/qemu/target/i386/=
sev.c:414
    #4 0x55827285113b in hmp_info_sev /home/elmarco/src/qemu/target/i386/=
monitor.c:684
    #5 0x5582724043b8 in handle_hmp_command /home/elmarco/src/qemu/monito=
r.c:3333

Fixes: 63036314
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20180319175823.22111-1-marcandre.lureau@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 target/i386/monitor.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/i386/monitor.c b/target/i386/monitor.c
index 011419eba2..a890b3c2ab 100644
--- a/target/i386/monitor.c
+++ b/target/i386/monitor.c
@@ -696,6 +696,8 @@ void hmp_info_sev(Monitor *mon, const QDict *qdict)
     } else {
         monitor_printf(mon, "SEV is not enabled\n");
     }
+
+    qapi_free_SevInfo(info);
 }
=20
 SevLaunchMeasureInfo *qmp_query_sev_launch_measure(Error **errp)
--=20
2.14.3
