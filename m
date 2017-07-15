Received: from eggs.gnu.org ([2001:4830:134:3::10]:43393)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1dWN8R-00043a-8A
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 09:29:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1dWN8Q-00038B-CZ
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 09:29:27 -0400
From: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>
Date: Sat, 15 Jul 2017 15:28:41 +0200
Message-Id: <20170715132841.9865-5-hpoussin@reactos.org>
In-Reply-To: <20170715132841.9865-1-hpoussin@reactos.org>
References: <20170715132841.9865-1-hpoussin@reactos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 4/4] vvfat: initialize memory after allocating
 it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>

This prevents some host to guest memory content leaks.

Fixes: https://bugs.launchpad.net/qemu/+bug/1599539

Signed-off-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
---
 block/vvfat.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/vvfat.c b/block/vvfat.c
index afc6170a69..7340decef3 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -115,6 +115,7 @@ static inline int array_ensure_allocated(array_t* arr=
ay, int index)
         array->pointer =3D g_realloc(array->pointer, new_size);
         if (!array->pointer)
             return -1;
+        memset(array->pointer + array->size, 0, new_size - array->size);
         array->size =3D new_size;
         array->next =3D index + 1;
     }
--=20
2.11.0
