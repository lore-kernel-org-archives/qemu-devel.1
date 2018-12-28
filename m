Received: from eggs.gnu.org ([208.118.235.92]:40215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gcwMf-0003Ng-Ga
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 12:56:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gcwLq-00056G-Fu
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 12:55:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40982)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gcw2W-0001sM-I6
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 12:35:16 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Fri, 28 Dec 2018 18:33:56 +0100
Message-Id: <20181228173356.15359-6-philmd@redhat.com>
In-Reply-To: <20181228173356.15359-1-philmd@redhat.com>
References: <20181228173356.15359-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 5/5] migration: Use strnlen() for fixed-size
 string
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Eric Blake <eblake@redhat.com>, Juan Quintela <quintela@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Igor Mammedov <imammedo@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Thomas Huth <thuth@redhat.com>

GCC 8 introduced the -Wstringop-overflow, which detect buffer overflow
by string-modifying functions declared in <string.h>, such strncpy(),
used in global_state_store_running().

GCC indeed found an incorrect use of strlen(), because this array
is loaded by VMSTATE_BUFFER(runstate, GlobalState) then parsed
using qapi_enum_parse which does not get the buffer length.

Use strnlen() which returns sizeof(s->runstate) if the array is not
NUL-terminated, assert the size is within range, and enforce the array
to be NUL-terminated to avoid an overflow in qapi_enum_parse().

This fixes:

    CC      migration/global_state.o
  qemu/migration/global_state.c: In function 'global_state_pre_save':
  qemu/migration/global_state.c:109:15: error: 'strlen' argument 1 declar=
ed attribute 'nonstring' [-Werror=3Dstringop-overflow=3D]
       s->size =3D strlen((char *)s->runstate) + 1;
                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~
  qemu/migration/global_state.c:24:13: note: argument 'runstate' declared=
 here
       uint8_t runstate[100] QEMU_NONSTRING;
               ^~~~~~~~
  cc1: all warnings being treated as errors
  make: *** [qemu/rules.mak:69: migration/global_state.o] Error 1

Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 migration/global_state.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/migration/global_state.c b/migration/global_state.c
index 01805c567a..4f060a6dbd 100644
--- a/migration/global_state.c
+++ b/migration/global_state.c
@@ -89,6 +89,16 @@ static int global_state_post_load(void *opaque, int ve=
rsion_id)
     s->received =3D true;
     trace_migrate_global_state_post_load(runstate);
=20
+    if (strnlen((char *)s->runstate,
+                sizeof(s->runstate)) =3D=3D sizeof(s->runstate)) {
+        /* This condition should never happen during migration, because
+         * all runstate names are shorter than 100 bytes (the size of
+         * s->runstate). However, a malicious stream could overflow
+         * the qapi_enum_parse() call, so we force the last character
+         * to a NUL byte.
+         */
+        s->runstate[sizeof(s->runstate) - 1] =3D '\0';
+    }
     r =3D qapi_enum_parse(&RunState_lookup, runstate, -1, &local_err);
=20
     if (r =3D=3D -1) {
@@ -107,7 +117,8 @@ static int global_state_pre_save(void *opaque)
     GlobalState *s =3D opaque;
=20
     trace_migrate_global_state_pre_save((char *)s->runstate);
-    s->size =3D strlen((char *)s->runstate) + 1;
+    s->size =3D strnlen((char *)s->runstate, sizeof(s->runstate)) + 1;
+    assert(s->size <=3D sizeof(s->runstate));
=20
     return 0;
 }
--=20
2.17.2
