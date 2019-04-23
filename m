Received: from eggs.gnu.org ([209.51.188.92]:37088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hIz1q-0005Hv-0F
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 13:16:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hIz1o-0005tb-0l
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 13:16:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54460)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1hIz1n-0005sn-RI
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 13:16:19 -0400
From: Laszlo Ersek <lersek@redhat.com>
Date: Tue, 23 Apr 2019 19:15:13 +0200
Message-Id: <20190423171520.4511-6-lersek@redhat.com>
In-Reply-To: <20190423171520.4511-1-lersek@redhat.com>
References: <20190423171520.4511-1-lersek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 05/12] roms/edk2-funcs.sh: add the
 qemu_edk2_get_thread_count() function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: berrange@redhat.com, eblake@redhat.com, f4bug@amsat.org, imammedo@redhat.com, kraxel@redhat.com, mprivozn@redhat.com, mst@redhat.com, peter.maydell@linaro.org, philmd@redhat.com, qemu-devel@nongnu.org

The edk2 "build" utility natively supports building modules (that is, INF
files) in parallel. The feature is not useful when building a single
module (with the "-m" option), but it is useful for platform firmware
builds (which include many modules). Add a function that determines the
"-n" option argument for "build", from the MAKEFLAGS variable (i.e. based
on the presence of a make job server).

Signed-off-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Michal Privoznik <mprivozn@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Tested-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---

Notes:
    pull:
   =20
    - pick up Igor's R-b
   =20
    v4:
   =20
    - no change
   =20
    v3:
   =20
    - pick up Igor's T-b
   =20
    v2:
   =20
    - pick up Phil's R-b / T-b
   =20
    - pick up Michal's and Michael's R-b's

 roms/edk2-funcs.sh | 25 ++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/roms/edk2-funcs.sh b/roms/edk2-funcs.sh
index d1cb1e4a111e..a9fae7ee891b 100644
--- a/roms/edk2-funcs.sh
+++ b/roms/edk2-funcs.sh
@@ -226,3 +226,28 @@ qemu_edk2_set_cross_env()
=20
   eval "export $cross_prefix_var=3D\$cross_prefix"
 }
+
+
+# Determine the "-n" option argument (that is, the number of modules to =
build
+# in parallel) for the edk2 "build" utility. Print the result to the sta=
ndard
+# output.
+#
+# Parameters:
+#   $1: the value of the MAKEFLAGS variable
+qemu_edk2_get_thread_count()
+{
+  local makeflags=3D"$1"
+
+  if [[ "$makeflags" =3D=3D *--jobserver-auth=3D* ]] ||
+     [[ "$makeflags" =3D=3D *--jobserver-fds=3D* ]]; then
+    # If there is a job server, allow the edk2 "build" utility to parall=
elize
+    # as many module builds as there are logical CPUs in the system. The=
 "make"
+    # instances forked by "build" are supposed to limit themselves throu=
gh the
+    # job server. The zero value below causes the edk2 "build" utility t=
o fetch
+    # the logical CPU count with Python's multiprocessing.cpu_count() me=
thod.
+    printf '0\n'
+  else
+    # Build a single module at a time.
+    printf '1\n'
+  fi
+}
--=20
2.19.1.3.g30247aa5d201
