Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAABBC43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 08:37:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FFE62075B
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 08:37:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dx8P+qlW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FFE62075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJBtN-0006oL-2J
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 04:37:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35014)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kJBr6-0005iW-4A
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 04:34:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59119)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kJBr0-0006bW-Tp
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 04:34:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600418090;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=5Ohz6PjOoI50Exshc4hPi6gBeM+WUI1S9YyZuqkUE2Q=;
 b=Dx8P+qlWHtdXQECNYC7HVLlmQJcrI7vBvuEhhnoZy5sPa3CVtIAhoSfOoz9qfdBuxUor54
 v+nMDTH15q9Qdn2apRWvsA0cW3a93+jhh/bBVyhp+M/WGBkf4jKFWdjZ+dWLK7J5eglp7I
 2bSg/l4EhDgzN7HmR7sCvT7sw7J8XgM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-TzVXzcatMwecTzfiHYHhsQ-1; Fri, 18 Sep 2020 04:34:45 -0400
X-MC-Unique: TzVXzcatMwecTzfiHYHhsQ-1
Received: by mail-wm1-f72.google.com with SMTP id y18so1216252wma.4
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 01:34:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=5Ohz6PjOoI50Exshc4hPi6gBeM+WUI1S9YyZuqkUE2Q=;
 b=l6im3ngXfBcSwfFb9QVInoJLY5vDkulyk70Sq0Htq9uQ/pRYRO41lgWW+nLaZaP9dS
 Au3n/HGF3bENP1l/+qn3ra+anTFV7KdSCv5hZc6ZzAnBTAGSBgx9TfAOT9abbrugVW+m
 QpjEqoq75fEVwoNX9Fq00EbTLKNRvqKbxC6iiE+h4I1XaIfzl06XyflerVq76FcbxtiV
 TyRgleJ2RIRd35pGcObTjYf3DfqsdG4n1gefQV0b2lTcXEBl7BhTEIYGDRMq+7I4hQah
 cRQPHq3e3n1ObGOATaWlDXPaYaVrh9swUjS2TIhq/Q6elnAKx2x836wuS95pf7X85nIi
 ZdGg==
X-Gm-Message-State: AOAM533krEYxFlw9ab6rHKLfCQjlkjI6s2G3XEBCb+6mL17jXdT6Wfr7
 DyO9dgVlRysNrpitB4SLUT6avZWJ5gr+gEsRqk5HIrF01EkkvSArjEvylayAzb3Z8GkKXj4ybqD
 XqREct3YjX/jE+wY=
X-Received: by 2002:adf:df81:: with SMTP id z1mr38336954wrl.9.1600418084664;
 Fri, 18 Sep 2020 01:34:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw7S6oWL/lHiRn9pY6JkyPp3B9ohE0KRcv0gS+SgcWeIUtwRNz8ZC5849BBoikX1fA0Mhwt6g==
X-Received: by 2002:adf:df81:: with SMTP id z1mr38336938wrl.9.1600418084463;
 Fri, 18 Sep 2020 01:34:44 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id d6sm3707809wrq.67.2020.09.18.01.34.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Sep 2020 01:34:43 -0700 (PDT)
Subject: Re: [PATCH] hw/nvram/fw_cfg: fix FWCfgDataGeneratorClass::get_data()
 consumption
To: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org
References: <20200916151510.22767-1-lersek@redhat.com>
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
Message-ID: <b12385c9-3a81-8d82-08ba-f46e3d14a468@redhat.com>
Date: Fri, 18 Sep 2020 10:34:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200916151510.22767-1-lersek@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 00:20:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.997,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/16/20 5:15 PM, Laszlo Ersek wrote:
> The documentation on g_byte_array_free()
> <https://developer.gnome.org/glib/stable/glib-Byte-Arrays.html#g-byte-array-free>
> says:
> 
>> Returns
>>
>> the element data if free_segment is FALSE, otherwise NULL. The element
>> data should be freed using g_free().
> 
> Because we currently call g_byte_array_free() with free_segment=TRUE, we
> end up passing data=NULL to fw_cfg_add_file().
> 
> On the plus side, fw_cfg_data_read() and fw_cfg_dma_transfer() both deal
> with NULL data gracefully: QEMU does not crash when the guest reads such
> an item, the guest just gets a properly sized, but zero-filled blob.
> 
> However, the bug breaks UEFI HTTPS boot, as the IANA_TLS_CIPHER array,
> generated otherwise correctly by the "tls-cipher-suites" object, is in
> effect replaced with a zero blob.
> 
> Fix the issue by passing free_segment=FALSE to g_byte_array_free():
> 
> - the caller (fw_cfg_add_from_generator()) temporarily assumes ownership
>   of the generated byte array,
> 
> - then ownership of the byte array is transfered to fw_cfg, as
>   fw_cfg_add_file() links (not copies) "data" into fw_cfg.
> 
> Cc: "Daniel P. Berrangé" <berrange@redhat.com>
> Cc: "Philippe Mathieu-Daudé" <philmd@redhat.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Fixes: 3203148917d035b09f71986ac2eaa19a352d6d9d
> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
> ---
>  hw/nvram/fw_cfg.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
> index f3a4728288eb..0e95d057fd51 100644
> --- a/hw/nvram/fw_cfg.c
> +++ b/hw/nvram/fw_cfg.c
> @@ -1056,7 +1056,7 @@ bool fw_cfg_add_from_generator(FWCfgState *s, const char *filename,
>          return false;
>      }
>      size = array->len;
> -    fw_cfg_add_file(s, filename, g_byte_array_free(array, TRUE), size);
> +    fw_cfg_add_file(s, filename, g_byte_array_free(array, FALSE), size);
>  
>      return true;
>  }
> 

Thanks, applied to my fw_cfg tree.


