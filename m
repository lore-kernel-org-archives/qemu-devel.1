Received: from eggs.gnu.org ([2001:4830:134:3::10]:54787)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dslaV-0007ve-43
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 04:03:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dslaL-0000hA-7a
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 04:02:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46658)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dslaK-0000gM-Vz
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 04:02:49 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Fri, 15 Sep 2017 10:02:25 +0200
Message-Id: <1505462549-27298-6-git-send-email-thuth@redhat.com>
In-Reply-To: <1505462549-27298-1-git-send-email-thuth@redhat.com>
References: <1505462549-27298-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 5/9] test-qga: Kill broken and dead
 QGA_TEST_SIDE_EFFECTING code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, John Snow <jsnow@redhat.com>

From: Eric Blake <eblake@redhat.com>

Back when the test was introduced, in commit 62c39b307, the
test was set up to run qemu-ga directly on the host performing
the test, and defaults to limiting itself to safe commands.  At
the time, it was envisioned that setting QGA_TEST_SIDE_EFFECTING
in the environment could cover a few more commands, while noting
the potential danger of those side effects running in the host.

But this has NEVER been tested: if you enable the environment
variable, the test WILL fail.  One obvious reason: if you are not
running as root, you'll probably get a permission failure when
trying to freeze the file systems, or when changing system time.
Less obvious: if you run the test as root (wow, you're brave), you
could end up hanging if the test tries to log things to a
temporarily frozen filesystem.  But the cutest reason of all: if
you get past the above hurdles, the test uses invalid JSON in
test_qga_fstrim() (missing '' around the dictionary key 'minimum'),
and will thus fail an assertion in qmp_fd().

Rather than leave this untested time-bomb in place, rip it out.
Hopefully, as originally envisioned, we can find an opportunity
to test an actual sandboxed guest where the guest-agent has
full permissions and will not unduly affect the host running
the test - if so, 'git revert' can be used if desired, for
salvaging any useful parts of this attempt.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/test-qga.c | 90 --------------------------------------------------=
------
 1 file changed, 90 deletions(-)

diff --git a/tests/test-qga.c b/tests/test-qga.c
index 06783e7..fd6bc76 100644
--- a/tests/test-qga.c
+++ b/tests/test-qga.c
@@ -642,65 +642,6 @@ static void test_qga_get_time(gconstpointer fix)
     QDECREF(ret);
 }
=20
-static void test_qga_set_time(gconstpointer fix)
-{
-    const TestFixture *fixture =3D fix;
-    QDict *ret;
-    int64_t current, time;
-    gchar *cmd;
-
-    /* get current time */
-    ret =3D qmp_fd(fixture->fd, "{'execute': 'guest-get-time'}");
-    g_assert_nonnull(ret);
-    qmp_assert_no_error(ret);
-    current =3D qdict_get_int(ret, "return");
-    g_assert_cmpint(current, >, 0);
-    QDECREF(ret);
-
-    /* set some old time */
-    ret =3D qmp_fd(fixture->fd, "{'execute': 'guest-set-time',"
-                 " 'arguments': { 'time': 1000 } }");
-    g_assert_nonnull(ret);
-    qmp_assert_no_error(ret);
-    QDECREF(ret);
-
-    /* check old time */
-    ret =3D qmp_fd(fixture->fd, "{'execute': 'guest-get-time'}");
-    g_assert_nonnull(ret);
-    qmp_assert_no_error(ret);
-    time =3D qdict_get_int(ret, "return");
-    g_assert_cmpint(time / 1000, <, G_USEC_PER_SEC * 10);
-    QDECREF(ret);
-
-    /* set back current time */
-    cmd =3D g_strdup_printf("{'execute': 'guest-set-time',"
-                          " 'arguments': { 'time': %" PRId64 " } }",
-                          current + time * 1000);
-    ret =3D qmp_fd(fixture->fd, cmd);
-    g_free(cmd);
-    g_assert_nonnull(ret);
-    qmp_assert_no_error(ret);
-    QDECREF(ret);
-}
-
-static void test_qga_fstrim(gconstpointer fix)
-{
-    const TestFixture *fixture =3D fix;
-    QDict *ret;
-    QList *list;
-    const QListEntry *entry;
-
-    ret =3D qmp_fd(fixture->fd, "{'execute': 'guest-fstrim',"
-                 " arguments: { minimum: 4194304 } }");
-    g_assert_nonnull(ret);
-    qmp_assert_no_error(ret);
-    list =3D qdict_get_qlist(ret, "return");
-    entry =3D qlist_first(list);
-    g_assert(qdict_haskey(qobject_to_qdict(entry->value), "paths"));
-
-    QDECREF(ret);
-}
-
 static void test_qga_blacklist(gconstpointer data)
 {
     TestFixture fix;
@@ -831,30 +772,6 @@ static void test_qga_fsfreeze_status(gconstpointer f=
ix)
     QDECREF(ret);
 }
=20
-static void test_qga_fsfreeze_and_thaw(gconstpointer fix)
-{
-    const TestFixture *fixture =3D fix;
-    QDict *ret;
-    const gchar *status;
-
-    ret =3D qmp_fd(fixture->fd, "{'execute': 'guest-fsfreeze-freeze'}");
-    g_assert_nonnull(ret);
-    qmp_assert_no_error(ret);
-    QDECREF(ret);
-
-    ret =3D qmp_fd(fixture->fd, "{'execute': 'guest-fsfreeze-status'}");
-    g_assert_nonnull(ret);
-    qmp_assert_no_error(ret);
-    status =3D qdict_get_try_str(ret, "return");
-    g_assert_cmpstr(status, =3D=3D, "frozen");
-    QDECREF(ret);
-
-    ret =3D qmp_fd(fixture->fd, "{'execute': 'guest-fsfreeze-thaw'}");
-    g_assert_nonnull(ret);
-    qmp_assert_no_error(ret);
-    QDECREF(ret);
-}
-
 static void test_qga_guest_exec(gconstpointer fix)
 {
     const TestFixture *fixture =3D fix;
@@ -1029,13 +946,6 @@ int main(int argc, char **argv)
     g_test_add_data_func("/qga/guest-get-osinfo", &fix,
                          test_qga_guest_get_osinfo);
=20
-    if (g_getenv("QGA_TEST_SIDE_EFFECTING")) {
-        g_test_add_data_func("/qga/fsfreeze-and-thaw", &fix,
-                             test_qga_fsfreeze_and_thaw);
-        g_test_add_data_func("/qga/set-time", &fix, test_qga_set_time);
-        g_test_add_data_func("/qga/fstrim", &fix, test_qga_fstrim);
-    }
-
     ret =3D g_test_run();
=20
     fixture_tear_down(&fix, NULL);
--=20
1.8.3.1
