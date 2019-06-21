Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8877C43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 02:05:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 969D52084A
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 02:05:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qmr7Vmie"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 969D52084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54126 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1he8vu-00045Y-PN
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 22:05:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40998)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1he8a2-0006Xp-71
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 21:43:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1he8Zx-0006Tm-9f
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 21:43:05 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:54635)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1he8Zt-0006LR-NI
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 21:42:58 -0400
Received: by mail-wm1-x341.google.com with SMTP id g135so4780620wme.4
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2019 18:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=r43n33nGY2axkM37zxfub6AARNJoo1eQ/uWxCMQ4hvk=;
 b=Qmr7Vmie6oOO75Cuc0lPVhTuaLBYQWhMyUCO/IMJLJ5kXF4Aa4KwVwAIZ3bar2g2zS
 Ddu/hmJtkJw39/XLTtfa5kd3XEcEM5+pQveXkimnp5kqKlT3S//bs8ZELkZwQ7+OgXEI
 8U431em1lMa1xs37jA/fRhHjOIx+LEH3nBRXfZ0bBdp70YZJYuOAd93vkvodmO3hGl3v
 aPp5dFA5a8BvbRRa6S2Xo3XQON0QMIEzjW/AXcVVOzHBv3A6xydkAXLMihhSRvbx32kO
 YxjL8EKBgM8UpDv+mkEKxirqmPl22ZcRd7lT0jM3tb57CwREQZy07QnIj9BBGS1cRuhu
 E17w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=r43n33nGY2axkM37zxfub6AARNJoo1eQ/uWxCMQ4hvk=;
 b=UZAf9erzx3jysQeUfembmMLjkmCVgN+0qpcRSBKHEv2cC7eifGVz+uGxpZANgzGZMb
 syuSb7pLiOgKFrYyL5HxFoQqQwG48PL+7bhc+t1U/arXfSQlKtwkDKBocablVlf5R8VY
 Lah/hVVTBrTvvS6rBQ7dqzOrRkiwktsihWDjNgZcwioXPvZZYSDBefbii9lltygX7Kl8
 N+eWPjYYEO+X2PCzaqo/gO+9o8W50btdnLYBxb/zY47BeL2Ot/pOCs+2HsVNSpJqW4A8
 aQ3mN2cLjUO38wt7jB03fP0J1cNugARvYjWOj3QpZD5eHqlVArogciPhWoaZDj+7NVco
 aoGQ==
X-Gm-Message-State: APjAAAUb5WBBdyeTOzj5grs8r7+Ei56At59XWDT1JZWI5aee/uWYDseO
 opFGEoyqROAenGb83P0fYvP13GGH
X-Google-Smtp-Source: APXvYqxnM1zPDrLYlvDV8usVLTBU4jDVOi6kJd8T5LYmcsoGidthmv/+ahvmYtNvl3I+MRhoGRMu/g==
X-Received: by 2002:a1c:208c:: with SMTP id g134mr1553520wmg.112.1561081369020; 
 Thu, 20 Jun 2019 18:42:49 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id d1sm1123125wru.41.2019.06.20.18.42.48
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 20 Jun 2019 18:42:48 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 21 Jun 2019 03:42:21 +0200
Message-Id: <1561081350-3723-17-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1561081350-3723-1-git-send-email-pbonzini@redhat.com>
References: <1561081350-3723-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: [Qemu-devel] [PULL 16/25] target/i386: kvm: Re-inject #DB to guest
 with updated DR6
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
Cc: Liran Alon <liran.alon@oracle.com>
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
Reviewed-by: Krish Sadhukhan <krish.sadhukhan@oracle.com>
Signed-off-by: Liran Alon <liran.alon@oracle.com>
Message-Id: <20190619162140.133674-5-liran.alon@oracle.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index c763643..9864aa0 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -3897,6 +3897,9 @@ static int kvm_handle_debug(X86CPU *cpu,
         /* pass to guest */
         env->exception_injected = arch_info->exception;
         env->has_error_code = 0;
+        if (arch_info->exception == EXCP01_DB) {
+            env->dr[6] = arch_info->dr6;
+        }
     }
 
     return ret;
-- 
1.8.3.1



