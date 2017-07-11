Received: from eggs.gnu.org ([2001:4830:134:3::10]:51859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dUryU-0002hA-6D
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 06:00:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dUryP-0002WI-Ie
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 06:00:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:64550)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dUryP-0002Vf-DL
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 06:00:53 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 11 Jul 2017 12:00:49 +0200
Message-Id: <20170711100049.20513-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2] build: disable Xen on ARM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, sstabellini@kernel.org, anthony.perard@citrix.com

While ARM could present the xenpv machine, it does not and trying to enab=
le
it breaks compilation.  Revert to the previous test which only looked at
$target_name, not $cpu.

Fixes: 3b6b75506de44c5070639943c30a0ad5850f5d02
Reported-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/configure b/configure
index 806658c98b..5096cbcf14 100755
--- a/configure
+++ b/configure
@@ -202,9 +202,9 @@ supported_kvm_target() {
 supported_xen_target() {
     test "$xen" =3D "yes" || return 1
     glob "$1" "*-softmmu" || return 1
-    case "${1%-softmmu}:$cpu" in
-        arm:arm | aarch64:aarch64 | \
-        i386:i386 | i386:x86_64 | x86_64:i386 | x86_64:x86_64)
+    # Only i386 and x86_64 provide the xenpv machine.
+    case "${1%-softmmu}" in
+        i386|x86_64)
             return 0
         ;;
     esac
--=20
2.13.0
