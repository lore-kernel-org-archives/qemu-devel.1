Received: from eggs.gnu.org ([208.118.235.92]:47642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1geyow-0003ZR-4F
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 03:57:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1geyos-0001Z4-Q5
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 03:57:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49038)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1geyos-0001YH-K0
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 03:57:38 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EE1F92CD7F7
	for <qemu-devel@nongnu.org>; Thu,  3 Jan 2019 08:57:37 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Thu,  3 Jan 2019 09:56:37 +0100
Message-Id: <20190103085638.17600-5-philmd@redhat.com>
In-Reply-To: <20190103085638.17600-1-philmd@redhat.com>
References: <20190103085638.17600-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 4/5] migration: Fix stringop-truncation
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
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Eric Blake <eblake@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>

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
2.17.2
