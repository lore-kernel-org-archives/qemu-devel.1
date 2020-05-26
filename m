Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE5EAC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 12:02:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9348320663
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 12:02:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J91W+Cz3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9348320663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdYHc-0005Ug-R1
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 08:02:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46522)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jdYGZ-0004tw-9Z
 for qemu-devel@nongnu.org; Tue, 26 May 2020 08:01:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39959
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jdYGX-0006vQ-Tm
 for qemu-devel@nongnu.org; Tue, 26 May 2020 08:01:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590494464;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=dHEWyrZWC131zwnoFGUZLXcbcB4oFZzQ33l5lxF/tzg=;
 b=J91W+Cz3s0ztsxL2lUZSJJloGsZ23qZ5Qnqnj33ZrVyJ21wGqv3eK+huE7arsHy3jyoLbZ
 BUGMiv68NxBgoC5wXQBTbd5tinrtI8fD+G5lT427P2+MZOcz8R8LwRt8P3YGngq6y4ImId
 PlD/Mh7GMjzUGefPNFbu09a4ojFtNbE=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-JAER2vMqPV2tHbOaeHhWKA-1; Tue, 26 May 2020 08:01:02 -0400
X-MC-Unique: JAER2vMqPV2tHbOaeHhWKA-1
Received: by mail-ed1-f70.google.com with SMTP id g10so8854947edt.3
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 05:01:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=dHEWyrZWC131zwnoFGUZLXcbcB4oFZzQ33l5lxF/tzg=;
 b=i7Ayje1/dZZAWXM16EpNcfni38IF7vbPPGK9w3H2FXn8qxbod4ew1X2EmlEGkfWJWm
 fGYVeiXOG6seEIekFMb4HUcuKchOOO/DynD01QpCNP4u9xSZzU7gy55z1kgzesZ3B7eZ
 OQGWSS5Me+ErFMn5qaYiRSIG3SeiZQr34QGlZS4hmBIPrp2e/X0HWM/QRm2756BBUyyY
 mKY1iDnwcJ4GkPXUG8AF2fAWyOmo8Awiz9SkqPT7xsTJ8lRndWckN1OeFsgKgHVeUS34
 BWSF5G2dTyExu1Dk65XUK6xgMrt8XJzQrCiQ/73aXuEhhS99EKjSVXNZJcOrorbyhwSa
 FPPg==
X-Gm-Message-State: AOAM532NP9bReBt37/Ij/amm3HLC8Phos6vXvG9pBVHFG7te3c//wELO
 0nC8fZoN01MPJp7HksnVLwv2QxjT9ycztiqGTPvQzdnoV4spgR2MOdABf7/u10LFTHdVIDGNoqS
 II/3H0rT9mQGDcUw=
X-Received: by 2002:a17:906:d98:: with SMTP id
 m24mr729191eji.553.1590494461258; 
 Tue, 26 May 2020 05:01:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzl+aTiCwkK3IYBd60kaeM5M+mLO0yCTK3blEyFdi2CkhL8gBYaUowxlt7K3IhCME3i7pj3NQ==
X-Received: by 2002:a17:906:d98:: with SMTP id
 m24mr729151eji.553.1590494460871; 
 Tue, 26 May 2020 05:01:00 -0700 (PDT)
Received: from [192.168.1.36] (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id jx14sm17295136ejb.79.2020.05.26.05.00.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2020 05:01:00 -0700 (PDT)
Subject: Re: [PATCH 2/7] block/nvme: drop tautologous assertion
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
References: <20200519171138.201667-1-stefanha@redhat.com>
 <20200519171138.201667-3-stefanha@redhat.com>
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
Message-ID: <31b8ad04-8187-0690-ec15-ae10b8ab6dac@redhat.com>
Date: Tue, 26 May 2020 14:00:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200519171138.201667-3-stefanha@redhat.com>
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
> nvme_process_completion() explicitly checks cid so the assertion that
> follows is always true:
> 
>   if (cid == 0 || cid > NVME_QUEUE_SIZE) {
>       ...
>       continue;
>   }
>   assert(cid <= NVME_QUEUE_SIZE);
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  block/nvme.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/block/nvme.c b/block/nvme.c
> index 7eb4512666..5286227074 100644
> --- a/block/nvme.c
> +++ b/block/nvme.c
> @@ -336,7 +336,6 @@ static bool nvme_process_completion(BDRVNVMeState *s, NVMeQueuePair *q)
>                      cid);
>              continue;
>          }
> -        assert(cid <= NVME_QUEUE_SIZE);
>          trace_nvme_complete_command(s, q->index, cid);
>          preq = &q->reqs[cid - 1];
>          req = *preq;
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


