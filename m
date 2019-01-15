Received: from eggs.gnu.org ([209.51.188.92]:35835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gjUyw-0008H5-Tp
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:06:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gjUyt-0003qJ-Ho
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:06:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:18087)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gjUyt-0003db-2F
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:06:39 -0500
Date: Tue, 15 Jan 2019 15:06:20 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190115200252.25911-49-mst@redhat.com>
References: <20190115200252.25911-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190115200252.25911-1-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 48/49] migration: Fix stringop-truncation
 warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Eric Blake <eblake@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Juan Quintela <quintela@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

GCC 8 added a -Wstringop-truncation warning:

  The -Wstringop-truncation warning added in GCC 8.0 via r254630 for
  bug 81117 is specifically intended to highlight likely unintended
  uses of the strncpy function that truncate the terminating NUL
  character from the source string.

This new warning leads to compilation failures:

    CC      migration/global_state.o
  qemu/migration/global_state.c: In function 'global_state_store_running'=
:
  qemu/migration/global_state.c:45:5: error: 'strncpy' specified bound 10=
0 equals destination size [-Werror=3Dstringop-truncation]
       strncpy((char *)global_state.runstate, state, sizeof(global_state.=
runstate));
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~
  make: *** [qemu/rules.mak:69: migration/global_state.o] Error 1

Adding an assert is enough to silence GCC.

(alternatively, we could hard-code "running")

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
[PMD: More verbose commit message]
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
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
MST
