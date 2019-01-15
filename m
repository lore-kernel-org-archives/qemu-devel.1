Received: from eggs.gnu.org ([209.51.188.92]:35846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gjUyw-0008FD-4s
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:06:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gjUyt-0003qL-G5
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:06:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44344)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gjUyt-0003ef-3a
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:06:39 -0500
Date: Tue, 15 Jan 2019 15:06:27 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190115200252.25911-50-mst@redhat.com>
References: <20190115200252.25911-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190115200252.25911-1-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 49/49] migration: Use strnlen() for
 fixed-size string
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

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
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
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
MST
