Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E8F5C32771
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 19:14:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7774F207E0
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 19:14:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7774F207E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iro7N-0000Rp-TI
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 14:14:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34171)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Filip.Bozuta@rt-rk.com>) id 1iro5T-0006vq-2u
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 14:12:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Filip.Bozuta@rt-rk.com>) id 1iro5P-0002s6-Se
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 14:12:18 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:53839 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Filip.Bozuta@rt-rk.com>)
 id 1iro5P-0002qz-Lm
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 14:12:15 -0500
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 6FF611A21BB;
 Wed, 15 Jan 2020 20:12:10 +0100 (CET)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw493-lin.domain.local (rtrkw493-lin.domain.local
 [10.10.14.93])
 by mail.rt-rk.com (Postfix) with ESMTPSA id E8F2B1A21D3;
 Wed, 15 Jan 2020 20:12:09 +0100 (CET)
From: Filip Bozuta <Filip.Bozuta@rt-rk.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 08/13] linux-user: Add support for setting alsa timer
 enhanced read using ioctl
Date: Wed, 15 Jan 2020 20:11:58 +0100
Message-Id: <1579115523-4159-9-git-send-email-Filip.Bozuta@rt-rk.com>
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

This patch implements functionality of following ioctl:

SNDRV_TIMER_IOCTL_TREAD - Setting enhanced time read

    Sets enhanced time read which is used for reading time with timestamps
    and events. The third ioctl's argument is a pointer to an 'int'. Enhanced
    reading is set if the third argument is different than 0, otherwise normal
    time reading is set.

Implementation notes:

    Because the implemented ioctl has 'int' as its third argument, the
    implementation was straightforward.

Signed-off-by: Filip Bozuta <Filip.Bozuta@rt-rk.com>
---
 linux-user/ioctls.h       | 1 +
 linux-user/syscall_defs.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index ed1bd4c..9106773 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
@@ -452,6 +452,7 @@
   IOCTL(SNDRV_TIMER_IOCTL_PVERSION, IOC_R, MK_PTR(TYPE_INT))
   IOCTL(SNDRV_TIMER_IOCTL_NEXT_DEVICE, IOC_RW,
         MK_PTR(MK_STRUCT(STRUCT_snd_timer_id)))
+  IOCTL(SNDRV_TIMER_IOCTL_TREAD, IOC_W, MK_PTR(TYPE_INT))
 
   IOCTL(HDIO_GETGEO, IOC_R, MK_PTR(MK_STRUCT(STRUCT_hd_geometry)))
   IOCTL(HDIO_GET_UNMASKINTR, IOC_R, MK_PTR(TYPE_INT))
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 7ceb6f8..0971623 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -2429,6 +2429,7 @@ struct target_statfs64 {
 #define TARGET_SNDRV_TIMER_IOCTL_PVERSION     TARGET_IOR('T', 0x00, int)
 #define TARGET_SNDRV_TIMER_IOCTL_NEXT_DEVICE  TARGET_IOWR('T', 0x01,           \
                                                 struct snd_timer_id)
+#define TARGET_SNDRV_TIMER_IOCTL_TREAD        TARGET_IOW('T', 0x02, int)
 
 /* vfat ioctls */
 #define TARGET_VFAT_IOCTL_READDIR_BOTH    TARGET_IORU('r', 1)
-- 
2.7.4


