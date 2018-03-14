Received: from eggs.gnu.org ([2001:4830:134:3::10]:45582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ew5Dq-0006rG-FU
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 08:09:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ew5Dl-0001Zz-Ff
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 08:09:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58998 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ew5Dl-0001Zn-Ay
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 08:09:29 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EC350EB700
	for <qemu-devel@nongnu.org>; Wed, 14 Mar 2018 12:09:28 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Wed, 14 Mar 2018 12:09:06 +0000
Message-Id: <20180314120906.30872-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH RFC] configure: shorthand for only enabling
 native softmmu target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

With the huge number of QEMU targets, a default configuration will take
a very long time to rebuild. When developing most code changes, it is
sufficient to test compilation with a single target - rebuilding all
targets just extends compile times while not detecting any new problems.

Developers will often thus specify a single target for configure,
commonly matching the host architecture. eg

  ./configure --target-list=3Dx86_64-softmmu

This works fine, but is a bit of a verbose thing to type out everytime
configure is invoked. There are already short-hand args to disable all
user targets, all softmmu targets, or all tcg targets. This adds one
further shorthand to disable all non-native architecture targets.

  ./configure --native

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---

Suggestions welcomed for better names than --native, but bear in mind
the goal is to minimise amount of typing so nothing too verbose, hence
why I didn't do something like --disable-non-native ...

 configure | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/configure b/configure
index af72fc852e..807af93116 100755
--- a/configure
+++ b/configure
@@ -233,6 +233,22 @@ supported_whpx_target() {
     return 1
 }
=20
+supported_native_target() {
+    glob "$1" "*-softmmu" || return 1
+    case "${1%-softmmu}:$cpu" in
+        arm:arm | aarch64:aarch64 | \
+        i386:i386 | i386:x32 | \
+        x86_64:x86_64 | \
+        mips:mips | mipsel:mips | \
+        ppc:ppc | ppcemb:ppc | \
+        ppc64:ppc64 | \
+        s390x:s390x)
+            return 0
+        ;;
+    esac
+    return 1
+}
+
 supported_target() {
     case "$1" in
         *-softmmu)
@@ -254,6 +270,10 @@ supported_target() {
             return 1
             ;;
     esac
+    if test "$native" =3D "yes"
+    then
+	supported_native_target "$1" || return 1
+    fi
     test "$tcg" =3D "yes" && return 0
     supported_kvm_target "$1" && return 0
     supported_xen_target "$1" && return 0
@@ -390,6 +410,7 @@ cocoa=3D"no"
 softmmu=3D"yes"
 linux_user=3D"no"
 bsd_user=3D"no"
+native=3D"no"
 blobs=3D"yes"
 pkgversion=3D""
 pie=3D""
@@ -1112,6 +1133,8 @@ for opt do
       cocoa=3D"yes" ;
       audio_drv_list=3D"coreaudio $(echo $audio_drv_list | sed s,coreaud=
io,,g)"
   ;;
+  --native) native=3D"yes"
+  ;;
   --disable-system) softmmu=3D"no"
   ;;
   --enable-system) softmmu=3D"yes"
@@ -1540,6 +1563,7 @@ Advanced options (experts only):
                            xen pv domain builder
   --enable-debug-stack-usage
                            track the maximum stack usage of stacks creat=
ed by qemu_alloc_stack
+  --native                 only enable the softmmu target matching host =
architecture
=20
 Optional features, enabled with --enable-FEATURE and
 disabled with --disable-FEATURE, default is enabled if available:
--=20
2.14.3
