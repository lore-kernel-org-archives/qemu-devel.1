Received: from eggs.gnu.org ([209.51.188.92]:57989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1h2QAb-0000aq-JW
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 19:49:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1h2QAa-0001xF-Rj
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 19:48:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39010)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1h2QAa-0001wo-Kh
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 19:48:56 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E9329BDD0
	for <qemu-devel@nongnu.org>; Sat,  9 Mar 2019 00:48:55 +0000 (UTC)
From: Laszlo Ersek <lersek@redhat.com>
Date: Sat,  9 Mar 2019 01:48:21 +0100
Message-Id: <20190309004826.9027-6-lersek@redhat.com>
In-Reply-To: <20190309004826.9027-1-lersek@redhat.com>
References: <20190309004826.9027-1-lersek@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 05/10] roms/edk2-funcs.sh: add the
 qemu_edk2_get_thread_count() function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: berrange@redhat.com, imammedo@redhat.com, kraxel@redhat.com, mst@redhat.com, philmd@redhat.com, qemu-devel@nongnu.org

The edk2 "build" utility natively supports building modules (that is, INF
files) in parallel. The feature is not useful when building a single
module (with the "-m" option), but it is useful for platform firmware
builds (which include many modules). Add a function that determines the
"-n" option argument for "build", from the MAKEFLAGS variable (i.e. based
on the presence of a make job server).

Signed-off-by: Laszlo Ersek <lersek@redhat.com>
---
 roms/edk2-funcs.sh | 25 ++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/roms/edk2-funcs.sh b/roms/edk2-funcs.sh
index 22a5dc8f6ab6..7fc62f074c59 100644
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
