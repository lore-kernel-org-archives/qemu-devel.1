Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA41C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 16:21:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F391C22362
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 16:21:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q34olN5e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F391C22362
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX6FQ-0005rS-Q9
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 11:21:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60733)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iX63r-0001vI-Ph
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 11:09:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iX63q-00067T-Mm
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 11:09:03 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:34951)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iX63q-00066y-Gb
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 11:09:02 -0500
Received: by mail-wm1-x334.google.com with SMTP id 8so4365327wmo.0
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 08:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=ep9NciRh5AxFxbZ8BVLC6AZ8AyyeFsDsKi2zTRHiEDs=;
 b=q34olN5e+B7fBP5OyGWSbN52OFQFEIUCQDHMnC5q4RYWebkTba4S6FVHqFqU/XLLl7
 D5YVKGYdUjMeN8qoIU1BJXnBX2S0geCXRugaeDeTMAs5yCgZHkMNRppT0m30y1THlcVn
 6zECr3NT+NhO4opw0DifKQd8CcpP0HGUZpQv2pIKqrdajAjvhHmyJVeVWHiAk7AZXd3L
 ffZmQPXhopTjXBPAnt6Q9a69BXBFZ+nwppkOUIQ8p0CqYuH1LTT83C/yS2wL2AIKupZv
 lYagvPEC7AD3FOK5rPTW03+1MMNnL7BOLoVrAJUCcuzRw1mcBS9HG3j9R8LmUH6b8IS/
 0odg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=ep9NciRh5AxFxbZ8BVLC6AZ8AyyeFsDsKi2zTRHiEDs=;
 b=tAKfl7o1RGni8Gg4jU4q2U0MVL+xxIEoK4iJX7XepjXf81xx6vxdoWAvUN5CHOD3Z1
 MEYe0+eR64ATYAjwbGYl5nqni6YgaWn5tgAK/+F6Eki4OM2l9go41BiSHhHOhNB+EgxL
 ch5k6RY8VIaLAOCsQVU8rCT8D51C74HVq87YXzrjnJ9RN4rtEmKJEGSCMbLZ4xCmSFjq
 OSSyNT91lpUy3T38eitUXCRLwOvPJrHzxwX8+bWw4B9L5+QcQAESYCcXYj4pPTosiZKz
 gPKNn1u0cg0Ju8StcI9duqCySAMwBOF9Pxpko+xnDxagjJEJZE/JJmvRcIRouW/mR4r3
 4iLQ==
X-Gm-Message-State: APjAAAWnpM5dtJjciDd/oZS5d/61Xk6oCdLBR+qxHjj6aLvWHQaR/XLE
 CbeAGmqRJIHAEVVP9gOwe1DU0h2F
X-Google-Smtp-Source: APXvYqwqvmvvn6lKZWrIrchwmY8QrF876Ief37m6UjixFm1q+1SHHwPrC0APaauYWQ77dIK2pHnOBQ==
X-Received: by 2002:a1c:e157:: with SMTP id y84mr6275554wmg.59.1574179741090; 
 Tue, 19 Nov 2019 08:09:01 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n13sm3442203wmi.25.2019.11.19.08.09.00
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 19 Nov 2019 08:09:00 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 08/12] docs/microvm.rst: add instructions for shutting down the
 guest
Date: Tue, 19 Nov 2019 17:08:44 +0100
Message-Id: <1574179728-35535-9-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1574179728-35535-1-git-send-email-pbonzini@redhat.com>
References: <1574179728-35535-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::334
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
Cc: Sergio Lopez <slp@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Sergio Lopez <slp@redhat.com>

Add a new section explaining the particularities of the microvm
machine type for triggering a guest-initiated shut down.

Signed-off-by: Sergio Lopez <slp@redhat.com>
Message-Id: <20191115161338.42864-3-slp@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/microvm.rst | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/docs/microvm.rst b/docs/microvm.rst
index 4cf8474..fcf41fc 100644
--- a/docs/microvm.rst
+++ b/docs/microvm.rst
@@ -106,3 +106,24 @@ disabled::
      -device virtio-blk-device,drive=test \
      -netdev tap,id=tap0,script=no,downscript=no \
      -device virtio-net-device,netdev=tap0
+
+
+Triggering a guest-initiated shut down
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+As the microvm machine type includes just a small set of system
+devices, some x86 mechanisms for rebooting or shutting down the
+system, like sending a key sequence to the keyboard or writing to an
+ACPI register, doesn't have any effect in the VM.
+
+The recommended way to trigger a guest-initiated shut down is by
+generating a ``triple-fault``, which will cause the VM to initiate a
+reboot. Additionally, if the ``-no-reboot`` argument is present in the
+command line, QEMU will detect this event and terminate its own
+execution gracefully.
+
+Linux does support this mechanism, but by default will only be used
+after other options have been tried and failed, causing the reboot to
+be delayed by a small number of seconds. It's possible to instruct it
+to try the triple-fault mechanism first, by adding ``reboot=t`` to the
+kernel's command line.
-- 
1.8.3.1



