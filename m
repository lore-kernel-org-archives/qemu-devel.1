Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C39C35E01
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:34:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2819620CC7
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="krlXXX0O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2819620CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6ZPi-0002hs-C2
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 07:34:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52834)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Z0V-00044O-GK
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:08:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Z0U-0003hV-Ez
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:08:11 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:38766)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6Z0U-0003h3-9G
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:08:10 -0500
Received: by mail-wm1-x32f.google.com with SMTP id a9so2897915wmj.3
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 04:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=+QntnSwGiMZJz9M5LirsEIfpTxlqSVZPz0auwZeZsmQ=;
 b=krlXXX0OAzQCaKqynMM6ZpzDE8EfxzfR2nGl3wOhV+Htgc43gjg8EIvh2I9dnBBQH6
 GAXNjyTcgXZUjZ+vX1Sq77VPdpBeWseuneIiNz9LnVssvpHE3SDvRJzmVDLJcMV2vms5
 ETC8spvr15gZOOM2DdN70s7wmZTqsemmgGFIjbhyYmW+dDiXy7ooISafkkyqMmU0bR/D
 A9+b4PZMHaeyu1hYlH/bm4idRiAt1YNXZ7UuH/6nID2ovGpGfjErPc16OzyaRQk6uIKM
 XeLNlenPIDQi4g2tjp30xklO7MMZbXVT6K37zUG65emYTexmn7ZEi9AM0HHYLvK75fZD
 SKAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=+QntnSwGiMZJz9M5LirsEIfpTxlqSVZPz0auwZeZsmQ=;
 b=Pp9RQTGHOihUjvclf6Nj3P+mM9m029KQTepyMLu5RgJVp0w9YDttHiwt/R4pKy3YeA
 0reRlyRipjaEhFa8MiEUHhs8cWyRM1jQmoRCck/eDCMWux7OTba43zl4GhTVA4GHaTTT
 uooSIvhQoULvxyWdhYOdfglugBA5FUgRXyApGBytmEpF+5pJrAE2D5PgQgn+u71ZhG2i
 do9aMivZLKQiLjmWMoQLArn5lnsObxzwou/mg2RilaIo9ZlvvwkW0PooeIbqhLY2K8CU
 xjyFtqnfOSXHflw6uxB9nsQgV7A9MVlqqQmXZQ1NAmjZ/ZpuGIdD3D4Xe/RKHhf0GpVF
 /FHA==
X-Gm-Message-State: APjAAAXI/qnFeMZyPDlCJ7eIatBH3yQLfRlCKbbh69U+S/UcKTT/0XMm
 wSnX0/n77zJLPzVBYs1GVJGVd9HQ
X-Google-Smtp-Source: APXvYqyV4aoKxSrz9M1zfiWtDvTUSC9+pIysCajzZz3sBbJDaCpiDyn4OJSLAB6pwq8FbOQXlS5WBA==
X-Received: by 2002:a1c:4857:: with SMTP id v84mr5039115wma.8.1582632489044;
 Tue, 25 Feb 2020 04:08:09 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id h13sm22709423wrw.54.2020.02.25.04.08.08
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 04:08:08 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 136/136] WHPX: Assigning maintainer for Windows Hypervisor
 Platform
Date: Tue, 25 Feb 2020 13:07:34 +0100
Message-Id: <1582632454-16491-34-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32f
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
Cc: Sunil Muthuswamy <sunilmut@microsoft.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Sunil Muthuswamy <sunilmut@microsoft.com>

Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
Message-Id: <SN4PR2101MB0880E245954826FD91C9D67DC0110@SN4PR2101MB0880.namprd21.prod.outlook.com>
Reviewed-by: Justin Terry (VM) <juterry@microsoft.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 195dd58..36d94c1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -404,6 +404,14 @@ S: Supported
 F: target/i386/kvm.c
 F: scripts/kvm/vmxcap
 
+WHPX CPUs
+M: Sunil Muthuswamy <sunilmut@microsoft.com>
+S: Supported
+F: target/i386/whpx-all.c
+F: target/i386/whp-dispatch.h
+F: accel/stubs/whpx-stub.c
+F: include/sysemu/whpx.h
+
 Guest CPU Cores (Xen)
 ---------------------
 X86 Xen CPUs
-- 
1.8.3.1


