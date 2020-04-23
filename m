Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF364C55191
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 04:20:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DC972087E
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 04:20:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nJUQGGwC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DC972087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRTLT-0000EV-MR
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 00:20:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49352)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1jRTGE-0008Pp-Q5
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 00:14:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1jRTG6-0006Vi-9e
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 00:14:50 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:38630)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1jRTG5-0006U0-Ms
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 00:14:41 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03N4D8Br052357;
 Thu, 23 Apr 2020 04:14:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=Zv0fyL99R1UsFGCTMrkgtdNF4qpuM5u8ypOXrcG1Vbo=;
 b=nJUQGGwCjizYgSiTLxRE/wnQud6/l42BruKE2csEipbq+jP/ckDs+I2UdfGAFiz+s3NH
 +lxTiZ84MM2x74RknDF5IrbHxZTc6NqGu1oox3A32EEf+QvwCF1g98L98XE1Tx0SpUpZ
 0GBtzAJmrKI7dXGo1sugJUadY5yQbbf9XDAvNPhTLqJI2lfQl+rjLEl0IfO5HOjxFC3M
 aFNg0mhaewSUpX/3X3gOWE0ZiqfKJdNEsEjiLcx9GFhrli0f5CzO1QnPpK3CxY5aZXuX
 sXnmbmHb3/GwBBAeIaewav0GZx026CbwYKY+dgjABa+vWcFH9KE84OGJoLYfYQ33S3+Y Ew== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2120.oracle.com with ESMTP id 30jhyc541u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Apr 2020 04:14:34 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03N4CJCE089372;
 Thu, 23 Apr 2020 04:14:34 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3030.oracle.com with ESMTP id 30gb1ku7jj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Apr 2020 04:14:34 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 03N4EWV8020161;
 Thu, 23 Apr 2020 04:14:32 GMT
Received: from flaka.hsd1.ca.comcast.net (/67.180.143.163)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 22 Apr 2020 21:14:32 -0700
From: elena.ufimtseva@oracle.com
To: qemu-devel@nongnu.org
Subject: [PATCH RESEND v6 07/36] multi-process: add a command line option for
 debug file
Date: Wed, 22 Apr 2020 21:13:42 -0700
Message-Id: <98c95420dd062f7870d0803ddb7533a582fd5c74.1587614626.git.elena.ufimtseva@oracle.com>
X-Mailer: git-send-email 2.25.GIT
In-Reply-To: <cover.1587614626.git.elena.ufimtseva@oracle.com>
References: <cover.1587614626.git.elena.ufimtseva@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9599
 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 suspectscore=1 spamscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004230027
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9599
 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 spamscore=0 mlxscore=0
 clxscore=1015 suspectscore=1 phishscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004230027
Received-SPF: pass client-ip=156.151.31.85;
 envelope-from=elena.ufimtseva@oracle.com; helo=userp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 00:14:40
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.85
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, swapnil.ingle@nutanix.com,
 john.g.johnson@oracle.com, kraxel@redhat.com, jag.raman@oracle.com,
 quintela@redhat.com, mst@redhat.com, armbru@redhat.com,
 kanth.ghatraju@oracle.com, felipe@nutanix.com, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, dgilbert@redhat.com,
 liran.alon@oracle.com, stefanha@redhat.com, thanos.makatos@nutanix.com,
 rth@twiddle.net, kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Elena Ufimtseva <elena.ufimtseva@oracle.com>

Can be used with -d rdebug command options when starting qemu.

Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/qemu/log.h | 1 +
 util/log.c         | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/include/qemu/log.h b/include/qemu/log.h
index f4724f7330..a039ddb61a 100644
--- a/include/qemu/log.h
+++ b/include/qemu/log.h
@@ -64,6 +64,7 @@ static inline bool qemu_log_separate(void)
 #define CPU_LOG_PLUGIN     (1 << 18)
 /* LOG_STRACE is used for user-mode strace logging. */
 #define LOG_STRACE         (1 << 19)
+#define LOG_REMOTE_DEBUG   (1 << 20)
 
 /* Lock output for a series of related logs.  Since this is not needed
  * for a single qemu_log / qemu_log_mask / qemu_log_mask_and_addr, we
diff --git a/util/log.c b/util/log.c
index 2da6cb31dc..1f90e70cdd 100644
--- a/util/log.c
+++ b/util/log.c
@@ -334,6 +334,8 @@ const QEMULogItem qemu_log_items[] = {
 #endif
     { LOG_STRACE, "strace",
       "log every user-mode syscall, its input, and its result" },
+    { LOG_REMOTE_DEBUG, "rdebug",
+      "log remote debug" },
     { 0, NULL, NULL },
 };
 
-- 
2.25.GIT


