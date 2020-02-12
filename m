Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD0CC3B186
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 16:42:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A975920714
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 16:42:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d7lj4n+g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A975920714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1v5x-00059Q-SJ
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 11:42:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36612)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j1v53-0003Jb-05
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 11:41:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j1v51-0001ie-WE
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 11:41:40 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:36349)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j1v51-0001i9-QH
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 11:41:39 -0500
Received: by mail-wm1-x335.google.com with SMTP id p17so3298332wma.1
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2020 08:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Oo23LZ+bVDGb+bI6Wuhk5pe6slIqDak+OkHafTFG1M8=;
 b=d7lj4n+gGvjSeLgmK0OhVz0NM90F/ZZqU2NfatMzFSfMg2FdpqcJW/t/bJxywR6LRu
 DsbEF6qg6j8xQhoi8uzr+peOcrlRLJDx8caLvvKdVqipVLWzHq7+NnpEqje0rRoXl0ta
 n3xugMBSBHdbC8tEuN3vrx5/mbyEBMZJXY9sdN4nXf18tzbCh2e+RarQgUyHETGSfHcU
 mdhWNpH7Lzq+n2YH3RbwgiYGVs5+RgaAWCDre/PnnVOy+vKmwZrZNWOoQOtYRJYS8GRF
 rX6z6E/rfX2QiAuphgA/WJFO4qkcfv3p+293pmZ9p7c/U8CBebODG/TXxr5rPctZq771
 WAng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=Oo23LZ+bVDGb+bI6Wuhk5pe6slIqDak+OkHafTFG1M8=;
 b=qXhSdZDk1/RDgtuSqoQyFNgXiwpHbOW4Z4cFtiPAsnRlk86XaE5HDt2cohXnWf72Zp
 4mBAxpdV+PgIEciL/7mm5GQZ4QOsoBVFz4sljC653w2zEIlaUVImNnOcUFD8z515NsFB
 K7KPqmAuQD7MLMoi/dSzcrs3zHil0e7gYKoYGrsrboY9ctfYe3XxCU4vjh8ak4b7ICa1
 AtYIXaPB7Pp06Rv/btbRuKBVltnBe0jACAlOWiaiGEnalXVGao2SeFLKGnZyFOazD5wP
 YVhf75qx+NcRoFCu5AE+zYkVmk+ToFktAV6proTHBe/bNsBb6oNFx5+BlJoylvk/YSw2
 JakQ==
X-Gm-Message-State: APjAAAWVzkUJwHTCPNv/yZPdNQs56uKdWhiClsmOhZZBeaI0ec6Z1mZi
 keFlx5Sm+BOsheEQ/4IZXgnx5rHk
X-Google-Smtp-Source: APXvYqyYRPihTdET1TDMyHzIpvQHHZAjXmCNuf4dgq93R4RQuwG+DbeMzt8e0ijVbEB37AdsQXcRxw==
X-Received: by 2002:a05:600c:21c5:: with SMTP id
 x5mr13987288wmj.72.1581525698598; 
 Wed, 12 Feb 2020 08:41:38 -0800 (PST)
Received: from donizetti.fritz.box ([151.30.86.140])
 by smtp.gmail.com with ESMTPSA id a16sm1195122wrt.30.2020.02.12.08.41.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Feb 2020 08:41:37 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 5/9] exec: do not define use_icount for user-mode emulation
Date: Wed, 12 Feb 2020 17:41:25 +0100
Message-Id: <20200212164129.6968-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200212164129.6968-1-pbonzini@redhat.com>
References: <20200212164129.6968-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::335
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

use_icount is also defined by stubs/cpu-get-icount.c, we do not need
to have a useless definition in exec.c.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-id: <20200204161036.20889-1-pbonzini@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 exec.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/exec.c b/exec.c
index 67e520d18e..5fc3746053 100644
--- a/exec.c
+++ b/exec.c
@@ -98,15 +98,15 @@ CPUTailQ cpus = QTAILQ_HEAD_INITIALIZER(cpus);
 /* current CPU in the current thread. It is only valid inside
    cpu_exec() */
 __thread CPUState *current_cpu;
-/* 0 = Do not count executed instructions.
-   1 = Precise instruction counting.
-   2 = Adaptive rate instruction counting.  */
-int use_icount;
 
 uintptr_t qemu_host_page_size;
 intptr_t qemu_host_page_mask;
 
 #if !defined(CONFIG_USER_ONLY)
+/* 0 = Do not count executed instructions.
+   1 = Precise instruction counting.
+   2 = Adaptive rate instruction counting.  */
+int use_icount;
 
 typedef struct PhysPageEntry PhysPageEntry;
 
-- 
2.21.0



