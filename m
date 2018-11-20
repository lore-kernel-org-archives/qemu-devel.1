Received: from eggs.gnu.org ([2001:4830:134:3::10]:34474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gP7x9-00044g-6t
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 10:28:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gP7x5-0005EM-8d
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 10:28:39 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 20 Nov 2018 19:27:52 +0400
Message-Id: <20181120152753.10463-3-marcandre.lureau@redhat.com>
In-Reply-To: <20181120152753.10463-1-marcandre.lureau@redhat.com>
References: <20181120152753.10463-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-3.1? 2/3] migration: fix
 stringop-truncation warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Juan Quintela <quintela@redhat.com>, Max Reitz <mreitz@redhat.com>, Jeff Cody <jcody@redhat.com>, Liu Yuan <namei.unix@gmail.com>, Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Adding an assert is enough to silence GCC.

~/src/qemu/migration/global_state.c: In function 'global_state_store_runn=
ing':
~/src/qemu/migration/global_state.c:45:5: error: 'strncpy' specified boun=
d 100 equals destination size [-Werror=3Dstringop-truncation]
     strncpy((char *)global_state.runstate,
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            state, sizeof(global_state.runstate));
            ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

(alternatively, we could hard-code "running")

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 migration/global_state.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/migration/global_state.c b/migration/global_state.c
index 8e8ab5c51e..01805c567a 100644
--- a/migration/global_state.c
+++ b/migration/global_state.c
@@ -42,6 +42,7 @@ int global_state_store(void)
 void global_state_store_running(void)
 {
     const char *state =3D RunState_str(RUN_STATE_RUNNING);
+    assert(strlen(state) < sizeof(global_state.runstate));
     strncpy((char *)global_state.runstate,
            state, sizeof(global_state.runstate));
 }
--=20
2.19.1.708.g4ede3d42df
