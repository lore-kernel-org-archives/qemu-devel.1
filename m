Received: from eggs.gnu.org ([2001:4830:134:3::10]:53506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1d62vg-0001jb-Id
	for qemu-devel@nongnu.org; Wed, 03 May 2017 18:39:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1d62vf-0000Qe-Qd
	for qemu-devel@nongnu.org; Wed, 03 May 2017 18:39:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34202)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1d62vf-0000Pz-Kh
	for qemu-devel@nongnu.org; Wed, 03 May 2017 18:39:27 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A23AB3D968
	for <qemu-devel@nongnu.org>; Wed,  3 May 2017 22:39:26 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu,  4 May 2017 02:38:46 +0400
Message-Id: <20170503223846.6559-6-marcandre.lureau@redhat.com>
In-Reply-To: <20170503223846.6559-1-marcandre.lureau@redhat.com>
References: <20170503223846.6559-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 5/5] dump: fix memory_mapping_filter leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Spotted by ASAN.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 memory_mapping.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/memory_mapping.c b/memory_mapping.c
index 6a39d71da2..a5d38552a6 100644
--- a/memory_mapping.c
+++ b/memory_mapping.c
@@ -337,6 +337,7 @@ void memory_mapping_filter(MemoryMappingList *list, i=
nt64_t begin,
         if (cur->phys_addr >=3D begin + length ||
             cur->phys_addr + cur->length <=3D begin) {
             QTAILQ_REMOVE(&list->head, cur, next);
+            g_free(cur);
             list->num--;
             continue;
         }
--=20
2.12.0.191.gc5d8de91d
