Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D104C561F8
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 07:45:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3B0E22249
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 07:45:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i/d9XRkb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3B0E22249
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kV8o4-0003DD-I0
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 03:45:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33166)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1kV8nE-0002NQ-1b
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 03:44:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51050)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1kV8n4-0007sx-6j
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 03:44:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603266248;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r9K4ZemMkj/soIwnkE/HQIdIF6oea1crz+uTDUi9lHw=;
 b=i/d9XRkbiax3fXomC+v/aAjvHvI9vPH9FlpNd7oMDrOFV/WGaFPKZTrh5U6BoJQAh5dhiE
 /6KAeJ6r8/u6CanVhaX1JYB3z7PWwGhUhWuNTgjqgcWwdMMkSWs40BQ3l94lxaWh8YFC79
 +ohOC3F/T7r+rUj5CQQl8tHKigdZ3vY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-Y2lEFyhpOu2AN-5Sf3Yxug-1; Wed, 21 Oct 2020 03:44:05 -0400
X-MC-Unique: Y2lEFyhpOu2AN-5Sf3Yxug-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 99B419CC0A;
 Wed, 21 Oct 2020 07:44:04 +0000 (UTC)
Received: from [10.72.13.212] (ovpn-13-212.pek2.redhat.com [10.72.13.212])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EC25B5B4DC;
 Wed, 21 Oct 2020 07:44:01 +0000 (UTC)
Subject: Re: [PATCH v3] net: remove an assert call in eth_get_gso_type
To: P J P <ppandit@redhat.com>
References: <20201021060550.1652896-1-ppandit@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <38575304-e5ff-c93e-c1e8-997d4148e579@redhat.com>
Date: Wed, 21 Oct 2020 15:44:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201021060550.1652896-1-ppandit@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/21 02:16:02
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Gaoning Pan <pgn@zju.edu.cn>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Prasad J Pandit <pjp@fedoraproject.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/10/21 下午2:05, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
>
> eth_get_gso_type() routine returns segmentation offload type based on
> L3 protocol type. It calls g_assert_not_reached if L3 protocol is
> unknown, making the following return statement unreachable. Remove the
> g_assert call, it maybe triggered by a guest user.
>
> Reported-by: Gaoning Pan <pgn@zju.edu.cn>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>   net/eth.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> Update v3: use LOG_GUEST_ERROR mask and %0x04PRIx16 conversion.
>    -> https://lists.nongnu.org/archive/html/qemu-devel/2020-10/msg05759.html
>    -> https://lists.nongnu.org/archive/html/qemu-devel/2020-10/msg05752.html
>
> diff --git a/net/eth.c b/net/eth.c
> index 0c1d413ee2..eee77071f9 100644
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
> @@ -71,9 +72,8 @@ eth_get_gso_type(uint16_t l3_proto, uint8_t *l3_hdr, uint8_t l4proto)
>               return VIRTIO_NET_HDR_GSO_TCPV6 | ecn_state;
>           }
>       }
> -
> -    /* Unsupported offload */
> -    g_assert_not_reached();
> +    qemu_log_mask(LOG_GUEST_ERROR, "%s: probably not GSO frame, "
> +        "unknown L3 protocol: 0x%04"PRIx16"\n", __func__, l3_proto);
>
>       return VIRTIO_NET_HDR_GSO_NONE | ecn_state;
>   }
> --
> 2.26.2


Hi Prasad:

If I understand the code correctly. It should not be a guest error, 
since guest is allowed to send a packet other than IPV4(6).

Thanks


>
>


