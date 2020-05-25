Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE27CC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 08:02:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1474207DA
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 08:02:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1474207DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jd83i-00086y-Pd
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 04:02:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37686)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <schwab@suse.de>) id 1jd81I-0005vc-Cl
 for qemu-devel@nongnu.org; Mon, 25 May 2020 03:59:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:44638)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <schwab@suse.de>) id 1jd81H-0006zg-B3
 for qemu-devel@nongnu.org; Mon, 25 May 2020 03:59:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 45717ABEC;
 Mon, 25 May 2020 07:59:32 +0000 (UTC)
From: Andreas Schwab <schwab@suse.de>
To: qemu-devel@nongnu.org
Subject: [PATCH] linux-user: implement OFD locks
X-Yow: That's a decision that can only be made between you & SY SPERLING!!
Date: Mon, 25 May 2020 09:59:28 +0200
Message-ID: <mvm7dx0cun3.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=195.135.220.15; envelope-from=schwab@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/25 01:03:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: riku.voipio@iki.fi, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Andreas Schwab <schwab@suse.de>
---
 linux-user/generic/fcntl.h | 4 ++++
 linux-user/syscall.c       | 6 ++++++
 2 files changed, 10 insertions(+)

diff --git a/linux-user/generic/fcntl.h b/linux-user/generic/fcntl.h
index 9f727d4df2..c85c5b9fed 100644
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
index 7eac6b7d47..492450e77d 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -6097,6 +6097,9 @@ static int target_to_host_fcntl_cmd(int cmd)
     case TARGET_F_SETFD:
     case TARGET_F_GETFL:
     case TARGET_F_SETFL:
+    case TARGET_F_OFD_GETLK:
+    case TARGET_F_OFD_SETLK:
+    case TARGET_F_OFD_SETLKW:
         ret = cmd;
         break;
     case TARGET_F_GETLK:
@@ -6382,6 +6385,7 @@ static abi_long do_fcntl(int fd, int cmd, abi_ulong arg)
         break;
 
     case TARGET_F_GETLK64:
+    case TARGET_F_OFD_GETLK:
         ret = copy_from_user_flock64(&fl64, arg);
         if (ret) {
             return ret;
@@ -6393,6 +6397,8 @@ static abi_long do_fcntl(int fd, int cmd, abi_ulong arg)
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


-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."

