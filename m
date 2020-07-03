Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E71B1C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 08:19:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B75D3206A1
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 08:19:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZJrftzmK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B75D3206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrGuY-00005T-UF
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 04:19:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49518)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jrGtq-0007cH-BU
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 04:18:22 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:43620
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jrGtn-0002SS-9v
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 04:18:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593764298;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=SuoPmEmUnEi6/tjSF6oOrW03tRAWrZgFzay2VrkzAJs=;
 b=ZJrftzmKfDZtV+jFq3rtKddOb8W3K26lKwlD2ycHLy49A/dveyBqO2rDJqtQn+ZgYf3y9F
 /vHtLKRTOm1LV/WOitineAc47pdWEf8phpZXS/y2KQ1Pa2BZMY9165g5KTjDO2fjD5seFF
 wQPjEuwm56FaWokumWvX8QU1CjW5w/w=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-173-JOqHGzdpMNWfVfr5sa8UYw-1; Fri, 03 Jul 2020 04:18:16 -0400
X-MC-Unique: JOqHGzdpMNWfVfr5sa8UYw-1
Received: by mail-wr1-f72.google.com with SMTP id y16so30948068wrr.20
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 01:18:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=SuoPmEmUnEi6/tjSF6oOrW03tRAWrZgFzay2VrkzAJs=;
 b=oxyn1sFqEx0keUt6fdGuzlFi7Hp95HNhvE6iny6LKiF/tNAnhZRtBVDCpJHJTztiAJ
 rYMFlqq6ugrg7Kyvy1YqJ+TOX/H9bWsJQm8r1uWZ2ntFnFNbTBfc7ODoQURHZrQ4MRmL
 IlixUbt23iNOkf0v7TE5JmggHkZDuL3R76QeRNh2DB8TLU8Is6z4PgLY7BJVJKNBKmIX
 AcpX78RI1EJwB3hc9/C9gBpEcvzhx5/5oFTzIIpaFT5L160QiHO3rkNvOkf2GUUQ5QpZ
 mfIJNDumWrO10tw7gGKjZoAiSAnUtYI0sqSpe4PesHip1S8NVNw8EH0YzVV6Ou1D7QrY
 5jTg==
X-Gm-Message-State: AOAM5311aJjYwqNXPpdGGTmY+9dlhsO2KQVHkw+2+XSXoOcU9t2ZapfB
 i4bcX1Xe/75hUlDLdPbOFh+dn8GVgBsoETmnxE42ZRuptumoqLLa3AlOfuz6XfiH52QoXTJ6dJ7
 6Q0SDKAHvWFdtiy4=
X-Received: by 2002:adf:8444:: with SMTP id 62mr33949379wrf.278.1593764295767; 
 Fri, 03 Jul 2020 01:18:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxiQO6JnIXWAs+WHfpuW4NE9xQwG0guLX7dS/G5Q1JNkqg42P1kqvm6TbDmGl7XmC1+hUp0pw==
X-Received: by 2002:adf:8444:: with SMTP id 62mr33949360wrf.278.1593764295540; 
 Fri, 03 Jul 2020 01:18:15 -0700 (PDT)
Received: from [192.168.1.39] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id h84sm13699425wme.22.2020.07.03.01.18.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jul 2020 01:18:15 -0700 (PDT)
Subject: Re: [PATCH v2 17/18] hw/block/nvme: provide the mandatory subnqn field
To: Klaus Jensen <its@irrelevant.dk>, qemu-block@nongnu.org
References: <20200703063420.2241014-1-its@irrelevant.dk>
 <20200703063420.2241014-18-its@irrelevant.dk>
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
Message-ID: <73b19cd0-f52c-d61c-79b0-14f4d985aea6@redhat.com>
Date: Fri, 3 Jul 2020 10:18:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200703063420.2241014-18-its@irrelevant.dk>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 01:34:15
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
Cc: Kevin Wolf <kwolf@redhat.com>, Dmitry Fomichev <Dmitry.Fomichev@wdc.com>,
 Klaus Jensen <k.jensen@samsung.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Javier Gonzalez <javier.gonz@samsung.com>,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/3/20 8:34 AM, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> The SUBNQN field is mandatory in NVM Express 1.3.
> 
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
> Reviewed-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
> ---
>  hw/block/nvme.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 8138baa6fbd8..5bbb6aa0efc3 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -2134,6 +2134,9 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
>      id->oncs = cpu_to_le16(NVME_ONCS_WRITE_ZEROS | NVME_ONCS_TIMESTAMP |
>                             NVME_ONCS_FEATURES);
>  
> +    pstrcpy((char *) id->subnqn, sizeof(id->subnqn), "nqn.2019-08.org.qemu:");
> +    pstrcat((char *) id->subnqn, sizeof(id->subnqn), n->params.serial);

What about using strpadcpy()?

  char *subnqn = g_strdup_printf("nqn.2019-08.org.qemu:%s",
                                 n->params.serial);
  strpadcpy((char *)id->subnqn, sizeof(id->subnqn), subnqn, '\0');
  g_free(subnqn);

> +
>      id->psd[0].mp = cpu_to_le16(0x9c4);
>      id->psd[0].enlat = cpu_to_le32(0x10);
>      id->psd[0].exlat = cpu_to_le32(0x4);
> 


