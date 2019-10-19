Return-Path: <SRS0=F+Q9=YM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 367DCCA9EAC
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 15:39:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02DA72082C
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 15:39:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pNAwN7yy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02DA72082C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLqpB-0002C1-GX
	for qemu-devel@archiver.kernel.org; Sat, 19 Oct 2019 11:39:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47452)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLqkk-0005EW-Mf
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 11:34:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLqkj-0002uX-NY
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 11:34:50 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:52804)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLqkj-0002u4-IA
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 11:34:49 -0400
Received: by mail-wm1-x32e.google.com with SMTP id r19so8997295wmh.2
 for <qemu-devel@nongnu.org>; Sat, 19 Oct 2019 08:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8KsmRbilP8bTZKqxOfgUbDMH68hI/j6t6Vn/sO5YZF0=;
 b=pNAwN7yyrstS/boNbk4++Hs+1ZQFnDplZvfIvtZIVp2oNcGpd4OmgKJl5EumyJEpjU
 ysN+z+4Lu7rML0t3EKK2OqoBvrQJNsYxOLUupnN6C6XoEV5i++OSP128RnpWH0EkhwpV
 DF7gfgFfWmG/H6qY2yfQw47D5dXk8FJo4cbl5Ol8vFeDNoUTQaB62GnKhA+E5MWHPmED
 irLj5UDu1uS8NfrCDK3aqd51q41C0Y8Dn6ipXc28g1cOaAOhAVuMTUWQGThkV0MGD+Oz
 Db2IcQWp6/7ufLrkZ1Mxq3JBDcXkC7PGMw+CC/ROEtrLqMRGtfKK5k7/87fL0q2W5m8C
 Nj4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=8KsmRbilP8bTZKqxOfgUbDMH68hI/j6t6Vn/sO5YZF0=;
 b=U8AO9GkKAsI8LvRMA+txONIj3/Zj9qphOhdBE7JKlvlj6hE5+KL/VKselUPuMqlWZV
 CN+HC48US+mnNpNDlB6tVaSBZOaFWgv5xJ3LMtu5wrBfeIKQZflZlP1GxJPq9R0J//N+
 fD5UTKQ6ANhQttFydoWWUecIHB57hl2u0nzyS2NH1URUhmcQBZDvUiQ1GQ9R2jXRvOeX
 qtcgICArAQ29S9NmJBQ9ygoGgPcQxTaGFtDosVQ6vx8Axds0WlIZGETJXR4OCCLzMgJ0
 WiqQErbQziFCvgCh5jt7LhdKV6ApotL6UxdSnO0k4Mq0P3L6OVBygmSJPDnNQBqZHOMK
 1osA==
X-Gm-Message-State: APjAAAV7xBErGM8k+N5PRt+BVGxRly0fZ96rT6kJRPyzuKo162bRApfQ
 bSQ4gQ+OYJ196ahanZWhl9FWcpGN
X-Google-Smtp-Source: APXvYqy3khOTnsGP6oa2a0x5SEIh8lc5JDHT7wIzh4GtqT+r0K/IanbXXqIxCqkzSamUYOZ8RF4Lqw==
X-Received: by 2002:a05:600c:2196:: with SMTP id
 e22mr8283882wme.1.1571499288505; 
 Sat, 19 Oct 2019 08:34:48 -0700 (PDT)
Received: from x1w.redhat.com (14.red-88-21-201.staticip.rima-tde.net.
 [88.21.201.14])
 by smtp.gmail.com with ESMTPSA id j19sm15245605wre.0.2019.10.19.08.34.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Oct 2019 08:34:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 07/11] tests/ssh_linux_malta: Run tests using a snapshot
 image
Date: Sat, 19 Oct 2019 17:34:33 +0200
Message-Id: <20191019153437.9820-8-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191019153437.9820-1-f4bug@amsat.org>
References: <20191019153437.9820-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32e
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>, Cleber Rosa <crosa@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If a test fails, it can corrupt the underlying QCow2 image,
making further tests failing.
Fix this by running each test with a snapshot.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/acceptance/linux_ssh_mips_malta.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/acceptance/linux_ssh_mips_malta.py b/tests/acceptance/linux_ssh_mips_malta.py
index ffbb06f846..27907e8fbd 100644
--- a/tests/acceptance/linux_ssh_mips_malta.py
+++ b/tests/acceptance/linux_ssh_mips_malta.py
@@ -90,7 +90,7 @@ class LinuxSSH(Test):
         self.vm.add_args('-no-reboot',
                          '-kernel', kernel_path,
                          '-append', kernel_command_line,
-                         '-hda', image_path,
+                         '-drive', 'file=%s,snapshot=on' % image_path,
                          '-netdev', 'user,id=vnet,hostfwd=:127.0.0.1:0-:22',
                          '-device', 'pcnet,netdev=vnet')
         self.vm.launch()
-- 
2.21.0


