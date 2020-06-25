Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB205C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 06:31:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74E0E20706
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 06:31:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lnm+qsMT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74E0E20706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joLQ0-00082Y-Nu
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 02:31:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42012)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1joLOb-0007Eb-23
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 02:30:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31434
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1joLOZ-0004tf-1X
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 02:30:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593066595;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=KIhiPt/pTnrhm63PkhpiXHAX5Y90xSMxrmAVAFqxbTQ=;
 b=Lnm+qsMTWNGjJv/WXXbv8lOcOOJ+ZZ/JyL4CUA1PFvxyED2cXnB8YGq3FAIb7Jv2hbtseQ
 cTlkvGm5fPldURwscbjrAxX04fyQcfviVuRA5glCwjEIAsCjZJvvMCF57YCHUl5LWEbPcF
 vfdwDCSvpkKYm2iLC8b3XebawFM1kGQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-173-ilqxathuMgiu-PmFKUNrYQ-1; Thu, 25 Jun 2020 02:29:54 -0400
X-MC-Unique: ilqxathuMgiu-PmFKUNrYQ-1
Received: by mail-wm1-f72.google.com with SMTP id g187so6168201wme.0
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 23:29:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=KIhiPt/pTnrhm63PkhpiXHAX5Y90xSMxrmAVAFqxbTQ=;
 b=WG1V+c4102Q3Q7oybsQHf0LzZCVL7Ho28SV5nqTB9ipSDjodk2ccixyGl4yFhCuyV+
 hCdxa7nn+gETdU1SU1tXPtRHiy1pbvE5LzRsUuE2cOErRWYXgWcmGIPoqufO9ayS1paj
 KADbEPQ6XNFFflb2Tn9T1yY02FtQenuRLSDCXcklMoIJl9NF2nQ5w+jWxwy2+f4QX4Ez
 O1I4zftvHM/TkFrN4Bu5+aEytU9I06Z/qp2WXuZIvk7l6wyyZV/ez13NsLG1itrCt99B
 r+kMG0AiMfIqvTsvkaBMOgnnuKDyEczhx3ROLLoxYJPhmbPgv7ZHg0y+Gi33ArRTqXgY
 NFUg==
X-Gm-Message-State: AOAM532JalvYhZ9VSEuf8ZLQHocCIfPjUMAw9TZblp0JgQwLbMGknX4v
 BO1Ew53C735uVqut63rCdjFlU2J/xKAPpFUtB4Il5YQlQ5Ld/fewyHbW376YrwBQ4ny66oH5qOH
 PntscBMHJ/Ad9Dk0=
X-Received: by 2002:a1c:f60d:: with SMTP id w13mr1689344wmc.51.1593066592931; 
 Wed, 24 Jun 2020 23:29:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwTKh0B9f8d4xX5wbNYfn0WeZyx002Yc/waKZWqVXLsbDf/izvD3noEfegR6bz21Bv3dOe/ew==
X-Received: by 2002:a1c:f60d:: with SMTP id w13mr1689324wmc.51.1593066592743; 
 Wed, 24 Jun 2020 23:29:52 -0700 (PDT)
Received: from [192.168.1.40] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id l17sm11336872wmh.14.2020.06.24.23.29.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jun 2020 23:29:52 -0700 (PDT)
Subject: Re: [PATCH v2 7/9] tz-ppc: add dummy read/write methods
To: P J P <ppandit@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20200624185523.762240-1-ppandit@redhat.com>
 <20200624185523.762240-8-ppandit@redhat.com>
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
Message-ID: <7ffe6cd9-fc23-3fdf-6c57-7bb0af0dd030@redhat.com>
Date: Thu, 25 Jun 2020 08:29:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200624185523.762240-8-ppandit@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 01:47:53
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
Cc: Prasad J Pandit <pjp@fedoraproject.org>, Li Qiang <liq3ea@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Lei Sun <slei.casper@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/24/20 8:55 PM, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
> 
> Add tz-ppc-dummy mmio read/write methods to avoid assert failure
> during initialisation.
> 
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>  hw/misc/tz-ppc.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/hw/misc/tz-ppc.c b/hw/misc/tz-ppc.c
> index 6431257b52..dc8892f61f 100644
> --- a/hw/misc/tz-ppc.c
> +++ b/hw/misc/tz-ppc.c
> @@ -196,7 +196,22 @@ static bool tz_ppc_dummy_accepts(void *opaque, hwaddr addr,
>      g_assert_not_reached();

This is a shame we now have to fill the read/write handlers for
unreachable code :(

>  }
>  
> +static uint64_t tz_ppc_dummy_read(void *opaque, hwaddr addr, unsigned size)
> +{

I'd instead use a clearer:

       g_assert_not_reached();

> +    qemu_log_mask(LOG_GUEST_ERROR, "%s not implemented\n", __func__);
> +    return 0;
> +}
> +
> +static void tz_ppc_dummy_write(void *opaque, hwaddr addr,
> +                                        uint64_t data, unsigned size)
> +{

Ditto:

       g_assert_not_reached();

> +    qemu_log_mask(LOG_GUEST_ERROR, "%s not implemented\n", __func__);
> +}
> +
>  static const MemoryRegionOps tz_ppc_dummy_ops = {
> +    /* define r/w methods to avoid assert failure in memory_region_init_io */
> +    .read = tz_ppc_dummy_read,
> +    .write = tz_ppc_dummy_write,
>      .valid.accepts = tz_ppc_dummy_accepts,
>  };
>  
> 


