Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A409C18E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 11:33:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F44E20719
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 11:33:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F+QLlWXH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F44E20719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEAT4-0002s2-Bp
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 07:33:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35019)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <linus.walleij@linaro.org>) id 1jEAS1-0002QX-GT
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:32:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <linus.walleij@linaro.org>) id 1jEARz-0008W2-Rl
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:32:01 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:34341)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <linus.walleij@linaro.org>)
 id 1jEARz-0008DR-GI
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:31:59 -0400
Received: by mail-lj1-x242.google.com with SMTP id s13so22388985ljm.1
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 04:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=WmJlBqTMa5CmdiFIToGjODDNiC8IWRj11NilEIEtQyE=;
 b=F+QLlWXHueXk9FIie+nFx5HGLWeGdYJkP1o+weY4/OE7tGYvjaycevNwN888rlgn8/
 nTLBUXpuzAe/IDou25ef/q2vc4WvRwwug6YUdLnhfXfZVDS8027fcl7ELowhrgXoSEtY
 KB/HU3ypUqaJZR6sLIjBk22EL59kT6FsLYCgoS79hCVnV/7uXK3bACbOAImWiQ5zfDmV
 OlqVjFhQ0dUs97Wu5f1FzjrVVB4iciokJnoUKu5vXptLshhJeBCg7P7kDhQ349KTiC7w
 /97l8ecM3Q9N+M80A4VduEj/zPXxW7kDiUmHHsoK/FaHIwVXsqo7l7hu1VHHRoZeT6xI
 r3Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=WmJlBqTMa5CmdiFIToGjODDNiC8IWRj11NilEIEtQyE=;
 b=pjwsuP8AlwCCkxI0SXI3z3Ghutanq/6rqqeCrZuLfUp9mQ90Idoa7uJtIximfNTw+x
 8ENDUwbdpUnTDvvyImi6KwYUVjCB0H2KEFnYuK8dfckvzvnSYZyVRGahKh5aLxNNHCAr
 vOeaIUC51VsA+zBlgj2ZDfKjF2R+0rmqKQvrNVEvszcGcL+RDce57/HOV3/JrXR0wWk0
 J2oox2F+zPbuN2KXWo3Uf/7CfAnEForVajIFflw743+kcN80h8DopBMBKb2/HOzPQu6O
 WwyxpAl6vfGJEd2IFxSUCyTvX+Xcpwzt92IjTvnFrQQEw7/oSfCBBKDWksEt/oFe8lvj
 7s8w==
X-Gm-Message-State: ANhLgQ1U7IhX6VIuBDYZ1ZUQC0pg9rbb4unIE0a5s/94XiPDq1c8vBKw
 EhSWnGlk+9tIRHmtrtmM60xZtg==
X-Google-Smtp-Source: ADFU+vuUA0PtGuRfrupcVqALAoBlNnXdvyHxT7lgi1sZxyelUn5XW7P+x0jA+NKEwgdlYgklvWkvNA==
X-Received: by 2002:a2e:9804:: with SMTP id a4mr500667ljj.180.1584444717157;
 Tue, 17 Mar 2020 04:31:57 -0700 (PDT)
Received: from genomnajs.ideon.se ([85.235.10.227])
 by smtp.gmail.com with ESMTPSA id a18sm2105691ljn.85.2020.03.17.04.31.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2020 04:31:56 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
To: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>
Subject: [PATCH] ext4: Give 32bit personalities 32bit hashes
Date: Tue, 17 Mar 2020 12:31:53 +0100
Message-Id: <20200317113153.7945-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::242
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
Cc: Peter Maydell <peter.maydell@linaro.org>, linux-api@vger.kernel.org,
 Linus Walleij <linus.walleij@linaro.org>, qemu-devel@nongnu.org,
 stable@vger.kernel.org, Florian Weimer <fw@deneb.enyo.de>,
 Andy Lutomirski <luto@kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It was brought to my attention that this bug from 2018 was
still unresolved: 32 bit emulators like QEMU were given
64 bit hashes when running 32 bit emulation on 64 bit systems.

The personality(2) system call supports to let processes
indicate that they are 32 bit Linux to the kernel. This
was suggested by Teo in the original thread, so I just wired
it up and it solves the problem.

Programs that need the 32 bit hash only need to issue the
personality(PER_LINUX32) call and things start working.

I made a test program like this:

  #include <dirent.h>
  #include <errno.h>
  #include <stdio.h>
  #include <string.h>
  #include <sys/types.h>
  #include <sys/personality.h>

  int main(int argc, char** argv) {
    DIR* dir;
    personality(PER_LINUX32);
    dir = opendir("/boot");
    printf("dir=%p\n", dir);
    printf("readdir(dir)=%p\n", readdir(dir));
    printf("errno=%d: %s\n", errno, strerror(errno));
    return 0;
  }

This was compiled with an ARM32 toolchain from Bootlin using
glibc 2.28 and thus suffering from the bug.

Before the patch:

  $ ./readdir-bug
  dir=0x86000
  readdir(dir)=(nil)
  errno=75: Value too large for defined data type

After the patch:

  $ ./readdir-bug
  dir=0x86000
  readdir(dir)=0x86020
  errno=0: Success

Problem solved.

Cc: Florian Weimer <fw@deneb.enyo.de>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: stable@vger.kernel.org
Suggested-by: Theodore Ts'o <tytso@mit.edu>
Link: https://bugs.launchpad.net/qemu/+bug/1805913
Link: https://lore.kernel.org/lkml/87bm56vqg4.fsf@mid.deneb.enyo.de/
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=205957
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 fs/ext4/dir.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/ext4/dir.c b/fs/ext4/dir.c
index 9aa1f75409b0..3faf9edf3e92 100644
--- a/fs/ext4/dir.c
+++ b/fs/ext4/dir.c
@@ -27,6 +27,7 @@
 #include <linux/slab.h>
 #include <linux/iversion.h>
 #include <linux/unicode.h>
+#include <linux/personality.h>
 #include "ext4.h"
 #include "xattr.h"
 
@@ -618,6 +619,14 @@ static int ext4_dx_readdir(struct file *file, struct dir_context *ctx)
 
 static int ext4_dir_open(struct inode * inode, struct file * filp)
 {
+	/*
+	 * If we are currently running e.g. a 32 bit emulator on
+	 * a 64 bit machine, the emulator will indicate that it needs
+	 * a 32 bit personality and thus 32 bit hashes from the file
+	 * system.
+	 */
+	if (personality(current->personality) == PER_LINUX32)
+		filp->f_mode |= FMODE_32BITHASH;
 	if (IS_ENCRYPTED(inode))
 		return fscrypt_get_encryption_info(inode) ? -EACCES : 0;
 	return 0;
-- 
2.24.1


