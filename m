Received: from eggs.gnu.org ([2001:4830:134:3::10]:48650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <r.bolshakov@yadro.com>) id 1gYzhj-0008Un-Dz
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 15:41:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <r.bolshakov@yadro.com>) id 1gYzTd-0005IG-Bn
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 15:26:58 -0500
Received: from mta-01.yadro.com ([89.207.88.251]:45318)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <r.bolshakov@yadro.com>)
	id 1gYzTc-0005Gv-VV
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 15:26:57 -0500
Received: from localhost (unknown [127.0.0.1])
	by mta-01.yadro.com (Postfix) with ESMTP id C6AFC4193F
	for <qemu-devel@nongnu.org>; Mon, 17 Dec 2018 20:26:55 +0000 (UTC)
Received: from mta-01.yadro.com ([127.0.0.1])
	by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zBXVN1kUryVs for <qemu-devel@nongnu.org>;
	Mon, 17 Dec 2018 23:26:54 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
	[172.17.10.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by mta-01.yadro.com (Postfix) with ESMTPS id BE4654193A
	for <qemu-devel@nongnu.org>; Mon, 17 Dec 2018 23:26:54 +0300 (MSK)
From: Roman Bolshakov <r.bolshakov@yadro.com>
Date: Mon, 17 Dec 2018 23:26:01 +0300
Message-ID: <20181217202602.31113-2-r.bolshakov@yadro.com>
In-Reply-To: <20181217202602.31113-1-r.bolshakov@yadro.com>
References: <20181217202602.31113-1-r.bolshakov@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC 1/2] util: Implement debug-threads for macOS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Roman Bolshakov <r.bolshakov@yadro.com>

macOS provides pthread_setname_np that doesn't have thread id argument.

Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
---
 configure                | 32 ++++++++++++++++++++++++++------
 qemu-options.hx          |  4 ++--
 util/qemu-thread-posix.c |  6 +++++-
 3 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/configure b/configure
index 224d3071ac..99dc073e53 100755
--- a/configure
+++ b/configure
@@ -3715,8 +3715,8 @@ if test "$mingw32" !=3D yes -a "$pthread" =3D no; t=
hen
       "Make sure to have the pthread libs and headers installed."
 fi
=20
-# check for pthread_setname_np
-pthread_setname_np=3Dno
+# check for pthread_setname_np with thread id
+pthread_setname_np_w_tid=3Dno
 cat > $TMPC << EOF
 #include <pthread.h>
=20
@@ -3730,7 +3730,24 @@ int main(void)
 }
 EOF
 if compile_prog "" "$pthread_lib" ; then
-  pthread_setname_np=3Dyes
+  pthread_setname_np_w_tid=3Dyes
+fi
+
+# check for pthread_setname_np without thread id
+pthread_setname_np_wo_tid=3Dno
+cat > $TMPC << EOF
+#include <pthread.h>
+
+static void *f(void *p) { pthread_setname_np("QEMU"); }
+int main(void)
+{
+    pthread_t thread;
+    pthread_create(&thread, 0, f, 0);
+    return 0;
+}
+EOF
+if compile_prog "" "$pthread_lib" ; then
+  pthread_setname_np_wo_tid=3Dyes
 fi
=20
 ##########################################
@@ -6883,11 +6900,14 @@ fi
 # Hold two types of flag:
 #   CONFIG_THREAD_SETNAME_BYTHREAD  - we've got a way of setting the nam=
e on
 #                                     a thread we have a handle to
-#   CONFIG_PTHREAD_SETNAME_NP       - A way of doing it on a particular
+#   CONFIG_PTHREAD_SETNAME_NP_W_TID - A way of doing it on a particular
 #                                     platform
-if test "$pthread_setname_np" =3D "yes" ; then
+if test "$pthread_setname_np_w_tid" =3D "yes" ; then
   echo "CONFIG_THREAD_SETNAME_BYTHREAD=3Dy" >> $config_host_mak
-  echo "CONFIG_PTHREAD_SETNAME_NP=3Dy" >> $config_host_mak
+  echo "CONFIG_PTHREAD_SETNAME_NP_W_TID=3Dy" >> $config_host_mak
+elif test "$pthread_setname_np_wo_tid" =3D "yes" ; then
+  echo "CONFIG_THREAD_SETNAME_BYTHREAD=3Dy" >> $config_host_mak
+  echo "CONFIG_PTHREAD_SETNAME_NP_WO_TID=3Dy" >> $config_host_mak
 fi
=20
 if test "$vxhs" =3D "yes" ; then
diff --git a/qemu-options.hx b/qemu-options.hx
index df42116ecc..d4f3564b78 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -538,8 +538,8 @@ ETEXI
 DEF("name", HAS_ARG, QEMU_OPTION_name,
     "-name string1[,process=3Dstring2][,debug-threads=3Don|off]\n"
     "                set the name of the guest\n"
-    "                string1 sets the window title and string2 the proce=
ss name (on Linux)\n"
-    "                When debug-threads is enabled, individual threads a=
re given a separate name (on Linux)\n"
+    "                string1 sets the window title and string2 the proce=
ss name\n"
+    "                When debug-threads is enabled, individual threads a=
re given a separate name\n"
     "                NOTE: The thread names are for debugging and not a =
stable API.\n",
     QEMU_ARCH_ALL)
 STEXI
diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
index 865e476df5..c6934bd22c 100644
--- a/util/qemu-thread-posix.c
+++ b/util/qemu-thread-posix.c
@@ -484,12 +484,16 @@ static void *qemu_thread_start(void *args)
     void *arg =3D qemu_thread_args->arg;
     void *r;
=20
-#ifdef CONFIG_PTHREAD_SETNAME_NP
+#ifdef CONFIG_THREAD_SETNAME_BYTHREAD
     /* Attempt to set the threads name; note that this is for debug, so
      * we're not going to fail if we can't set it.
      */
     if (name_threads && qemu_thread_args->name) {
+# if defined(CONFIG_PTHREAD_SETNAME_NP_W_TID)
         pthread_setname_np(pthread_self(), qemu_thread_args->name);
+# elif defined(CONFIG_PTHREAD_SETNAME_NP_WO_TID)
+        pthread_setname_np(qemu_thread_args->name);
+# endif
     }
 #endif
     g_free(qemu_thread_args->name);
--=20
2.19.1
