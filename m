Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E6A5C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 09:50:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D71022088E
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 09:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jc00kwf+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D71022088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo23J-0006AG-2b
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 05:50:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40408)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jo22e-0005fJ-S4
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 05:50:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27210
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jo22c-0004xt-8w
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 05:50:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592992200;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=5J1hozn5/xeWGmOFjvG78902m8r1178Rs5fboTYZlG0=;
 b=Jc00kwf+OsijfA2VgGgpjRRPwNPiIfgjtK9AwBQSIMmacFiCxnom6z2eXlUpS3SZnukGir
 8HdDMTc0mIAeTnCIuSWUjuWR60A/BJcj5ovgVZMWfXdcvHHXEYwcLOKE+Io9oWxD2qYqCx
 jJnJhgMe/J8ME49rKL6JxQArVC4WW1E=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-119-vks3SW6UP_qBL8dcprrluw-1; Wed, 24 Jun 2020 05:49:59 -0400
X-MC-Unique: vks3SW6UP_qBL8dcprrluw-1
Received: by mail-ej1-f70.google.com with SMTP id ca6so1444023ejb.7
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 02:49:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=5J1hozn5/xeWGmOFjvG78902m8r1178Rs5fboTYZlG0=;
 b=V3KQsiLGqIn0E5N/+EzBaFzEpHe75oX1ltYrhxQZ+bkcYYgBPgYf73WtjtRDtsRQwn
 RuJG6MQnYShlHH/azwwlvXLTpTgNy4uncMuw4rcO3zx64Bbcp5SdEtiQ3mjhoyIf2JiY
 +66xDKxDkAPduplCn+jt/CX6IJfQ42LSx5giQrRHymZ+hmBWjaNBx0BuZ8ZMlBP2QxcO
 AV/7iG5Q2V68RHGCVZL6vPaAb4DuCOJjgILPPPMMzprLRFj2N4UPsKFD6+FB5IphKWdS
 FCAFkPwhs48BdkqU23CqRhlhbrUk0NjBV83fCd0BfqQr2ojuLK2ecker/SIUq7Cn/KPw
 gf5Q==
X-Gm-Message-State: AOAM533FFgquMcVqwrPVJMnv3xlnvOrPu60kbLpemydhweaa41HNFrWm
 WoVu6A6ky+rymmdZp05U/t/FO5izdbvXv4kNxjOsADjOdRAwN7BYoNfLCyGE0b8z3hMHLAXz3Yg
 IPqnjtjcSvjCqd9Q=
X-Received: by 2002:a17:906:5e05:: with SMTP id
 n5mr23937341eju.278.1592992197726; 
 Wed, 24 Jun 2020 02:49:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxY7uqhwBWtoRoLH7Djde110REXVCfcwHup0jKO6lKO1Req7gfyETHybOhYjL2vnfN3KvuqrQ==
X-Received: by 2002:a5d:4dd0:: with SMTP id f16mr31835882wru.117.1592991995143; 
 Wed, 24 Jun 2020 02:46:35 -0700 (PDT)
Received: from [192.168.1.40] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id 33sm20277686wri.16.2020.06.24.02.46.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jun 2020 02:46:33 -0700 (PDT)
Subject: Re: [RFC PATCH 3/3] fuzz: Add callbacks for dma-access functions
To: Alexander Bulekov <alxndr@bu.edu>, qemu-devel@nongnu.org
References: <20200611055651.13784-1-alxndr@bu.edu>
 <20200611055651.13784-4-alxndr@bu.edu>
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
Message-ID: <f4d61f60-6065-24a6-c085-a613a3a335de@redhat.com>
Date: Wed, 24 Jun 2020 11:46:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200611055651.13784-4-alxndr@bu.edu>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 02:33:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: darren.kenny@oracle.com, bsd@redhat.com,
 Richard Henderson <rth@twiddle.net>, stefanha@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/11/20 7:56 AM, Alexander Bulekov wrote:
> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> ---
>  exec.c                                | 17 ++++++++++++++++-
>  include/exec/memory.h                 |  8 ++++++++
>  include/exec/memory_ldst_cached.inc.h |  9 +++++++++
>  include/sysemu/dma.h                  |  5 ++++-
>  memory_ldst.inc.c                     | 12 ++++++++++++
>  5 files changed, 49 insertions(+), 2 deletions(-)
> 
> diff --git a/exec.c b/exec.c
> index be4be2df3a..2ed724ab54 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -3247,7 +3247,10 @@ MemTxResult address_space_read_full(AddressSpace *as, hwaddr addr,
>  {
>      MemTxResult result = MEMTX_OK;
>      FlatView *fv;
> -
> +#ifdef CONFIG_FUZZ
> +    if(as->root == get_system_memory())

Since it is local to exec.c, you can directly use system_memory.

But why restrict this to the system memory anyway?

> +        dma_read_cb(addr, len);
> +#endif


