Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4023EC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 09:51:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B339206F5
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 09:51:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a973NyPH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B339206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsNmx-0005aD-CH
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 05:51:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50768)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jsNlx-0004Ii-9J
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 05:50:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20753
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jsNlu-0001vY-PB
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 05:50:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594029046;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Lzspemo64GgoTEzY1+QiTkoiew+zyGrqfpIrTXkHLAI=;
 b=a973NyPHXi9TWry/zpO6bMDAa8+oMGMsi8GGwz2OVYYJMORBqCtzFpdXrbcoECazr7+5zK
 YYeQ864/+Zl8SJX9OGHZNxbeC9Q/Meu7MxkvNA4SOYfMBG3nM0wxxinU2EIPmLzUrh3EHa
 bPxMlh25xg/25Ea6iWPXnpag4DkFNpo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-JTlBWiv6Nvm_J891NTXTMA-1; Mon, 06 Jul 2020 05:50:42 -0400
X-MC-Unique: JTlBWiv6Nvm_J891NTXTMA-1
Received: by mail-wr1-f71.google.com with SMTP id g14so41398053wrp.8
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2020 02:50:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=Lzspemo64GgoTEzY1+QiTkoiew+zyGrqfpIrTXkHLAI=;
 b=iaOq9nCUjMRKCO7Sbk5slnsx5sw3e4FxRi5celzJ96xSCZ6b07kVDhQDQL4goPtjwz
 BSj9gOL4KdNCFrtyu33u7bFO3ASgFwpQ4xH/vg8ciZfC3351kRTeYwq8LnywCkx7dBUu
 PULcjaRDFsBUtWCa/vZQsH305RrdVxTFM72Msk/VOMu5alcY8t4NtYRIAkGa2cvVEGWc
 ScHxv2w028X39O/LIlzpVR+NxH7v2MQrs/D2HcWdl70/YbrmAC5zKLeXpid5TiZEXudT
 ZOJJ2dJb+pg8WEnrtV9Fksja0Ky/aQ2niYTy9QxFTLw2BclRlQ+PEF/itI8oeblZakW5
 YR0g==
X-Gm-Message-State: AOAM530P/08fMhzSFhDlEBOBsILOBN//eyTMuGOqujCzQFAgEIpb+Jb1
 K2SJRn+WSR9lF7dFkXL7i9c8FhA3+dxrajZrt/4JegUpmeBPWKdWUK03SySsxqsVXcwp5Gcqxhr
 qtMDhzNd+N2MGJsQ=
X-Received: by 2002:adf:e948:: with SMTP id m8mr49030345wrn.398.1594029041451; 
 Mon, 06 Jul 2020 02:50:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw2Bn43VJmy1LXsifeeBKCLABQEFEN9907w3NeP2akVMY3P9qYfUDPPradEWlpRmqVA0LeZiw==
X-Received: by 2002:adf:e948:: with SMTP id m8mr49030325wrn.398.1594029041254; 
 Mon, 06 Jul 2020 02:50:41 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id m10sm23529599wru.4.2020.07.06.02.50.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jul 2020 02:50:40 -0700 (PDT)
Subject: Re: [PATCH v3 02/18] hw/block/nvme: fix missing endian conversion
To: Klaus Jensen <its@irrelevant.dk>, qemu-block@nongnu.org
References: <20200706061303.246057-1-its@irrelevant.dk>
 <20200706061303.246057-3-its@irrelevant.dk>
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
Message-ID: <0df6daf3-38f3-e181-6166-a34f5c9a59eb@redhat.com>
Date: Mon, 6 Jul 2020 11:50:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200706061303.246057-3-its@irrelevant.dk>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 01:52:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Dmitry Fomichev <Dmitry.Fomichev@wdc.com>,
 Klaus Jensen <k.jensen@samsung.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Javier Gonzalez <javier.gonz@samsung.com>,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/6/20 8:12 AM, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> Fix a missing cpu_to conversion by moving conversion to just before
> returning instead.
> 
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> Suggested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  hw/block/nvme.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 71b388aa0e20..766cd5b33bb1 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -815,8 +815,8 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>          trace_pci_nvme_getfeat_vwcache(result ? "enabled" : "disabled");
>          break;
>      case NVME_NUMBER_OF_QUEUES:
> -        result = cpu_to_le32((n->params.max_ioqpairs - 1) |
> -                             ((n->params.max_ioqpairs - 1) << 16));
> +        result = (n->params.max_ioqpairs - 1) |
> +            ((n->params.max_ioqpairs - 1) << 16);
>          trace_pci_nvme_getfeat_numq(result);
>          break;
>      case NVME_TIMESTAMP:
> @@ -826,7 +826,7 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>          return NVME_INVALID_FIELD | NVME_DNR;
>      }
>  
> -    req->cqe.result = result;
> +    req->cqe.result = cpu_to_le32(result);
>      return NVME_SUCCESS;
>  }
>  
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


