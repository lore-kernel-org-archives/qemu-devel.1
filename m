Received: from eggs.gnu.org ([2001:4830:134:3::10]:35577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1fIDnh-0000lA-0J
	for qemu-devel@nongnu.org; Mon, 14 May 2018 09:46:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1fIDng-0005ID-5x
	for qemu-devel@nongnu.org; Mon, 14 May 2018 09:46:05 -0400
From: Michal Privoznik <mprivozn@redhat.com>
Date: Mon, 14 May 2018 15:45:45 +0200
Message-Id: <9dbde2b5d864d126b75d8c0d7bae2011e8cc7e9b.1526305502.git.mprivozn@redhat.com>
Subject: [Qemu-devel] [PATCH] qemu-options: Allow -no-user-config again
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, pbonzini@redhat.com, qemu-trivial@nongnu.org

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
---
 vl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/vl.c b/vl.c
index b9f6b42779..846cd29d8a 100644
--- a/vl.c
+++ b/vl.c
@@ -4015,6 +4015,10 @@ int main(int argc, char **argv, char **envp)
                     exit(1);
                 }
                 break;
+            case QEMU_OPTION_nodefconfig:
+            case QEMU_OPTION_nouserconfig:
+                /* Nothing to be parsed here. Especially, do not error out below. */
+                break;
             default:
                 if (os_parse_cmd_args(popt->index, optarg)) {
                     error_report("Option not supported in this build");
-- 
2.16.1
