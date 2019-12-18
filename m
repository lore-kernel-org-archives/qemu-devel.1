Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D5F5C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 12:21:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49B6B206D7
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 12:21:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oYb+ZgPv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49B6B206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihYK5-0004mR-03
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 07:21:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46817)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY2t-0006BO-Kd
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:03:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY2s-0000Bx-AG
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:03:15 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:43632)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ihY2s-00008e-0d
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:03:14 -0500
Received: by mail-wr1-x42a.google.com with SMTP id d16so1982743wre.10
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 04:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references;
 bh=+astimZn8Je4fKicS3bRyHB/lJlYx/kgk/kvsdzU+FM=;
 b=oYb+ZgPv4c/bxGsXNkBw4AOzjvdL94VPOt5cDS9+q0pHdognWh7XNwRCp4H+rYnS6I
 Z4X9nDPm7t5d0HWt+gJKNzA+Bfl8KlahSmaHskP+dbSK7HBv9UuFAmCx/Hu0aGeIrYCx
 +b5aFfo234G/Euz1iSVka9Ch4nuC/CXuH6AJO87GXHN/uDMyhxurJNDms/mO24tcz6UW
 xpP1ahZnG2ez6kYhXw6fHvq30pDXi+0EmjBV5hlMgiPx5vlWvuPb9qdGXOMz9YslZvs+
 ItnGbWqotqatN6LFmMP9MF2kLd7H4tXHW4mpKBNgixTtvDhGDOkflO6buWup8bk6P4iQ
 qr1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references;
 bh=+astimZn8Je4fKicS3bRyHB/lJlYx/kgk/kvsdzU+FM=;
 b=Xp4rfur6yDyH9K6y8w86dYq8vVj3aFYIdRcqFDCotS05IHTu02mvUIGvZLRVGjB7le
 SVyeN/CL6ICErZ6Elkmmd+276YY+aGxyPJn8ZZsvfbUOAs0ZIaGxxSPguY6ej2EMo230
 MgMYTGx/WIs1gtTy8TyNBxYbh5OXjNSxWUuFUm5/vLsJG5D8pr1u00dXr9Zn5fryb6m0
 2wIybLkJPcqSVvxHa7sOA/4AzpBAXA9qdVYTK+MTYrZuSSFnbBtCwO5ODooRF7umDwty
 GO4vGA7Wj8Uxhg5TenVf/TPl51+qEu32i7WAjhu17SAq0fOBj28WnsTzpnVuk0LL0qFK
 ZhuA==
X-Gm-Message-State: APjAAAUvgOb0vgxQxrL8QMl9ZOrADiLaknZpkGhGmK+jerIHr90g49OO
 w1W9p0QjsHR6CV4Fw+m8agUcM0F6
X-Google-Smtp-Source: APXvYqyzFhBOcFtDIZniGhEagoJCKQ7/O0eZDTx6QNHVpEUIAk/5xqIOf2cqv+P+GOqwXpuoN/lTmg==
X-Received: by 2002:a5d:50cf:: with SMTP id f15mr2428379wrt.381.1576670592241; 
 Wed, 18 Dec 2019 04:03:12 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n67sm2236838wmf.46.2019.12.18.04.03.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 18 Dec 2019 04:03:11 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 17/87] accel: compile accel/accel.c just once
Date: Wed, 18 Dec 2019 13:01:43 +0100
Message-Id: <1576670573-48048-18-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
References: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42a
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now that accel/accel.c does not use CONFIG_TCG or CONFIG_KVM anymore,
it need not be compiled once for every softmmu target.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile.objs       | 1 +
 accel/Makefile.objs | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile.objs b/Makefile.objs
index 4e4d6dd..c4bc783 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -55,6 +55,7 @@ common-obj-$(CONFIG_POSIX) += os-posix.o
 
 common-obj-$(CONFIG_LINUX) += fsdev/
 
+common-obj-y += accel/
 common-obj-y += migration/
 
 common-obj-y += audio/
diff --git a/accel/Makefile.objs b/accel/Makefile.objs
index 8b498d3..17e5ac6 100644
--- a/accel/Makefile.objs
+++ b/accel/Makefile.objs
@@ -1,4 +1,4 @@
-obj-$(CONFIG_SOFTMMU) += accel.o
+common-obj-$(CONFIG_SOFTMMU) += accel.o
 obj-$(call land,$(CONFIG_SOFTMMU),$(CONFIG_POSIX)) += qtest.o
 obj-$(CONFIG_KVM) += kvm/
 obj-$(CONFIG_TCG) += tcg/
-- 
1.8.3.1



