Received: from eggs.gnu.org ([2001:4830:134:3::10]:53614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dXTKq-00010l-El
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 10:18:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dXTKp-0007ur-Hi
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 10:18:48 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 18 Jul 2017 16:18:03 +0200
Message-Id: <1500387486-5469-19-git-send-email-kwolf@redhat.com>
In-Reply-To: <1500387486-5469-1-git-send-email-kwolf@redhat.com>
References: <1500387486-5469-1-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 18/21] vvfat: initialize memory after allocating
 it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Herv=C3=A9 Poussineau <hpoussin@reactos.org>

This prevents some host to guest memory content leaks.

Fixes: https://bugs.launchpad.net/qemu/+bug/1599539

Signed-off-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/vvfat.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/vvfat.c b/block/vvfat.c
index ea7775f..6b11596 100644
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
1.8.3.1
