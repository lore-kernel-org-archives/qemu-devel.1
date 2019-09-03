Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF393C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 21:14:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 968B521897
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 21:14:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="V0FaXdLJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 968B521897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5G8D-00060K-52
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 17:14:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53605)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1i5FaB-0007ou-Tp
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 16:39:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1i5FaA-0000cZ-Jl
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 16:39:19 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:60264)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1i5FaA-0000c0-Aj
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 16:39:18 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x83KXlhJ062406;
 Tue, 3 Sep 2019 20:39:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=corp-2019-08-05;
 bh=7Wh3yhe6Bpe43/29d3VnRo50DQgpolFEQ9cXqoSsgFY=;
 b=V0FaXdLJwp+v5PWI7t47FSP9CgfvBMKSpyAs03PIeTonXs6hF5r6x92Fiz59QwEKvTJA
 vPfZQ9wwW6mEqmc68nDk3B+FDZRxYToaIwDFVLiMj0sJGHjSfaBlN9KQ8KoRQ2Fu/9V1
 0+GV7YJw2hD5xhkYPNmt2IFr0u8OXQZiq5D0NZhiyDwpBPxI0rwflx+u3c1o7cAvtq/H
 o8HM9MVm2ooHkhJMKEU5v8dhiRw5l3uTNVS2DnUN7kykk3fTKiLqzQxBWvbu0lh9CQcn
 hHvEca6+ZxKiqLL6TPjt97GPfMxP3KlGsf/GL5eVmCKbJTsb3RwDI7DnRoTlh84RCt6y +Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2120.oracle.com with ESMTP id 2usy66r2gu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 03 Sep 2019 20:39:11 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x83Kc9Ai025311;
 Tue, 3 Sep 2019 20:39:10 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3020.oracle.com with ESMTP id 2us5pha0jb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 03 Sep 2019 20:39:10 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x83Kd7QE017733;
 Tue, 3 Sep 2019 20:39:08 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 03 Sep 2019 13:39:07 -0700
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Date: Tue,  3 Sep 2019 16:37:54 -0400
Message-Id: <53b203319b96293b03adecc00b8d758fb4cc9c8c.1567534653.git.jag.raman@oracle.com>
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
 definitions=main-1909030206
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.85
Subject: [Qemu-devel] [RFC v3 PATCH 28/45] multi-process: Introduce build
 flags to separate remote process code
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

Introduce SCSI_PROCESS & REMOTE_PROCESS build flags to separate
code that applies only to remote processes.

Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
---
 New patch in v3

 Makefile.target | 4 ++++
 rules.mak       | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/Makefile.target b/Makefile.target
index a0c00c6..ac545fc 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -256,6 +256,10 @@ ifdef CONFIG_DARWIN
 	$(call quiet-command,SetFile -a C $@,"SETFILE","$(TARGET_DIR)$@")
 endif
 
+ifdef CONFIG_MPQEMU
+$(SCSI_DEV_BUILD): REMOTE_FLAGS = -DREMOTE_PROCESS -DSCSI_PROCESS
+endif
+
 $(SCSI_DEV_BUILD): $(all-remote-lsi-obj-y) $(COMMON_LDADDS)
 	$(call LINK, $(filter-out %.mak, $^))
 ifdef CONFIG_DARWIN
diff --git a/rules.mak b/rules.mak
index 967295d..22e0c36 100644
--- a/rules.mak
+++ b/rules.mak
@@ -67,7 +67,7 @@ expand-objs = $(strip $(sort $(filter %.o,$1)) \
 
 %.o: %.c
 	$(call quiet-command,$(CC) $(QEMU_LOCAL_INCLUDES) $(QEMU_INCLUDES) \
-	       $(QEMU_CFLAGS) $(QEMU_DGFLAGS) $(CFLAGS) $($@-cflags) \
+	       $(QEMU_CFLAGS) $(QEMU_DGFLAGS) $(CFLAGS) $($@-cflags) $(REMOTE_FLAGS) \
 	       -c -o $@ $<,"CC","$(TARGET_DIR)$@")
 %.o: %.rc
 	$(call quiet-command,$(WINDRES) -I. -o $@ $<,"RC","$(TARGET_DIR)$@")
-- 
1.8.3.1


