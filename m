Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B207C33CA1
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 12:59:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6975820720
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 12:59:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gOcyKNLP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6975820720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipAve-0008C3-Tq
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 07:59:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60620)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ipAWf-0004Bi-07
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:33:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ipAWd-0004WW-Tz
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:33:28 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:36689)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ipAWd-0004W6-Nc
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:33:27 -0500
Received: by mail-wm1-x335.google.com with SMTP id p17so2324541wma.1
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 04:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Szvn2P1fTtzbAoJG3/7kSHDMFC+czJio/vRe33KbfBY=;
 b=gOcyKNLPH99DkPWkpAq2BVmSLwolIUuNhQq84RtNQiX6T/ZvNLeEQv8lOpFICDAO2Q
 BC2F0t+wuLErMdSvs4+ynONXCt7AwljTzTeDfK/bCHkHl85j9zjolJoRXMNXcX6NafLP
 w7DWa6pDwTkYtjXd10QB5bRWomA2LwHDb0+WpKqKrozhtQTvyTHGYCXQZ/BW5s7qbslR
 4NZ536iVFwfwSkivCVuVRZ2My6J5or/XhHDopq9PViDSVDLayQ8xamjwsY7qc9jFgz1P
 Z80XkiaflwauFHjP2+HJffKSgZyo59vGSOWVtHc8d8aA90KDStKQSafSEep1R2mAkAxG
 xTKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=Szvn2P1fTtzbAoJG3/7kSHDMFC+czJio/vRe33KbfBY=;
 b=gG/us28+3lV1A8t36FLUB02aMkCCE5xyKHQDqXyi+55r+Ege89IxMzTgw+04ZkCHpf
 Yi2RxJOSm9CI5vzM2H/ysYOJhlLdA/9tAominpyMDk6ON/Pkw0fRKbKoeSaOvJ1bncoP
 YR7s3L6It3iYrGJJzoq6nZENKMx4lwm7WfBGA3kY5VxhhrPKsV0UhhmEQ7ooi9Zr53zZ
 gh+xvEAjkYtOIFnmZAcD4KfnZHWvvgB0qacrmrqPoPaYDLZUCxYDz9cJJFtqLjCC81FF
 /T3sc8jkImNX4D70WOYLZ9YkCdvYkslU80xuqlS2yJJm9xpCs3M8VWlnAh2htA4QPMyl
 j+IA==
X-Gm-Message-State: APjAAAVHDDqqGiIYU6/w4EYSzXbc7fYX/zBEJT3FD36PXfGcHevgW69a
 eXvDelFcGEGyG1K7jGsyY/6MW/Jh
X-Google-Smtp-Source: APXvYqwLCaan4SDdvW4zu+WRJnXtYUwJ8oFzQH5oB8rGtLgQuITuk+js0r2JL+S7D3Frfg8pDuDsiA==
X-Received: by 2002:a7b:c389:: with SMTP id s9mr3617473wmj.7.1578486806603;
 Wed, 08 Jan 2020 04:33:26 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id o4sm4037750wrw.97.2020.01.08.04.33.25
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 08 Jan 2020 04:33:26 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 28/38] hw/usb/redirect: Explicit we ignore few QEMUChrEvent in
 IOEventHandler
Date: Wed,  8 Jan 2020 13:32:45 +0100
Message-Id: <1578486775-52247-29-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1578486775-52247-1-git-send-email-pbonzini@redhat.com>
References: <1578486775-52247-1-git-send-email-pbonzini@redhat.com>
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

The Chardev events are listed in the QEMUChrEvent enum. To be
able to use this enum in the IOEventHandler typedef, we need to
explicit all the events ignored by this frontend, to silent the
following GCC warning:

    CC      hw/usb/redirect.o
  hw/usb/redirect.c: In function ‘usbredir_chardev_event’:
  hw/usb/redirect.c:1361:5: error: enumeration value ‘CHR_EVENT_BREAK’ not handled in switch [-Werror=switch]
   1361 |     switch (event) {
        |     ^~~~~~
  hw/usb/redirect.c:1361:5: error: enumeration value ‘CHR_EVENT_MUX_IN’ not handled in switch [-Werror=switch]
  hw/usb/redirect.c:1361:5: error: enumeration value ‘CHR_EVENT_MUX_OUT’ not handled in switch [-Werror=switch]
  cc1: all warnings being treated as errors

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20191218172009.8868-6-philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/usb/redirect.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c
index e0f5ca6..ddc1a59 100644
--- a/hw/usb/redirect.c
+++ b/hw/usb/redirect.c
@@ -1370,6 +1370,11 @@ static void usbredir_chardev_event(void *opaque, int event)
         DPRINTF("chardev close\n");
         qemu_bh_schedule(dev->chardev_close_bh);
         break;
+    case CHR_EVENT_BREAK:
+    case CHR_EVENT_MUX_IN:
+    case CHR_EVENT_MUX_OUT:
+        /* Ignore */
+        break;
     }
 }
 
-- 
1.8.3.1



