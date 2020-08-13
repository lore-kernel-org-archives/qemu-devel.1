Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1BF2C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 06:56:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51E1120771
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 06:56:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51E1120771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k679w-0007X7-9M
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 02:56:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60420)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1k673b-0006aR-IP
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 02:49:47 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:36419)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1k673Q-0004cv-1x
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 02:49:47 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1M734j-1k3fP934D1-008cN3; Thu, 13 Aug 2020 08:49:32 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 13/14] linux-user: Add support for btrfs ioctls used to scrub a
 filesystem
Date: Thu, 13 Aug 2020 08:49:22 +0200
Message-Id: <20200813064923.263565-14-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200813064923.263565-1-laurent@vivier.eu>
References: <20200813064923.263565-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:sJQgqB+yrFfcywyEc++7ZtyzxLgCyEK7lGk6SAgeNP0VQDgLoDl
 IiTtMWRyomXxyptlXG9fqYK4VdvQ1ysQWOX1k6U6LmMy53Rz9Ut81BPMdGbUVvX/M/0R1CS
 bW1TVSjSTeJdBQwkJSROQYn+0ZrzGVh01HRgDdQiVKE/C5ey50rt968aM9p2KqZu1O52DAv
 Gv0h1y8dhIqOnFE4pRF0g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QIy7UvtZsTQ=:PSAK6HErv2XLCfe0pKgmIR
 JbgcdkoSODPcULw528N2MNTMCO/VY9n5wlqJ6jDlnAXI2Dt3OCuWdbr0PyqXbkGQ/w7aiNUR4
 EmqcuqE3wqtoIvpA6mSkSq/Pg5z3Jyj3e0qbtSD44EtT8JpJa1cVbqpR9rwQ2q9xzNkc8A+Yk
 USSVd3bJhgYMWpPOxwCM07pBZJTNKYM45/3ThpQv1QPp1OsA9r/OgyrD/KhjRpkAkF+wG231C
 A1Ix771epWUFvKSRdafPGJU8z2AKFTkvPu4aBa9wy1sbIcnjXU7q+yEdjJJywHg74LjsXl2T7
 TzOZcNN1Idt3U0uFkKwZ8Ut+EnucVl32B6pUMkqC0SAq1WN2HGkryd/xTlMwObp4JqDorCq4C
 yoxZmSw7p1qlnOy+FH8DVCUybJzO4RsjrfuzaCReyDaqXSUhwVQJWBPlEFP6s/WkeeasQmWJ6
 4buYQg1gTyBBGYKJcC7fciOtud3Pn0nt9O5crSYw6d8AoYRHjzOJff/AVFVvNMYHNTwsAxtsr
 00g03egjOK96wRwtXVG5zEBKWRugaorZ1Fd9v6oxXa3T+vJrUo0cc2LSKYz4/37rIcgjYu2BH
 cIwcWz3d9WzqXxyArsKJxS0NPgid2Q+fAjXIgXCRWkPTIyD0wjBNi8dbVSL5NVVNdZ+Opg2Af
 JyvfSrcFPOmjAwyJcjLFDQqGv+IjOR5cMhnIFKDL/YaHrAk5kiKJiK0YYHXECrwUn9qV1UT5+
 lBpREzfYnISkkA9rekMTc7N4dBXqnTYRaOUTvKRKeNK07XINHNvsujY1ZuDPHDbiMeA7+eA/W
 PR5FVM7yIaKeOXvKWw5XaWmAcBHbUXRXmvnwG1EyM29FTRYtisAMXTCkvi1Z4Q5HBh9u6FH
Received-SPF: none client-ip=217.72.192.74; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 02:49:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Laurent Vivier <laurent@vivier.eu>, Filip Bozuta <Filip.Bozuta@syrmia.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Filip Bozuta <Filip.Bozuta@syrmia.com>

This patch implements functionality for following ioctls:

BTRFS_IOC_SCRUB - Starting a btrfs filesystem scrub

    Start a btrfs filesystem scrub. The third ioctls argument
    is a pointer to a following type:

    struct btrfs_ioctl_scrub_args {
	__u64 devid;				/* in */
	__u64 start;				/* in */
	__u64 end;				/* in */
	__u64 flags;				/* in */
	struct btrfs_scrub_progress progress;	/* out */
	/* pad to 1k */
	__u64 unused[(1024-32-sizeof(struct btrfs_scrub_progress))/8];
    };

    Before calling this ioctl, field 'devid' should be filled
    with value that represents the device id of the btrfs filesystem
    for which the scrub is to be started.

BTRFS_IOC_SCRUB_CANCEL - Canceling scrub of a btrfs filesystem

    Cancel a btrfs filesystem scrub if it is running. The third
    ioctls argument is ignored.

BTRFS_IOC_SCRUB_PROGRESS - Getting status of a running scrub

    Read the status of a running btrfs filesystem scrub. The third
    ioctls argument is a pointer to the above mentioned
    'struct btrfs_ioctl_scrub_args'. Similarly as with 'BTRFS_IOC_SCRUB',
    the 'devid' field should be filled with value that represents the
    id of the btrfs device for which the scrub has started. The status
    of a running scrub is returned in the field 'progress' which is
    of type 'struct btrfs_scrub_progress' and its definition can be
    found at:
    https://elixir.bootlin.com/linux/latest/source/include/uapi/linux/btrfs.h#L150

Implementation nots:

    Ioctls in this patch use type 'struct btrfs_ioctl_scrub_args' as their
    third argument. That is the reason why an aproppriate thunk type
    definition is added in file 'syscall_types.h'.

Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20200803094629.21898-9-Filip.Bozuta@syrmia.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/ioctls.h        | 11 +++++++++++
 linux-user/syscall_defs.h  |  3 +++
 linux-user/syscall_types.h | 27 +++++++++++++++++++++++++++
 3 files changed, 41 insertions(+)

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index 882bfb3e8854..e3bfe7877433 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
@@ -215,6 +215,17 @@
 #ifdef BTRFS_IOC_SUBVOL_SETFLAGS
      IOCTL(BTRFS_IOC_SUBVOL_SETFLAGS, IOC_W, MK_PTR(TYPE_ULONGLONG))
 #endif
+#ifdef BTRFS_IOC_SCRUB
+     IOCTL(BTRFS_IOC_SCRUB, IOC_RW,
+           MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_scrub_args)))
+#endif
+#ifdef BTRFS_IOC_SCRUB_CANCEL
+     IOCTL(BTRFS_IOC_SCRUB_CANCEL, 0, TYPE_NULL)
+#endif
+#ifdef BTRFS_IOC_SCRUB_PROGRESS
+     IOCTL(BTRFS_IOC_SCRUB_PROGRESS, IOC_RW,
+           MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_scrub_args)))
+#endif
 #ifdef BTRFS_IOC_DEV_INFO
      IOCTL(BTRFS_IOC_DEV_INFO, IOC_RW,
            MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_dev_info_args)))
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 8ae54f6946ed..d4fe0085bef4 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -987,6 +987,9 @@ struct target_rtc_pll_info {
                                                            abi_ullong)
 #define TARGET_BTRFS_IOC_SUBVOL_SETFLAGS        TARGET_IOW(BTRFS_IOCTL_MAGIC, 26,\
                                                            abi_ullong)
+#define TARGET_BTRFS_IOC_SCRUB                  TARGET_IOWRU(BTRFS_IOCTL_MAGIC, 27)
+#define TARGET_BTRFS_IOC_SCRUB_CANCEL           TARGET_IO(BTRFS_IOCTL_MAGIC, 28)
+#define TARGET_BTRFS_IOC_SCRUB_PROGRESS         TARGET_IOWRU(BTRFS_IOCTL_MAGIC, 29)
 #define TARGET_BTRFS_IOC_DEV_INFO               TARGET_IOWRU(BTRFS_IOCTL_MAGIC, 30)
 #define TARGET_BTRFS_IOC_INO_PATHS              TARGET_IOWRU(BTRFS_IOCTL_MAGIC, 35)
 #define TARGET_BTRFS_IOC_LOGICAL_INO            TARGET_IOWRU(BTRFS_IOCTL_MAGIC, 36)
diff --git a/linux-user/syscall_types.h b/linux-user/syscall_types.h
index 51743bb75237..8d4b5b3e921a 100644
--- a/linux-user/syscall_types.h
+++ b/linux-user/syscall_types.h
@@ -406,6 +406,33 @@ STRUCT(btrfs_ioctl_ino_lookup_user_args,
        MK_ARRAY(TYPE_CHAR, BTRFS_VOL_NAME_MAX + 1), /* name */
        MK_ARRAY(TYPE_CHAR, BTRFS_INO_LOOKUP_USER_PATH_MAX)) /* path */
 
+STRUCT(btrfs_scrub_progress,
+       TYPE_ULONGLONG, /* data_extents_scrubbed */
+       TYPE_ULONGLONG, /* tree_extents_scrubbed */
+       TYPE_ULONGLONG, /* data_bytes_scrubbed */
+       TYPE_ULONGLONG, /* tree_bytes_scrubbed */
+       TYPE_ULONGLONG, /* read_errors */
+       TYPE_ULONGLONG, /* csum_errors */
+       TYPE_ULONGLONG, /* verify_errors */
+       TYPE_ULONGLONG, /* no_csum */
+       TYPE_ULONGLONG, /* csum_discards */
+       TYPE_ULONGLONG, /* super_errors */
+       TYPE_ULONGLONG, /* malloc_errors */
+       TYPE_ULONGLONG, /* uncorrectable_errors */
+       TYPE_ULONGLONG, /* corrected_er */
+       TYPE_ULONGLONG, /* last_physical */
+       TYPE_ULONGLONG) /* unverified_errors */
+
+STRUCT(btrfs_ioctl_scrub_args,
+       TYPE_ULONGLONG, /* devid */
+       TYPE_ULONGLONG, /* start */
+       TYPE_ULONGLONG, /* end */
+       TYPE_ULONGLONG, /* flags */
+       MK_STRUCT(STRUCT_btrfs_scrub_progress), /* progress */
+       MK_ARRAY(TYPE_ULONGLONG,
+                (1024 - 32 -
+                 sizeof(struct btrfs_scrub_progress)) / 8)) /* unused */
+
 STRUCT(btrfs_ioctl_dev_info_args,
        TYPE_ULONGLONG, /* devid */
        MK_ARRAY(TYPE_CHAR, BTRFS_UUID_SIZE), /* uuid */
-- 
2.26.2


