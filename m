Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA05C282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 12:37:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 562ED206DA
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 12:37:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A9UOv0Rh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 562ED206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipAaG-0000Rq-2F
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 07:37:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60223)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ipAWF-0003Zj-L8
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:33:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ipAWE-0004DV-Ko
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:33:03 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:50267)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ipAWE-0004D9-F5
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:33:02 -0500
Received: by mail-wm1-x331.google.com with SMTP id a5so2310457wmb.0
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 04:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=nB7ia0X/j64Wf1GK1SEbzmS3pheCsvBwIJ/lbjlWJeo=;
 b=A9UOv0Rh07AQvZPYE5UgAo+z6hG4/gZ1i0hDbi7o53jIWjTtMW4E6BQjUW3ScpYsUd
 qPrAYAIo3NR0pDNPRZrGy+JvAwYdfEVA5yga0hQLMBYlMPc44qF0SY9wgi4f44q/Aejb
 3FPEh7ReXOBnWm+x1w9aGBc3V4vs/yazL1JeVF+Pq7CiNNrVglEzmindr3QPG+05I9yw
 Fic3FB5r1Yo+uoy4fNNyyPpyry8AbY8ZRTU7KYopymIPRez+XA+C0EJCSO5/pAcZBENk
 FYSrtTS4qr0ht6AoKXEe0sVmcPCr7/r1X0QP9aP4m8eC9gZ5uuj4IaasdjLnQShp5201
 qmMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=nB7ia0X/j64Wf1GK1SEbzmS3pheCsvBwIJ/lbjlWJeo=;
 b=dlRUt0iYElb2RGFHibN8G1i5K1w79l4y1ikE6XDdNVHwtxv4aZP7J1tkWF2jBFC23r
 7126HX1B7/3NVcMYo+3HixQQgOZJ92mN366oZO/E1STp+lEbIAXKGoB9/cjlxMA4aTdP
 o8S+VB1dZrB4rtk7Jlg2JXlgsdNEtqZ4s8fuLpqjk+7N6LpB7yRoCLMlAVEKaTX+jUix
 XQLhtge19CN8UfnN/41mkp4CIgDXiHDB2YQU3JJo6v3Gy3QRzxPipg5VOC1LseZioeAY
 ucn3a8xcuFMqFKxF3g50ji5aDLre/dQdZhijE/D/hYmgqGyaDVt4QjT8hOaF4gZJcv23
 lHfQ==
X-Gm-Message-State: APjAAAW1qmQTGxVMc7DFK1EqUw7UDKX4V09jLwXJZ13medeI8ecR3hLj
 X5ikj6z7fiaFT17bdEEZJaiakSv/
X-Google-Smtp-Source: APXvYqzGh8CltuSge9Gks249GnW4NCTndUoUIjro0Op7rNAvvKH+Qb/mZG0CK3PnogpJsap43qjV+A==
X-Received: by 2002:a1c:4144:: with SMTP id o65mr3731323wma.81.1578486780979; 
 Wed, 08 Jan 2020 04:33:00 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id o4sm4037750wrw.97.2020.01.08.04.33.00
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 08 Jan 2020 04:33:00 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 04/38] replay: check other timers for icount limit
Date: Wed,  8 Jan 2020 13:32:21 +0100
Message-Id: <1578486775-52247-5-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1578486775-52247-1-git-send-email-pbonzini@redhat.com>
References: <1578486775-52247-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::331
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
Cc: Pavel Dovgalyuk <pavel.dovgaluk@gmail.com>,
 Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pavel Dovgalyuk <pavel.dovgaluk@gmail.com>

Record/replay can stall when there are no virtual devices that generate
events - it just uses all the time for vCPU thread. Therefore main loop
has to wait too much for the vCPU thread, because they are synchronized
in rr mode.
This patch does not let creating too long vCPU executions without
interrupting to main loop. It checks realtime timers that always exits
to control user input.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Message-Id: <157675958855.14346.18049977447896411847.stgit@pasha-Precision-3630-Tower>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 cpus.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/cpus.c b/cpus.c
index b472378..be2d655 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1316,6 +1316,10 @@ static int64_t tcg_get_icount_limit(void)
          */
         deadline = qemu_clock_deadline_ns_all(QEMU_CLOCK_VIRTUAL,
                                               QEMU_TIMER_ATTR_ALL);
+        /* Check realtime timers, because they help with input processing */
+        deadline = qemu_soonest_timeout(deadline,
+                qemu_clock_deadline_ns_all(QEMU_CLOCK_REALTIME,
+                                           QEMU_TIMER_ATTR_ALL));
 
         /* Maintain prior (possibly buggy) behaviour where if no deadline
          * was set (as there is no QEMU_CLOCK_VIRTUAL timer) or it is more than
-- 
1.8.3.1



