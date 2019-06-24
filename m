Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D466C43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 12:52:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53F5F20679
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 12:52:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53F5F20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50900 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfOSb-0002ez-F3
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 08:52:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57432)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vkuznets@redhat.com>) id 1hfORx-0001o5-Vl
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 08:51:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vkuznets@redhat.com>) id 1hfORu-0007aQ-RM
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 08:51:56 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35264)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <vkuznets@redhat.com>) id 1hfORt-0007Ot-EF
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 08:51:54 -0400
Received: by mail-wm1-f68.google.com with SMTP id c6so13295167wml.0
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2019 05:51:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version:content-transfer-encoding;
 bh=EjyJVNaH0An7l3HNMRO5nkT465x+UE9Jzj1FPB9sExk=;
 b=R/rSZMrKCbWeyIGuuhvGAWfuxoG663giYvwHZvghE8xHE2uMDxzpcrVlkKaPkP4/f6
 4KHDAdgH6cDMKG6mfv0Yb519T5l59zHpOfx0LKMD4IEmUGCu2SZWi49MnKib3vdSn+VN
 dVplpGgZn7jMBbhHL6WrdKDNTN/OiWaUWYgaqgJ042aYD57eGqE2warh0wZgCALJ/0/a
 b31mIwzrcVTbmoj2EGRlFQkHe0Jae/ai9Woi1ixUDMMv3PvtYJJn0Ttj4u/QI40Y5kdu
 egZjO/lyJknrdy2iZ2ei7HmICZPcVqXqJZK+joXEDm/WafkEZN251nKBiiIQHgjGwNXf
 O7lQ==
X-Gm-Message-State: APjAAAXFCygqKGILs/86JtRmqC5+lUBGOualXalN8now2uloRWN8y2N2
 /JPMedkUBuSVFW74UcFujKax9Q==
X-Google-Smtp-Source: APXvYqyXSDa4cNA3OTVBF7FPRLru7mhpXDBv90ZnXGWjjPooG8d7Z3cw3pZU780hChDo0mFpeAzqaw==
X-Received: by 2002:a1c:4c1a:: with SMTP id z26mr15422859wmf.2.1561380710727; 
 Mon, 24 Jun 2019 05:51:50 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10])
 by smtp.gmail.com with ESMTPSA id w2sm10087809wrr.31.2019.06.24.05.51.49
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 24 Jun 2019 05:51:50 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-Reply-To: <20190624123835.28869-1-alex.bennee@linaro.org>
References: <20190624123835.28869-1-alex.bennee@linaro.org>
Date: Mon, 24 Jun 2019 14:51:49 +0200
Message-ID: <87zhm7du3e.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [PATCH] target/i386: fix feature check in
 hyperv-stub.c
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
Cc: peter.maydell@linaro.org, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-devel@nongnu.org, Roman Kagan <rkagan@virtuozzo.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Alex Bennée <alex.bennee@linaro.org> writes:

> Commit 2d384d7c8 broken the build when built with:
>
>   configure --without-default-devices --disable-user
>
> The reason was the conversion of cpu->hyperv_synic to
> cpu->hyperv_synic_kvm_only although the rest of the patch introduces a
> feature checking mechanism. So I've fixed the KVM_EXIT_HYPERV_SYNIC in
> hyperv-stub to do the same feature check as in the real hyperv.c
>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Roman Kagan <rkagan@virtuozzo.com>
> ---
>  target/i386/hyperv-stub.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/i386/hyperv-stub.c b/target/i386/hyperv-stub.c
> index fe548cbae2..0028527e79 100644
> --- a/target/i386/hyperv-stub.c
> +++ b/target/i386/hyperv-stub.c
> @@ -15,7 +15,7 @@ int kvm_hv_handle_exit(X86CPU *cpu, struct kvm_hyperv_exit *exit)
>  {
>      switch (exit->type) {
>      case KVM_EXIT_HYPERV_SYNIC:
> -        if (!cpu->hyperv_synic) {
> +        if (!hyperv_feat_enabled(cpu, HYPERV_FEAT_SYNIC)) {
>              return -1;
>          }

As I just sent out exactly the same patch, this probably means the fix
is uncontroversial :-)

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

