Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B379C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 12:53:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D81ED206C3
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 12:53:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iS8KoplF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D81ED206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgSth-0002Ig-5y
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 08:53:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50822)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jgSsy-0001RQ-5H
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 08:52:48 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:24422
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jgSsx-00013q-BJ
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 08:52:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591188766;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=QSLwSaJdS/C/XC03gtwE3bIO7N3XIJWOIVm+zqi/waY=;
 b=iS8KoplFKvS07tkZsQOTHxQiK2u1qxkz7wOLyNfdw/7LGdTpUyW23YRL26rs05FmMCN+wf
 gXPYFXpehY6H+cU9K6ELwy1WRHCDDDmy30/DbwQ8SvsIXi2Nf4ynKgvGPU+uNwbg7O5NUp
 u5f66GLlJo3incqX4itQqlJWTbyO9FU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-101-B7AM8ucQOxmo-oUDrLkSFw-1; Wed, 03 Jun 2020 08:52:45 -0400
X-MC-Unique: B7AM8ucQOxmo-oUDrLkSFw-1
Received: by mail-wm1-f69.google.com with SMTP id f62so773975wme.3
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2020 05:52:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=QSLwSaJdS/C/XC03gtwE3bIO7N3XIJWOIVm+zqi/waY=;
 b=prBOCbxN86kKb2GKnrP30LPPSz+DjVwTQ4ZcaMkNZRmOZLDBPSce/5VU4eS/s/ucGv
 ytlKJdoglabb+0SC24Csf76ZLl28tWAfnpL5weoqAAjflZI1471B8cV1L3p2aX76uFjN
 OxN7x5KCm/+duuPG5HgbErvL2dw2Z2CZbrj1WnttxYzpZLQ7b0QOiRlgP9tQ1XQ61ZCw
 +L3mqhz05YFMs7q5lVbg4FhwADbGG4eK36SMa/v7rU4GJbn89NIldSJKWYFP0N8xYu0r
 TWp74Ucu+2smCzMVj3c7JXPxSht1GlSbHJBegCuTjw8q3P9yQnHmPCStxUU9ec7yybeK
 N7Sw==
X-Gm-Message-State: AOAM530m3jR3MsrYW5NtT444Fnq10OR0ndvwEJXmCucgLleiyy+cKuo7
 bVVu0QjQbKqdHc79nsHpahV64/uVzdU384fBaZABuKD2z9fSycSdOtFHG0/c3S7Il8lU6yKZ+hS
 /D+DRsQ8LFbgtJ8g=
X-Received: by 2002:a5d:5449:: with SMTP id w9mr31371653wrv.106.1591188763946; 
 Wed, 03 Jun 2020 05:52:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwF5hYmKO6da+5NZjfZcACPV+nmC9kUMVKhlNpxDg0rGbO2zIc9Hz3YSBFIYZ9zwIQQi0alIA==
X-Received: by 2002:a5d:5449:: with SMTP id w9mr31371637wrv.106.1591188763685; 
 Wed, 03 Jun 2020 05:52:43 -0700 (PDT)
Received: from [192.168.1.43] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id v27sm3418714wrv.81.2020.06.03.05.52.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jun 2020 05:52:43 -0700 (PDT)
Subject: Re: [PATCH] pci: check address before reading configuration bytes
To: P J P <ppandit@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
References: <20200603124041.1137464-1-ppandit@redhat.com>
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
Message-ID: <7e9358f9-9064-c523-84e9-74fe4cce89a4@redhat.com>
Date: Wed, 3 Jun 2020 14:52:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200603124041.1137464-1-ppandit@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/03 01:12:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Ren Ding <rding@gatech.edu>, Yi Ren <c4tren@gmail.com>,
 Prasad J Pandit <pjp@fedoraproject.org>, Hanqing Zhao <hanqing@gatech.edu>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/3/20 2:40 PM, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
> 
> While reading PCI configuration bytes, a guest may send an
> address towards the end of the configuration space. It may lead
> to an OOB access issue. Add check to ensure 'address + len' is
> within PCI configuration space.
> 
> Reported-by: Ren Ding <rding@gatech.edu>
> Reported-by: Hanqing Zhao <hanqing@gatech.edu>
> Reported-by: Yi Ren <c4tren@gmail.com>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>  hw/pci/pci.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 70c66965f5..4429fa9401 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -1385,7 +1385,9 @@ uint32_t pci_default_read_config(PCIDevice *d,
>          ranges_overlap(address, len, d->exp.exp_cap + PCI_EXP_LNKSTA, 2)) {
>          pcie_sync_bridge_lnk(d);
>      }
> -    memcpy(&val, d->config + address, len);
> +    if (address + len <= pci_config_size(d)) {

We don't want to hide/ignore earlier bugs, so IMO the caller should
check for access in range, and this function abort() as it should never
been called with such arguments.

> +        memcpy(&val, d->config + address, len);
> +    }
>      return le32_to_cpu(val);
>  }
>  
> 


