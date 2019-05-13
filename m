Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32BE9C04AB1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 09:22:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03E2721479
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 09:22:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03E2721479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53885 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQ79x-0002Uz-8s
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 05:22:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <schwab@suse.de>) id 1hQ78d-0001Vs-F8
	for qemu-devel@nongnu.org; Mon, 13 May 2019 05:20:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <schwab@suse.de>) id 1hQ6uh-0000zx-L4
	for qemu-devel@nongnu.org; Mon, 13 May 2019 05:06:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:39380 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <schwab@suse.de>) id 1hQ6uh-0000zS-F9
	for qemu-devel@nongnu.org; Mon, 13 May 2019 05:06:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
	by mx1.suse.de (Postfix) with ESMTP id 93A07AECD;
	Mon, 13 May 2019 09:06:26 +0000 (UTC)
From: Andreas Schwab <schwab@suse.de>
To: qemu-devel@nongnu.org
X-Yow: Edwin Meese made me wear CORDOVANS!!
Date: Mon, 13 May 2019 11:06:26 +0200
Message-ID: <mvmlfzaoh9p.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
	timestamps) [generic]
X-Received-From: 195.135.220.15
Subject: [Qemu-devel] [PATCH] linux-user: implement getsockopt SO_RCVTIMEO
 and SO_SNDTIMEO
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Andreas Schwab <schwab@suse.de>
---
 linux-user/syscall.c | 36 ++++++++++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index d113a65831..ba5775a94e 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -2171,10 +2171,42 @@ static abi_long do_getsockopt(int sockfd, int level, int optname,
         level = SOL_SOCKET;
         switch (optname) {
         /* These don't just return a single integer */
-        case TARGET_SO_RCVTIMEO:
-        case TARGET_SO_SNDTIMEO:
         case TARGET_SO_PEERNAME:
             goto unimplemented;
+        case TARGET_SO_RCVTIMEO: {
+            struct timeval tv;
+            socklen_t tvlen;
+
+            optname = SO_RCVTIMEO;
+
+get_timeout:
+            if (get_user_u32(len, optlen)) {
+                return -TARGET_EFAULT;
+            }
+            if (len < 0) {
+                return -TARGET_EINVAL;
+            }
+
+            tvlen = sizeof(tv);
+            ret = get_errno(getsockopt(sockfd, level, optname,
+                                       &tv, &tvlen));
+            if (ret < 0) {
+                return ret;
+            }
+            if (len > sizeof(struct target_timeval)) {
+                len = sizeof(struct target_timeval);
+            }
+            if (copy_to_user_timeval(optval_addr, &tv)) {
+                return -TARGET_EFAULT;
+            }
+            if (put_user_u32(len, optlen)) {
+                return -TARGET_EFAULT;
+            }
+            break;
+        }
+        case TARGET_SO_SNDTIMEO:
+            optname = SO_SNDTIMEO;
+            goto get_timeout;
         case TARGET_SO_PEERCRED: {
             struct ucred cr;
             socklen_t crlen;
-- 
2.21.0


-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."

