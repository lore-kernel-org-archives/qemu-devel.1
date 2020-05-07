Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19461C38A24
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 15:15:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FCD1207DD
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 15:15:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JgIPjRRL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FCD1207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWiEr-0003Ej-OA
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 11:15:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53268)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maxime.coquelin@redhat.com>)
 id 1jWiEC-0002g8-K0
 for qemu-devel@nongnu.org; Thu, 07 May 2020 11:14:24 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:50888
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <maxime.coquelin@redhat.com>)
 id 1jWiEB-000504-Gy
 for qemu-devel@nongnu.org; Thu, 07 May 2020 11:14:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588864462;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=oo5zP6H6XBsCwAJh4PfF9DAUYAhpdAv4tjRbvJBRi9g=;
 b=JgIPjRRLqykGvOC4e9r2iA76MsI25IcDNYWKwEO8pUtABnT5LUFwzWhobbF1EEAPYadorS
 s3BqfdkrDKhNeb10wKUVYuaSml2U+FWOlmuGiQmBsw9JY0HsxlEf7neIhK2j8LHh10btVg
 2cXJQqdoXHeIdAs69OtZxlm8dpoq5gs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-111-lnb-smw8Mti9I5i8BZza2A-1; Thu, 07 May 2020 11:13:09 -0400
X-MC-Unique: lnb-smw8Mti9I5i8BZza2A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5268883DE2E;
 Thu,  7 May 2020 15:13:06 +0000 (UTC)
Received: from [10.36.110.29] (unknown [10.36.110.29])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6A73F707B0;
 Thu,  7 May 2020 15:12:40 +0000 (UTC)
Subject: Re: [RFC v1 3/4] vhost-vdpa: implement vhost-vdpa backend
To: Cindy Lu <lulu@redhat.com>, mst@redhat.com, armbru@redhat.com,
 eblake@redhat.com, cohuck@redhat.com, jasowang@redhat.com
References: <20200420093241.4238-1-lulu@redhat.com>
 <20200420093241.4238-4-lulu@redhat.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Autocrypt: addr=maxime.coquelin@redhat.com; keydata=
 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
 Mwqu3GQ=
Message-ID: <c107994b-888d-8aa4-57d2-5188837ed757@redhat.com>
Date: Thu, 7 May 2020 17:12:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200420093241.4238-4-lulu@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81;
 envelope-from=maxime.coquelin@redhat.com; helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 00:55:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: shahafs@mellanox.com, kevin.tian@intel.com, parav@mellanox.com,
 xiao.w.wang@intel.com, saugatm@xilinx.com, qemu-devel@nongnu.org,
 aadam@redhat.com, cunming.liang@intel.com, rdunlap@infradead.org,
 hanand@xilinx.com, gdawar@xilinx.com, vmireyno@marvell.com, hch@infradead.org,
 eperezma@redhat.com, jiri@mellanox.com, jgg@mellanox.com, stefanha@redhat.com,
 zhihong.wang@intel.com, lingshan.zhu@intel.com, mhabets@solarflare.com,
 rob.miller@broadcom.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 4/20/20 11:32 AM, Cindy Lu wrote:
> Currently we have 2 types of vhost backends in QEMU: vhost kernel and
> vhost-user. The above patch provides a generic device for vDPA purpose,
> this vDPA device exposes to user space a non-vendor-specific configuration
> interface for setting up a vhost HW accelerator, this patch set introduces
> a third vhost backend called vhost-vdpa based on the vDPA interface.
> 
> Vhost-vdpa usage:
> 
>   qemu-system-x86_64 -cpu host -enable-kvm \
>     ......
>   -netdev type=vhost-vdpa,vhostdev=/dev/vhost-vdpa-id,id=vhost-vdpa0 \
>   -device virtio-net-pci,netdev=vhost-vdpa0,page-per-vq=on \
> 
> Author: Tiwei Bie
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  hw/net/vhost_net.c                |  43 ++++
>  hw/net/virtio-net.c               |   9 +
>  hw/virtio/Makefile.objs           |   2 +-
>  hw/virtio/vhost-backend.c         |   3 +
>  hw/virtio/vhost-vdpa.c            | 379 ++++++++++++++++++++++++++++++
>  hw/virtio/vhost.c                 |   5 +
>  include/hw/virtio/vhost-backend.h |   6 +-
>  include/hw/virtio/vhost-vdpa.h    |  14 ++
>  8 files changed, 459 insertions(+), 2 deletions(-)
>  create mode 100644 hw/virtio/vhost-vdpa.c
>  create mode 100644 include/hw/virtio/vhost-vdpa.h
> 
> diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
> index 4096d64aaf..0d13fda2fc 100644
> --- a/hw/net/vhost_net.c
> +++ b/hw/net/vhost_net.c
> @@ -17,8 +17,10 @@
>  #include "net/net.h"
>  #include "net/tap.h"
>  #include "net/vhost-user.h"
> +#include "net/vhost-vdpa.h"
>  
>  #include "standard-headers/linux/vhost_types.h"
> +#include "linux-headers/linux/vhost.h"
>  #include "hw/virtio/virtio-net.h"
>  #include "net/vhost_net.h"
>  #include "qemu/error-report.h"
> @@ -85,6 +87,29 @@ static const int user_feature_bits[] = {
>      VHOST_INVALID_FEATURE_BIT
>  };
>  
> +static const int vdpa_feature_bits[] = {
> +    VIRTIO_F_NOTIFY_ON_EMPTY,
> +    VIRTIO_RING_F_INDIRECT_DESC,
> +    VIRTIO_RING_F_EVENT_IDX,
> +    VIRTIO_F_ANY_LAYOUT,
> +    VIRTIO_F_VERSION_1,
> +    VIRTIO_NET_F_CSUM,
> +    VIRTIO_NET_F_GUEST_CSUM,
> +    VIRTIO_NET_F_GSO,
> +    VIRTIO_NET_F_GUEST_TSO4,
> +    VIRTIO_NET_F_GUEST_TSO6,
> +    VIRTIO_NET_F_GUEST_ECN,
> +    VIRTIO_NET_F_GUEST_UFO,
> +    VIRTIO_NET_F_HOST_TSO4,
> +    VIRTIO_NET_F_HOST_TSO6,
> +    VIRTIO_NET_F_HOST_ECN,
> +    VIRTIO_NET_F_HOST_UFO,
> +    VIRTIO_NET_F_MRG_RXBUF,
> +    VIRTIO_NET_F_MTU,
> +    VIRTIO_F_IOMMU_PLATFORM,
> +    VIRTIO_NET_F_GUEST_ANNOUNCE,
> +    VHOST_INVALID_FEATURE_BIT
> +};
>  static const int *vhost_net_get_feature_bits(struct vhost_net *net)
>  {
>      const int *feature_bits = 0;
> @@ -96,6 +121,9 @@ static const int *vhost_net_get_feature_bits(struct vhost_net *net)
>      case NET_CLIENT_DRIVER_VHOST_USER:
>          feature_bits = user_feature_bits;
>          break;
> +    case NET_CLIENT_DRIVER_VHOST_VDPA:
> +        feature_bits = vdpa_feature_bits;
> +        break;
>      default:
>          error_report("Feature bits not defined for this type: %d",
>                  net->nc->info->type);
> @@ -434,6 +462,10 @@ VHostNetState *get_vhost_net(NetClientState *nc)
>          assert(vhost_net);
>          break;
>  #endif
> +    case NET_CLIENT_DRIVER_VHOST_VDPA:
> +        vhost_net = vhost_vdpa_get_vhost_net(nc);
> +        assert(vhost_net);
> +        break;
>      default:
>          break;
>      }
> @@ -465,3 +497,14 @@ int vhost_net_set_mtu(struct vhost_net *net, uint16_t mtu)
>  
>      return vhost_ops->vhost_net_set_mtu(&net->dev, mtu);
>  }
> +int vhost_set_state(NetClientState *nc, int state)
> +{
> +    struct vhost_net *net = get_vhost_net(nc);
> +    struct vhost_dev *hdev = &net->dev;
> +    if (nc->info->type == NET_CLIENT_DRIVER_VHOST_VDPA) {

Maybe checking the vhost_set_state callback is implemented is enough,
and it is not need to restrict that to Vhost-vDPA?

> +        if (hdev->vhost_ops->vhost_set_state) {
> +                return hdev->vhost_ops->vhost_set_state(hdev, state);
> +             }
> +        }
> +    return 0;
> +}


