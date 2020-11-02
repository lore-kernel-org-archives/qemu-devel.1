Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0070C00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 10:26:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBFEE2071E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 10:26:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e6mNDcxM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBFEE2071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZX33-0008ER-Hb
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 05:26:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58298)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kZX2E-0007o1-Ju
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 05:25:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40029)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kZX2C-0003Im-BX
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 05:25:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604312753;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0i+r8zkLfSvZzA+y2wQ1NWMeSkorqmC4wRhVw95IzNw=;
 b=e6mNDcxMMqoFWkh/XmZn8TgQtQtZinHrcuamrO8w7ZEukSDoXRu66QJcSk1s6SYhBUJv9z
 tGQ2R5nGtSM7LmeOV3Kzqwk/jTCW0ypY05+fBZmhmfMMnQtoR6qGGtX+qIxQKC2OealuQr
 0hVuz2Wr42N6tIGxe6s0Osq/hYeNNm0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-93-ogE8aPUkOrGg1SpTvPcyEA-1; Mon, 02 Nov 2020 05:25:51 -0500
X-MC-Unique: ogE8aPUkOrGg1SpTvPcyEA-1
Received: by mail-wm1-f70.google.com with SMTP id e15so1722834wme.4
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 02:25:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0i+r8zkLfSvZzA+y2wQ1NWMeSkorqmC4wRhVw95IzNw=;
 b=MPcmk0cjPO4i4OPzgKgAC0i7ABZQOs18KjyEDvCp8wMYrIFA3KxvOKdQl8YqYYZcp7
 b/Si2welOI67cFG+rsEMdoDkeGPXMI3Dp15UBdkeTtfbfkulzz9pRxnmw+1etLZtJ9o4
 JcN9fvToEsZ5p/UiUJo0+793V401DoXj2wMJaA8659gYX0Czs1bRW4j68KP5lNPK83SI
 JVORyUrtqHNLH3M+ikiokOohC9ZnH9Izsgz0SRAvdlBVX/W9COxunL8ERm0FUhv+GDNG
 1btlrJ2aZU8YqZkypcI6+rFHTuwn6vaM6r+5guRkLPi4piEsW7xekcJOEffVWwledI2q
 vlag==
X-Gm-Message-State: AOAM5322eJAjlAiu6XatcAOJZyidl3qQ45+9RcetvDRjAWPYxKjNtLWb
 9Ta8i6sDZF4vElYAwM49dcBPTr0Rp929dfmGK64oFi35lmnZSzkIrYUGDK14bl1Mut8znISGAS2
 0R+nf6zxG1h//M7I=
X-Received: by 2002:a7b:c11a:: with SMTP id w26mr17631290wmi.78.1604312750739; 
 Mon, 02 Nov 2020 02:25:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwqdIrTYMHZpJpBEEXgRyuUY24Hsv9x8i58FP+Vu6e3gCJHk3wiDXtrox067dcoXRV869bxlg==
X-Received: by 2002:a7b:c11a:: with SMTP id w26mr17631270wmi.78.1604312750564; 
 Mon, 02 Nov 2020 02:25:50 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id l3sm17345839wmg.32.2020.11.02.02.25.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2020 02:25:49 -0800 (PST)
Subject: Re: [PATCH] pc: comment stule fixup
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
References: <20201102100948.1101121-1-mst@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <10d203e1-33d9-22f4-2395-d83561922b8c@redhat.com>
Date: Mon, 2 Nov 2020 11:25:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201102100948.1101121-1-mst@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 01:33:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/2/20 11:09 AM, Michael S. Tsirkin wrote:
> Fix up checkpatch comment style warnings.

Typo stule -> style in subject ;)

> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  hw/i386/pc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 416fb0e0f6..5872ae6095 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1150,9 +1150,9 @@ void pc_basic_device_init(struct PCMachineState *pcms,
>              exit(1);
>          }
>          /* For pc-piix-*, hpet's intcap is always IRQ2. For pc-q35-1.7

Since it needs a respin, maybe convert the 1st line too?

> -            * and earlier, use IRQ2 for compat. Otherwise, use IRQ16~23,
> -            * IRQ8 and IRQ2.
> -            */
> +         * and earlier, use IRQ2 for compat. Otherwise, use IRQ16~23,
> +         * IRQ8 and IRQ2.
> +         */
>          uint8_t compat = object_property_get_uint(OBJECT(hpet),
>                  HPET_INTCAP, NULL);
>          if (!compat) {
> 


