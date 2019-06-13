Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73595C31E49
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 16:52:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F00D2175B
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 16:52:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F00D2175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41788 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbSy5-0006RS-W5
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 12:52:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60010)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hbRku-0000aP-NQ
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 11:35:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hbRkt-0003XJ-60
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 11:35:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33028)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hbRko-0003J3-JP; Thu, 13 Jun 2019 11:35:06 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0DA4822387D;
 Thu, 13 Jun 2019 15:34:52 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-116-246.ams2.redhat.com
 [10.36.116.246])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D9DD26108C;
 Thu, 13 Jun 2019 15:34:47 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 13 Jun 2019 17:33:58 +0200
Message-Id: <20190613153405.24769-9-kwolf@redhat.com>
In-Reply-To: <20190613153405.24769-1-kwolf@redhat.com>
References: <20190613153405.24769-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Thu, 13 Jun 2019 15:34:56 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 08/15] monitor: Move {hmp,
 qmp}.c to monitor/{hmp, qmp}-cmds.c
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
Cc: kwolf@redhat.com, berrange@redhat.com, qemu-block@nongnu.org,
 armbru@redhat.com, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now that we have a monitor/ subdirectory, let's move hmp.c and qmp.c
from the root directory there. As they contain implementations of
monitor commands, rename them to {hmp,qmp}-cmds.c, so that {hmp,qmp}.c
are free for the HMP and QMP infrastructure.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 docs/devel/writing-qmp-commands.txt | 9 +++++----
 hmp.c =3D> monitor/hmp-cmds.c         | 2 +-
 qmp.c =3D> monitor/qmp-cmds.c         | 2 +-
 MAINTAINERS                         | 5 +++--
 Makefile.objs                       | 2 +-
 monitor/Makefile.objs               | 1 +
 6 files changed, 12 insertions(+), 9 deletions(-)
 rename hmp.c =3D> monitor/hmp-cmds.c (99%)
 rename qmp.c =3D> monitor/qmp-cmds.c (99%)

diff --git a/docs/devel/writing-qmp-commands.txt b/docs/devel/writing-qmp=
-commands.txt
index cc6ecd6d5d..46a6c48683 100644
--- a/docs/devel/writing-qmp-commands.txt
+++ b/docs/devel/writing-qmp-commands.txt
@@ -20,7 +20,7 @@ new QMP command.
=20
 2. Write the QMP command itself, which is a regular C function. Preferab=
ly,
    the command should be exported by some QEMU subsystem. But it can als=
o be
-   added to the qmp.c file
+   added to the monitor/qmp-cmds.c file
=20
 3. At this point the command can be tested under the QMP protocol
=20
@@ -101,7 +101,8 @@ protocol data.
=20
 The next step is to write the "hello-world" implementation. As explained
 earlier, it's preferable for commands to live in QEMU subsystems. But
-"hello-world" doesn't pertain to any, so we put its implementation in qm=
p.c:
+"hello-world" doesn't pertain to any, so we put its implementation in
+monitor/qmp-cmds.c:
=20
 void qmp_hello_world(Error **errp)
 {
@@ -146,7 +147,7 @@ for mandatory arguments). Finally, 'str' is the argum=
ent's type, which
 stands for "string". The QAPI also supports integers, booleans, enumerat=
ions
 and user defined types.
=20
-Now, let's update our C implementation in qmp.c:
+Now, let's update our C implementation in monitor/qmp-cmds.c:
=20
 void qmp_hello_world(bool has_message, const char *message, Error **errp=
)
 {
@@ -267,7 +268,7 @@ monitor (HMP).
=20
 With the introduction of the QAPI, HMP commands make QMP calls. Most of =
the
 time HMP commands are simple wrappers. All HMP commands implementation e=
xist in
-the hmp.c file.
+the monitor/hmp-cmds.c file.
=20
 Here's the implementation of the "hello-world" HMP command:
=20
diff --git a/hmp.c b/monitor/hmp-cmds.c
similarity index 99%
rename from hmp.c
rename to monitor/hmp-cmds.c
index 99414cd39c..712737cd18 100644
--- a/hmp.c
+++ b/monitor/hmp-cmds.c
@@ -1,5 +1,5 @@
 /*
- * Human Monitor Interface
+ * Human Monitor Interface commands
  *
  * Copyright IBM, Corp. 2011
  *
diff --git a/qmp.c b/monitor/qmp-cmds.c
similarity index 99%
rename from qmp.c
rename to monitor/qmp-cmds.c
index 6797568444..f1b1e4f08b 100644
--- a/qmp.c
+++ b/monitor/qmp-cmds.c
@@ -1,5 +1,5 @@
 /*
- * QEMU Management Protocol
+ * QEMU Management Protocol commands
  *
  * Copyright IBM, Corp. 2011
  *
diff --git a/MAINTAINERS b/MAINTAINERS
index 231964c1da..884f4b16bb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1917,7 +1917,8 @@ Human Monitor (HMP)
 M: Dr. David Alan Gilbert <dgilbert@redhat.com>
 S: Maintained
 F: monitor/misc.c
-F: hmp.[ch]
+F: monitor/hmp*
+F: hmp.h
 F: hmp-commands*.hx
 F: include/monitor/hmp-target.h
 F: tests/test-hmp.c
@@ -2037,7 +2038,7 @@ F: tests/check-qom-proplist.c
 QMP
 M: Markus Armbruster <armbru@redhat.com>
 S: Supported
-F: qmp.c
+F: monitor/qmp*
 F: monitor/misc.c
 F: docs/devel/*qmp-*
 F: docs/interop/*qmp-*
diff --git a/Makefile.objs b/Makefile.objs
index dd39a70b48..9495fcbc7e 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -83,8 +83,8 @@ common-obj-$(CONFIG_FDT) +=3D device_tree.o
 ######################################################################
 # qapi
=20
-common-obj-y +=3D qmp.o hmp.o
 common-obj-y +=3D qapi/
+common-obj-y +=3D monitor/
 endif
=20
 #######################################################################
diff --git a/monitor/Makefile.objs b/monitor/Makefile.objs
index e783b0616b..a7170af6e1 100644
--- a/monitor/Makefile.objs
+++ b/monitor/Makefile.objs
@@ -1 +1,2 @@
 obj-y +=3D misc.o
+common-obj-y +=3D qmp-cmds.o hmp-cmds.o
--=20
2.20.1


