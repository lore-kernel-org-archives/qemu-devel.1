Return-Path: <SRS0=t3yw=6Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8041C3A5A9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2020 16:55:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C00A206B8
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2020 16:55:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LXEP2+/j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C00A206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUvQ0-0002aD-HE
	for qemu-devel@archiver.kernel.org; Sat, 02 May 2020 12:55:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43316)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <johnnymarler@gmail.com>)
 id 1jUukr-000648-S9
 for qemu-devel@nongnu.org; Sat, 02 May 2020 12:12:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <johnnymarler@gmail.com>) id 1jUukr-0000GZ-5n
 for qemu-devel@nongnu.org; Sat, 02 May 2020 12:12:41 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:43262)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <johnnymarler@gmail.com>)
 id 1jUukq-0000Dq-PR
 for qemu-devel@nongnu.org; Sat, 02 May 2020 12:12:40 -0400
Received: by mail-pg1-x544.google.com with SMTP id l12so3289123pgr.10
 for <qemu-devel@nongnu.org>; Sat, 02 May 2020 09:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=JLBfF7zcpENReJw9X1q5i9CqjijuEZErdvXJe3QU2rU=;
 b=LXEP2+/jyIIHn4yzxA/ltiOWwbz24/4uqbuFMwd+6nXpth+9L8A6tSG6h2DNJzgxT5
 6mXf0hIVP7nucYpKXilKwfoXsJPgKmNcibZOY13qYeWGWD5eX6YqzSdNTfKwRb+5Vz5A
 M6gO9Bkg1Dew3mY8m1RGuu9CjlzAIzbW9bFJpnjQJsF63G3uMlss9vXV48zkyGWHML9I
 SMbmDLa4CqAf2DUYFcwJ1uPnr5HsG+3e3WeQ1vwPbFkEsL39341LRJ79Zi7yKbY0nrky
 JxfyWIXDMqXOuLaewpPguFEqvVGkH9IeU2lSNqTWy5OgKSEqs+aDPKDXVleY2uZeyQh5
 XCtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=JLBfF7zcpENReJw9X1q5i9CqjijuEZErdvXJe3QU2rU=;
 b=aoyZywE4I8gd2oQB+7RRwOdDYQsBEeL4T50nOQlNZmswlP/zkdrg57w49MxKTawgco
 ui92LLxQwoEF90Ug0ezCrScnHHQSDlcQWXh2UT1IE76Bzndgdg2cmZyCecFRQ+wgkqco
 qM7+sl+nSz/U1dqwvzhLRfH8NXIvkF+PMXiec6YH4DYKHtHhoB/EVnGJpuvJBDE5XLDG
 aGh6iRIGUjktVnuMfbSpe5T6Ozzw3GEF8G39ZQGxLIykOSIz2i7r9pFO7G6m8ilYzL2z
 9LKtuiAEUcfIelzubLWMyVQrobS3LqqhK8wblKuYb/MUm4It9N2FuBCrT4UEsWopeY1j
 6bZg==
X-Gm-Message-State: AGi0PuYj7pQUApIFezwi8SHVoLGsWk0pk6YnTbLk4xpknDwTr8YbFdCD
 MOi3JPs1xy7h4b+it6+egbvk4KiNLQzW3+4h
X-Google-Smtp-Source: APiQypImDf+TdZl/sSLTn4POU1LEo9bj/sDcHg737bVbGe959z82HXYm7LFFAByDHrPsPlyAWhRugA==
X-Received: by 2002:a63:4c9:: with SMTP id 192mr9468736pge.207.1588435958952; 
 Sat, 02 May 2020 09:12:38 -0700 (PDT)
Received: from localhost.localdomain (96-19-96-19-192-232.cpe.sparklight.net.
 [96.19.192.232])
 by smtp.gmail.com with ESMTPSA id l1sm2428699pjr.17.2020.05.02.09.12.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 May 2020 09:12:38 -0700 (PDT)
From: Jonathan Marler <johnnymarler@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] linux-user/mmap.c: fix integer underflow in target_mremap
Date: Sat,  2 May 2020 10:12:25 -0600
Message-Id: <20200502161225.14346-1-johnnymarler@gmail.com>
X-Mailer: git-send-email 2.23.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=johnnymarler@gmail.com; helo=mail-pg1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::544
X-Mailman-Approved-At: Sat, 02 May 2020 12:52:16 -0400
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
Cc: Jonathan Marler <johnnymarler@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fixes: https://bugs.launchpad.net/bugs/1876373

This code path in mmap occurs when a page size is decreased with mremap.  When a section of pages is shrunk, qemu calls mmap_reserve on the pages that were released.  However, it has the diff operation reversed, subtracting the larger old_size from the smaller new_size.  Instead, it should be subtracting the smaller new_size from the larger old_size.  You can also see in the previous line of the change that this mmap_reserve call only occurs when old_size > new_size.

Signed-off-by: Jonathan Marler <johnnymarler@gmail.com>
---
 linux-user/mmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index e378033797..caab62909e 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -708,7 +708,7 @@ abi_long target_mremap(abi_ulong old_addr, abi_ulong old_size,
         if (prot == 0) {
             host_addr = mremap(g2h(old_addr), old_size, new_size, flags);
             if (host_addr != MAP_FAILED && reserved_va && old_size > new_size) {
-                mmap_reserve(old_addr + old_size, new_size - old_size);
+                mmap_reserve(old_addr + old_size, old_size - new_size);
             }
         } else {
             errno = ENOMEM;
-- 
2.23.1


