Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2647C4363D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 02:48:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05ED8206DC
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 02:48:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aEf6zLeW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05ED8206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKupO-0000Fs-ST
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 22:48:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56802)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kKunl-0007sI-Gr
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 22:46:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22451)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kKuni-0007cJ-FS
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 22:46:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600829191;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/lh34OiXB1TcHfGXtoYHhpPBDKHfjh7czJGs0xeiWY0=;
 b=aEf6zLeWodx0B0jZhknoo17Y3HY5mKSdF6SkO2KDDhrZvRt6h2KaMcpl/Il/Zxm8uIqqnU
 CSI4HKvjuKW1VOtk69vC0qDarwK+PLwSl8oOl1Sbqji1hzmaWBr1mqkCbZCenSX6svq9rV
 8FvZH5i8Kz4Nq2VFMmxX5ZRSTWy5weY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-R5a62sITM72idhhthrHvFA-1; Tue, 22 Sep 2020 22:46:24 -0400
X-MC-Unique: R5a62sITM72idhhthrHvFA-1
Received: by mail-wm1-f72.google.com with SMTP id m19so1628433wmg.6
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2020 19:46:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/lh34OiXB1TcHfGXtoYHhpPBDKHfjh7czJGs0xeiWY0=;
 b=U9SE/uXrs74P6bkhN5FZGy0ydgHlwEfXziHdBpk4LPy7FpETbYAtCsXIaHry2WU1xM
 GlJe5KmxVGs+pmglA/anhKpgQOvyktgDRo31Iz8+RaeVlU+prykIpK/b0X7qd4cnZrrN
 NWwfOQs4RzMdDdt4UenW3sLRWvQd5cfpI9EytboTxeKCAsYtqVxvUlCV8SluBIzhre2I
 EzS1Q64yfjaSxEfV+DsoZKZchQZ0ng1Emo/19atlUbWJxWGKM+VL7OK8NMJYvNan3tgQ
 KYd4QITmFEh05TXmB8eJ9pNOSUfM/4iVOBL9kpVQbfbXz8SUkb5gN2vTBcW/b0MQ0kwa
 6bRw==
X-Gm-Message-State: AOAM532UU0AkFIS840HAo3kR0tVR7qv5DY36LxnYPyL5HaXBkkIvplwG
 A7dyqfabQgaV0J4Vyg9TDjymYoW/Xqf+nYtNqseDGkBcbckO/wPYplWZ/4TJN/YH+b6Tb8TZPK/
 vU9NGYe0G6Zcz0ow=
X-Received: by 2002:a1c:4e08:: with SMTP id g8mr3881132wmh.53.1600829182993;
 Tue, 22 Sep 2020 19:46:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzMlWOpvs0Cr6KaiDZyCKfHgMcM0ynX9EDi//oefniNXLz8ACblp422O4KsV6BDoAAPQTPMHQ==
X-Received: by 2002:a1c:4e08:: with SMTP id g8mr3881114wmh.53.1600829182770;
 Tue, 22 Sep 2020 19:46:22 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:2eaa:3549:74e8:ad2b?
 ([2001:b07:6468:f312:2eaa:3549:74e8:ad2b])
 by smtp.gmail.com with ESMTPSA id g8sm6288908wmd.12.2020.09.22.19.46.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Sep 2020 19:46:22 -0700 (PDT)
Subject: Re: [PATCH] bios-tables-test: Remove kernel-irqchip=off option
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
References: <20200922194732.2100510-1-ehabkost@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4fd276da-3397-c315-b8b3-6166c92ae01c@redhat.com>
Date: Wed, 23 Sep 2020 04:46:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200922194732.2100510-1-ehabkost@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 21:51:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Laurent Vivier <lvivier@redhat.com>, 1896263@bugs.launchpad.net,
 Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22/09/20 21:47, Eduardo Habkost wrote:
> We don't need to use kernel-irqchip=off for irq0 override if IRQ
> routing is supported by the host, which is the case since 2009
> (IRQ routing was added to KVM in Linux v2.6.30).
> 
> This is a more straightforward fix for Launchpad bug #1896263, as
> it doesn't require increasing the complexity of the MSR code.
> kernel-irqchip=off is for debugging only and there's no need to
> increase the complexity of the code just to work around an issue
> that was already fixed in the kernel.
> 
> Fixes: https://bugs.launchpad.net/bugs/1896263
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  tests/qtest/bios-tables-test.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
> index a9c8d478aee..27e8f0a1cb7 100644
> --- a/tests/qtest/bios-tables-test.c
> +++ b/tests/qtest/bios-tables-test.c
> @@ -663,8 +663,7 @@ static void test_acpi_one(const char *params, test_data *data)
>              data->uefi_fl1, data->uefi_fl2, data->cd, params ? params : "");
>  
>      } else {
> -        /* Disable kernel irqchip to be able to override apic irq0. */
> -        args = g_strdup_printf("-machine %s,kernel-irqchip=off %s -accel tcg "
> +        args = g_strdup_printf("-machine %s %s -accel tcg "
>              "-net none -display none %s "
>              "-drive id=hd0,if=none,file=%s,format=raw "
>              "-device %s,drive=hd0 ",
> 

Queued, thanks.

Paolo


