Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C89DC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 11:35:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E1C622242
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 11:35:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Noa1QOKv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E1C622242
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUpv2-0002b8-Gk
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 07:35:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55698)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kUpu4-0001eQ-Sh
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 07:34:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60390)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kUpu2-0002NB-D2
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 07:34:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603193644;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QONgRfenDuI4RpW0FL5NIret7BNhEnCuWDDU9PU5+As=;
 b=Noa1QOKvMsxLQfvP81anStTvN1Rk3kIeFgbYrFGlVSWKcZ0eKskvr4RWJK93+SpFq27Q7v
 3sEvXTTuCZjcx2aVyfW5vtGN15k8o8jcc1RZ/Lj+lk9Qd3q+pLaCNEXnFv7Wxyo/yk04Di
 1bfmwvBS2xWx2MLZihykz0iMrDVE8xk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-258-aaceRuvTNNedOVvC0bW9GA-1; Tue, 20 Oct 2020 07:34:03 -0400
X-MC-Unique: aaceRuvTNNedOVvC0bW9GA-1
Received: by mail-wm1-f72.google.com with SMTP id r19so348053wmh.9
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 04:34:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QONgRfenDuI4RpW0FL5NIret7BNhEnCuWDDU9PU5+As=;
 b=FA6NxHhDJztyYR/2osP08TcXlIWooWqa+HuLhZw+n2tsIhBhv6l7MP02PhjhcXGz+6
 1cJZUIVln5Uc0kgh5fQaArlksFUNWjlLnOVlR8mEJ4s/KaylbSYiiv/XOnvbcCbeP+Gy
 VZDlrdW9zVtkTqnGauWDXEfFi1KCvULmK24tStRA+ZYCM6tspAj3x968SCdin7jBUF/n
 7Nmrz16Ato7RugsKCXKbcby0I4Fg5I/TxKwA7OvqlUhbKkg8xz0M1NVaHVOpF9QZN0H9
 q+7ogX4eiYNTbrgxyeiFkXm/zLGLePJ7UWragXiNO3Vq+btmTmymyhFPjgymz9jlLaW0
 dISw==
X-Gm-Message-State: AOAM531i/FuXipsdJ6k+3EPU4kpXnMfQD6gXcnec5s0LgrXONW20Z0C8
 HLKVFvTG8UfsNDZyShRmbiFa/vRlWx3RYd6Bvhuo/h4Va4wxY8+4kEecvpD39YYdxOApoDUQZog
 UzgSuWcluCSGeyQw=
X-Received: by 2002:adf:edc6:: with SMTP id v6mr2941057wro.273.1603193642053; 
 Tue, 20 Oct 2020 04:34:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw6PL5IpnV1bxIUa5iO6FR+78bxzjTJeAN0rU8dfHQv803JJ7D86sd1/6Ddrg1A3SXEjx6Jog==
X-Received: by 2002:adf:edc6:: with SMTP id v6mr2941020wro.273.1603193641803; 
 Tue, 20 Oct 2020 04:34:01 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id i10sm2977962wrq.27.2020.10.20.04.34.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2020 04:34:00 -0700 (PDT)
Subject: Re: [RFC 5/5] block/nvme: Align iov's va and size on host page size
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, stefanha@redhat.com,
 fam@euphon.net, alex.williamson@redhat.com
References: <20201015115252.15582-1-eric.auger@redhat.com>
 <20201015115252.15582-6-eric.auger@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <71f7e137-6664-60d9-eb20-887de6a05eac@redhat.com>
Date: Tue, 20 Oct 2020 13:33:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201015115252.15582-6-eric.auger@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:15:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: kwolf@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/15/20 1:52 PM, Eric Auger wrote:
> Make sure iov's va and size are properly aligned on the host page
> size.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>   block/nvme.c | 13 +++++++------
>   1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/block/nvme.c b/block/nvme.c
> index be8ec48bf2..45807ed110 100644
> --- a/block/nvme.c
> +++ b/block/nvme.c
> @@ -978,11 +978,12 @@ static coroutine_fn int nvme_cmd_map_qiov(BlockDriverState *bs, NvmeCmd *cmd,
>       for (i = 0; i < qiov->niov; ++i) {
>           bool retry = true;
>           uint64_t iova;
> +        size_t len = QEMU_ALIGN_UP(qiov->iov[i].iov_len,
> +                                   qemu_real_host_page_size);
>   try_map:
>           r = qemu_vfio_dma_map(s->vfio,
>                                 qiov->iov[i].iov_base,
> -                              qiov->iov[i].iov_len,
> -                              true, &iova);
> +                              len, true, &iova);
>           if (r == -ENOMEM && retry) {
>               retry = false;
>               trace_nvme_dma_flush_queue_wait(s);
> @@ -1126,8 +1127,8 @@ static inline bool nvme_qiov_aligned(BlockDriverState *bs,
>       BDRVNVMeState *s = bs->opaque;
>   
>       for (i = 0; i < qiov->niov; ++i) {
> -        if (!QEMU_PTR_IS_ALIGNED(qiov->iov[i].iov_base, s->page_size) ||
> -            !QEMU_IS_ALIGNED(qiov->iov[i].iov_len, s->page_size)) {
> +        if (!QEMU_PTR_IS_ALIGNED(qiov->iov[i].iov_base, qemu_real_host_page_size) ||
> +            !QEMU_IS_ALIGNED(qiov->iov[i].iov_len, qemu_real_host_page_size)) {
>               trace_nvme_qiov_unaligned(qiov, i, qiov->iov[i].iov_base,
>                                         qiov->iov[i].iov_len, s->page_size);
>               return false;
> @@ -1143,7 +1144,7 @@ static int nvme_co_prw(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
>       int r;
>       uint8_t *buf = NULL;
>       QEMUIOVector local_qiov;
> -
> +    size_t len = QEMU_ALIGN_UP(bytes, qemu_real_host_page_size);
>       assert(QEMU_IS_ALIGNED(offset, s->page_size));
>       assert(QEMU_IS_ALIGNED(bytes, s->page_size));
>       assert(bytes <= s->max_transfer);
> @@ -1151,7 +1152,7 @@ static int nvme_co_prw(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
>           return nvme_co_prw_aligned(bs, offset, bytes, qiov, is_write, flags);
>       }
>       trace_nvme_prw_buffered(s, offset, bytes, qiov->niov, is_write);
> -    buf = qemu_try_memalign(s->page_size, bytes);
> +    buf = qemu_try_memalign(qemu_real_host_page_size, len);
>   
>       if (!buf) {
>           return -ENOMEM;
> 


