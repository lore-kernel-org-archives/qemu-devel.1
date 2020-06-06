Return-Path: <SRS0=faK4=7T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFFCCC433E1
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 13:23:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C543C206DC
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 13:23:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C543C206DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhYmz-0001Nd-0D
	for qemu-devel@archiver.kernel.org; Sat, 06 Jun 2020 09:23:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39038)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jhYgT-00078Z-Lb
 for qemu-devel@nongnu.org; Sat, 06 Jun 2020 09:16:25 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:50593)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jhYgR-0007es-ET
 for qemu-devel@nongnu.org; Sat, 06 Jun 2020 09:16:25 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MUY5o-1jYrXC2vMu-00QPQM; Sat, 06 Jun 2020 15:16:14 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v2 06/19] linux-user: implement OFD locks
Date: Sat,  6 Jun 2020 15:15:54 +0200
Message-Id: <20200606131607.1250819-7-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200606131607.1250819-1-laurent@vivier.eu>
References: <20200606131607.1250819-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:BYn4zGr7uIuxM6JoSVqH3Eo2qGskmQRusG6ttdwoYfnGF9DvBR5
 99j/xqQmlMjUNOvbX2no6gMQM8Dy7VNUOCHvNuzxVVAnZAm2fn7AlWwtqacX9SSRJZ1lXsi
 GDE4K4Lzg5f1tAOwftaKiUxRMiq0YPZ3X5EBLwuWm1x+k1Zbmb76aQ2AT0k1cUalB/a7Rr6
 eOWC0liWaHDuiHl2lPgtA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7r44l3UW59g=:ZQeHtNmVezgTQbv65jocmK
 jVxPcEpMHcOlx2vDveBjV4numjLEZW+VDGtqdNOIPfxFna6HNudSoQf9hFp/Urlp6VCX0sABr
 gBiVhFPzKk9rKvYpUF3cv1NBVAXMoYUIzmoyw8f95e6U7PVtIrdC8IEPvI9T5jdDxWojmONBR
 S83yiPxJbrxXuIFU4D1KUV1ziZJ+gPBK6BAtvuFa3Qb6hSXCHBJS2MA8QGdGpPOVFgFdQc2yB
 XHT1agQlhXXKRjcBP5rdDa4fJTvFw3d6J0hSYG7FvCSmkn36PuDyWpHjHZdsHFo84tSCvs0a7
 pgqOLt+BxPJf9XTEOXAtvKCXB5W1zoxtiwLh2yrJ+1Cr82RoiTFfaP00WeiReKGABLkD96MRj
 sO38g3OUYbWytnhqYv/8rG+WaxIKvn1ZysmyPZqTygfdrbOtJhBXMXzImCqAnPwxU+B4yMz+u
 B6IU7g2UVCIygb38RVdtQ8kkEOcx2XRmvuY/bVKA025MstR0MSPobjooDY1xuLgALgHb9LW3q
 gY0V5BZByn4fZNfPDS4A1qNkKlhVGjI0PG50MBHjmQ7+w+QJHn/a4U/xAy1OeMpiiV1Yk/MUm
 q2Aj/XJO9ZRz/TMhrYCySgZFSod7PbsjAMe1lWsE3IE6+gJxNPKqGlwgZQVR0EONpggQ20WAr
 07YnAg0tuf4jaZ5dzTPxgXEA1hFH0q+bNDp+A/iPGNkO/hl9FCQKOYI17ElVk8ThCDpKQFj8I
 XU5n7t2jZmlKjeMwZbtcLS8dUkfqqm2bVyOQhUXiAwgeTYnKZ3RdvVKcfH7+FVYVtzHEbf3pc
 JLXIxK1LWnKqs6J43RtMEtIIZY+6i2ONeoScELMG0AVPxJJ5e2OXi0p62/GbaCtyX6+LQVF
Received-SPF: none client-ip=212.227.126.187; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/06 09:16:17
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
index 9ac3af20c176..2d8125fa53c6 100644
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


