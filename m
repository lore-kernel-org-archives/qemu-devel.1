Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A85C072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 18:46:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2754821848
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 18:46:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2754821848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58796 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUFDC-0007YV-CY
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 14:46:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hUFBb-0006Vf-Qm
	for qemu-devel@nongnu.org; Fri, 24 May 2019 14:45:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hUFBa-0005py-6v
	for qemu-devel@nongnu.org; Fri, 24 May 2019 14:44:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55576)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hUFBY-0005lC-6E
	for qemu-devel@nongnu.org; Fri, 24 May 2019 14:44:57 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 23F073086268;
	Fri, 24 May 2019 18:44:54 +0000 (UTC)
Received: from localhost (ovpn-116-14.gru2.redhat.com [10.97.116.14])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6F2EF7D925;
	Fri, 24 May 2019 18:44:51 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
	Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Date: Fri, 24 May 2019 15:44:31 -0300
Message-Id: <20190524184447.16678-2-ehabkost@redhat.com>
In-Reply-To: <20190524184447.16678-1-ehabkost@redhat.com>
References: <20190524184447.16678-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.49]);
	Fri, 24 May 2019 18:44:54 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 01/17] qom/object: Display more helpful message
 when an object type is missing
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

When writing a new board, adding device which uses other devices
(container) or simply refactoring, one can discover the hard way
his machine misses some devices. In the case of containers, the
error is not obvious:

  $ qemu-system-microblaze -M xlnx-zynqmp-pmu
  **
  ERROR:/source/qemu/qom/object.c:454:object_initialize_with_type: assert=
ion failed: (type !=3D NULL)
  Aborted (core dumped)

And we have to look at the coredump to figure the error:

  (gdb) bt
  #1  0x00007f84773cf895 in abort () at /lib64/libc.so.6
  #2  0x00007f847961fb53 in  () at /lib64/libglib-2.0.so.0
  #3  0x00007f847967a4de in g_assertion_message_expr () at /lib64/libglib=
-2.0.so.0
  #4  0x000055c4bcac6c11 in object_initialize_with_type (data=3Ddata@entr=
y=3D0x55c4bdf239e0, size=3Dsize@entry=3D2464, type=3D<optimized out>) at =
/source/qemu/qom/object.c:454
  #5  0x000055c4bcac6e6d in object_initialize (data=3Ddata@entry=3D0x55c4=
bdf239e0, size=3Dsize@entry=3D2464, typename=3Dtypename@entry=3D0x55c4bcc=
7c643 "xlnx.zynqmp_ipi") at /source/qemu/qom/object.c:474
  #6  0x000055c4bc9ea474 in xlnx_zynqmp_pmu_init (machine=3D0x55c4bdd4600=
0) at /source/qemu/hw/microblaze/xlnx-zynqmp-pmu.c:176
  #7  0x000055c4bca3b6cb in machine_run_board_init (machine=3D0x55c4bdd46=
000) at /source/qemu/hw/core/machine.c:1030
  #8  0x000055c4bc95f6d2 in main (argc=3D<optimized out>, argv=3D<optimiz=
ed out>, envp=3D<optimized out>) at /source/qemu/vl.c:4479

Since the caller knows the type name requested, we can simply display it
to ease development.

With this patch applied we get:

  $ qemu-system-microblaze -M xlnx-zynqmp-pmu
  qemu-system-microblaze: missing object type 'xlnx.zynqmp_ipi'
  Aborted (core dumped)

Since the assert(type) check in object_initialize_with_type() is
now impossible, remove it.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-Id: <20190427135642.16464-1-philmd@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 qom/object.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/qom/object.c b/qom/object.c
index 99c4fa707e..3966a3d461 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -28,6 +28,7 @@
 #include "qapi/qmp/qbool.h"
 #include "qapi/qmp/qnum.h"
 #include "qapi/qmp/qstring.h"
+#include "qemu/error-report.h"
=20
 #define MAX_INTERFACES 32
=20
@@ -448,7 +449,6 @@ static void object_initialize_with_type(void *data, s=
ize_t size, TypeImpl *type)
 {
     Object *obj =3D data;
=20
-    g_assert(type !=3D NULL);
     type_initialize(type);
=20
     g_assert(type->instance_size >=3D sizeof(Object));
@@ -468,6 +468,11 @@ void object_initialize(void *data, size_t size, cons=
t char *typename)
 {
     TypeImpl *type =3D type_get_by_name(typename);
=20
+    if (!type) {
+        error_report("missing object type '%s'", typename);
+        abort();
+    }
+
     object_initialize_with_type(data, size, type);
 }
=20
--=20
2.18.0.rc1.1.g3f1ff2140


