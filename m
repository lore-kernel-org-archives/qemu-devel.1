Received: from eggs.gnu.org ([208.118.235.92]:47699)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1geyp9-0003nB-9u
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 03:57:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1geyp3-0001gk-MH
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 03:57:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35221)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1geyp1-0001eW-Ku
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 03:57:49 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B64E8142BEF
	for <qemu-devel@nongnu.org>; Thu,  3 Jan 2019 08:57:44 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Thu,  3 Jan 2019 09:56:38 +0100
Message-Id: <20190103085638.17600-6-philmd@redhat.com>
In-Reply-To: <20190103085638.17600-1-philmd@redhat.com>
References: <20190103085638.17600-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 5/5] migration: Use strnlen() for fixed-size
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
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Eric Blake <eblake@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>

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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
v5: Use Linux-kernel-style multiline comments
---
 migration/global_state.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/migration/global_state.c b/migration/global_state.c
index 01805c567a..2c8c447239 100644
--- a/migration/global_state.c
+++ b/migration/global_state.c
@@ -89,6 +89,17 @@ static int global_state_post_load(void *opaque, int ve=
rsion_id)
     s->received =3D true;
     trace_migrate_global_state_post_load(runstate);
=20
+    if (strnlen((char *)s->runstate,
+                sizeof(s->runstate)) =3D=3D sizeof(s->runstate)) {
+        /*
+         * This condition should never happen during migration, because
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
@@ -107,7 +118,8 @@ static int global_state_pre_save(void *opaque)
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
