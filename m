Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D981C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 21:22:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22347204EC
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 21:22:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DA1PNa94"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22347204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5GFZ-0003tz-Oe
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 17:22:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53750)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1i5FaS-00089G-P4
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 16:39:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1i5FaR-0000r6-5L
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 16:39:36 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:57712)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1i5FaQ-0000qK-V2
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 16:39:35 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x83KdS91058074;
 Tue, 3 Sep 2019 20:39:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=corp-2019-08-05;
 bh=YXMntpdnHucR0S0HJkiG0v5fei/qZsExEcUB/3nWg8s=;
 b=DA1PNa94fDVFIaCAJuW5gU8QslIBPmwqs33Y8wA3bF2IA8uvjaX7XXXKIUrfwOeOgG0C
 Czw1HCFm538aTkEc6ZPSMK0DzmS/Gqht/elOMoS30Uw0iOeBs4HDS6RYJwgnZN0z6aZ+
 aUqVSCDKl9rFxIK/Rh3g5QNefrrsIeWdT0796xRpknedJPesEgxjBp9BqeoNWO4r0Dhk
 0E0Ke75n7DmGp2ZY/Hbr4fGzSXgTTxmm5kJKZDIo32e68SH9stoSL4COj72p63UOfznP
 4yEwV2PhEvoTn4Ph++wJswWE+nPXyrBYzL7Bdl4oaMSjUAPrriNDWz43+cTyKQSDxUx5 +g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by aserp2120.oracle.com with ESMTP id 2usy6n022e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 03 Sep 2019 20:39:28 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x83KcbDm178418;
 Tue, 3 Sep 2019 20:39:27 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3020.oracle.com with ESMTP id 2us4wegren-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 03 Sep 2019 20:39:27 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x83KdQK9012895;
 Tue, 3 Sep 2019 20:39:26 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 03 Sep 2019 13:39:25 -0700
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Date: Tue,  3 Sep 2019 16:38:05 -0400
Message-Id: <3b6822d87f65f1d6e52c22094dd646f7dae13ce0.1567534653.git.jag.raman@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1567534653.git.jag.raman@oracle.com>
References: <cover.1567534653.git.jag.raman@oracle.com>
In-Reply-To: <cover.1567534653.git.jag.raman@oracle.com>
References: <cover.1567534653.git.jag.raman@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9369
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909030207
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9369
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909030207
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 141.146.126.78
Subject: [Qemu-devel] [RFC v3 PATCH 39/45] multi-process/mon: build system
 for QMP module in remote process
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, john.g.johnson@oracle.com,
 kraxel@redhat.com, jag.raman@oracle.com, quintela@redhat.com, mst@redhat.com,
 armbru@redhat.com, kanth.ghatraju@oracle.com, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, dgilbert@redhat.com,
 liran.alon@oracle.com, stefanha@redhat.com, rth@twiddle.net, kwolf@redhat.com,
 berrange@redhat.com, mreitz@redhat.com, ross.lagerwall@citrix.com,
 marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Makefile changes necessary to compile QMP module for the remote process

Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
---
 New patch in v3

 Makefile.objs         |  7 +++++++
 Makefile.target       | 20 +++++++++++++++++++-
 hw/core/Makefile.objs |  1 +
 monitor/Makefile.objs |  3 +++
 qapi/Makefile.objs    |  2 ++
 qom/Makefile.objs     |  1 +
 ui/Makefile.objs      |  2 ++
 7 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/Makefile.objs b/Makefile.objs
index f817cf6..04af900 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -30,6 +30,7 @@ remote-pci-obj-$(CONFIG_MPQEMU) += backends/
 remote-pci-obj-$(CONFIG_MPQEMU) += block/
 remote-pci-obj-$(CONFIG_MPQEMU) += migration/
 remote-pci-obj-$(CONFIG_MPQEMU) += remote/
+remote-pci-obj-$(CONFIG_MPQEMU) += monitor/
 
 remote-pci-obj-$(CONFIG_MPQEMU) += cpus-common.o
 remote-pci-obj-$(CONFIG_MPQEMU) += dma-helpers.o
@@ -42,6 +43,7 @@ remote-pci-obj-$(CONFIG_MPQEMU) += iothread.o
 # remote-lsi-obj-y is code used to implement remote LSI device
 
 remote-lsi-obj-$(CONFIG_MPQEMU) += hw/
+remote-lsi-obj-$(CONFIG_MPQEMU) += ui/
 
 #######################################################################
 # crypto-obj-y is code used by both qemu system emulation and qemu-img
@@ -112,6 +114,11 @@ common-obj-y += vl-parse.o
 common-obj-y += qapi/
 endif
 
+remote-pci-obj-$(CONFIG_MPQEMU) += qapi/
+remote-pci-obj-$(CONFIG_MPQEMU) += blockdev-nbd.o
+remote-pci-obj-$(CONFIG_MPQEMU) += job-qmp.o
+remote-pci-obj-$(CONFIG_MPQEMU) += balloon.o
+
 #######################################################################
 # Target-independent parts used in system and user emulation
 common-obj-y += cpus-common.o
diff --git a/Makefile.target b/Makefile.target
index ac545fc..0ca832f 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -135,11 +135,29 @@ remote-pci-tgt-obj-$(CONFIG_MPQEMU) += accel/stubs/hax-stub.o
 remote-pci-tgt-obj-$(CONFIG_MPQEMU) += accel/stubs/whpx-stub.o
 remote-pci-tgt-obj-$(CONFIG_MPQEMU) += stubs/vl-stub.o
 remote-pci-tgt-obj-$(CONFIG_MPQEMU) += stubs/net-stub.o
-remote-pci-tgt-obj-$(CONFIG_MPQEMU) += stubs/monitor.o
 remote-pci-tgt-obj-$(CONFIG_MPQEMU) += stubs/replay.o
 remote-pci-tgt-obj-$(CONFIG_MPQEMU) += stubs/xen-mapcache.o
+remote-pci-tgt-obj-$(CONFIG_MPQEMU) += stubs/migration.o
+remote-pci-tgt-obj-$(CONFIG_MPQEMU) += stubs/ui-stub.o
+remote-pci-tgt-obj-$(CONFIG_MPQEMU) += stubs/gdbstub.o
+remote-pci-tgt-obj-$(CONFIG_MPQEMU) += stubs/qapi-target.o
+remote-pci-tgt-obj-$(CONFIG_MPQEMU) += stubs/qapi-misc.o
 
 remote-pci-tgt-obj-$(CONFIG_MPQEMU) += remote/memory.o
+remote-pci-tgt-obj-$(CONFIG_MPQEMU) += arch_init.o
+remote-pci-tgt-obj-$(CONFIG_MPQEMU) += monitor/misc.o
+
+remote-pci-tgt-obj-$(CONFIG_MPQEMU) += qapi/qapi-introspect.o
+remote-pci-tgt-obj-$(CONFIG_MPQEMU) += qapi/qapi-commands-block-core.o
+remote-pci-tgt-obj-$(CONFIG_MPQEMU) += qapi/qapi-commands-block.o
+remote-pci-tgt-obj-$(CONFIG_MPQEMU) += qapi/qapi-commands-misc.o
+remote-pci-tgt-obj-$(CONFIG_MPQEMU) += qapi/qapi-commands.o
+remote-pci-tgt-obj-$(CONFIG_MPQEMU) += qapi/qapi-commands-machine-target.o
+remote-pci-tgt-obj-$(CONFIG_MPQEMU) += qapi/qapi-commands-misc-target.o
+remote-pci-tgt-obj-$(CONFIG_MPQEMU) += qapi/qapi-visit-machine-target.o
+remote-pci-tgt-obj-$(CONFIG_MPQEMU) += qapi/qapi-visit-misc-target.o
+remote-pci-tgt-obj-$(CONFIG_MPQEMU) += qapi/qapi-types-machine-target.o
+remote-pci-tgt-obj-$(CONFIG_MPQEMU) += qapi/qapi-types-misc-target.o
 
 #########################################################
 # Linux user emulator target
diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
index 0229f4b..d2c5658 100644
--- a/hw/core/Makefile.objs
+++ b/hw/core/Makefile.objs
@@ -42,3 +42,4 @@ remote-pci-obj-$(CONFIG_MPQEMU) += nmi.o
 remote-pci-obj-$(CONFIG_MPQEMU) += qdev-properties-system.o
 remote-pci-obj-$(CONFIG_MPQEMU) += qdev-fw.o
 remote-pci-obj-$(CONFIG_MPQEMU) += numa.o
+remote-pci-obj-$(CONFIG_MPQEMU) += machine-qmp-cmds.o
diff --git a/monitor/Makefile.objs b/monitor/Makefile.objs
index e91a858..11c42ec 100644
--- a/monitor/Makefile.objs
+++ b/monitor/Makefile.objs
@@ -1,3 +1,6 @@
 obj-y += misc.o
 common-obj-y += monitor.o qmp.o hmp.o
 common-obj-y += qmp-cmds.o hmp-cmds.o
+
+remote-pci-obj-$(CONFIG_MPQEMU) += monitor.o qmp.o hmp.o
+remote-pci-obj-$(CONFIG_MPQEMU) += qmp-cmds.o hmp-cmds.o
diff --git a/qapi/Makefile.objs b/qapi/Makefile.objs
index c5a29e8..972bdb2 100644
--- a/qapi/Makefile.objs
+++ b/qapi/Makefile.objs
@@ -30,3 +30,5 @@ obj-y += $(QAPI_TARGET_MODULES:%=qapi-events-%.o)
 obj-y += qapi-events.o
 obj-y += $(QAPI_TARGET_MODULES:%=qapi-commands-%.o)
 obj-y += qapi-commands.o
+
+remote-pci-obj-$(CONFIG_MPQEMU) += $(QAPI_COMMON_MODULES:%=qapi-commands-%.o)
diff --git a/qom/Makefile.objs b/qom/Makefile.objs
index 05da824..e42ea7a 100644
--- a/qom/Makefile.objs
+++ b/qom/Makefile.objs
@@ -7,3 +7,4 @@ common-obj-$(CONFIG_SOFTMMU) += qom-hmp-cmds.o qom-qmp-cmds.o
 remote-pci-obj-$(CONFIG_MPQEMU) += object.o qom-qobject.o container.o
 remote-pci-obj-$(CONFIG_MPQEMU) += object_interfaces.o
 remote-pci-obj-$(CONFIG_MPQEMU) += cpu.o
+remote-pci-obj-$(CONFIG_MPQEMU) += qom-qmp-cmds.o
diff --git a/ui/Makefile.objs b/ui/Makefile.objs
index cc2bf5b..7b5219d 100644
--- a/ui/Makefile.objs
+++ b/ui/Makefile.objs
@@ -65,3 +65,5 @@ console-gl.o-libs += $(OPENGL_LIBS)
 egl-helpers.o-libs += $(OPENGL_LIBS)
 egl-context.o-libs += $(OPENGL_LIBS)
 egl-headless.o-libs += $(OPENGL_LIBS)
+
+remote-lsi-obj-$(CONFIG_MPQEMU) += vnc-stubs.o
-- 
1.8.3.1


