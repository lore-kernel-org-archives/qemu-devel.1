Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE436C2D0EF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 18:49:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CF9420936
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 18:49:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="FmAcCsfs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CF9420936
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPW3p-0005GS-Ko
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 14:49:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57059)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <osandov@osandov.com>) id 1jPW2y-0003yi-0G
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 14:49:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <osandov@osandov.com>) id 1jPW2w-0001SR-MM
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 14:49:03 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632]:39360)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <osandov@osandov.com>) id 1jPW2w-0001Qo-Fm
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 14:49:02 -0400
Received: by mail-pl1-x632.google.com with SMTP id k18so1284276pll.6
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2020 11:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=osandov-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=DlNMpF2CMpqeTP2iekn92c+9jpUi7a1OMI+kSZWpYVM=;
 b=FmAcCsfssTVy/6B6h9bQmP0/X7fKXkMGL5s0b6QNRYEgIKnM2mnXviQLPjPzMzxZkv
 RRGgQgut/zZuad59e1HhxrlV+8CEEqc4lD4G0r9taOUCjY+Ho5vFlLYXbVL8N/YMoLmf
 ZCD1iCGNywiL54lNG7yB2f9Nh/2k69uhKPTe2bQTjW25VNMnHCVE/X1TuJAqstZAaf8m
 fNl0b18fVppfOsYDC+B1tDr+iFgJCpE/6x5YAO2a3MqNGJEiCoM7AXL2jucFxVojXya/
 MQ3dHhwnOi5tB01ZpOzRpY7gJU1AfSPPm1ccDYxyUMnjtsMRfzmoJBdATxtYrGvYe9bb
 rOSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=DlNMpF2CMpqeTP2iekn92c+9jpUi7a1OMI+kSZWpYVM=;
 b=mgckI/bpJ3CElQwLrHF0wZkcvgf/feLL4FczFnCPqF514+WKiXixZRStWIdSdtJdDi
 okuK3TsNbFnEAE7LWX28fgzmMj01/hdaKQR4j9DJmts/IAUXNvWas6vThidKSy+hbHZP
 ULU5MpFtRUTjNspkcywgKkfJLL323epvY36rFtU7j/2xAbLBz11aDgCkhLGZb9vO2vX7
 LQP7GAWuueNZRgEpgHowzgPQkaAKAhnfKFiRqhPI8szNZIPf7/TobJv+Fc/h2Hr/yHS6
 3vgcSXymOfPtYR6//yC4TtQoynVJhuWpiNXX3Q2BJ4PBhmMWLSimBSzL38te1Anc2Ckx
 pamw==
X-Gm-Message-State: AGi0PuZPk2bcb8HIE0OyaiTreJk82jvIaLelD0O+f0MXvf9Rd3VGvPub
 yaY3X55UuXnwvfVBwIm6+mflqXVfjJ8=
X-Google-Smtp-Source: APiQypIv8WETmEXuCrNbbIhSYBFdIlhv5m8cMUJppkzqxZh5T1rR3mCm/iVn1tOlXXwuJW46BsQFrA==
X-Received: by 2002:a17:902:8b82:: with SMTP id
 ay2mr4961733plb.285.1587149340917; 
 Fri, 17 Apr 2020 11:49:00 -0700 (PDT)
Received: from vader.tfbnw.net ([2620:10d:c090:400::5:82d8])
 by smtp.gmail.com with ESMTPSA id ml24sm5908747pjb.48.2020.04.17.11.48.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2020 11:48:57 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: Greg Kurz <groug@kaod.org>, Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: [PATCH v2] 9pfs: local: ignore O_NOATIME if we don't have permissions
Date: Fri, 17 Apr 2020 11:48:24 -0700
Message-Id: <e9bee604e8df528584693a4ec474ded6295ce8ad.1587149256.git.osandov@fb.com>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::632
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Omar Sandoval <osandov@fb.com>

QEMU's local 9pfs server passes through O_NOATIME from the client. If
the QEMU process doesn't have permissions to use O_NOATIME (namely, it
does not own the file nor have the CAP_FOWNER capability), the open will
fail. This causes issues when from the client's point of view, it
believes it has permissions to use O_NOATIME (e.g., a process running as
root in the virtual machine). Additionally, overlayfs on Linux opens
files on the lower layer using O_NOATIME, so in this case a 9pfs mount
can't be used as a lower layer for overlayfs (cf.
https://github.com/osandov/drgn/blob/dabfe1971951701da13863dbe6d8a1d172ad9650/vmtest/onoatimehack.c
and https://github.com/NixOS/nixpkgs/issues/54509).

Luckily, O_NOATIME is effectively a hint, and is often ignored by, e.g.,
network filesystems. open(2) notes that O_NOATIME "may not be effective
on all filesystems. One example is NFS, where the server maintains the
access time." This means that we can honor it when possible but fall
back to ignoring it.

Acked-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
Changes from v1:

* Add comment
* Add Christian's acked-by

 hw/9pfs/9p-util.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/hw/9pfs/9p-util.h b/hw/9pfs/9p-util.h
index 79ed6b233e..546f46dc7d 100644
--- a/hw/9pfs/9p-util.h
+++ b/hw/9pfs/9p-util.h
@@ -37,9 +37,22 @@ static inline int openat_file(int dirfd, const char *name, int flags,
 {
     int fd, serrno, ret;
 
+again:
     fd = openat(dirfd, name, flags | O_NOFOLLOW | O_NOCTTY | O_NONBLOCK,
                 mode);
     if (fd == -1) {
+        if (errno == EPERM && (flags & O_NOATIME)) {
+            /*
+             * The client passed O_NOATIME but we lack permissions to honor it.
+             * Rather than failing the open, fall back without O_NOATIME. This
+             * doesn't break the semantics on the client side, as the Linux
+             * open(2) man page notes that O_NOATIME "may not be effective on
+             * all filesystems". In particular, NFS and other network
+             * filesystems ignore it entirely.
+             */
+            flags &= ~O_NOATIME;
+            goto again;
+        }
         return -1;
     }
 
-- 
2.26.1


