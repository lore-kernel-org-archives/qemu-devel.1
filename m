Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A08C32771
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 19:24:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03BA820728
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 19:24:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03BA820728
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iroGr-0006af-Lm
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 14:24:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34246)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Filip.Bozuta@rt-rk.com>) id 1iro5b-00077Q-1o
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 14:12:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Filip.Bozuta@rt-rk.com>) id 1iro5Z-00030g-Sc
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 14:12:26 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:53843 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Filip.Bozuta@rt-rk.com>)
 id 1iro5Z-0002rA-Lv
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 14:12:25 -0500
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id A43871A21BC;
 Wed, 15 Jan 2020 20:12:10 +0100 (CET)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw493-lin.domain.local (rtrkw493-lin.domain.local
 [10.10.14.93])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 376FC1A21FF;
 Wed, 15 Jan 2020 20:12:10 +0100 (CET)
From: Filip Bozuta <Filip.Bozuta@rt-rk.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 13/13] linux-user: Add support for TYPE_LONG and TYPE_ULONG
 in do_ioctl()
Date: Wed, 15 Jan 2020 20:12:03 +0100
Message-Id: <1579115523-4159-14-git-send-email-Filip.Bozuta@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1579115523-4159-1-git-send-email-Filip.Bozuta@rt-rk.com>
References: <1579115523-4159-1-git-send-email-Filip.Bozuta@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 89.216.37.149
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
Cc: peter.maydell@linaro.org, berrange@redhat.com, arnd@arndb.de,
 richard.henderson@linaro.org, laurent@vivier.eu, jcmvbkbc@gmail.com,
 amarkovic@wavecomp.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Function "do_ioctl()" located in file "syscall.c" was missing
an option for TYPE_LONG and TYPE_ULONG. This caused some ioctls
to not be recognised because they had the third argument that was
of type 'long' or 'unsigned long'.

For example:

Since implemented ioctls RTC_IRQP_SET and RTC_EPOCH_SET
are of type IOW(writing type) that have unsigned long as
their third argument, they were not recognised in QEMU
before the changes of this patch.

Signed-off-by: Filip Bozuta <Filip.Bozuta@rt-rk.com>
---
 linux-user/syscall.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index a3993a2..2ba2c5c 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -5176,6 +5176,8 @@ static abi_long do_ioctl(int fd, int cmd, abi_long arg)
         break;
     case TYPE_PTRVOID:
     case TYPE_INT:
+    case TYPE_LONG:
+    case TYPE_ULONG:
         ret = get_errno(safe_ioctl(fd, ie->host_cmd, arg));
         break;
     case TYPE_PTR:
-- 
2.7.4


