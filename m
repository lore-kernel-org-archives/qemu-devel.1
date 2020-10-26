Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01C4CC4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 17:03:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6310E206D4
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 17:03:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MPLlDywQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6310E206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX5tq-0006Hy-GG
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 13:03:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43214)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kX5qN-0002zV-Ku
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 12:59:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55098)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kX5qK-0005cL-RI
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 12:59:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603731576;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z+kXbEM/Nq2H+uTRufx+cyFwcq6wPhqZXTX3wXf2zjs=;
 b=MPLlDywQ+Pi7BtsZ1cNDJFwAA/RaqVFNVbuRDCkxZczyqpCQSEal/T816CGB0CYQO6vJP6
 8GIabJrBbCh9VenCB/KF2Yyg/4FwW4uKmpm/RpeJBLw0iIE1xk+qjAzoEDsRVr00yTTQ88
 V63XBkPrYSH0G7dI8Kg3E1BpX6yipPA=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235-IM_plVwVOYmUJrOoRiPTLQ-1; Mon, 26 Oct 2020 12:59:34 -0400
X-MC-Unique: IM_plVwVOYmUJrOoRiPTLQ-1
Received: by mail-ed1-f72.google.com with SMTP id n16so4808274edw.19
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 09:59:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Z+kXbEM/Nq2H+uTRufx+cyFwcq6wPhqZXTX3wXf2zjs=;
 b=PUpO0o1hFM3gVMPRW6d/KdCNkobQ3cLFDXX1aS/cgLPp3AXBhecbT6eJw3FkCDDDp/
 /QR3oT6Y7oNbyZLzPeNE53Z1f0VaMJSESdm9Avga7mh3e9SNztDu+AESVmQ83CUCPd9+
 z1LFqrEXm9tAreeNwznTL8Vtbu+ELVloxuSJZssqa5juu5G4QliREC9EEiHcIlhq2s7G
 MULuTLGGY/TAvCEooF+c6laGii1iKg7S7brdLuU7w7ONp4bybiP83Ch16kPwt+axTU4r
 6gHjC/aO5DNliogAhB8yJcfSipMxRvWZ3BDzzG/1PXJOmUByoizsIwtth2UwvRuW4Gvt
 eQTA==
X-Gm-Message-State: AOAM530WcvBzpgzVen1wLoNTDdm016JeQkg8X0VlygChRN0qbkgDlToy
 lezq1IVZAV9X2WQsy8sxFSa7dfFMUA1Eewmkb+Dqf94sc0TbF5wCLjN+/P9lKQAf7NNmeVBLso9
 48ZY2qtpKrj10cUs=
X-Received: by 2002:a50:ef12:: with SMTP id m18mr16766497eds.313.1603731573344; 
 Mon, 26 Oct 2020 09:59:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJytsbxFDVdtD9YDXVszXYc4Jt9K/gQWwtFwfn+1YINBANu444FwFPBndRVGWZVT5uW0Ici2Tg==
X-Received: by 2002:a50:ef12:: with SMTP id m18mr16766407eds.313.1603731571617; 
 Mon, 26 Oct 2020 09:59:31 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id e17sm6308135ejh.64.2020.10.26.09.59.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2020 09:59:30 -0700 (PDT)
Subject: Re: [PULL v2 0/2] Tracing patches
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
References: <20201026160221.62704-1-stefanha@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d620c1d4-d3c2-47dc-5bc7-78c01944a1eb@redhat.com>
Date: Mon, 26 Oct 2020 17:59:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201026160221.62704-1-stefanha@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 02:39:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.167, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Stefan,

On 10/26/20 5:02 PM, Stefan Hajnoczi wrote:
> The following changes since commit 4c5b97bfd0dd54dc27717ae8d1cd10e14eef1430:
> 
>    Merge remote-tracking branch 'remotes/kraxel/tags/modules-20201022-pull-request' into staging (2020-10-22 12:33:21 +0100)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/stefanha/qemu.git tags/tracing-pull-request
> 
> for you to fetch changes up to 1e8ebf1116a7023b4dd1919d31af8b4e17321da4:
> 
>    Add execute bit back to scripts/tracetool.py (2020-10-26 13:22:36 +0000)
> 
> ----------------------------------------------------------------
> Pull request
> 
> ----------------------------------------------------------------
> 
> Anthony PERARD via (1):
>    Add execute bit back to scripts/tracetool.py

Author email is incorrect: Anthony PERARD via <qemu-devel@nongnu.org>

> 
> Josh DuBois (1):
>    trace/simple: Enable tracing on startup only if the user specifies a
>      trace option
> 
>   trace/control.c      | 6 +++++-
>   scripts/tracetool.py | 0
>   2 files changed, 5 insertions(+), 1 deletion(-)
>   mode change 100644 => 100755 scripts/tracetool.py
> 


