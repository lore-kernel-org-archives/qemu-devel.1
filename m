Received: from eggs.gnu.org ([2001:4830:134:3::10]:33931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gZJZW-0006mG-Hn
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 12:54:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gZJZU-0006cu-ER
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 12:54:22 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Tue, 18 Dec 2018 18:51:22 +0100
Message-Id: <20181218175122.3229-6-philmd@redhat.com>
In-Reply-To: <20181218175122.3229-1-philmd@redhat.com>
References: <20181218175122.3229-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 5/5] migration: Use strnlen() for fixed-size
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Juan Quintela <quintela@redhat.com>, qemu-block@nongnu.org, 1803872@bugs.launchpad.net, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Howard Spoelstra <hsp.cat7@gmail.com>, Jeff Cody <jcody@redhat.com>, David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Ben Pye <ben@curlybracket.co.uk>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Thomas Huth <thuth@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Liu Yuan <namei.unix@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Max Reitz <mreitz@redhat.com>

GCC 8 introduced the -Wstringop-overflow, which detect buffer overflow
by string-modifying functions declared in <string.h>, such strncpy(),
used in global_state_store_running().

Since the global_state.runstate does not necessarily contains a
terminating NUL character, We had to use the QEMU_NONSTRING attribute.

The GCC manual says about the nonstring attribute:

  However, when the array is declared with the attribute the call to
  strlen is diagnosed because when the array doesn=E2=80=99t contain a
  NUL-terminated string the call is undefined. [...]
  In addition, calling strnlen and strndup with such arrays is safe
  provided a suitable bound is specified, and not diagnosed.

GCC indeed found an incorrect use of strlen(), because this array
is loaded by VMSTATE_BUFFER(runstate, GlobalState) then parsed
using qapi_enum_parse which does not get the buffer length.

Use strnlen() which returns sizeof(s->runstate) if the array is not
NUL-terminated.

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

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 migration/global_state.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/global_state.c b/migration/global_state.c
index 6e19333422..c19030ef62 100644
--- a/migration/global_state.c
+++ b/migration/global_state.c
@@ -106,7 +106,7 @@ static int global_state_pre_save(void *opaque)
     GlobalState *s =3D opaque;
=20
     trace_migrate_global_state_pre_save((char *)s->runstate);
-    s->size =3D strlen((char *)s->runstate) + 1;
+    s->size =3D strnlen((char *)s->runstate, sizeof(s->runstate)) + 1;
=20
     return 0;
 }
--=20
2.17.2
