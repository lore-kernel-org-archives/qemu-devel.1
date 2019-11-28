Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC1BC432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 14:40:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 430F02071F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 14:40:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hRu1ZMlh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 430F02071F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaKyA-0007cL-Cj
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 09:40:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53077)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iaKHo-0000wH-I7
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 08:56:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iaKHf-0005Np-MM
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 08:56:40 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21315
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iaKHe-00056P-FQ
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 08:56:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574949395;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h+U3ENo6Nxs9oMrIK43N88tQQZGmJePHCZejmxXN16I=;
 b=hRu1ZMlh12BqhE6iA+lcXHD4K2sL0Xa53qON0+v+8QNRQFkKBctBkcC2iqhIvEvPsmBs6w
 uagz4/CNad24Kbd4MpjWIVnPlv+NqZQdyWxOumtXuKFCV1z7Hd/I7w5+jIHlEuS62P5k2y
 Ni+19Zhj/Ykoq7r6HJEzwOkjzOjgBnU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-INMJyQgMPluAWgaymi6JrQ-1; Thu, 28 Nov 2019 08:56:33 -0500
Received: by mail-wm1-f70.google.com with SMTP id z3so3606248wmk.1
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2019 05:56:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=h+U3ENo6Nxs9oMrIK43N88tQQZGmJePHCZejmxXN16I=;
 b=l2guzvk9thq+LXiqwZaq/tOEm6cPc5dQTeyODn7H2Mskr56XWIJG4jH0L94Cd7UGaW
 XC7rVFkIDCjl1iJBWlnehnDtjh7xV1KdWnKdG7tnS0iz/uwcUg4A3QED/QUSNvhCNwv/
 YxQh8og2pUclQbEwmymVC+86HpyOQZdwegSuwHyv3Ib7wK/6CvpG8YktD95CVy4bgu0K
 n8BEvUMDQtlV8z1LjsxU2S0nwzQOup0jACM1aXbrZPi8uqlzZ7SYUsl+8vqw1lHUKNsg
 +4KOe6qq8UFsRzFQTWvTeSkDekKoVtgllF1+VuzpljpZY96APYNWBOivRukQ4UDEaPxM
 QKyQ==
X-Gm-Message-State: APjAAAVl3WeCkGmu1EZolBhHEnFt9He5U29xzkdKMLzok0o0E3KZEaEh
 vuRttrLmyi7OhrmSCIAYswi0aoSE1ANHhUUBuSR1O+76I290ru+kUISd0JXl3cWEGH6uAxDk1zu
 afHlMBE7D99MDtRE=
X-Received: by 2002:adf:eecc:: with SMTP id a12mr36568238wrp.363.1574949392112; 
 Thu, 28 Nov 2019 05:56:32 -0800 (PST)
X-Google-Smtp-Source: APXvYqzDlXDLMtvS2ddKdsDWTpXa4+tMMzW3C+CJVYGQovQ1fgo6ZuVFC8A9l/GF0dV9mxgeJGapQQ==
X-Received: by 2002:adf:eecc:: with SMTP id a12mr36568220wrp.363.1574949391867; 
 Thu, 28 Nov 2019 05:56:31 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:459f:99a9:39f1:65ba?
 ([2001:b07:6468:f312:459f:99a9:39f1:65ba])
 by smtp.gmail.com with ESMTPSA id u14sm23771982wrm.51.2019.11.28.05.56.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Nov 2019 05:56:31 -0800 (PST)
Subject: Re: [PATCH v2 5/5] hvf: save away type as well as vector so we can
 reinject them
To: Cameron Esfahani <dirty@apple.com>
References: <cover.1574625592.git.dirty@apple.com>
 <e07e6085d8ab9054e58f85ae58e112df6adc024d.1574625592.git.dirty@apple.com>
 <eb3a2de7-fcfe-f0d5-8534-1c59ff40f61e@redhat.com>
 <5F8C8B54-3653-4417-9A08-E724032294F9@apple.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <cdc4958b-6ef5-aee2-1cf2-8cb59ca031fe@redhat.com>
Date: Thu, 28 Nov 2019 14:56:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <5F8C8B54-3653-4417-9A08-E724032294F9@apple.com>
Content-Language: en-US
X-MC-Unique: INMJyQgMPluAWgaymi6JrQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 26/11/19 21:04, Cameron Esfahani wrote:
> Our test case was booting many concurrent macOS VMs under heavy
> system load.  I don't know if I could create one to replicate that.

Does this work?

diff --git a/target/i386/hvf/x86hvf.c b/target/i386/hvf/x86hvf.c
index 1485b95776..26c6c3a49f 100644
--- a/target/i386/hvf/x86hvf.c
+++ b/target/i386/hvf/x86hvf.c
@@ -357,7 +357,11 @@ bool hvf_inject_interrupts(CPUState *cpu_state)
     bool have_event = true;
     if (env->interrupt_injected != -1) {
         vector = env->interrupt_injected;
-        intr_type = VMCS_INTR_T_SWINTR;
+        if (env->ins_len) {
+            intr_type = VMCS_INTR_T_SWINTR;
+        } else {
+            intr_type = VMCS_INTR_T_HWINTR;
+        }
     } else if (env->exception_nr != -1) {
         vector = env->exception_nr;
         if (vector == EXCP03_INT3 || vector == EXCP04_INTO) {

Thanks,

Paolo


