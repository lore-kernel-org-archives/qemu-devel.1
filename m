Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E59C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 13:11:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E28DC20716
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 13:11:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HGnAqT1E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E28DC20716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihvav-0004BS-OD
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 08:11:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43874)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1ihuy3-0000PT-QA
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:31:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1ihuy2-0002re-GN
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:31:47 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20075
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1ihuy2-0002oP-AK
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:31:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576758705;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d1NwnKNFRuuxevU3nGqbAtAHtU1cIvtea8ojJXVOLbw=;
 b=HGnAqT1EbN56wvfmQtL+9P7kJZ0Kv6jRLiiC//O8Yjia+/TZCOxpRD0eG2qyKnbtte5Tck
 eGBOZPTFhv9pSGrAjRkbiCEnjPzg1CCb+hvIC96YRiIJC8nZ4Ek71SSiEDRiqvLM+pWZTn
 z7O7DyzWWJr5GAbsAoL7zaRAciEDeZY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-115-AsHM7xG4NVuFyG0icI_ngw-1; Thu, 19 Dec 2019 07:31:42 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A2B3A184BEC5
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 12:31:41 +0000 (UTC)
Received: from localhost (ovpn-112-22.ams2.redhat.com [10.36.112.22])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 203B463B8E;
 Thu, 19 Dec 2019 12:31:37 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 4/9] util: add dbus helper unit
Date: Thu, 19 Dec 2019 16:30:24 +0400
Message-Id: <20191219123029.200788-5-marcandre.lureau@redhat.com>
In-Reply-To: <20191219123029.200788-1-marcandre.lureau@redhat.com>
References: <20191219123029.200788-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: AsHM7xG4NVuFyG0icI_ngw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: berrange@redhat.com, quintela@redhat.com, mprivozn@redhat.com,
 dgilbert@redhat.com, pbonzini@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 MAINTAINERS         |  2 ++
 include/qemu/dbus.h | 19 +++++++++++++++
 util/Makefile.objs  |  3 +++
 util/dbus.c         | 57 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 81 insertions(+)
 create mode 100644 include/qemu/dbus.h
 create mode 100644 util/dbus.c

diff --git a/MAINTAINERS b/MAINTAINERS
index c0faf5377d..9c03214693 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2207,6 +2207,8 @@ F: qapi/migration.json
 D-Bus
 M: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
 S: Maintained
+F: util/dbus.c
+F: include/qemu/dbus.h
 F: docs/interop/dbus.rst
=20
 Seccomp
diff --git a/include/qemu/dbus.h b/include/qemu/dbus.h
new file mode 100644
index 0000000000..9d591f9ee4
--- /dev/null
+++ b/include/qemu/dbus.h
@@ -0,0 +1,19 @@
+/*
+ * Helpers for using D-Bus
+ *
+ * Copyright (C) 2019 Red Hat, Inc.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ */
+
+#ifndef DBUS_H
+#define DBUS_H
+
+#include <gio/gio.h>
+
+GStrv qemu_dbus_get_queued_owners(GDBusConnection *connection,
+                                  const char *name,
+                                  Error **errp);
+
+#endif /* DBUS_H */
diff --git a/util/Makefile.objs b/util/Makefile.objs
index df124af1c5..80b76352cd 100644
--- a/util/Makefile.objs
+++ b/util/Makefile.objs
@@ -55,5 +55,8 @@ util-obj-$(CONFIG_INOTIFY1) +=3D filemonitor-inotify.o
 util-obj-$(CONFIG_LINUX) +=3D vfio-helpers.o
 util-obj-$(CONFIG_POSIX) +=3D drm.o
 util-obj-y +=3D guest-random.o
+util-obj-$(CONFIG_GIO) +=3D dbus.o
+dbus.o-cflags =3D $(GIO_CFLAGS)
+dbus.o-libs =3D $(GIO_LIBS)
=20
 stub-obj-y +=3D filemonitor-stub.o
diff --git a/util/dbus.c b/util/dbus.c
new file mode 100644
index 0000000000..9099dc5b4b
--- /dev/null
+++ b/util/dbus.c
@@ -0,0 +1,57 @@
+/*
+ * Helpers for using D-Bus
+ *
+ * Copyright (C) 2019 Red Hat, Inc.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/dbus.h"
+#include "qemu/error-report.h"
+#include "qapi/error.h"
+
+/*
+ * qemu_dbus_get_queued_owners() - return the list of queued unique names
+ * @connection: A GDBusConnection
+ * @name: a service name
+ *
+ * Return: a GStrv of unique names, or NULL on failure.
+ */
+GStrv
+qemu_dbus_get_queued_owners(GDBusConnection *connection, const char *name,
+                            Error **errp)
+{
+    g_autoptr(GDBusProxy) proxy =3D NULL;
+    g_autoptr(GVariant) result =3D NULL;
+    g_autoptr(GVariant) child =3D NULL;
+    g_autoptr(GError) err =3D NULL;
+
+    proxy =3D g_dbus_proxy_new_sync(connection, G_DBUS_PROXY_FLAGS_NONE, N=
ULL,
+                                  "org.freedesktop.DBus",
+                                  "/org/freedesktop/DBus",
+                                  "org.freedesktop.DBus",
+                                  NULL, &err);
+    if (!proxy) {
+        error_setg(errp, "Failed to create DBus proxy: %s", err->message);
+        return NULL;
+    }
+
+    result =3D g_dbus_proxy_call_sync(proxy, "ListQueuedOwners",
+                                    g_variant_new("(s)", name),
+                                    G_DBUS_CALL_FLAGS_NO_AUTO_START,
+                                    -1, NULL, &err);
+    if (!result) {
+        if (g_error_matches(err,
+                            G_DBUS_ERROR,
+                            G_DBUS_ERROR_NAME_HAS_NO_OWNER)) {
+            return g_new0(char *, 1);
+        }
+        error_setg(errp, "Failed to call ListQueuedOwners: %s", err->messa=
ge);
+        return NULL;
+    }
+
+    child =3D g_variant_get_child_value(result, 0);
+    return g_variant_dup_strv(child, NULL);
+}
--=20
2.24.0.308.g228f53135a


