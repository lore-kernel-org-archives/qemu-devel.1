Received: from eggs.gnu.org ([2001:4830:134:3::10]:45914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1fKHvG-000633-8w
	for qemu-devel@nongnu.org; Sun, 20 May 2018 02:34:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1fKHvA-0002tk-4P
	for qemu-devel@nongnu.org; Sun, 20 May 2018 02:34:23 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Sun, 20 May 2018 09:15:02 +0300
Message-Id: <aec0d0e11812c602866c9fa044847f1e7b1e7dff.1526796813.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1526796813.git.mjt@msgid.tls.msk.ru>
References: <cover.1526796813.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1526796813.git.mjt@msgid.tls.msk.ru>
References: <cover.1526796813.git.mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 16/22] qemu-options: Allow -no-user-config again
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Michal Privoznik <mprivozn@redhat.com>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Michal Privoznik <mprivozn@redhat.com>

After 1217d6ca2bf28c0febe1bd7d5b3fa912bbf6af2a we error out
explicitly if an unknown -option was passed on the command line.
However, we are doing two pass command line option parsing. In
the first pass we just look for -no-user-config or -nodefconfig
being present which determines whether we load user config or
not. Then in the second pass we finally parse everything else
throwing an error if an unsupported -option was found. Problem is
that in the second pass -no-user-config and -nodefconfig are not
handled explicitly which makes us throw the unsupported option
error.

Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 vl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/vl.c b/vl.c
index 3b39bbd7a8..d5836c65ae 100644
--- a/vl.c
+++ b/vl.c
@@ -4011,6 +4011,10 @@ int main(int argc, char **argv, char **envp)
                     exit(1);
                 }
                 break;
+            case QEMU_OPTION_nodefconfig:
+            case QEMU_OPTION_nouserconfig:
+                /* Nothing to be parsed here. Especially, do not error o=
ut below. */
+                break;
             default:
                 if (os_parse_cmd_args(popt->index, optarg)) {
                     error_report("Option not supported in this build");
--=20
2.11.0
