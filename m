Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA843C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 15:42:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A00621734
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 15:42:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j5V8V04X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A00621734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59637 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuech-0005TD-Hz
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 10:42:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51363)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iucrL-0004vc-Cs
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iucrK-0003IB-Bf
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:23 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:43675)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iucrK-0003Hb-5j
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:22 -0500
Received: by mail-wr1-x432.google.com with SMTP id d16so3113125wre.10
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 05:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kwopIYB/WLvPXsn1n5soFXTxjBcyD4Z2aHNDQJbuDLo=;
 b=j5V8V04XdmUw9XwQxjLzBRIwNE5CDm5i65eubKo6FTvLrAXu/suDp+1y0BlNTQjCu7
 BkGki89TOXJlf6e4BfrGIgsi7JAVOGxzhneZXxCbCcduuz99XHlizPzi8J7wUUM5INQa
 vctiYh/5BafuMrO8OzsXuoEY4aBG6hYEt70RZDaTMGz0QqNlRKoteYmgi2D8gY1GXoo4
 oEAyKoT7EjPh6XbiShKcsMj0KdElL/j8oXzGdNTGxJPrPx9pkw0s7VJLUiDWsTw2ceA1
 nfoEN/yxeB8tLsrififYwq/qYlH/dda0RGDP91GFbEAaw5JjHEQ7ngX0MDIg3QKfHWWO
 uLPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=kwopIYB/WLvPXsn1n5soFXTxjBcyD4Z2aHNDQJbuDLo=;
 b=GH/aceuJd/CItF2g4zmvnfwukSfGjuy1aJHUOjcuEL+765br1Q2w/6KYE/hayvTC3J
 C1GDmwKw4Yh44tOI2pUf/WRdNJqlpXrDnmKB3TkR9aMpbEPbkVDcD4UKM079yXL5KX/c
 bicykrFwM7U824FQJ377p3jNkLdMd+ZDN/mTV/z+B50pFOvb1+YrqBm8uQGbGnUFZnhv
 IPh026VDchDLOBekAG5VAkB5ifBLFACVUGMtkFf42ssEEfV796wZyvrOSijOkjqkRDlv
 g1OnQSlIaupFtvndbP7Q4B7S5pWr5ZGgR4SJC8burM8brRPTyQbOVRfoUzHMtNRCw9Ng
 QuxQ==
X-Gm-Message-State: APjAAAUP7DeV8yk0VJRy9cjFwvtmj0AGlCPDmPLH6MWHRA2mMUUCMABd
 rQLPoi13MHKhd6x7ZWg2J0eqZnbp
X-Google-Smtp-Source: APXvYqwM46v7H66iEYghLH08OlMbyDTsdeLu7ymBZdamxB8jZHnMXpAk1+cxUREmdvUtJ6VGeQHHJw==
X-Received: by 2002:adf:eb48:: with SMTP id u8mr17451878wrn.283.1579787360962; 
 Thu, 23 Jan 2020 05:49:20 -0800 (PST)
Received: from 640k.localdomain.com ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id s15sm3073171wrp.4.2020.01.23.05.49.20
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 23 Jan 2020 05:49:20 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 16/59] hw/core: Restrict reset handlers API to system-mode
Date: Thu, 23 Jan 2020 14:48:19 +0100
Message-Id: <1579787342-27146-17-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1579787342-27146-1-git-send-email-pbonzini@redhat.com>
References: <1579787342-27146-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::432
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

The user-mode code does not use this API, restrict it
to the system-mode.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20200118140619.26333-6-philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/core/Makefile.objs | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
index 0edd9e6..2fea68c 100644
--- a/hw/core/Makefile.objs
+++ b/hw/core/Makefile.objs
@@ -1,6 +1,7 @@
 # core qdev-related obj files, also used by *-user:
 common-obj-y += qdev.o qdev-properties.o
-common-obj-y += bus.o reset.o
+common-obj-y += bus.o
+common-obj-$(CONFIG_SOFTMMU) += reset.o
 common-obj-$(CONFIG_SOFTMMU) += qdev-fw.o
 common-obj-$(CONFIG_SOFTMMU) += fw-path-provider.o
 # irq.o needed for qdev GPIO handling:
-- 
1.8.3.1



