Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8806C282DD
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 13:06:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD6E12067D
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 13:06:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD6E12067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipXWC-0000x1-Iw
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 08:06:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36518)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Filip.Bozuta@rt-rk.com>) id 1ipXQc-0003JR-Rg
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 08:00:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Filip.Bozuta@rt-rk.com>) id 1ipXQa-00038c-HY
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 08:00:46 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:42117 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Filip.Bozuta@rt-rk.com>)
 id 1ipXQY-000353-II
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 08:00:43 -0500
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 1F8761A2142;
 Thu,  9 Jan 2020 13:59:34 +0100 (CET)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw493-lin.domain.local (rtrkw493-lin.domain.local
 [10.10.14.93])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 0233B1A20DC;
 Thu,  9 Jan 2020 13:59:33 +0100 (CET)
From: Filip Bozuta <Filip.Bozuta@rt-rk.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 07/12] linux-user: Add support for getting alsa timer version
 and id
Date: Thu,  9 Jan 2020 13:59:18 +0100
Message-Id: <1578574763-8327-8-git-send-email-Filip.Bozuta@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1578574763-8327-1-git-send-email-Filip.Bozuta@rt-rk.com>
References: <1578574763-8327-1-git-send-email-Filip.Bozuta@rt-rk.com>
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
Cc: riku.voipio@iki.fi, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch implements functionalities of following ioctls:

SNDRV_TIMER_IOCTL_PVERSION - Getting the sound timer version

    Read the sound timer version. The third ioctl's argument is
    a pointer to an int in which the specified timers version
    is returned.

SNDRV_TIMER_IOCTL_NEXT_DEVICE - Getting id information about next timer

    Read id information about the next timer device from the sound timer
    device list. The id infomration is returned in the following structure:

        struct snd_timer_id {
            int dev_class;    /* timer device class number */
            int dev_sclass;   /* slave device class number (unused) */
            int card;         /* card number */
            int device;       /* device number */
            int subdevice;    /* sub-device number */
        };

    The devices in the sound timer device list are arranged by the fields
    of this structure respectively (first by dev_class number, then by
    card number, ...). A pointer to this structure should be passed as
    the third ioctl's argument. Before calling the ioctl, the parameters
    of this structure should be initialized in relation to the next timer
    device which information is to be obtained. For example, if a wanted
    timer device has the device class number equal to or bigger then 2,
    the field dev_class should be initialized to 2. After the ioctl call,
    the structure fields are filled with values from the next device in
    the sound timer device list. If there is no next device in the list,
    then the structure is filled with "zero" id values (in that case all
    fields are filled with value -1).

Implementation notes:

    The ioctl 'SNDRV_TIMER_IOCTL_NEXT_DEVICE' has a pointer to a
    'struct snd_timer_id' as its third argument. That is the reason why
    corresponding definition is added in 'linux-user/syscall_types.h'.
    Since all elements of this structure are of type 'int', the rest of
    the implementation is straightforward.

    The line '#include <linux/rtc.h>' was added to recognize
    preprocessor definitions for these ioctls. This needs to be
    done only once in this series of commits. Also, the content
    of this file (with respect to ioctl definitions) remained
    unchanged for a long time, therefore there is no need to
    worry about supporting older Linux kernel version.

Signed-off-by: Filip Bozuta <Filip.Bozuta@rt-rk.com>
---
 linux-user/ioctls.h        | 4 ++++
 linux-user/syscall.c       | 1 +
 linux-user/syscall_defs.h  | 5 +++++
 linux-user/syscall_types.h | 7 +++++++
 4 files changed, 17 insertions(+)

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index 1f1f3e6..ed1bd4c 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
@@ -449,6 +449,10 @@
   IOCTL(SOUND_MIXER_WRITE_LOUD, IOC_W, MK_PTR(TYPE_INT))
   IOCTL(SOUND_MIXER_WRITE_RECSRC, IOC_W, MK_PTR(TYPE_INT))
 
+  IOCTL(SNDRV_TIMER_IOCTL_PVERSION, IOC_R, MK_PTR(TYPE_INT))
+  IOCTL(SNDRV_TIMER_IOCTL_NEXT_DEVICE, IOC_RW,
+        MK_PTR(MK_STRUCT(STRUCT_snd_timer_id)))
+
   IOCTL(HDIO_GETGEO, IOC_R, MK_PTR(MK_STRUCT(STRUCT_hd_geometry)))
   IOCTL(HDIO_GET_UNMASKINTR, IOC_R, MK_PTR(TYPE_INT))
   IOCTL(HDIO_GET_MULTCOUNT, IOC_R, MK_PTR(TYPE_INT))
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 74c3c08..a3993a2 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -108,6 +108,7 @@
 #include <linux/netlink.h>
 #include <linux/if_alg.h>
 #include <linux/rtc.h>
+#include <sound/asound.h>
 #include "linux_loop.h"
 #include "uname.h"
 
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index af4f366..7409021 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -2425,6 +2425,11 @@ struct target_statfs64 {
 
 #define TARGET_SOUND_MIXER_WRITE_RECSRC	TARGET_MIXER_WRITE(SOUND_MIXER_RECSRC)
 
+/* alsa timer ioctls */
+#define TARGET_SNDRV_TIMER_IOCTL_PVERSION     TARGET_IOR('T', 0x00, int)
+#define TARGET_SNDRV_TIMER_IOCTL_NEXT_DEVICE  TARGET_IOWR('T', 0x01,                     \
+                                                          struct snd_timer_id)
+
 /* vfat ioctls */
 #define TARGET_VFAT_IOCTL_READDIR_BOTH    TARGET_IORU('r', 1)
 #define TARGET_VFAT_IOCTL_READDIR_SHORT   TARGET_IORU('r', 2)
diff --git a/linux-user/syscall_types.h b/linux-user/syscall_types.h
index 4027272..2f4cd78 100644
--- a/linux-user/syscall_types.h
+++ b/linux-user/syscall_types.h
@@ -83,6 +83,13 @@ STRUCT(buffmem_desc,
 STRUCT(mixer_info,
        MK_ARRAY(TYPE_CHAR, 16), MK_ARRAY(TYPE_CHAR, 32), TYPE_INT, MK_ARRAY(TYPE_INT, 10))
 
+STRUCT(snd_timer_id,
+       TYPE_INT, /* dev_class */
+       TYPE_INT, /* dev_sclass */
+       TYPE_INT, /* card */
+       TYPE_INT, /* device */
+       TYPE_INT) /* subdevice */
+
 /* loop device ioctls */
 STRUCT(loop_info,
        TYPE_INT,                 /* lo_number */
-- 
2.7.4


