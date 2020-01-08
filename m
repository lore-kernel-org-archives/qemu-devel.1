Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA8FC282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 12:55:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 360342051A
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 12:55:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k7viQz9h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 360342051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipAsI-0002Ms-Ns
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 07:55:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60716)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ipAWm-0004PA-E3
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:33:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ipAWl-0004bC-CI
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:33:36 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:50274)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ipAWl-0004ak-67
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:33:35 -0500
Received: by mail-wm1-x333.google.com with SMTP id a5so2312312wmb.0
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 04:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/fSkOiubeSR2RsQ2FE11TyyAzCwnm2uZ+zIHW+a+jmk=;
 b=k7viQz9hHdRB/kc7Z1yIt1Z1Fpa6raRZepLhOq6A4P7+nJnabr5MTuXWulgle7yKvI
 VgA0ANDuQruAO3BfZigEtOTGlYbSr9L8Yvv8N/0dFZXXupr0TzUsFeTVgifO0fiUu5Y/
 DE4kyw12rfH7ejWiX00ue4RMx3AeS9wG7dqOEHae/EEZneIKb8AFu58hxFxDPYlQhaja
 9willGtvIb2u4tqgVogp1nuprxAScccDfXwCJdPgKFdlN9tIGNCkOKwaiYhANthemfOb
 ZWrxg5LvFtYfWgSqBUJ09WnQqTaDn8tR+oPawuwresAybbGey6e4ESXFTajDuaHHRYTn
 ijBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=/fSkOiubeSR2RsQ2FE11TyyAzCwnm2uZ+zIHW+a+jmk=;
 b=ojmjDx4PsYG8k+7vroEhZ+kgUDd/lzg1DWdeJKh4//q1nLF+Wrb7l2lo7PUuZ7m4EP
 ABsN/1PPvvUMvcvTFD+Ldpdm5gtd8fes56LxB66xg9nutzh5EaFoJNRIevTORnvi6ANo
 Tp5L06/nqob0JLkI3LqzrCbpqtXo8R8zmswL+lYbUBUsPCrZQdLgaPDcPErrATWql+/x
 Nqkui0QBEHDoCVswntwUuyKE68YyYmMG2jqnhB5BdnpSwCxAsOPTAPw7qzL3flqqSvhd
 BUURL6VSn6kiFXcAj3NOV8YCJtV118NdUN7MmEQDPGbicpAvMo5S5IWNTfhFR2G2Zu8a
 F1AA==
X-Gm-Message-State: APjAAAXCRIawqQidTlg1WHqUZkOt31VxFN8vh/a3aFFreq7+a2bfzCwa
 Y0LLo+gbWU/FWkprerUcJ2MrMtlp
X-Google-Smtp-Source: APXvYqwsdN8LajZk8WgLJ7VW/Lty3R60qSgpIVrvWN5+uoXDjyxb2J3J0UjJ0Qt/jSIPUpYUOeFrww==
X-Received: by 2002:a7b:c351:: with SMTP id l17mr3777149wmj.25.1578486813980; 
 Wed, 08 Jan 2020 04:33:33 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id o4sm4037750wrw.97.2020.01.08.04.33.32
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 08 Jan 2020 04:33:33 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 34/38] monitor/qmp: Explicit we ignore few QEMUChrEvent in
 IOEventHandler
Date: Wed,  8 Jan 2020 13:32:51 +0100
Message-Id: <1578486775-52247-35-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1578486775-52247-1-git-send-email-pbonzini@redhat.com>
References: <1578486775-52247-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::333
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

    CC      monitor/qmp.o
  monitor/qmp.c: In function ‘monitor_qmp_event’:
  monitor/qmp.c:345:5: error: enumeration value ‘CHR_EVENT_BREAK’ not handled in switch [-Werror=switch]
    345 |     switch (event) {
        |     ^~~~~~
  monitor/qmp.c:345:5: error: enumeration value ‘CHR_EVENT_MUX_IN’ not handled in switch [-Werror=switch]
  monitor/qmp.c:345:5: error: enumeration value ‘CHR_EVENT_MUX_OUT’ not handled in switch [-Werror=switch]
  cc1: all warnings being treated as errors

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20191218172009.8868-12-philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 monitor/qmp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/monitor/qmp.c b/monitor/qmp.c
index b67a8e7..6c46be4 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -365,6 +365,11 @@ static void monitor_qmp_event(void *opaque, int event)
         mon_refcount--;
         monitor_fdsets_cleanup();
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



