Return-Path: <SRS0=3HrQ=6A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE84C38A2C
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 00:57:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7ABA9208E0
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 00:57:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="T3FGgCkL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ABA9208E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOsqD-0001Q8-I0
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 20:57:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34528)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <osandov@osandov.com>) id 1jOse3-0007gw-BT
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 20:44:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <osandov@osandov.com>) id 1jOse2-0002pj-6v
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 20:44:43 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:40113)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <osandov@osandov.com>) id 1jOse1-0002p2-Sr
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 20:44:42 -0400
Received: by mail-pl1-x644.google.com with SMTP id t16so699717plo.7
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2020 17:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=osandov-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=qzd4XYaICaQ5TW+Z8DNktVSgGmrCpL5J0yEg78IQNzk=;
 b=T3FGgCkLP/O/+NY5SzW9ZfDbBUamTsOWPXNZDAdZ+AnV+TwVpjIXXC5CqvaCe+UPDi
 jw6y6k0Dr119+via/B2HM8GhTSjq0VFNW1QabFVndeo3WiEjSKVBmKscVQCkYqBREfZi
 rqzVicsh6F4uzJvNFrH2/+HgGJMb5ZoPJHAyNS5Gd5fQMMUopdMjf+5oqNb5rJv4Zuaq
 jtc/+bcB0odbRB21QYJF/f+6tFe1S+yVDyGFFEO5da3DwgTjPEZwg5OZAOkR2jPUY18I
 yVa1tK5k+7G9YsUtbCSoa0SolGgPj7sfkMHkOXleiM1YZwsgfckChvmdYNGz0y8zKz7u
 b+ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=qzd4XYaICaQ5TW+Z8DNktVSgGmrCpL5J0yEg78IQNzk=;
 b=lrZOLMrUXYT+OQjs+lVkvbTrJb8LgbZWSEQZ00pMR75Tp5HjtZRMoaY4w+Wy9Fkpsv
 fHYJhirLThCW3FR3rppIK/cUwzRmvDSo97fbD+gYxlmd10YuLjZ1kh4ojwjPi6tWAeyy
 kaFdfN1NhtEN8OHJYxfwsTSZr4X7PlE4U/qjZNERh6FxdaLiu4riAVcds+HFqjDhEATW
 wW2kxJyoUiKS9tvsf1Hbdvl49x1attV8EoOg/9QkKA4pyJZ2CUnkWkK22NT2ZIDG4pwN
 JUnx7iq2CxYv1gnszXGDhqILxS8yZw1USjWnUrsNAKHkXcMFTVqpAYm1m7peQ7zpw4E2
 auKA==
X-Gm-Message-State: AGi0PuaZ6BIdEaYI21AK2MbV5fWdRzZwJpGuveWZgzsza/LRTxrIieKE
 ApihJIWEzvN/SEJp4HHjfoExeg+es3E=
X-Google-Smtp-Source: APiQypLPoHnAuPglVQGEYyJ3dyY07sWFqxlOolOKLRPmeKCwb5Sgy00h1IeJpQSYnrRm2Wzz6tLaCQ==
X-Received: by 2002:a17:902:8643:: with SMTP id
 y3mr7337921plt.149.1586997880163; 
 Wed, 15 Apr 2020 17:44:40 -0700 (PDT)
Received: from vader.tfbnw.net ([2620:10d:c090:400::5:b0c6])
 by smtp.gmail.com with ESMTPSA id f30sm739675pje.29.2020.04.15.17.44.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2020 17:44:39 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: Greg Kurz <groug@kaod.org>, Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: [PATCH] 9pfs: local: ignore O_NOATIME if we don't have permissions
Date: Wed, 15 Apr 2020 17:44:33 -0700
Message-Id: <1e65cffe9778857735e7ae6066d6f0df0b0e2db3.1586997767.git.osandov@fb.com>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
X-Mailman-Approved-At: Wed, 15 Apr 2020 20:56:44 -0400
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

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 hw/9pfs/9p-util.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/9pfs/9p-util.h b/hw/9pfs/9p-util.h
index 79ed6b233e..50842d540f 100644
--- a/hw/9pfs/9p-util.h
+++ b/hw/9pfs/9p-util.h
@@ -37,9 +37,14 @@ static inline int openat_file(int dirfd, const char *name, int flags,
 {
     int fd, serrno, ret;
 
+again:
     fd = openat(dirfd, name, flags | O_NOFOLLOW | O_NOCTTY | O_NONBLOCK,
                 mode);
     if (fd == -1) {
+        if (errno == EPERM && (flags & O_NOATIME)) {
+            flags &= ~O_NOATIME;
+            goto again;
+        }
         return -1;
     }
 
-- 
2.26.1


