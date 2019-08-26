Return-Path: <SRS0=7Gz3=WW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A42B6C3A59F
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 13:58:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71F902173E
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 13:58:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71F902173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2FVd-0005DI-Vc
	for qemu-devel@archiver.kernel.org; Mon, 26 Aug 2019 09:58:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38031)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1i2FPI-00081n-AU
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 09:51:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1i2FPG-0006Oh-Ti
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 09:51:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39588)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1i2FOv-0006I5-2z; Mon, 26 Aug 2019 09:51:17 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5D089308FB82;
 Mon, 26 Aug 2019 13:51:16 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E628A5D6C8;
 Mon, 26 Aug 2019 13:51:13 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 26 Aug 2019 16:50:51 +0300
Message-Id: <20190826135103.22410-2-mlevitsk@redhat.com>
In-Reply-To: <20190826135103.22410-1-mlevitsk@redhat.com>
References: <20190826135103.22410-1-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Mon, 26 Aug 2019 13:51:16 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 01/13] introduce g_autowipe
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Marking a pointer with g_autowipe, will
not only free it at the scope exit, but also
erase the data it points to just prior to freeing it.

This is first attempt to implement this feature,
as suggested by Daniel and Nir.

The things that need to be verified prior to merging this is

1. Can we just always use memset_s (defined in C++)
 or some alternative.

2. is it portable enought for us to use malloc_usable_size
to get the size of malloced pointer in the autofree callback?
This function is aviable in glibc (but no wrapper in glib).

Thanks for Daniel for the g_autowipe and to Nir for the
information about the fact that plain memset is usually
optimized away.

Suggested-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Suggested-by: Nir Soffer <nsoffer@redhat.com>
Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 include/autowipe.h | 52 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 include/autowipe.h

diff --git a/include/autowipe.h b/include/autowipe.h
new file mode 100644
index 0000000000..1ed4eaf3ba
--- /dev/null
+++ b/include/autowipe.h
@@ -0,0 +1,52 @@
+/*
+ * g_autowipe implementation for crypto secret wiping
+ *
+ * Copyright (c) 2019 Red Hat, Inc.
+ * Copyright (c) 2019 Maxim Levitsky
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it would be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+
+#include <stddef.h>
+#include <malloc.h>
+#include <glib.h>
+
+
+/*
+ * based on
+ * https://www.cryptologie.net/article/419/zeroing-memory-compiler-optim=
izations-and-memset_s/
+ */
+
+static inline void memerase(void *pointer, size_t size)
+{
+#ifdef __STDC_LIB_EXT1__
+    memset_s(pointer, size, 0, size);
+#else
+    /*volatile used to force compiler to not optimize the code away*/
+    volatile unsigned char *p =3D pointer;
+    while (size--) {
+        *p++ =3D 0;
+    }
+#endif
+}
+
+static void g_autoptr_cleanup_generic_wipe_gfree(void *p)
+{
+    void **pp =3D (void **)p;
+    size_t size =3D malloc_usable_size(*pp);
+    memerase(*pp, size);
+    g_free(*pp);
+}
+
+#define g_autowipe _GLIB_CLEANUP(g_autoptr_cleanup_generic_wipe_gfree)
--=20
2.17.2


