Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 657AAC55178
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 13:46:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E580C21BE5
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 13:46:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IeZyHtlg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E580C21BE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX2pM-0000GZ-34
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 09:46:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37610)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kX2mP-0004AR-62
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 09:43:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46550)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kX2mL-0000Lz-I7
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 09:43:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603719795;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NlGQ1JqyweksmaNTz+9QQmeKHBPY6rAZYmVTZUvjgqE=;
 b=IeZyHtlgQXXHnCnK/jGc3ww5tUf9lDbok+Pv2zHX7VhI60uNT714O8L9/0vDkEqtVGqMHD
 nZg391DoprriqYjdkYlT4yzlWicvik2hBB7HnCXXLMcbAnsUVgEsVU680Wljo1fiai/Wn5
 EPxJAa60E1XV4RcCRmzvq2QnP597dug=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-568-NRtx9d01PSWOeTNjCE8aiQ-1; Mon, 26 Oct 2020 09:43:11 -0400
X-MC-Unique: NRtx9d01PSWOeTNjCE8aiQ-1
Received: by mail-ed1-f69.google.com with SMTP id 28so4293823edv.9
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 06:43:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=NlGQ1JqyweksmaNTz+9QQmeKHBPY6rAZYmVTZUvjgqE=;
 b=awBpF2yz8mTW0j2a2f970pcxA+yz0CpprDqh22dpgCXOcptGXtfie22pqlR3egRWpv
 FlDVx1QnJIKagpnHMHOAVPDtLe1OXL2NYhdtK3XX9ok3BZNdiUIhMihzazquKGmuh6cL
 CwZ0oBkp5a4zD4coB9zA5C9UR2ib/DjWc7f1eqeNYC5eap6YDrASTA/kW1Ce/9lKklil
 WHemEmE/MQH7RT+Up07Dep+FlyyxJO0U+HN6P37KsDyp65fNCauZ4L7RIqwjD0d6oMbW
 gH2OfBjmSgWUhjmn0En0zkWq6uuS0GaFOaUIa862SnuMiz2kPODxYsDuyI5w6NuCCXDg
 Sh6w==
X-Gm-Message-State: AOAM533LU4ya+DuM5k/h+35xHIbDRjNRpacuZl3kJlROVxXzIvvL30YU
 8yypjH3OmNvml4t8bj9uRLqXQDS2zfPsINh8VyDD4tZE1mBNoPPp405PlrU7CrtXCqQno2harSD
 uUZAz6ce2qiZcKU8=
X-Received: by 2002:a17:906:f205:: with SMTP id
 gt5mr15721306ejb.48.1603719790268; 
 Mon, 26 Oct 2020 06:43:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxe9MBRquXjMekoPck8GlcsgOl6dSxQDfnAVyADHW7JbyRrDCcayswtqJKcrpp1t/79xAoyzw==
X-Received: by 2002:a17:906:f205:: with SMTP id
 gt5mr15721287ejb.48.1603719790033; 
 Mon, 26 Oct 2020 06:43:10 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id vr3sm6026081ejb.124.2020.10.26.06.43.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2020 06:43:09 -0700 (PDT)
Subject: Re: [PATCH 1/4] spapr: qemu_memalign() doesn't return NULL
To: Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
References: <160371602625.305923.7832478283946753271.stgit@bahia.lan>
 <160371603337.305923.17158585537944509438.stgit@bahia.lan>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <7b6abe52-c17e-09b8-9239-e0e38d4d0a1f@redhat.com>
Date: Mon, 26 Oct 2020 14:43:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <160371603337.305923.17158585537944509438.stgit@bahia.lan>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/25 21:03:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.167, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/26/20 1:40 PM, Greg Kurz wrote:
> qemu_memalign() aborts if OOM. Drop some dead code.
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>   hw/ppc/spapr.c       |    6 ------
>   hw/ppc/spapr_hcall.c |    8 ++------
>   2 files changed, 2 insertions(+), 12 deletions(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 0cc19b5863a4..f098d0ee6d98 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1521,12 +1521,6 @@ void spapr_reallocate_hpt(SpaprMachineState *spapr, int shift,
>           int i;
>   
>           spapr->htab = qemu_memalign(size, size);
> -        if (!spapr->htab) {
> -            error_setg_errno(errp, errno,
> -                             "Could not allocate HPT of order %d", shift);
> -            return;

Wasn't the idea to use qemu_try_memalign() here?

> -        }
> -
>           memset(spapr->htab, 0, size);
>           spapr->htab_shift = shift;
>   
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index 607740150fa2..34e146f628fb 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -361,12 +361,8 @@ static void *hpt_prepare_thread(void *opaque)
>       size_t size = 1ULL << pending->shift;
>   
>       pending->hpt = qemu_memalign(size, size);
> -    if (pending->hpt) {
> -        memset(pending->hpt, 0, size);
> -        pending->ret = H_SUCCESS;
> -    } else {
> -        pending->ret = H_NO_MEM;

Ditto.

> -    }
> +    memset(pending->hpt, 0, size);
> +    pending->ret = H_SUCCESS;
>   
>       qemu_mutex_lock_iothread();
>   


