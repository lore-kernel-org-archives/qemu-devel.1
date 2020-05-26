Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E5EC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 12:05:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99C1720787
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 12:05:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fszqtawo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99C1720787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdYKr-00079K-QZ
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 08:05:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46912)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jdYJQ-0006SG-Jh
 for qemu-devel@nongnu.org; Tue, 26 May 2020 08:04:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26768
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jdYJP-0007Dw-W5
 for qemu-devel@nongnu.org; Tue, 26 May 2020 08:04:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590494643;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Z3Wq3Em2Aw2dsLEqjMlNDuFafdjpjpHZo5g/RkevMuo=;
 b=fszqtawoH/y2WFheYHW5IxndZsdQFwigQaHNSf2KowrsaOlZAYDQpDIIeSH4iMESUfJq5s
 sb/R3LnRnfieUmnWyYPHTn/8ZdkbNsa7BKnQWeFm2Q6+30Xwcl1eVsKaFJQjXM42GAZ16m
 s6TpB9Bwxi3EgLbZIShF7PZuHTCUkLI=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-16-99wn7B-8NmCXZjyvT_yEFA-1; Tue, 26 May 2020 08:03:59 -0400
X-MC-Unique: 99wn7B-8NmCXZjyvT_yEFA-1
Received: by mail-ej1-f69.google.com with SMTP id g9so6450438ejs.20
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 05:03:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=Z3Wq3Em2Aw2dsLEqjMlNDuFafdjpjpHZo5g/RkevMuo=;
 b=UDgDy6ZVjViQhNEB6ERSQ/qB90K0Wmi8jzGIzLFvzkpgV1ik8Uii0Hmrf4S2d4mi5k
 0EjVjMnNppi+hvr/1TXGSLo+oMpULSZ3pfpSji7nXF3v7PLntnIuWxU5fF4zAqDsPx+T
 zW9hTmgzeihV9uEupiUFz8xFJKF0O9hz1sf98lkbSqNhjx/mXuIP3oAo1FHYLuKY47Go
 LisEeMCltnSl5Hr/CRIbbHNsuw09gzHox2Fv+bhaHovxIt2NAGos4bzIas/MTqA1+QTp
 z6uenFUSZviTHcKWyUcyFMqUCtpjPLXtTDfSOvy+nvF7oTVSaUrB+of7mM9UibMmFok3
 rOzA==
X-Gm-Message-State: AOAM532iLRMLtedfGPrq8MSbUhfyN3PE1Ghicdp+7UCmpBGq3zetomXB
 jzvxBz4Vlfdr4MG0J4/RtWjG3AR9dnRRcQ6W07yJ1ggIPqts8G3YpATQk2ky3odGnlwTzrawkPu
 TKbrwqjnC+Ef2gzI=
X-Received: by 2002:a17:906:3b4f:: with SMTP id
 h15mr744488ejf.421.1590494637910; 
 Tue, 26 May 2020 05:03:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz1vI4FeQmvrUZuqj/zGxiwM6bsAOzDtMpF/Q/U+Qskb2D16/n6xnhqJnRf3u2kHflpHfDouQ==
X-Received: by 2002:a17:906:3b4f:: with SMTP id
 h15mr744473ejf.421.1590494637708; 
 Tue, 26 May 2020 05:03:57 -0700 (PDT)
Received: from [192.168.1.36] (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id k27sm17930203eji.18.2020.05.26.05.03.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2020 05:03:56 -0700 (PDT)
Subject: Re: [PATCH 3/7] block/nvme: don't access CQE after moving cq.head
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
References: <20200519171138.201667-1-stefanha@redhat.com>
 <20200519171138.201667-4-stefanha@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <8c8f4fee-9cfa-142c-9bfa-35cbe8d4b85a@redhat.com>
Date: Tue, 26 May 2020 14:03:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200519171138.201667-4-stefanha@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 01:19:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/19/20 7:11 PM, Stefan Hajnoczi wrote:
> Do not access a CQE after incrementing q->cq.head and releasing q->lock.
> It is unlikely that this causes problems in practice but it's a latent
> bug.
> 
> The reason why it should be safe at the moment is that completion
> processing is not re-entrant and the CQ doorbell isn't written until the
> end of nvme_process_completion().
> 
> Make this change now because QEMU expects completion processing to be
> re-entrant and later patches will do that.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  block/nvme.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/block/nvme.c b/block/nvme.c
> index 5286227074..6bf58bc6aa 100644
> --- a/block/nvme.c
> +++ b/block/nvme.c
> @@ -321,11 +321,14 @@ static bool nvme_process_completion(BDRVNVMeState *s, NVMeQueuePair *q)
>      q->busy = true;
>      assert(q->inflight >= 0);
>      while (q->inflight) {
> +        int ret;
>          int16_t cid;
> +
>          c = (NvmeCqe *)&q->cq.queue[q->cq.head * NVME_CQ_ENTRY_BYTES];
>          if ((le16_to_cpu(c->status) & 0x1) == q->cq_phase) {
>              break;
>          }
> +        ret = nvme_translate_error(c);

Tricky.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

>          q->cq.head = (q->cq.head + 1) % NVME_QUEUE_SIZE;
>          if (!q->cq.head) {
>              q->cq_phase = !q->cq_phase;
> @@ -344,7 +347,7 @@ static bool nvme_process_completion(BDRVNVMeState *s, NVMeQueuePair *q)
>          preq->busy = false;
>          preq->cb = preq->opaque = NULL;
>          qemu_mutex_unlock(&q->lock);
> -        req.cb(req.opaque, nvme_translate_error(c));
> +        req.cb(req.opaque, ret);
>          qemu_mutex_lock(&q->lock);
>          q->inflight--;
>          progress = true;
> 


