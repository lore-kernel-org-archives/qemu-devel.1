Received: from eggs.gnu.org ([2001:4830:134:3::10]:44735)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ctJV4-0001vk-3V
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 15:43:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ctJV1-00006o-68
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 15:43:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58884)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ctJV1-00006d-1D
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 15:43:19 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0636061B8F
	for <qemu-devel@nongnu.org>; Wed, 29 Mar 2017 19:43:18 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Wed, 29 Mar 2017 16:41:40 -0300
Message-Id: <20170329194148.19015-2-ehabkost@redhat.com>
In-Reply-To: <20170329194148.19015-1-ehabkost@redhat.com>
References: <20170329194148.19015-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC v2 1/9] configure: test if _Generic works as
 expected
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Test if _Generic works as expected, and set HAVE_C11_GENERIC
config variable if it does.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 configure | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/configure b/configure
index d1ce33bc79..b29bce0b53 100755
--- a/configure
+++ b/configure
@@ -1548,6 +1548,22 @@ EOF
   fi
 fi
 
+# Ensure we support _Generic, and that it takes type qualifiers into account
+have_c11_generic=
+cat > $TMPC << EOF
+const int *p;
+typedef typeof(_Generic(p,
+                        const int *: (int *)0,
+                        int *: 0,
+                        default: 0)) T;
+T foo;
+int x(void);
+int x(void) { return *foo; }
+EOF
+if do_cc $QEMU_CFLAGS -Werror -c -o $TMPO $TMPC;then
+  have_c11_generic=yes
+fi
+
 # Workaround for http://gcc.gnu.org/PR55489.  Happens with -fPIE/-fPIC and
 # large functions that use global variables.  The bug is in all releases of
 # GCC, but it became particularly acute in 4.6.x and 4.7.x.  It is fixed in
@@ -5751,6 +5767,10 @@ if test "$have_sysmacros" = "yes" ; then
   echo "CONFIG_SYSMACROS=y" >> $config_host_mak
 fi
 
+if test "$have_c11_generic" = "yes" ; then
+  echo "HAVE_C11_GENERIC=y" >> $config_host_mak
+fi
+
 # Hold two types of flag:
 #   CONFIG_THREAD_SETNAME_BYTHREAD  - we've got a way of setting the name on
 #                                     a thread we have a handle to
-- 
2.11.0.259.g40922b1
