Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 550A4C43613
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 20:13:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33BAD208CB
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 20:13:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33BAD208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41670 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdgxE-0006Qk-FY
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 16:13:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35296)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hdgv7-0004JI-6Z
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 16:11:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hdgv5-00017X-Mt
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 16:11:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33922)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hdgv4-00014M-2u
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 16:10:59 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7B0B18112C
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2019 20:10:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-85.ams2.redhat.com
 [10.36.116.85])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 195C060142;
 Wed, 19 Jun 2019 20:10:55 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 082CC1136436; Wed, 19 Jun 2019 22:10:51 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 19 Jun 2019 22:10:48 +0200
Message-Id: <20190619201050.19040-16-armbru@redhat.com>
In-Reply-To: <20190619201050.19040-1-armbru@redhat.com>
References: <20190619201050.19040-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Wed, 19 Jun 2019 20:10:56 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 15/17] dump: Move the code to dump/
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
Cc: kwolf@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 MAINTAINERS                   | 2 +-
 Makefile.target               | 3 +--
 dump/Makefile.objs            | 2 ++
 dump.c =3D> dump/dump.c         | 0
 win_dump.c =3D> dump/win_dump.c | 0
 win_dump.h =3D> dump/win_dump.h | 0
 6 files changed, 4 insertions(+), 3 deletions(-)
 create mode 100644 dump/Makefile.objs
 rename dump.c =3D> dump/dump.c (100%)
 rename win_dump.c =3D> dump/win_dump.c (100%)
 rename win_dump.h =3D> dump/win_dump.h (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index ea110e99ca..a3fdda015f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1850,7 +1850,7 @@ F: include/sysemu/device_tree.h
 Dump
 S: Supported
 M: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
-F: dump.c
+F: dump/dump.c
 F: hw/misc/vmcoreinfo.c
 F: include/hw/misc/vmcoreinfo.h
 F: include/sysemu/dump-arch.h
diff --git a/Makefile.target b/Makefile.target
index 167ae2174e..a6919e0caf 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -150,13 +150,12 @@ endif #CONFIG_BSD_USER
 ifdef CONFIG_SOFTMMU
 obj-y +=3D arch_init.o cpus.o gdbstub.o balloon.o ioport.o
 obj-y +=3D qtest.o
+obj-y +=3D dump/
 obj-y +=3D hw/
 obj-y +=3D monitor/
 obj-y +=3D qapi/
 obj-y +=3D memory.o
 obj-y +=3D memory_mapping.o
-obj-y +=3D dump.o
-obj-$(TARGET_X86_64) +=3D win_dump.o
 obj-y +=3D migration/ram.o
 LIBS :=3D $(libs_softmmu) $(LIBS)
=20
diff --git a/dump/Makefile.objs b/dump/Makefile.objs
new file mode 100644
index 0000000000..ea6b074967
--- /dev/null
+++ b/dump/Makefile.objs
@@ -0,0 +1,2 @@
+obj-y +=3D dump.o
+obj-$(TARGET_X86_64) +=3D win_dump.o
diff --git a/dump.c b/dump/dump.c
similarity index 100%
rename from dump.c
rename to dump/dump.c
diff --git a/win_dump.c b/dump/win_dump.c
similarity index 100%
rename from win_dump.c
rename to dump/win_dump.c
diff --git a/win_dump.h b/dump/win_dump.h
similarity index 100%
rename from win_dump.h
rename to dump/win_dump.h
--=20
2.21.0


