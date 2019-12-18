Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 421AEC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 12:38:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C75C227BF
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 12:38:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="izDV2WSV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C75C227BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihYav-0004vS-Ei
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 07:38:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49832)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY3L-0006Z7-Bg
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:03:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY3J-00018V-4m
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:03:43 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:35440)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ihY3I-00017E-3u
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:03:41 -0500
Received: by mail-wr1-x435.google.com with SMTP id g17so2023493wro.2
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 04:03:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references;
 bh=4/VXcI8eYmiuGhNIitLwvxt1jFWhzm+DXm68V+YOb4o=;
 b=izDV2WSVLptNxaVwpq3bnK/bq+mS1jjT+xY1S5CtpCTN9DFfAKrB56crU1OPH61kEx
 B5yft5flSDXIAg1XweSxOYtOmYXeePo/5SwAxasrVxtdPhovKu4gdtq0bp1KHzMVMd8Z
 ZOVdgiytikqGHDdE5qEG3Pqhp9QaQg8R+3Sy79TbnC80XqcVmZPKDtZ9QHcJV0vQqxvP
 OTHcHK5DRNifJd85U+pFad7pSfYAlhTdkXq9Np1PIXUqh+0IdZMQMHVYBKChJvepdBFB
 6BuB5AmINuCqC2b7CG+gbXJiXweas8DYWXJ//c9Y6/z5BFmQrJ5ghRPXLN8BsrbQxeSH
 zESA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references;
 bh=4/VXcI8eYmiuGhNIitLwvxt1jFWhzm+DXm68V+YOb4o=;
 b=eAS92bwWN8rvqxkVEE8QZjZLnlGKTCWxdObCB2VEr1sATSb7+Y1drGXbH8Bot4mHYm
 PV8vEWrn1IGTm87l2dO1L6JVNkYQsX0MFt5udDGmx6nWr3cBKjQs+xbGFzImqtqwulWI
 khcz45TbLdF15jQ3WWfIquezSUR7MWBEhuDUTCbn+XvV9AtI9pRVC/1p+PH9y6pyYm61
 6N25fS9UjagaxGOd1CU3qxVZZrAP8ol86Qvr1ZdvDDbMQj8Ez0pxDeB7jZRhXsfkrB1d
 yQc46rTLrHk/iKZPvhIXb0PArl5jnOwtuP3SL1nFvbz7IK7fVwp0he0sutS25fJZY+BT
 IIJw==
X-Gm-Message-State: APjAAAWyvDoYboI93dbHf6nPdjmca8sra1Q/c+mR5BfBZ/+YIwPH3yeq
 tYNRxmTUag9ixwe2c1T7db5Su9zB
X-Google-Smtp-Source: APXvYqzicw4FYBOIO3B6wE5/hGTq4I4shso9U0BjbYa2ADuz5rvsXECEz9ClM12tzuruFce6IgbXyA==
X-Received: by 2002:a5d:4085:: with SMTP id o5mr2387051wrp.321.1576670616727; 
 Wed, 18 Dec 2019 04:03:36 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n67sm2236838wmf.46.2019.12.18.04.03.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 18 Dec 2019 04:03:36 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 42/87] configure: set $PYTHON to a full path
Date: Wed, 18 Dec 2019 13:02:08 +0100
Message-Id: <1576670573-48048-43-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
References: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::435
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

This will make it possible to replace it in a shebang line.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure b/configure
index 0a63c75..2943f5d 100755
--- a/configure
+++ b/configure
@@ -908,7 +908,7 @@ for binary in "${PYTHON-python3}" python python2
 do
     if has "$binary"
     then
-        python="$binary"
+        python=$(command -v "$binary")
         break
     fi
 done
-- 
1.8.3.1



