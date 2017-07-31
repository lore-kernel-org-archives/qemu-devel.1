Received: from eggs.gnu.org ([2001:4830:134:3::10]:50905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dc7pd-00046s-VM
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 06:21:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dc7pb-00069F-9s
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 06:21:49 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Mon, 31 Jul 2017 13:21:28 +0300
Message-Id: <b7b1e9dd6d56612d4656817b11e43d9fbefdc497.1501496349.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1501496349.git.mjt@msgid.tls.msk.ru>
References: <cover.1501496349.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1501496349.git.mjt@msgid.tls.msk.ru>
References: <cover.1501496349.git.mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 09/25] ivshmem: fix incorrect error handling in
 ivshmem_recv_msg()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Screwed up in commit 3a55fc0f, v2.6.0.

If qemu_chr_fe_read_all() returns -EINTR the do {} statement continues an=
d the
n accumulator used to complete reads upto sizeof(msg) is decremented by 4=
 (the
value of EINTR on Linux).
To avoid that, use simpler if() statements and continue if EINTR occured.

hw/misc/ivshmem.c:650:14: warning: Loss of sign in implicit conversion
    } while (n < sizeof(msg));
             ^

Reported-by: Clang Static Analyzer
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 hw/misc/ivshmem.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/misc/ivshmem.c b/hw/misc/ivshmem.c
index a58f9ee579..47a015f072 100644
--- a/hw/misc/ivshmem.c
+++ b/hw/misc/ivshmem.c
@@ -642,7 +642,10 @@ static int64_t ivshmem_recv_msg(IVShmemState *s, int=
 *pfd, Error **errp)
     do {
         ret =3D qemu_chr_fe_read_all(&s->server_chr, (uint8_t *)&msg + n=
,
                                    sizeof(msg) - n);
-        if (ret < 0 && ret !=3D -EINTR) {
+        if (ret < 0) {
+            if (ret =3D=3D -EINTR) {
+                continue;
+            }
             error_setg_errno(errp, -ret, "read from server failed");
             return INT64_MIN;
         }
--=20
2.11.0
