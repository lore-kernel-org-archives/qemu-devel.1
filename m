Return-Path: <SRS0=kcoF=UO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58368C31E44
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Jun 2019 00:46:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14E732183E
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Jun 2019 00:46:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FfUlWh4N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14E732183E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57814 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbwqF-0002Lj-Q8
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 20:46:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60420)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hbwmc-0000Vr-Dp
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 20:43:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hbwma-0004Aj-OJ
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 20:43:01 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:35064)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1hbwmZ-00049W-UZ
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 20:43:00 -0400
Received: by mail-wm1-x343.google.com with SMTP id c6so3877964wml.0
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 17:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Tuj2jcO/BLerGp9WHchtQ73E8BBK3njFpTpGB+i8VjI=;
 b=FfUlWh4NN90smDWXqsZIEUrL80d5krp6TQUPG85yIn2No5UHhYhb4tdc2EEvA64WMw
 jyAFA0mTXSugllkdFdWVJJM/1rTeWOpG9DxYwvAqYJ9IA6ziX03qT+N4Na+TsaeAPJjh
 hIHRhncetbUj260Jbe8I/Yf9A1vGWrBvRspy3Xbi8ou/6sNv0VFe8M/keovvFPmKYY/o
 BeezW0iorndlXyuD51dyhuivGh0eQnVSG7dwtRQcPbjIFhYBQwgPnOheF7ibIY1EkL7w
 gcTg0nPfxOgDkNE1DziYY9Jnp56oz9xscP5uwpvS3HnJxUQC+BXFBiWu6dLyaj/sYpnM
 glMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=Tuj2jcO/BLerGp9WHchtQ73E8BBK3njFpTpGB+i8VjI=;
 b=MogGfL/bUp2OQgZaO0kfsc+rq2Tpw7L8LPa5bJg3BjDr60Lu2jSvEPfSr9vKdB6XKJ
 KYdQvMmzPalGYqfRqByMG/paNRqoscpbswwt38jLf7bkqmOhUNVUDXtF5mpGOsGsploP
 88QipTZehqJUZiXh+bxymsXNqiQpk+kNyqJjRQXKtbp0kQak1bMRwtnij5768MQ/uBeq
 /3nBY9JJ7wtyLEZ+Hb87MYnGKUDKc4OYjUnUzm53NzIoXuqhDW7Axf7HV3aMo2Y0vcOk
 us+U6W0mj5GuN4QdzNFcpP2L059iprmRIIHOsQk2LlxkTYR/8WNouzuza+IR6PfewQtP
 jVpg==
X-Gm-Message-State: APjAAAUR2LKYJvOi0r+ha0hhwdTZaTcUJJU4bBGK0iq+6KNtWrBELqqW
 +I6zApgd22rgaEImxtlUcoo6Wawz
X-Google-Smtp-Source: APXvYqxnDfbSIMjtDK6qE3IP4/WjGAGMF/TrvxTtI9EYB8Nr4KbaoV53xwSxcyApa+FcNQgPMu2X0g==
X-Received: by 2002:a1c:3c8a:: with SMTP id j132mr9528804wma.172.1560559377625; 
 Fri, 14 Jun 2019 17:42:57 -0700 (PDT)
Received: from donizetti.lan ([2001:b07:6468:f312:1da0:213e:1763:a1a8])
 by smtp.gmail.com with ESMTPSA id m21sm3774234wmc.1.2019.06.14.17.42.56
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 14 Jun 2019 17:42:57 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Sat, 15 Jun 2019 02:42:51 +0200
Message-Id: <20190615004256.16367-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190615004256.16367-1-pbonzini@redhat.com>
References: <20190615004256.16367-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: [Qemu-devel] [PATCH 2/7] KVM: i386: Re-inject #DB to guest with
 updated DR6
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
Cc: liran.alon@oracle.com, nikita.leshchenko@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Liran Alon <liran.alon@oracle.com>

If userspace (QEMU) debug guest, when #DB is raised in guest and
intercepted by KVM, KVM forwards information on #DB to userspace
instead of injecting #DB to guest.
While doing so, KVM don't update vCPU DR6 but instead report the #DB DR6
value to userspace for further handling.
See KVM's handle_exception() DB_VECTOR handler.

QEMU handler for this case is kvm_handle_debug(). This handler basically
checks if #DB is related to one of user set hardware breakpoints and if
not, it re-inject #DB into guest.
The re-injection is done by setting env->exception_injected to #DB which
will later be passed as events.exception.nr to KVM_SET_VCPU_EVENTS ioctl
by kvm_put_vcpu_events().

However, in case userspace re-injects #DB, KVM expects userspace to set
vCPU DR6 as reported to userspace when #DB was intercepted! Otherwise,
KVM_REQ_EVENT handler will inject #DB with wrong DR6 to guest.

Fix this issue by updating vCPU DR6 appropriately when re-inject #DB to
guest.

Reviewed-by: Nikita Leshenko <nikita.leshchenko@oracle.com>
Signed-off-by: Liran Alon <liran.alon@oracle.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index c8d8196e71..53f95b02a0 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -3546,6 +3546,9 @@ static int kvm_handle_debug(X86CPU *cpu,
         /* pass to guest */
         env->exception_injected = arch_info->exception;
         env->has_error_code = 0;
+        if (arch_info->exception == EXCP01_DB) {
+            env->dr[6] = arch_info->dr6;
+        }
     }
 
     return ret;
-- 
2.21.0



