Received: from eggs.gnu.org ([2001:4830:134:3::10]:34244)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1f5pWD-0004jX-Tw
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 05:24:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1f5pWC-0006VS-UT
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 05:24:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:32778 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1f5pWC-0006U5-QL
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 05:24:48 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 10 Apr 2018 11:24:45 +0200
Message-Id: <20180410092446.26903-4-kraxel@redhat.com>
In-Reply-To: <20180410092446.26903-1-kraxel@redhat.com>
References: <20180410092446.26903-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 3/4] configure: don't warn GTK if disabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Peter Xu <peterx@redhat.com>

We don't need to detect GTK ABI if GTK is disabled in general.
Otherwise we could get this warning (when host is installed with GTK ABI
version 2) even when configure with "--disable-gtk":

    WARNING: Use of GTK 2.0 is deprecated and will be removed in
    WARNING: future releases. Please switch to using GTK 3.0

CC: Paolo Bonzini <pbonzini@redhat.com>
CC: Gerd Hoffmann <kraxel@redhat.com>
CC: Peter Maydell <peter.maydell@linaro.org>
CC: Fam Zheng <famz@redhat.com>
CC: "Philippe Mathieu-Daud=C3=A9" <f4bug@amsat.org>
Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Message-id: 20180409082323.29575-1-peterx@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 configure | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/configure b/configure
index 752dd9ef32..931d2a07cc 100755
--- a/configure
+++ b/configure
@@ -2540,19 +2540,18 @@ fi
 ##########################################
 # GTK probe
=20
-if test "$gtkabi" =3D ""; then
-    # The GTK ABI was not specified explicitly, so try whether 3.0 is av=
ailable.
-    # Use 2.0 as a fallback if that is available.
-    if $pkg_config --exists "gtk+-3.0 >=3D 3.0.0"; then
-        gtkabi=3D3.0
-    elif $pkg_config --exists "gtk+-2.0 >=3D 2.18.0"; then
-        gtkabi=3D2.0
-    else
-        gtkabi=3D3.0
-    fi
-fi
-
 if test "$gtk" !=3D "no"; then
+    if test "$gtkabi" =3D ""; then
+        # The GTK ABI was not specified explicitly, so try whether 3.0 i=
s available.
+        # Use 2.0 as a fallback if that is available.
+        if $pkg_config --exists "gtk+-3.0 >=3D 3.0.0"; then
+            gtkabi=3D3.0
+        elif $pkg_config --exists "gtk+-2.0 >=3D 2.18.0"; then
+            gtkabi=3D2.0
+        else
+            gtkabi=3D3.0
+        fi
+    fi
     gtkpackage=3D"gtk+-$gtkabi"
     gtkx11package=3D"gtk+-x11-$gtkabi"
     if test "$gtkabi" =3D "3.0" ; then
--=20
2.9.3
