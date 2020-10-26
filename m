Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB0C1C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 09:56:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 465342087C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 09:56:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g2TXKPeC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 465342087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWzEk-0008Ba-56
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 05:56:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34950)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kWzBI-0005AW-C6
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 05:52:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42678)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kWzBG-0001ai-Mr
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 05:52:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603705965;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IaeP7KKKmxO8MibyEMUeiU7p6h6rT8EI48aWMgO/ECY=;
 b=g2TXKPeC3usgdZK60GbdC4YuA52Bi2uYNXYYDOb6kaG91dfXOdUyK8a3h04Mg2WSpJhqDX
 AUkrjVb8F1em4zBgYI9P5MNiH1oTmGVmlD3pgXU7MBvUnraDDpCaREB1bIyar/UxnZIHdy
 p/jhQvn3kmswxHc7L6gR81Q+LjkuOGU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-44-fjG__ouzPvm_qnorOwLdiw-1; Mon, 26 Oct 2020 05:52:43 -0400
X-MC-Unique: fjG__ouzPvm_qnorOwLdiw-1
Received: by mail-wr1-f69.google.com with SMTP id j15so771130wro.4
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 02:52:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IaeP7KKKmxO8MibyEMUeiU7p6h6rT8EI48aWMgO/ECY=;
 b=I6FYWMT8jXJN3lPmJ9cPP6c4mc5BaIyPnLaRLG5/rqGl6XOl1GhSPsFsQ0eYzWR0PI
 jEsSsJFeG8r6U0qHzooIExUJ2XCbaRGc/cs8kz0T07ykS0B50ZaexbjWNrIFCrMXIGci
 S+DVfuccqMr0KvpduUskOUjfmJncF4dqPk6wGEA7xywx+jcYWN5/dxR1XN1qkBNjTS0B
 JUsEvbXqzNT8GL7aIF4dAZRzkvbm84r4Hl2/HxpcmldQb9rBWjV4TXM9C1+323fkisjX
 ZhVLGf+ZEC3p0WQZGqeslFoXNnFAaku8kgF3xV7XasiTD+ehtVPC4phhpPC5ALCOMxr9
 Qfxw==
X-Gm-Message-State: AOAM530jOoIEDiIR2u5AHXT58GLqTzwXG46Kz2xO6ej+7wzR5blsVvN3
 /Jcv9PstQMZZu5nzKCXfq6TFMsbMdZDcQhg9hVQdj7J3DtD/LbRt/+eahemAWd8unqyc9p0ItQX
 KuyURpHayMrmw5X4=
X-Received: by 2002:adf:f101:: with SMTP id r1mr17977313wro.392.1603705962500; 
 Mon, 26 Oct 2020 02:52:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxG6zNG5If7O48x59KIH8zZgAVLYRn8SVYMt7zDMiqYjE4H91Drfbp4By6isAKN7grdYGkm6g==
X-Received: by 2002:adf:f101:: with SMTP id r1mr17977298wro.392.1603705962309; 
 Mon, 26 Oct 2020 02:52:42 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id s11sm21420109wrm.56.2020.10.26.02.52.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2020 02:52:41 -0700 (PDT)
Subject: Re: [PATCH v2 4/6] cfi: Initial support for cfi-icall in QEMU
To: Daniele Buono <dbuono@linux.vnet.ibm.com>, qemu-devel@nongnu.org
References: <20201023200645.1055-1-dbuono@linux.vnet.ibm.com>
 <20201023200645.1055-5-dbuono@linux.vnet.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <50a26676-722b-889a-b926-ad25e513d384@redhat.com>
Date: Mon, 26 Oct 2020 10:52:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201023200645.1055-5-dbuono@linux.vnet.ibm.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/25 21:03:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1,
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, Alexander Bulekov <alxndr@bu.edu>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 23/10/20 22:06, Daniele Buono wrote:
> +
> +#ifdef CONFIG_CFI
> +/* If CFI is enabled, use an attribute to disable cfi-icall on the following
> + * function */
> +#define __disable_cfi__ __attribute__((no_sanitize("cfi-icall")))
> +#else
> +/* If CFI is not enabled, use an empty define to not change the behavior */
> +#define __disable_cfi__
> +#endif
> +
> diff --git a/plugins/core.c b/plugins/core.c

__disable_cfi__ is a reserved identifier, since it starts with two
underscores.  Please name it QEMU_DISABLE_CFI and put it in
include/qemu/compiler.h.

Thanks,

Paolo


