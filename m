Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6278FC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 12:48:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CBA02146E
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 12:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r7ZtFfuB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CBA02146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihYkw-0001VS-8Z
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 07:48:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54744)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY3j-00079c-7d
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:04:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY3h-0002oV-Vu
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:04:07 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:39631)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ihY3h-0002kt-Mt
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:04:05 -0500
Received: by mail-wr1-x42c.google.com with SMTP id y11so2005756wrt.6
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 04:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=GLnTbT7DrMhmAKNR/jbBoBJjkKqPWblBYnI5K43pAHM=;
 b=r7ZtFfuBc4fQtX8TWPtSf4zgOA5mP5flDUcJqaSNAghZlo/y8k5lM39tKFpeDIfp+p
 f2sUoSYsZmjgMhpNp3irUwh9KKOoY70woM9SRIntHN0/2cJRLq6xFZZdRhiar2SxSFWO
 x27t1czt7SiwOM3u9xGeuKh8qPDyqzs5Ro2WHO9J0be32VV2Di2cxiY4WLJAcisvlm/Q
 gPnJz2Nb4MCY+yfTxYkE6ykKz4KjEqNp0ynEiGxnrkUSvreaQamotbIdedEoWhsaQEe2
 gy/YaGEYXt19rypu3jlc2D4JEpfYcg22phw6ZTAVLLJOS6qieXe0F9uBo2enf9iplhnv
 HQWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=GLnTbT7DrMhmAKNR/jbBoBJjkKqPWblBYnI5K43pAHM=;
 b=SvGzGo0wxboLfagKwvIplMEK8Hn6fQg3ap411urvaGSNa1Ng1DOpiQZuHHpQeskqo4
 GwiSTruqmfHCdk9FQQ6Ugc1UDOmNAK+jBrGRtxMGZKTtMNCiuoToSOAxwVWxjblSz5pB
 ODNzr357BnhQg4Tfo856iFAGpjyLpcX9glqlUS+t8WrITNrZKpU91VXBBHE5rdHdSHb4
 mnlJE06dDISWr3wrnnetppa2hvO4jX0t+ftwAWBdEcTDbT5b7uWPMY6AT/sXKGhWuRSL
 W0tLAgJkE0QniUVWIo02LStk+AKn0AtxVfFzh/544qWyFFaS7OUnIgjaWpEcd9eZz8H3
 fkQw==
X-Gm-Message-State: APjAAAXEfD4BvN0Rgv5UfcznH9P5+eku32LyIay18q+hV8noXX7G6KI2
 scQu9tEHYM65o3doxnYg/KpDMYBA
X-Google-Smtp-Source: APXvYqxXSX6am7bSp8RnSV0ljBrpEsXUyQn8+D+MtEyQuZAcDY1nGL3YGrgrfk0ubT9w4p5EX101FA==
X-Received: by 2002:a5d:6a83:: with SMTP id s3mr2349947wru.99.1576670644589;
 Wed, 18 Dec 2019 04:04:04 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n67sm2236838wmf.46.2019.12.18.04.04.03
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 18 Dec 2019 04:04:03 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 61/87] memory: use RCU_READ_LOCK_GUARD
Date: Wed, 18 Dec 2019 13:02:27 +0100
Message-Id: <1576670573-48048-62-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
References: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42c
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
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/exec/memory.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 27a84e0..9d3fdb5 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -2171,7 +2171,7 @@ MemTxResult address_space_read(AddressSpace *as, hwaddr addr,
 
     if (__builtin_constant_p(len)) {
         if (len) {
-            rcu_read_lock();
+            RCU_READ_LOCK_GUARD();
             fv = address_space_to_flatview(as);
             l = len;
             mr = flatview_translate(fv, addr, &addr1, &l, false, attrs);
@@ -2182,7 +2182,6 @@ MemTxResult address_space_read(AddressSpace *as, hwaddr addr,
                 result = flatview_read_continue(fv, addr, attrs, buf, len,
                                                 addr1, l, mr);
             }
-            rcu_read_unlock();
         }
     } else {
         result = address_space_read_full(as, addr, attrs, buf, len);
-- 
1.8.3.1



