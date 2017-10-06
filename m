Received: from eggs.gnu.org ([2001:4830:134:3::10]:42297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cQp-0000jI-Gs
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:53:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cQn-0006cB-Tf
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:53:27 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  6 Oct 2017 20:49:45 -0300
Message-Id: <20171006235023.11952-51-f4bug@amsat.org>
In-Reply-To: <20171006235023.11952-1-f4bug@amsat.org>
References: <20171006235023.11952-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 50/88] ivshmem: use g_new() family of functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu trival <qemu-trivial@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/misc/ivshmem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/misc/ivshmem.c b/hw/misc/ivshmem.c
index b3ef3ec1e3..9dd432a295 100644
--- a/hw/misc/ivshmem.c
+++ b/hw/misc/ivshmem.c
@@ -429,7 +429,7 @@ static void resize_peers(IVShmemState *s, int nb_peers)
     assert(nb_peers > old_nb_peers);
     IVSHMEM_DPRINTF("bumping storage to %d peers\n", nb_peers);
 
-    s->peers = g_realloc(s->peers, nb_peers * sizeof(Peer));
+    s->peers = g_renew(Peer, s->peers, nb_peers);
     s->nb_peers = nb_peers;
 
     for (i = old_nb_peers; i < nb_peers; i++) {
@@ -753,7 +753,7 @@ static void ivshmem_reset(DeviceState *d)
 static int ivshmem_setup_interrupts(IVShmemState *s, Error **errp)
 {
     /* allocate QEMU callback data for receiving interrupts */
-    s->msi_vectors = g_malloc0(s->vectors * sizeof(MSIVector));
+    s->msi_vectors = g_new0(MSIVector, s->vectors);
 
     if (ivshmem_has_feature(s, IVSHMEM_MSI)) {
         if (msix_init_exclusive_bar(PCI_DEVICE(s), s->vectors, 1, errp)) {
-- 
2.14.2
