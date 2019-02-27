Received: from eggs.gnu.org ([209.51.188.92]:49777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gynur-0005GT-L0
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 20:21:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gynuq-0000nQ-SO
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 20:21:45 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 27 Feb 2019 12:21:32 +1100
Message-Id: <20190227012132.16271-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] Allow -sandbox off with --disable-seccomp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: otubo@redhat.com, pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

At present, when seccomp support is compiled out with --disable-seccomp
we fail with an error if the user puts -sandbox on the command line.

That kind of makes sense, but it's a bit strange that we reject a request
to disable sandboxing with "-sandbox off" saying we don't support
sandboxing.

This puts in a small sandbox to (correctly) silently ignore -sandbox off
when we don't have sandboxing support compiled in.  This makes life easie=
r
for testcases, since they can safely specify "-sandbox off" without havin=
g
to care if the qemu they're using is compiled with sandbox support or not=
.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 vl.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/vl.c b/vl.c
index 502857a176..9d5f1b7ebb 100644
--- a/vl.c
+++ b/vl.c
@@ -3857,9 +3857,11 @@ int main(int argc, char **argv, char **envp)
                     exit(1);
                 }
 #else
-                error_report("-sandbox support is not enabled "
-                             "in this QEMU binary");
-                exit(1);
+                if (!g_str_equal(optarg, "off")) {
+                    error_report("-sandbox support is not enabled "
+                                 "in this QEMU binary");
+                    exit(1);
+                }
 #endif
                 break;
             case QEMU_OPTION_add_fd:
--=20
2.20.1
