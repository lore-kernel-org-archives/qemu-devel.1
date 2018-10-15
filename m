Received: from eggs.gnu.org ([2001:4830:134:3::10]:39386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gC1R0-00045h-Ez
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 07:53:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gC1Qy-0001yh-TV
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 07:53:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59106)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gC1Qx-0001wp-C0
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 07:53:15 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B7D9A601B
	for <qemu-devel@nongnu.org>; Mon, 15 Oct 2018 11:53:14 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 15 Oct 2018 13:52:46 +0200
Message-Id: <20181015115309.17089-13-armbru@redhat.com>
In-Reply-To: <20181015115309.17089-1-armbru@redhat.com>
References: <20181015115309.17089-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 12/35] migration: Fix !replay_can_snapshot()
 error handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>

Calling error_report() in a function that takes an Error ** argument
is suspicious.  save_snapshot() and load_snapshot() do that, and then
fail without setting an error.  Wrong.  The HMP commands survive this
unscathed, since hmp_handle_error() does nothing when no error has
been set.  Callers main() (on behalf of -loadvm) and
replay_vmstate_init() crash, but I'm not sure the error is possible
there.

Screwed up when commit 377b21ccea1 (v2.12.0) added incorrect error
handling right next to correct examples.  Fix by calling error_setg()
instead of error_report().

Fixes: 377b21ccea1755a8b0dae822c29567c58dda6939
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 migration/savevm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 2d10e45582..5f8eb38676 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2414,8 +2414,8 @@ int save_snapshot(const char *name, Error **errp)
     AioContext *aio_context;
=20
     if (!replay_can_snapshot()) {
-        error_report("Record/replay does not allow making snapshot "
-                     "right now. Try once more later.");
+        error_setg(errp, "Record/replay does not allow making snapshot "
+                   "right now. Try once more later.");
         return ret;
     }
=20
@@ -2611,8 +2611,8 @@ int load_snapshot(const char *name, Error **errp)
     MigrationIncomingState *mis =3D migration_incoming_get_current();
=20
     if (!replay_can_snapshot()) {
-        error_report("Record/replay does not allow loading snapshot "
-                     "right now. Try once more later.");
+        error_setg(errp, "Record/replay does not allow loading snapshot =
"
+                   "right now. Try once more later.");
         return -EINVAL;
     }
=20
--=20
2.17.1
