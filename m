Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87875C33C99
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 10:52:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50BE620678
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 10:52:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FWELFU0d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50BE620678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iomTB-0002Bc-CN
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 05:52:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55864)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iomAL-0002N3-V2
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 05:32:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iomAK-0004So-Ff
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 05:32:49 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57673
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iomAK-0004Sd-C4
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 05:32:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578393167;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8Le5hZ/Wfhmw2PDPjqsu0uBKJUVGybeJ15wX6trk4gM=;
 b=FWELFU0duom/UjJI6okBCZk1Y5BaHi9zVWcrphcml7HwpGhhMGA0nsJ3OvDg9lHYKcmuW5
 RYZcC7D6AQ990MsA/R2ZsSARhmJHMNeLbiKn2uv8y5XvvRjf/Tuz69aHkt/QDTx22I7FyN
 xtrDKM3P4E0YruAKUxnt2rXA0GjvmVQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-R07r0htMN-u21n-itjRSfQ-1; Tue, 07 Jan 2020 05:32:45 -0500
Received: by mail-wr1-f70.google.com with SMTP id t3so27658638wrm.23
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 02:32:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8Le5hZ/Wfhmw2PDPjqsu0uBKJUVGybeJ15wX6trk4gM=;
 b=s4usNiwC/n+ZNakdiEf0HV4C1qLXu8s2spthFeA5nU1xcHkoCY2kDwuQt3g8aM2pLo
 wUkM7+Iog5c2o0MQEwuYdf7elPoV75aHuCaJuVK/fAZ1slx3hyffPu4esoblDwSjCW9W
 8LJXuXU3u4zhQpKf8eCHa2VobHSl/BaDB0jIMALE4oy2l0KoFUXb4zmR3+ira9nh3Xtd
 JhNheHvrg5i2FnIfXmx6eqF40kBeq21glqHW4e5yuWNDQOk7MBXV7k2pwFD+1ZQS9MRp
 v+UL3fwumsQ42vqYYRpPU8vcLXtDMpIkJz7qV4czMUPakUPrJsuWpZPpQ0IzEonhS5kB
 WnmQ==
X-Gm-Message-State: APjAAAXkb7j32dc63JXlymGHlutMc2wT1i6KlOa7d0UBG3ihPXNarP7r
 EJuQD6q8rEiqnctCWiSF7Dknm0+Oy5FA+X0BeAoBeYmY1L7J+ttPtztPDFaqkHBuPBxE+MJX8uz
 iqP31zkUcjh4yQ/w=
X-Received: by 2002:adf:ef0b:: with SMTP id e11mr91722156wro.128.1578393164562; 
 Tue, 07 Jan 2020 02:32:44 -0800 (PST)
X-Google-Smtp-Source: APXvYqybSbZb5FJzY0fq+KgPJEKtW48Ac5mhKJ5Jv6LZbrICgSGHwJIumMUJxewtQx+zER1Ev93xjQ==
X-Received: by 2002:adf:ef0b:: with SMTP id e11mr91722133wro.128.1578393164333; 
 Tue, 07 Jan 2020 02:32:44 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c6d:4079:b74c:e329?
 ([2001:b07:6468:f312:c6d:4079:b74c:e329])
 by smtp.gmail.com with ESMTPSA id v3sm77347697wru.32.2020.01.07.02.32.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jan 2020 02:32:43 -0800 (PST)
Subject: Re: [PATCH v2] accel/kvm: Make "kernel_irqchip" default on
To: Xiaoyao Li <xiaoyao.li@intel.com>, Eduardo Habkost <ehabkost@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20191228104326.21732-1-xiaoyao.li@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <05532242-3a70-b547-3765-0ab29583c4b0@redhat.com>
Date: Tue, 7 Jan 2020 11:32:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191228104326.21732-1-xiaoyao.li@intel.com>
Content-Language: en-US
X-MC-Unique: R07r0htMN-u21n-itjRSfQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 28/12/19 11:43, Xiaoyao Li wrote:
> Commit 11bc4a13d1f4 ("kvm: convert "-machine kernel_irqchip" to an
> accelerator property") moves kernel_irqchip property from "-machine" to
> "-accel kvm", but it forgets to set the default value of
> kernel_irqchip_allowed and kernel_irqchip_split.
> 
> Also cleaning up the three useless members (kernel_irqchip_allowed,
> kernel_irqchip_required, kernel_irqchip_split) in struct MachineState.
> 
> Fixes: 11bc4a13d1f4 ("kvm: convert "-machine kernel_irqchip" to an accelerator property")
> Reported-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
> Changes in v2:
>   - Add Reported-by tag;
>   - Initialize kernel_irqchip_split in init_machine();

Now that I am actually reviewing the patch on something other than a
phone, I think this would break "-machine kernel_irqchip=split".  I'll
test, and squash if it works, something like this:

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index afbbe0a1af..ea35433170 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -98,7 +98,7 @@ struct KVMState
     int kvm_shadow_mem;
     bool kernel_irqchip_allowed;
     bool kernel_irqchip_required;
-    bool kernel_irqchip_split;
+    OnOffAuto kernel_irqchip_split;
     bool sync_mmu;
     bool manual_dirty_log_protect;
     /* The man page (and posix) say ioctl numbers are signed int, but
@@ -1799,7 +1799,7 @@ static void kvm_irqchip_create(KVMState *s)
      * in-kernel irqchip for us */
     ret = kvm_arch_irqchip_create(s);
     if (ret == 0) {
-        if (s->kernel_irqchip_split) {
+        if (s->kernel_irqchip_split == ON_OFF_AUTO_ON) {
             perror("Split IRQ chip mode not supported.");
             exit(1);
         } else {
@@ -2070,7 +2070,9 @@ static int kvm_init(MachineState *ms)
         goto err;
     }
 
-    s->kernel_irqchip_split = mc->default_kernel_irqchip_split;
+    if (s->kernel_irqchip_split == ON_OFF_AUTO_AUTO) {
+        s->kernel_irqchip_split = mc->default_kernel_irqchip_split ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
+    }
 
     if (s->kernel_irqchip_allowed) {
         kvm_irqchip_create(s);
@@ -3007,17 +3009,17 @@ static void kvm_set_kernel_irqchip(Object *obj, Visitor *v,
         case ON_OFF_SPLIT_ON:
             s->kernel_irqchip_allowed = true;
             s->kernel_irqchip_required = true;
-            s->kernel_irqchip_split = false;
+            s->kernel_irqchip_split = ON_OFF_AUTO_OFF;
             break;
         case ON_OFF_SPLIT_OFF:
             s->kernel_irqchip_allowed = false;
             s->kernel_irqchip_required = false;
-            s->kernel_irqchip_split = false;
+            s->kernel_irqchip_split = ON_OFF_AUTO_OFF;
             break;
         case ON_OFF_SPLIT_SPLIT:
             s->kernel_irqchip_allowed = true;
             s->kernel_irqchip_required = true;
-            s->kernel_irqchip_split = true;
+            s->kernel_irqchip_split = ON_OFF_AUTO_ON;
             break;
         default:
             /* The value was checked in visit_type_OnOffSplit() above. If
@@ -3040,7 +3042,7 @@ bool kvm_kernel_irqchip_required(void)
 
 bool kvm_kernel_irqchip_split(void)
 {
-    return kvm_state->kernel_irqchip_split;
+    return kvm_state->kernel_irqchip_split == ON_OFF_AUTO_ON;
 }
 
 static void kvm_accel_instance_init(Object *obj)
@@ -3049,6 +3051,7 @@ static void kvm_accel_instance_init(Object *obj)
 
     s->kvm_shadow_mem = -1;
     s->kernel_irqchip_allowed = true;
+    s->kernel_irqchip_split = ON_OFF_AUTO_AUTO;
 }
 
 static void kvm_accel_class_init(ObjectClass *oc, void *data)

As a follow up, kernel_irqchip_allowed and kernel_irqchip_required could also be changed to a single OnOffAuto field, I think.

Paolo


