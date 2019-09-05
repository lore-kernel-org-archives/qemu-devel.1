Return-Path: <SRS0=/Jg5=XA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E0DC43331
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 15:27:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 218F5206B8
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 15:27:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 218F5206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5tf9-00068J-G8
	for qemu-devel@archiver.kernel.org; Thu, 05 Sep 2019 11:27:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42784)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1i5taB-0000D7-0K
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 11:22:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1i5ta9-0007fu-CT
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 11:21:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35714)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1i5ta9-0007ff-4U
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 11:21:57 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 63F6389AC7;
 Thu,  5 Sep 2019 15:21:56 +0000 (UTC)
Received: from localhost (ovpn-117-222.ams2.redhat.com [10.36.117.222])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5F2845D9CA;
 Thu,  5 Sep 2019 15:21:48 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org,
	virtio-fs@redhat.com
Date: Thu,  5 Sep 2019 16:21:34 +0100
Message-Id: <20190905152136.30637-2-stefanha@redhat.com>
In-Reply-To: <20190905152136.30637-1-stefanha@redhat.com>
References: <20190905152136.30637-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Thu, 05 Sep 2019 15:21:56 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [RFC 1/3] virtiofsd: add org.qemu.Virtiofsd interface
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Eryu Guan <eguan@linux.alibaba.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Define a DBus interface for virtiofsd management.  It only allows
querying and changing the log level at the moment.

In the future more methods and properties could be added.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 configure                                |  7 +++++++
 Makefile                                 | 13 +++++++++++++
 contrib/virtiofsd/Makefile.objs          |  6 +++++-
 .gitignore                               |  1 +
 contrib/virtiofsd/org.qemu.Virtiofsd.xml |  7 +++++++
 5 files changed, 33 insertions(+), 1 deletion(-)
 create mode 100644 contrib/virtiofsd/org.qemu.Virtiofsd.xml

diff --git a/configure b/configure
index 2976e64b9b..17b789d772 100755
--- a/configure
+++ b/configure
@@ -3674,10 +3674,16 @@ if $pkg_config --atleast-version=3D$glib_req_ver =
gio-2.0; then
     gio=3Dyes
     gio_cflags=3D$($pkg_config --cflags gio-2.0)
     gio_libs=3D$($pkg_config --libs gio-2.0)
+    gdbus_codegen=3D$($pkg_config --variable=3Dgdbus_codegen gio-2.0)
 else
     gio=3Dno
 fi
=20
+if $pkg_config --atleast-version=3D$glib_req_ver gio-unix-2.0; then
+    gio_cflags=3D"$gio_cflags $($pkg_config --cflags gio-unix-2.0)"
+    gio_libs=3D"$gio_libs $($pkg_config --libs gio-unix-2.0)"
+fi
+
 # Sanity check that the current size_t matches the
 # size that glib thinks it should be. This catches
 # problems on multi-arch where people try to build
@@ -6856,6 +6862,7 @@ if test "$gio" =3D "yes" ; then
     echo "CONFIG_GIO=3Dy" >> $config_host_mak
     echo "GIO_CFLAGS=3D$gio_cflags" >> $config_host_mak
     echo "GIO_LIBS=3D$gio_libs" >> $config_host_mak
+    echo "GDBUS_CODEGEN=3D$gdbus_codegen" >> $config_host_mak
 fi
 echo "CONFIG_TLS_PRIORITY=3D\"$tls_priority\"" >> $config_host_mak
 if test "$gnutls" =3D "yes" ; then
diff --git a/Makefile b/Makefile
index a3dfdd6fa8..6b1af33348 100644
--- a/Makefile
+++ b/Makefile
@@ -124,6 +124,11 @@ GENERATED_QAPI_FILES +=3D qapi/qapi-doc.texi
=20
 generated-files-y +=3D $(GENERATED_QAPI_FILES)
=20
+ifdef CONFIG_LINUX
+generated-files-y +=3D contrib/virtiofsd/gdbus_generated.h
+generated-files-y +=3D contrib/virtiofsd/gdbus_generated.c
+endif
+
 generated-files-y +=3D trace/generated-tcg-tracers.h
=20
 generated-files-y +=3D trace/generated-helpers-wrappers.h
@@ -646,6 +651,14 @@ rdmacm-mux$(EXESUF): $(rdmacm-mux-obj-y) $(COMMON_LD=
ADDS)
 	$(call LINK, $^)
=20
 ifdef CONFIG_LINUX # relies on Linux-specific syscalls
+contrib/virtiofsd/gdbus_generated.h contrib/virtiofsd/gdbus_generated.c:=
 contrib/virtiofsd/gdbus_generated.c-timestamp ;
+contrib/virtiofsd/gdbus_generated.c-timestamp: $(SRC_PATH)/contrib/virti=
ofsd/org.qemu.Virtiofsd.xml
+	$(call quiet-command,$(GDBUS_CODEGEN) $< \
+		--interface-prefix org.qemu \
+		--generate-c-code contrib/virtiofsd/gdbus_generated, \
+		"GEN","$(@:%-timestamp=3D%)")
+	@>$@
+
 virtiofsd$(EXESUF): $(virtiofsd-obj-y) libvhost-user.a $(COMMON_LDADDS)
 	$(call LINK, $^)
 endif
diff --git a/contrib/virtiofsd/Makefile.objs b/contrib/virtiofsd/Makefile=
.objs
index 25f1e8dd73..9b2af1bc23 100644
--- a/contrib/virtiofsd/Makefile.objs
+++ b/contrib/virtiofsd/Makefile.objs
@@ -7,9 +7,13 @@ virtiofsd-obj-y =3D buffer.o \
                   fuse_virtio.o \
                   helper.o \
                   passthrough_ll.o \
-                  seccomp.o
+                  seccomp.o \
+                  gdbus_generated.o
=20
 seccomp.o-cflags :=3D $(SECCOMP_CFLAGS)
 seccomp.o-libs :=3D $(SECCOMP_LIBS)
=20
+gdbus_generated.o-cflags :=3D $(GIO_CFLAGS)
+gdbus_generated.o-libs :=3D $(GIO_LIBS)
+
 passthrough_ll.o-libs +=3D -lcap
diff --git a/.gitignore b/.gitignore
index fd6e6c38c7..c04d5dd0b1 100644
--- a/.gitignore
+++ b/.gitignore
@@ -6,6 +6,7 @@
 /config-target.*
 /config.status
 /config-temp
+/contrib/virtiofsd/gdbus_generated.*
 /elf2dmp
 /trace-events-all
 /trace/generated-events.h
diff --git a/contrib/virtiofsd/org.qemu.Virtiofsd.xml b/contrib/virtiofsd=
/org.qemu.Virtiofsd.xml
new file mode 100644
index 0000000000..efc0c59020
--- /dev/null
+++ b/contrib/virtiofsd/org.qemu.Virtiofsd.xml
@@ -0,0 +1,7 @@
+<!DOCTYPE node PUBLIC "-//freedesktop//DTD D-BUS Object Introspection 1.=
0//EN"
+         "http://www.freedesktop.org/standards/dbus/1.0/introspect.dtd">
+<node>
+    <interface name=3D"org.qemu.Virtiofsd">
+        <property name=3D"LogLevel" type=3D"s" access=3D"readwrite"/>
+    </interface>
+</node>
--=20
2.21.0


