Received: from eggs.gnu.org ([2001:4830:134:3::10]:56192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cov@codeaurora.org>) id 1cMKSt-00036D-Hg
	for qemu-devel@nongnu.org; Wed, 28 Dec 2016 15:04:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cov@codeaurora.org>) id 1cMKSq-0007VN-CJ
	for qemu-devel@nongnu.org; Wed, 28 Dec 2016 15:04:47 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:35120)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cov@codeaurora.org>) id 1cMKSq-0007VF-3I
	for qemu-devel@nongnu.org; Wed, 28 Dec 2016 15:04:44 -0500
From: Christopher Covington <cov@codeaurora.org>
Date: Wed, 28 Dec 2016 15:04:33 -0500
Message-Id: <20161228200433.24244-1-cov@codeaurora.org>
In-Reply-To: <20161228145344.30819-1-cov@codeaurora.org>
References: <20161228145344.30819-1-cov@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3] build: include sys/sysmacros.h for major()
 and minor()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Christopher Covington <cov@codeaurora.org>

The definition of the major() and minor() macros are moving within glibc =
to
<sys/sysmacros.h>. Include this header when it is available to avoid the
following sorts of build-stopping messages:

qga/commands-posix.c: In function =E2=80=98dev_major_minor=E2=80=99:
qga/commands-posix.c:656:13: error: In the GNU C Library, "major" is defi=
ned
 by <sys/sysmacros.h>. For historical compatibility, it is
 currently defined by <sys/types.h> as well, but we plan to
 remove this soon. To use "major", include <sys/sysmacros.h>
 directly. If you did not intend to use a system-defined macro
 "major", you should undefine it after including <sys/types.h>. [-Werror]
         *devmajor =3D major(st.st_rdev);
             ^~~~~~~~~~~~~~~~~~~~~~~~~~

qga/commands-posix.c:657:13: error: In the GNU C Library, "minor" is defi=
ned
 by <sys/sysmacros.h>. For historical compatibility, it is
 currently defined by <sys/types.h> as well, but we plan to
 remove this soon. To use "minor", include <sys/sysmacros.h>
 directly. If you did not intend to use a system-defined macro
 "minor", you should undefine it after including <sys/types.h>. [-Werror]
         *devminor =3D minor(st.st_rdev);
             ^~~~~~~~~~~~~~~~~~~~~~~~~~

The additional include allows the build to complete on Fedora 26 (Rawhide=
)
with glibc version 2.24.90.

Signed-off-by: Christopher Covington <cov@codeaurora.org>
---
 configure                 | 18 ++++++++++++++++++
 include/sysemu/os-posix.h |  4 ++++
 2 files changed, 22 insertions(+)

diff --git a/configure b/configure
index 218df87d21..58a33c71ad 100755
--- a/configure
+++ b/configure
@@ -4746,6 +4746,20 @@ if test "$modules" =3D "yes" && test "$LD_REL_FLAG=
S" =3D ""; then
 fi
=20
 ##########################################
+# check for sysmacros.h
+
+have_sysmacros=3Dno
+cat > $TMPC << EOF
+#include <sys/sysmacros.h>
+int main(void) {
+    return makedev(0, 0);
+}
+EOF
+if compile_prog "" "" ; then
+    have_sysmacros=3Dyes
+fi
+
+##########################################
 # End of CC checks
 # After here, no more $cc or $ld runs
=20
@@ -5721,6 +5735,10 @@ if test "$have_af_vsock" =3D "yes" ; then
   echo "CONFIG_AF_VSOCK=3Dy" >> $config_host_mak
 fi
=20
+if test "$have_sysmacros" =3D "yes" ; then
+  echo "CONFIG_SYSMACROS=3Dy" >> $config_host_mak
+fi
+
 # Hold two types of flag:
 #   CONFIG_THREAD_SETNAME_BYTHREAD  - we've got a way of setting the nam=
e on
 #                                     a thread we have a handle to
diff --git a/include/sysemu/os-posix.h b/include/sysemu/os-posix.h
index b0a6c0695b..900bdcb45a 100644
--- a/include/sysemu/os-posix.h
+++ b/include/sysemu/os-posix.h
@@ -34,6 +34,10 @@
 #include <netdb.h>
 #include <sys/un.h>
=20
+#ifdef CONFIG_SYSMACROS
+#include <sys/sysmacros.h>
+#endif
+
 void os_set_line_buffering(void);
 void os_set_proc_name(const char *s);
 void os_setup_signal_handling(void);
--=20
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc. Qualcomm Technologies, Inc. is a member of the Code Au=
rora
Forum, a Linux Foundation Collaborative Project.
