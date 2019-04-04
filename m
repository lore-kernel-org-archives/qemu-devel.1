Received: from eggs.gnu.org ([209.51.188.92]:42954)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <deller@gmx.de>) id 1hC7Gv-0000xo-D3
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 14:39:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <deller@gmx.de>) id 1hC7Gu-0001cl-Ee
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 14:39:33 -0400
Received: from mout.gmx.net ([212.227.15.19]:50165)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <deller@gmx.de>) id 1hC7Gu-0001aS-1k
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 14:39:32 -0400
Date: Thu, 4 Apr 2019 20:39:23 +0200
From: Helge Deller <deller@gmx.de>
Message-ID: <20190404183923.GA22347@ls3530.dellerweb.de>
References: <20190403124948.GA14129@ls3530.dellerweb.de>
	<20190403161729.GW25150@redhat.com>
	<CAFEAcA-85Z9wtZrf2AddGkrPZFOPgxFZ5sNOZCCBkqZRp8M2Dg@mail.gmail.com>
	<43102ef9-2f96-2863-00aa-b6f2906c2f4f@redhat.com>
	<20190404085621.GD10471@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190404085621.GD10471@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2] configure: Relax check for libseccomp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Helge Deller <deller@gmx.de>, Richard Henderson <richard.henderson@linaro.org>, Daniel =?iso-8859-15?Q?P=2E_Berrang=E9?= <berrange@redhat.com>

All major distributions do support libseccomp version >=3D 2.3.0, so there
is no need to special-case on various architectures any longer.

Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/configure b/configure
index 1c563a7027..8fe4fc84d8 100755
=2D-- a/configure
+++ b/configure
@@ -2377,36 +2369,16 @@ fi
 ##########################################
 # libseccomp check

-libseccomp_minver=3D"2.2.0"
 if test "$seccomp" !=3D "no" ; then
-    case "$cpu" in
-    i386|x86_64|mips)
-        ;;
-    arm|aarch64)
-        libseccomp_minver=3D"2.2.3"
-        ;;
-    ppc|ppc64|s390x)
-        libseccomp_minver=3D"2.3.0"
-        ;;
-    *)
-        libseccomp_minver=3D""
-        ;;
-    esac
-
-    if test "$libseccomp_minver" !=3D "" &&
-       $pkg_config --atleast-version=3D$libseccomp_minver libseccomp ; th=
en
+    libseccomp_minver=3D"2.3.0"
+    if $pkg_config --atleast-version=3D$libseccomp_minver libseccomp ; th=
en
         seccomp_cflags=3D"$($pkg_config --cflags libseccomp)"
         seccomp_libs=3D"$($pkg_config --libs libseccomp)"
         seccomp=3D"yes"
     else
         if test "$seccomp" =3D "yes" ; then
-            if test "$libseccomp_minver" !=3D "" ; then
-                feature_not_found "libseccomp" \
-                    "Install libseccomp devel >=3D $libseccomp_minver"
-            else
-                feature_not_found "libseccomp" \
-                    "libseccomp is not supported for host cpu $cpu"
-            fi
+            feature_not_found "libseccomp" \
+                 "Install libseccomp devel >=3D $libseccomp_minver"
         fi
         seccomp=3D"no"
     fi
