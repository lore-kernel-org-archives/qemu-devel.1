Received: from eggs.gnu.org ([2001:4830:134:3::10]:41248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gZDER-00015C-He
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 06:08:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gZDCM-00014v-Hy
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 06:06:05 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Tue, 18 Dec 2018 12:03:33 +0100
Message-Id: <20181218110333.22558-4-philmd@redhat.com>
In-Reply-To: <20181218110333.22558-1-philmd@redhat.com>
References: <20181218110333.22558-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 3/3] migration: Replace strncpy() by
 strpadcpy(pad='\0')
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Ben Pye <ben@curlybracket.co.uk>, Stefan Weil <sw@weilnetz.de>, Howard Spoelstra <hsp.cat7@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jeff Cody <jcody@redhat.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Thomas Huth <thuth@redhat.com>, Liu Yuan <namei.unix@gmail.com>, Igor Mammedov <imammedo@redhat.com>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, David Hildenbrand <david@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, 1803872@bugs.launchpad.net, Juan Quintela <quintela@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

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

The runstate name doesn't require the strings to be NUL-terminated,
therefore strncpy is the right function to use here.

We could add a #pragma GCC diagnostic ignored "-Wstringop-truncation"
around, disable the warning globally using -Wno-stringop-truncation,
but since QEMU provides the strpadcpy() which does the same purpose,
simply use it to avoid the annoying warning.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 migration/global_state.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/migration/global_state.c b/migration/global_state.c
index 8e8ab5c51e..c7e7618118 100644
--- a/migration/global_state.c
+++ b/migration/global_state.c
@@ -42,8 +42,8 @@ int global_state_store(void)
 void global_state_store_running(void)
 {
     const char *state =3D RunState_str(RUN_STATE_RUNNING);
-    strncpy((char *)global_state.runstate,
-           state, sizeof(global_state.runstate));
+    strpadcpy((char *)global_state.runstate,
+              sizeof(global_state.runstate), state, '\0');
 }
=20
 bool global_state_received(void)
--=20
2.17.2
