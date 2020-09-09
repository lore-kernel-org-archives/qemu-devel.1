Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDFEEC43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 01:50:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50054216C4
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 01:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dSPUleyf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50054216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFpGE-0000TX-8B
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 21:50:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52388)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1kFpFV-0008Of-Dn
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 21:50:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23039
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1kFpFS-0004Gz-V1
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 21:50:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599616209;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fejIZJchtbOAJ1skayPRG0zHotgQ2BCeZdmVyx+jkZY=;
 b=dSPUleyfBO8B1jB7dtv/1tGwq2tZiI6H2m1wphxEEKKoEQYybER47jKPH/ljYnSOnotqeL
 Xaa89liIy96gYPM8CTmVSusdX1PR5aymgIQ9q02htuA8Gd7EmYUAcXrC/ad5c9c2odk7HJ
 Ez/M0RWOA3B+gXBCN+YxyDj1drDHBQQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-479-QQahKSP2P2q2VCv-2mKujA-1; Tue, 08 Sep 2020 21:50:07 -0400
X-MC-Unique: QQahKSP2P2q2VCv-2mKujA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 72F3A80EF9B
 for <qemu-devel@nongnu.org>; Wed,  9 Sep 2020 01:50:06 +0000 (UTC)
Received: from [10.72.12.24] (ovpn-12-24.pek2.redhat.com [10.72.12.24])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2E37E5D9EF;
 Wed,  9 Sep 2020 01:50:04 +0000 (UTC)
Subject: Re: [PATCH 1/2] vhost-vdpa: define and use default value for vhostdev
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
References: <20200903185327.774708-1-lvivier@redhat.com>
 <20200903185327.774708-2-lvivier@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <eac8a6d5-91d6-8ca1-bb20-63e41aeafb22@redhat.com>
Date: Wed, 9 Sep 2020 09:50:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200903185327.774708-2-lvivier@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.120; envelope-from=jasowang@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 21:50:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.626, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Cindy Lu <lulu@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/9/4 上午2:53, Laurent Vivier wrote:
> vhostdev is defined as optional in net.json, and if not set
> /dev/vhost-vdpa-0 should be used.
>
> The default value is not set and if vhostdev is not provided
> QEMU crashes with a SIGSEGV exception.
>
> Fixes: 1e0a84ea49b6 ("vhost-vdpa: introduce vhost-vdpa net client")
> Cc: lulu@redhat.com
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>   net/vhost-vdpa.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index bc0e0d2d35b7..24103ef241e4 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -24,6 +24,9 @@
>   #include "monitor/monitor.h"
>   #include "hw/virtio/vhost.h"
>   
> +/* default vhostdev as defined in qapi/net.json */
> +#define VHOST_VDPA_DEFAULT_VHOSTDEV "/dev/vhost-vdpa-0"
> +
>   /* Todo:need to add the multiqueue support here */
>   typedef struct VhostVDPAState {
>       NetClientState nc;
> @@ -224,5 +227,7 @@ int net_init_vhost_vdpa(const Netdev *netdev, const char *name,
>                             (char *)name, errp)) {
>           return -1;
>       }
> -    return net_vhost_vdpa_init(peer, TYPE_VHOST_VDPA, name, opts->vhostdev);
> +    return net_vhost_vdpa_init(peer, TYPE_VHOST_VDPA, name,
> +                               opts->has_vhostdev ?
> +                               opts->vhostdev : VHOST_VDPA_DEFAULT_VHOSTDEV);
>   }


Hi Laurent:

I think having a default path could introduce more confusion here.

So I post a patch to remove the default [1].

Thanks

[1] 
https://lore.kernel.org/qemu-devel/20200831082737.10983-2-jasowang@redhat.com/



