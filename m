Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C49C1C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 07:44:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C56C21475
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 07:44:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HyJqfSGn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C56C21475
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlSjq-00040c-PV
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 03:44:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45016)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jlSis-0002hf-Jj
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 03:43:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38072
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jlSiq-0005YE-TI
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 03:43:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592379780;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=zQTPYAXbBqsFmed9DS7BJQqkK96B+vF646opAso6mXU=;
 b=HyJqfSGnyi2OBPfroyQtKSP9NlPofWdAqL3bzycrxRfAyggIsC/mMPphYsHk8XhQ+f6Of0
 8CE9DPbFOmNwddc4uTsp1fw/DF77EbzEHfyk8gmxqFilGXhCnetJrcRY5VfRBGGfQot+Su
 0PEqlUJkspocbtsadxO530hP+V+X+s4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-342-eXUtZnfNNXep_BBDuRPEjA-1; Wed, 17 Jun 2020 03:42:56 -0400
X-MC-Unique: eXUtZnfNNXep_BBDuRPEjA-1
Received: by mail-wm1-f71.google.com with SMTP id p24so308907wma.4
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 00:42:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=zQTPYAXbBqsFmed9DS7BJQqkK96B+vF646opAso6mXU=;
 b=PVxCuYmUWyl/W1V3QVAdyUyqoiKFp0ucrisWBb58tYQxNnSA4EYRARvbxdlrfuGcWY
 LvQYBevDK3QR5obk9JrKrY+R8uG3Y+DSl+3awBY11pDgqfXdFaXq7tb5XTNOXWtdt3gD
 BeuKo4wzoKznS0We7s0qHWTMUGguOzrGsKmPf6YyDQZD699IZ8OVZaT5nFFh+kqK5Tg8
 8Ha+Ldo4RsYb3zAEKqiLO6a7ku8Hu/yAqGrYsfaExZfds7/RGZa7q3SaWVtAyeWHUDtX
 Pr4lqV851CAqLnoHmYYP63S6nkORCC7Ln6jv0tUEvGKIxeUdpEftt8+lt6RWpLGifdeZ
 c2yA==
X-Gm-Message-State: AOAM531evED02aWivKNM9cJto/AViDRHWsJ0vu5Ijh44v1UeNGMX7c3X
 lcKlwbnT+g+mju01A110s0VIlgRaU1Xg9+I7LJpTCYn7RSIR6QIqywuEfy04NFmIhUJtElvnM4t
 UTMuMGu9hmPE7LZ4=
X-Received: by 2002:a5d:6a89:: with SMTP id s9mr6961084wru.15.1592379775388;
 Wed, 17 Jun 2020 00:42:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxdlwXMKWJHcKczhUHAREEwbCb9vZDlFpyc3ZyBoj/w3Wf8l/Nw14v1mNntZfZ/HBIS0hhT+A==
X-Received: by 2002:a5d:6a89:: with SMTP id s9mr6961054wru.15.1592379775132;
 Wed, 17 Jun 2020 00:42:55 -0700 (PDT)
Received: from [192.168.1.37] (93.red-83-59-160.dynamicip.rima-tde.net.
 [83.59.160.93])
 by smtp.gmail.com with ESMTPSA id a126sm7172522wme.28.2020.06.17.00.42.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jun 2020 00:42:54 -0700 (PDT)
Subject: Re: [PATCH 5/6] nvram: add nrf51_soc flash read method
To: P J P <ppandit@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
References: <20200617053934.122642-1-ppandit@redhat.com>
 <20200617053934.122642-6-ppandit@redhat.com>
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
Message-ID: <67e5fea1-1961-5773-ed82-a441ed8ffbcc@redhat.com>
Date: Wed, 17 Jun 2020 09:42:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200617053934.122642-6-ppandit@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 23:30:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Prasad J Pandit <pjp@fedoraproject.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Lei Sun <slei.casper@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Joel Stanley <joel@jms.id.au>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/17/20 7:39 AM, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
> 
> Add nrf51_soc mmio read method to avoid NULL pointer dereference
> issue.
> 
> Reported-by: Lei Sun <slei.casper@gmail.com>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>  hw/nvram/nrf51_nvm.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/hw/nvram/nrf51_nvm.c b/hw/nvram/nrf51_nvm.c
> index f2283c1a8d..e813c7ec72 100644
> --- a/hw/nvram/nrf51_nvm.c
> +++ b/hw/nvram/nrf51_nvm.c
> @@ -274,6 +274,12 @@ static const MemoryRegionOps io_ops = {
>  };
>  
>  
> +static uint64_t flash_read(void *opaque, hwaddr addr, unsigned size)
> +{
> +    qemu_log_mask(LOG_UNIMP, "%s not implemented\n", __func__);
> +    return 0;

This is a ROM device, shouldn't we return this instead?

        return ldl_le_p(s->storage + offset);

> +}
> +
>  static void flash_write(void *opaque, hwaddr offset, uint64_t value,
>          unsigned int size)
>  {
> @@ -300,6 +306,7 @@ static void flash_write(void *opaque, hwaddr offset, uint64_t value,
>  
>  
>  static const MemoryRegionOps flash_ops = {
> +    .read = flash_read,
>      .write = flash_write,
>      .valid.min_access_size = 4,
>      .valid.max_access_size = 4,
> 


