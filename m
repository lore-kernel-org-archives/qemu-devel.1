Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA14FC2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 11:15:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45CBB21556
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 11:15:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZqXqtgY3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45CBB21556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaGlg-0002m5-7v
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 06:15:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49732)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kaGfr-0003Ei-K6
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 06:09:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45204)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kaGfq-00084o-4M
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 06:09:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604488192;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/43DGqJxPtuqcCjvGrtIFDS+vtJ02f3ixJxkIC40oXM=;
 b=ZqXqtgY3oI+uWV6hy6zpkEoefkTgZA2s0gQ/Zb1cNUA5Q0FAwJyKs11lpB4wwz/x+zo1hk
 2T51O29ze7/AMpoTYVIG6fasay9NcsX7YEMVBUkkHcNfCpIrMs5yQDa5mpbMQMumJ0Ejh1
 Rqwhak5Jvdf1/YQXEYQ1lZR02mucbuw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-UuGyeKruNu675KZ6AfP6XQ-1; Wed, 04 Nov 2020 06:09:49 -0500
X-MC-Unique: UuGyeKruNu675KZ6AfP6XQ-1
Received: by mail-wr1-f70.google.com with SMTP id t11so9145719wrv.10
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2020 03:09:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/43DGqJxPtuqcCjvGrtIFDS+vtJ02f3ixJxkIC40oXM=;
 b=DmV0aroTnCnszJFoTalqtvt3/UIgp+vEiuBt0ErOdyosJ7R3qBtk5MPFKoXfxJPNy6
 hZ6FPu6OADm4Gt9oCb5hqECF3A6cD57MuerCKuF5QnerIKjNVwQ86NlqWYE/7DH9BzcP
 nAr4XG4ZMzX6UmHDHEbRROrNHCgqh8VZkACCfc3IfnNLxA8Rp3tLrsoZ0SXvM1PboBiD
 bSJpFQNMut4HCyDFDFe7uYtFsskEFZmkSEjqybktAl/xGrbY4DcQRohbNcFyWbIm0MwL
 zdSuW7JBBKj4xb4vlT1HDPVxzGCbOH97rB5y/tlEuVC5Y3dNnmb+LbmgOXNJLMsEItPU
 U9aQ==
X-Gm-Message-State: AOAM531VvXYYqYIHCDVGxGxq/0pWlTR0QneqKQxhmZybLfNpiUliHoXg
 5iaTmPVF1RygAvc4sHxAZt9ZsRFSYYjoPaC45jW7KdGrpmql38Ma3Ko+t6tBaeP17H68QURuQvz
 4H4bF8CB+24VqrrA=
X-Received: by 2002:a5d:43ca:: with SMTP id v10mr31586063wrr.7.1604488187958; 
 Wed, 04 Nov 2020 03:09:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzFYLjFRnxDBYKsUHHe+O90jk6UNcBS7zGTgwJx6ZRGolgal9i7kxfmBPQ2VGQBKxTI98wHIQ==
X-Received: by 2002:a5d:43ca:: with SMTP id v10mr31586045wrr.7.1604488187850; 
 Wed, 04 Nov 2020 03:09:47 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id v6sm2104959wrb.53.2020.11.04.03.09.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Nov 2020 03:09:47 -0800 (PST)
Subject: Re: [PATCH for-5.2 2/3] hw/block/nvme: fix uint16_t use of uint32_t
 sgls member
To: Klaus Jensen <its@irrelevant.dk>, qemu-devel@nongnu.org
References: <20201104102248.32168-1-its@irrelevant.dk>
 <20201104102248.32168-3-its@irrelevant.dk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <394f4100-5532-76eb-bebd-ef36795f0166@redhat.com>
Date: Wed, 4 Nov 2020 12:09:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201104102248.32168-3-its@irrelevant.dk>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 22:09:52
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, Dmitry Fomichev <dmitry.fomichev@wdc.com>,
 Klaus Jensen <k.jensen@samsung.com>, Max Reitz <mreitz@redhat.com>,
 Minwoo Im <minwoo.im.dev@gmail.com>, Keith Busch <kbusch@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/4/20 11:22 AM, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> nvme_map_sgl_data erroneously uses the sgls member of NvmeIdNs as a
> uint16_t.
> 
> Reported-by: Coverity (CID 1436129)
> Fixes: cba0a8a344fe ("hw/block/nvme: add support for scatter gather lists")
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---
>  hw/block/nvme.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 080d782f1c2b..2bdc50eb6fce 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -452,7 +452,7 @@ static uint16_t nvme_map_sgl_data(NvmeCtrl *n, QEMUSGList *qsg,
>               * segments and/or descriptors. The controller might accept
>               * ignoring the rest of the SGL.
>               */
> -            uint16_t sgls = le16_to_cpu(n->id_ctrl.sgls);
> +            uint32_t sgls = le32_to_cpu(n->id_ctrl.sgls);
>              if (sgls & NVME_CTRL_SGLS_EXCESS_LENGTH) {

I'm surprise the compiler doesn't warn here.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

>                  break;
>              }
> 


