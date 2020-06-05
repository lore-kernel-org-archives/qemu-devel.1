Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D66C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 11:52:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CDBC2070B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 11:52:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CDBC2070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhAtP-0000Gz-N7
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 07:52:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54840)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jhAoi-0008HN-Oo
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 07:47:20 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:39505)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jhAoh-0006ip-18
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 07:47:20 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MGhds-1jkyQI0Mmw-00DoPN; Fri, 05 Jun 2020 13:47:08 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 06/19] linux-user: implement OFD locks
Date: Fri,  5 Jun 2020 13:46:47 +0200
Message-Id: <20200605114700.1052050-7-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200605114700.1052050-1-laurent@vivier.eu>
References: <20200605114700.1052050-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:vkFt+5HVP+GXJ1RSohT/ydQFJAnHvmtqpph0SGnYR62YJqfg418
 o8qrK19SuuJTnaPJnAg8DJG7uoYafxty9DyJu0DNMnRECLOuTDinkxbw+208uBitCXcddRc
 zzc8kqDtCCSq530rqH7HKJwaVjQ3Szj9eCAfuOwzyRz0xHbkve9Z/ChuqxrJj83Zn38qSiN
 uWAXsj62FrD9IMeVGCviA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qMiX3Kl+18U=:lwfMqII+xn3RRboMbV4/hq
 xYARZUQg3rxpo7cv/qOLZMzucnPDhJXWl1EFiaEve8mapYLjvn3GrOuvdPNKY3dJGb+XYMdtq
 0dvHmoFFcXzcBA7oUhU1RS1/Fe0NwOufjvcM78CacpqJvJhllom6RRzwLmNJnl5eYvuefdk8E
 y15lxkQE7AhIrNUZdIm8PVUsoVTKLZYJNdgABYGpUnmpmof0AsIZY1fu7wAxtq/4+5tnDdjHn
 43im3wEfUZbLj6W2swHojtfSUn92Lh3jrgVmN8ceOz5N7zYYxxwLBQ7RyREBBfCmtQdRMW06v
 McqwHHS95An3WyA2Toy2C5rzgrFREdRvUS07ZGp16P7e/ve9+pKN0Y0V8pns5ZgFzRX6QD9zO
 bhcEjFbQYuC/iATIvHEwy3SGtK9+OffF1DRk/vi95Ic7E7IC+XUbEB2PcLMeJDLx+rwwJW5qO
 cw8EHnolw8KNy5QyoH8J7mTROr2KVXfri61rY1NK5MXo9CvNZ0vbF+cWYxdutZQJVDZ9t6TAt
 GGxksolAjWS3Z3JwS8Nd7CREtnT4AIDnT3K+U43x+nSgVM4irS7XVBGZKxmUnp8MeD5e/9743
 +lGXCjzvXLexigCkiuEryt7qvGfQhpXjRw6Q9Xy9BvBkz4VNokNjgAByizidjv0tt4AEBEQMJ
 n5+aZAdc4OeeOfMUc8KQoSSf8JTkN0l9ATfmCfMVoEAN+Rnp96sS9UhCI2qBdQqkjB8KM/UdR
 4/iszbEOPulzSmiZVn/09EV1R2+1sQR/Y82NlTVHqb9yG3gtiPzK64srKcwiTvzr+yAszkgg8
 GPjh1fhd7vohIe9BtHIorOvDyzL250MslvaeJUNyuAmPUANhOjHsriUwrjQjbJVT2hzwinF
Received-SPF: none client-ip=217.72.192.74; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 07:47:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Andreas Schwab <schwab@suse.de>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Andreas Schwab <schwab@suse.de>

Signed-off-by: Andreas Schwab <schwab@suse.de>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <mvm7dx0cun3.fsf@suse.de>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/generic/fcntl.h | 4 ++++
 linux-user/syscall.c       | 6 ++++++
 2 files changed, 10 insertions(+)

diff --git a/linux-user/generic/fcntl.h b/linux-user/generic/fcntl.h
index 9f727d4df2c8..c85c5b9fed65 100644
--- a/linux-user/generic/fcntl.h
+++ b/linux-user/generic/fcntl.h
@@ -99,6 +99,10 @@
 #define TARGET_F_SETLKW64      14
 #endif
 
+#define TARGET_F_OFD_GETLK     36
+#define TARGET_F_OFD_SETLK     37
+#define TARGET_F_OFD_SETLKW    38
+
 #ifndef TARGET_F_SETOWN_EX
 #define TARGET_F_SETOWN_EX     15
 #define TARGET_F_GETOWN_EX     16
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 63c40c48e31f..1cf638208201 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -6098,6 +6098,9 @@ static int target_to_host_fcntl_cmd(int cmd)
     case TARGET_F_SETFD:
     case TARGET_F_GETFL:
     case TARGET_F_SETFL:
+    case TARGET_F_OFD_GETLK:
+    case TARGET_F_OFD_SETLK:
+    case TARGET_F_OFD_SETLKW:
         ret = cmd;
         break;
     case TARGET_F_GETLK:
@@ -6383,6 +6386,7 @@ static abi_long do_fcntl(int fd, int cmd, abi_ulong arg)
         break;
 
     case TARGET_F_GETLK64:
+    case TARGET_F_OFD_GETLK:
         ret = copy_from_user_flock64(&fl64, arg);
         if (ret) {
             return ret;
@@ -6394,6 +6398,8 @@ static abi_long do_fcntl(int fd, int cmd, abi_ulong arg)
         break;
     case TARGET_F_SETLK64:
     case TARGET_F_SETLKW64:
+    case TARGET_F_OFD_SETLK:
+    case TARGET_F_OFD_SETLKW:
         ret = copy_from_user_flock64(&fl64, arg);
         if (ret) {
             return ret;
-- 
2.26.2


