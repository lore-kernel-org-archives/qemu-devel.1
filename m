Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D421CC4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 14:48:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FF8021534
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 14:48:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QOZROP+i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FF8021534
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUswM-0006tI-PE
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 10:48:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48206)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kUsuI-0005JJ-Eh
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 10:46:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44496)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kUsuC-0002vK-Lj
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 10:46:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603205184;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0G36GHbZa+UlPZIHqHqUoGXic9k5ct0p+jcqz+RNf6s=;
 b=QOZROP+i1dpLR3cUmARwQ4BRLDDrlZaaYbTPi4EJNvu4hC/Pj6tw00f6xmaw0KqSwDtxfG
 Xr3ZR11XE4saO93aVXk3X9zhPT3sqnpU0XN35ktXRWRtT/zSbhjectvUwIRN/yvcPK+tcw
 hdOkcoSJXOmaiDDVjgm0z4ARmp7kw2w=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-139-NwdZf-JhPR6WgttvCrCuOw-1; Tue, 20 Oct 2020 10:46:22 -0400
X-MC-Unique: NwdZf-JhPR6WgttvCrCuOw-1
Received: by mail-wr1-f69.google.com with SMTP id m20so902947wrb.21
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 07:46:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0G36GHbZa+UlPZIHqHqUoGXic9k5ct0p+jcqz+RNf6s=;
 b=FIoR/rQg+J1FIAj71qVHIn4huufMjCMom896SU8N/Uzz31zh0JcmkjSbk56O+Y6xRC
 Z9E6bg9SNB3BM2GXy0YnluPvePTt8J7+7F84tKslgs1WPOYA531AYSigDywOEkvmZ1YK
 K2rQiRx1wHj+cEOxJg4OZtRhquMz5AW3ih3cg9HdrpnRVuVkWVxmv+hMGhN3c4j6NnSt
 ImBsikL1rGmD64HFv9QVceDUAE14pyAxfJldXRBNNKuXFu3AAhchmrjATBBVTPK0Hpx2
 k8MQp5T8yAinLBxfWZI0XJbbp3GLvBD/fMFk2ynDYOoPYRhN061PQ5Kma3jkt8tKSRv2
 SBYQ==
X-Gm-Message-State: AOAM530b0qp7j0TAmrOGoLYNdmSK7qfUkok8xR+j+S1OPqt6bC1BbwRU
 x7qHsvzA6wfdaLT3hBhKTv3TPLrfoZifw1/0s5MhQZDIQscwinX6yYH6hs6SRp/tfonQ8rfdC0O
 N2IDZDaaILnYCwN4=
X-Received: by 2002:a1c:9a10:: with SMTP id c16mr3114545wme.96.1603205180935; 
 Tue, 20 Oct 2020 07:46:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy1xN6A/I0qbVBPQ0a4VMCw0+lBSsEgGPHe73yqIezdsyaBtaqTj2d3X6kAbWp21j86OXTvWQ==
X-Received: by 2002:a1c:9a10:: with SMTP id c16mr3114514wme.96.1603205180667; 
 Tue, 20 Oct 2020 07:46:20 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id u15sm2863625wml.21.2020.10.20.07.46.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2020 07:46:20 -0700 (PDT)
Subject: Re: [PATCH v2] net: remove an assert call in eth_get_gso_type
To: P J P <ppandit@redhat.com>, Jason Wang <jasowang@redhat.com>
References: <20201020140050.1623109-1-ppandit@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e1d4ef00-2beb-e905-a42d-a0df16ec07aa@redhat.com>
Date: Tue, 20 Oct 2020 16:46:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201020140050.1623109-1-ppandit@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:16:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: Gaoning Pan <pgn@zju.edu.cn>, QEMU Developers <qemu-devel@nongnu.org>,
 Prasad J Pandit <pjp@fedoraproject.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/20/20 4:00 PM, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
> 
> eth_get_gso_type() routine returns segmentation offload type based on
> L3 protocol type. It calls g_assert_not_reached if L3 protocol is
> unknown, making the following return statement unreachable. Remove the
> g_assert call, as it maybe triggered by a guest user.
> 
> Reported-by: Gaoning Pan <pgn@zju.edu.cn>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>   net/eth.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> Update v2: add qemu_log()
>    -> https://lists.nongnu.org/archive/html/qemu-devel/2020-10/msg05576.html
> 
> diff --git a/net/eth.c b/net/eth.c
> index 0c1d413ee2..fd76e349eb 100644
> --- a/net/eth.c
> +++ b/net/eth.c
> @@ -16,6 +16,7 @@
>    */
> 
>   #include "qemu/osdep.h"
> +#include "qemu/log.h"
>   #include "net/eth.h"
>   #include "net/checksum.h"
>   #include "net/tap.h"
> @@ -71,9 +72,7 @@ eth_get_gso_type(uint16_t l3_proto, uint8_t *l3_hdr, uint8_t l4proto)
>               return VIRTIO_NET_HDR_GSO_TCPV6 | ecn_state;
>           }
>       }
> -
> -    /* Unsupported offload */
> -    g_assert_not_reached();
> +    qemu_log("Probably not GSO frame, unknown L3 protocol: %hd\n", l3_proto);

Not sure why you choose decimal, the usual format is "0x%04"PRIx16.
Otherwise:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> 
>       return VIRTIO_NET_HDR_GSO_NONE | ecn_state;
>   }
> --
> 2.26.2
> 


