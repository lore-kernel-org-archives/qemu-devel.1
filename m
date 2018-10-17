Received: from eggs.gnu.org ([2001:4830:134:3::10]:53275)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gCihk-0005fb-Dx
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 06:05:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gCihX-0000wv-71
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 06:05:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55002)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gCihX-0000rQ-0R
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 06:05:15 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 17 Oct 2018 12:04:54 +0200
Message-Id: <1539770707-7289-3-git-send-email-thuth@redhat.com>
In-Reply-To: <1539770707-7289-1-git-send-email-thuth@redhat.com>
References: <1539770707-7289-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 02/15] target/cris/translate: Get rid of
 qemu_log_separate()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org

The gen_BUG() function calls already cpu_abort(), which prints the
information to stderr and the log already. So instead of additionally
printing the dc->pc via fprintf() and qemu_log here, too, we can
simply pass this information to cpu_abort() instead.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/cris/translate.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/target/cris/translate.c b/target/cris/translate.c
index 4ae1c04..11b2c11 100644
--- a/target/cris/translate.c
+++ b/target/cris/translate.c
@@ -137,11 +137,7 @@ typedef struct DisasContext {
=20
 static void gen_BUG(DisasContext *dc, const char *file, int line)
 {
-    fprintf(stderr, "BUG: pc=3D%x %s %d\n", dc->pc, file, line);
-    if (qemu_log_separate()) {
-        qemu_log("BUG: pc=3D%x %s %d\n", dc->pc, file, line);
-    }
-    cpu_abort(CPU(dc->cpu), "%s:%d\n", file, line);
+    cpu_abort(CPU(dc->cpu), "%s:%d pc=3D%x\n", file, line, dc->pc);
 }
=20
 static const char *regnames_v32[] =3D
--=20
1.8.3.1
