Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56515C43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 08:52:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27CBB20717
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 08:52:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AQOk5YhO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27CBB20717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHkig-0006xr-BO
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 04:52:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60885)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1jHki6-0006Uz-Aw
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 04:51:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1jHki4-0001ch-Sp
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 04:51:25 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:38655)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1jHki4-0001YW-O6
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 04:51:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585299084;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yzNTlG5COq53NHubS7RggOBZ7Jv7U/PZ3GV7vxBv5pw=;
 b=AQOk5YhOYe82FGbxZuizObx9kvI7fhJ+vUJ63WvqP2W9btOJDiX3jHlPzixAFuLaRiNvsx
 LqL9z1b+UxNcQQWBA/QtOUZ4WtpQsUZBDZNX1RZdz7fH04+taPrC7DRPs2FKWZI1hM0m5o
 fid51OTN9YFEquyyG5giyySaiT49Enk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-131-Iyfo3x72Owestt9AOP4HYw-1; Fri, 27 Mar 2020 04:51:22 -0400
X-MC-Unique: Iyfo3x72Owestt9AOP4HYw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E69A91005513;
 Fri, 27 Mar 2020 08:51:20 +0000 (UTC)
Received: from [10.36.113.142] (ovpn-113-142.ams2.redhat.com [10.36.113.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 584A460BF3;
 Fri, 27 Mar 2020 08:51:16 +0000 (UTC)
Subject: Re: [PATCH 2/2] virtio-iommu: delete vqs in unrealize to fix memleaks
To: Pan Nengyuan <pannengyuan@huawei.com>, qemu-devel@nongnu.org
References: <20200327035650.2085-1-pannengyuan@huawei.com>
 <20200327035650.2085-3-pannengyuan@huawei.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <c546bba5-c57d-cd51-94eb-a30fe73f7888@redhat.com>
Date: Fri, 27 Mar 2020 09:51:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200327035650.2085-3-pannengyuan@huawei.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: mst@redhat.com, zhang.zhanghailiang@huawei.com, euler.robot@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Pan,

On 3/27/20 4:56 AM, Pan Nengyuan wrote:
> req_vq/event_vq forgot to free in unrealize(). Fix that.
> 
> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
> ---
> Cc: Eric Auger <eric.auger@redhat.com>
> ---
>  hw/virtio/virtio-iommu.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
> index 4cee8083bc..9d2ff0693c 100644
> --- a/hw/virtio/virtio-iommu.c
> +++ b/hw/virtio/virtio-iommu.c
> @@ -696,6 +696,8 @@ static void virtio_iommu_device_unrealize(DeviceState *dev, Error **errp)
>      g_tree_destroy(s->domains);
>      g_tree_destroy(s->endpoints);
>  
> +    virtio_delete_queue(s->req_vq);
> +    virtio_delete_queue(s->event_vq);
>      virtio_cleanup(vdev);
>  }
>  
> 

thanks for fixing this.

Acked-by: Eric Auger <eric.auger@redhat.com>

Eric


