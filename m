Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04DD2C38A24
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 14:44:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B268B20575
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 14:44:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NaBY03AU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B268B20575
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWhkz-0006Fn-Qj
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 10:44:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47238)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jWhk7-0005kK-4f
 for qemu-devel@nongnu.org; Thu, 07 May 2020 10:43:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26394
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jWhk5-0003DQ-Uh
 for qemu-devel@nongnu.org; Thu, 07 May 2020 10:43:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588862597;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fmj+TxsqcfaWnGRv+bXSTtnVxhBzJpHOBFAax8SPGR4=;
 b=NaBY03AUVXQWtagT7ufYv8M08TDCPcIt5MJpmXRSh78/95mLM/NDjLO69yUU69w8dnM95t
 WuvSvBPqU6xSl/DgcKnrt5bp0/Xo0QVc7IYYBgIW+XuJuyYm3VWxPDmM9MilWm/1oYFCUI
 7I0XrjaJn29iDGTbl6rz4ujClpXeHKY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-58-71pHwSlQOY2syutbCSN_Ww-1; Thu, 07 May 2020 10:43:13 -0400
X-MC-Unique: 71pHwSlQOY2syutbCSN_Ww-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AC12319057A1;
 Thu,  7 May 2020 14:43:11 +0000 (UTC)
Received: from [10.36.114.214] (ovpn-114-214.ams2.redhat.com [10.36.114.214])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A9555707BA;
 Thu,  7 May 2020 14:42:56 +0000 (UTC)
Subject: Re: [PATCH v9 8/9] virtio-iommu: Implement probe request
To: Bharat Bhushan <bharatb.linux@gmail.com>
References: <20200323084617.1782-1-bbhushan2@marvell.com>
 <20200323084617.1782-9-bbhushan2@marvell.com>
 <20200423160952.GB645865@myrica>
 <199e049a-99f0-7760-778f-b7c547f158e9@redhat.com>
 <CAAeCc_nPrmiHDe61drkFmFVVWqOg6yvmC13TVfKmiZn1GF2eXA@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <44bd0135-89ec-caa0-bb47-f3a8c69860e7@redhat.com>
Date: Thu, 7 May 2020 16:42:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAAeCc_nPrmiHDe61drkFmFVVWqOg6yvmC13TVfKmiZn1GF2eXA@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 03:15:48
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: "Zhong, Yang" <yang.zhong@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, kevin.tian@intel.com,
 tnowicki@marvell.com, mst@redhat.com, Peter Maydell <peter.maydell@linaro.org>,
 drjones@redhat.com, peterx@redhat.com, qemu-devel@nongnu.org,
 alex.williamson@redhat.com, qemu-arm@nongnu.org,
 Bharat Bhushan <bbhushan2@marvell.com>, linuc.decode@gmail.com,
 eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Bharat,

On 5/5/20 11:06 AM, Bharat Bhushan wrote:
> On Fri, Apr 24, 2020 at 7:22 PM Auger Eric <eric.auger@redhat.com> wrote:
>>
>> Hi Bharat,
>> On 4/23/20 6:09 PM, Jean-Philippe Brucker wrote:
>>> Hi Bharat,
>>>
>>> A few more things found while rebasing
>>>
>>> On Mon, Mar 23, 2020 at 02:16:16PM +0530, Bharat Bhushan wrote:
>>>> This patch implements the PROBE request. Currently supported
>>>> page size mask per endpoint is returned. Also append a NONE
>>>> property in the end.
>>>>
>>>> Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
>>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>>> ---
>>>>  include/standard-headers/linux/virtio_iommu.h |   6 +
>>>>  hw/virtio/virtio-iommu.c                      | 161 +++++++++++++++++=
-
>>>>  hw/virtio/trace-events                        |   2 +
>>>>  3 files changed, 166 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/include/standard-headers/linux/virtio_iommu.h b/include/s=
tandard-headers/linux/virtio_iommu.h
>>>> index b9443b83a1..8a0d47b907 100644
>>>> --- a/include/standard-headers/linux/virtio_iommu.h
>>>> +++ b/include/standard-headers/linux/virtio_iommu.h
>>>> @@ -111,6 +111,7 @@ struct virtio_iommu_req_unmap {
>>>>
>>>>  #define VIRTIO_IOMMU_PROBE_T_NONE           0
>>>>  #define VIRTIO_IOMMU_PROBE_T_RESV_MEM               1
>>>> +#define VIRTIO_IOMMU_PROBE_T_PAGE_SIZE_MASK 2
>>>>
>>>>  #define VIRTIO_IOMMU_PROBE_T_MASK           0xfff
>>>>
>>>> @@ -130,6 +131,11 @@ struct virtio_iommu_probe_resv_mem {
>>>>      uint64_t                                        end;
>>>>  };
>>>>
>>>> +struct virtio_iommu_probe_pgsize_mask {
>>>> +    struct virtio_iommu_probe_property      head;
>>>> +    uint64_t                                pgsize_bitmap;
>>>> +};
>>>> +
>>>>  struct virtio_iommu_req_probe {
>>>>      struct virtio_iommu_req_head            head;
>>>>      uint32_t                                        endpoint;
>>>> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
>>>> index 747e3cf1da..63fbacdcdc 100644
>>>> --- a/hw/virtio/virtio-iommu.c
>>>> +++ b/hw/virtio/virtio-iommu.c
>>>> @@ -38,6 +38,10 @@
>>>>
>>>>  /* Max size */
>>>>  #define VIOMMU_DEFAULT_QUEUE_SIZE 256
>>>> +#define VIOMMU_PROBE_SIZE 512
>>>> +
>>>> +#define SUPPORTED_PROBE_PROPERTIES (\
>>>> +    1 << VIRTIO_IOMMU_PROBE_T_PAGE_SIZE_MASK)
>>>>
>>>>  typedef struct VirtIOIOMMUDomain {
>>>>      uint32_t id;
>>>> @@ -62,6 +66,13 @@ typedef struct VirtIOIOMMUMapping {
>>>>      uint32_t flags;
>>>>  } VirtIOIOMMUMapping;
>>>>
>>>> +typedef struct VirtIOIOMMUPropBuffer {
>>>> +    VirtIOIOMMUEndpoint *endpoint;
>>>> +    size_t filled;
>>>> +    uint8_t *start;
>>>> +    bool error;
>>>
>>> It doesn't seem like bufstate->error gets used anywhere
>> maybe rebase your work on
>> [PATCH for-4.2 v10 10/15] virtio-iommu: Implement probe request
>> which tests it.
>=20
> This was the staring point for me, As of now i moved away from "error"
> from above struct.
>=20
>>
>> Also in
>> [Qemu-devel] [PATCH for-4.2 v10 10/15] virtio-iommu: Implement probe req=
uest
>> I changed the implementation to keep it simpler.

In [PATCH 2/5] virtio-iommu: Implement RESV_MEM probe request
I reworked the original implementation. I think this version is simpler
to start from. I removed the VirtIOIOMMUPropBuffer struct which looks
more complex than requested.

Thanks

Eric
>>
>> Thanks
>>
>> Eric
>>>
>>>> +} VirtIOIOMMUPropBuffer;
>>>> +
>>>>  static inline uint16_t virtio_iommu_get_bdf(IOMMUDevice *dev)
>>>>  {
>>>>      return PCI_BUILD_BDF(pci_bus_num(dev->bus), dev->devfn);
>>>> @@ -490,6 +501,114 @@ static int virtio_iommu_unmap(VirtIOIOMMU *s,
>>>>      return ret;
>>>>  }
>>>>
>>>> +static int virtio_iommu_fill_none_prop(VirtIOIOMMUPropBuffer *bufstat=
e)
>>>> +{
>>>> +    struct virtio_iommu_probe_property *prop;
>>>> +
>>>> +    prop =3D (struct virtio_iommu_probe_property *)
>>>> +                (bufstate->start + bufstate->filled);
>>>> +    prop->type =3D 0;
>>>> +    prop->length =3D 0;
>>>> +    bufstate->filled +=3D sizeof(*prop);
>>>> +    trace_virtio_iommu_fill_none_property(bufstate->endpoint->id);
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static int virtio_iommu_fill_page_size_mask(VirtIOIOMMUPropBuffer *bu=
fstate)
>>>> +{
>>>> +    struct virtio_iommu_probe_pgsize_mask *page_size_mask;
>>>> +    size_t prop_size =3D sizeof(*page_size_mask);
>>>> +    VirtIOIOMMUEndpoint *ep =3D bufstate->endpoint;
>>>> +    VirtIOIOMMU *s =3D ep->viommu;
>>>> +    IOMMUDevice *sdev;
>>>> +
>>>> +    if (bufstate->filled + prop_size >=3D VIOMMU_PROBE_SIZE) {
>>>> +        bufstate->error =3D true;
>>>> +        /* get the traversal stopped by returning true */
>>>> +        return true;
>>>> +    }
>>>> +
>>>> +    page_size_mask =3D (struct virtio_iommu_probe_pgsize_mask *)
>>>> +                     (bufstate->start + bufstate->filled);
>>>> +
>>>> +    page_size_mask->head.type =3D VIRTIO_IOMMU_PROBE_T_PAGE_SIZE_MASK=
;
>>>> +    page_size_mask->head.length =3D prop_size;
>>>> +    QLIST_FOREACH(sdev, &s->notifiers_list, next) {
>>>> +        if (ep->id =3D=3D sdev->devfn) {
>>>> +            page_size_mask->pgsize_bitmap =3D sdev->page_size_mask;
>>>
>>> Do we need a cpu_to_le64 here?
>=20
> Ack, yes, even head.type and head.length needed  cpu_to_le16().
>=20
>>>
>>>> +    }
>>>> +    }
>>>> +    bufstate->filled +=3D sizeof(*page_size_mask);
>>>> +    trace_virtio_iommu_fill_pgsize_mask_property(bufstate->endpoint->=
id,
>>>> +                                                 page_size_mask->pgsi=
ze_bitmap,
>>>> +                                                 bufstate->filled);
>>>> +    return false;
>>>> +}
>>>> +
>>>> +/* Fill the properties[] buffer with properties of type @type */
>>>> +static int virtio_iommu_fill_property(int type,
>>>> +                                      VirtIOIOMMUPropBuffer *bufstate=
)
>>>> +{
>>>> +    int ret =3D -ENOSPC;
>>>> +
>>>> +    if (bufstate->filled + sizeof(struct virtio_iommu_probe_property)
>>>> +            >=3D VIOMMU_PROBE_SIZE) {
>>>> +        /* no space left for the header */
>>>> +        bufstate->error =3D true;
>>>> +        goto out;
>>>> +    }
>>>> +
>>>> +    switch (type) {
>>>> +    case VIRTIO_IOMMU_PROBE_T_NONE:
>>>> +        ret =3D virtio_iommu_fill_none_prop(bufstate);
>>>> +        break;
>>>> +    case VIRTIO_IOMMU_PROBE_T_PAGE_SIZE_MASK:
>>>> +    {
>>>> +        ret =3D virtio_iommu_fill_page_size_mask(bufstate);
>>>> +    break;
>>>> +    }
>>>> +    default:
>>>> +        ret =3D -ENOENT;
>>>> +        break;
>>>> +    }
>>>> +out:
>>>> +    if (ret) {
>>>> +        error_report("%s property of type=3D%d could not be filled (%=
d),"
>>>> +                     " remaining size =3D 0x%lx",
>>>> +                     __func__, type, ret, bufstate->filled);
>>>> +    }
>>>> +    return ret;
>>>> +}
>>>> +
>>>> +/**
>>>> + * virtio_iommu_probe - Fill the probe request buffer with all
>>>> + * the properties the device is able to return and add a NONE
>>>> + * property at the end. @buf points to properties[].
>>>> + */
>>>> +static int virtio_iommu_probe(VirtIOIOMMU *s,
>>>> +                              struct virtio_iommu_req_probe *req,
>>>> +                              uint8_t *buf)
>>>> +{
>>>> +    uint32_t ep_id =3D le32_to_cpu(req->endpoint);
>>>> +    VirtIOIOMMUEndpoint *ep =3D virtio_iommu_get_endpoint(s, ep_id);
>>>> +    int16_t prop_types =3D SUPPORTED_PROBE_PROPERTIES, type;
>>>> +    VirtIOIOMMUPropBuffer bufstate =3D {.start =3D buf, .filled =3D 0=
,
>>>> +                                       .error =3D false, .endpoint =
=3D ep};
>>>
>>> Probably need to check if ep is valid before going further
>=20
> yes, will take care
>=20
>>>
>>>> +
>>>> +    while ((type =3D ctz32(prop_types)) !=3D 32) {
>>>> +        if (virtio_iommu_fill_property(type, &bufstate)) {
>>>> +            goto failure;
>>>> +        }
>>>> +        prop_types &=3D ~(1 << type);
>>>> +    }
>>>> +    if (virtio_iommu_fill_property(VIRTIO_IOMMU_PROBE_T_NONE, &bufsta=
te)) {
>>>> +        goto failure;
>>>> +    }
>>>
>>> We got rid of the NONE property in the spec, now there is:
>>>
>>>  "If the device doesn=E2=80=99t fill all probe_size bytes with properti=
es, it
>>>   SHOULD fill the remaining bytes of properties with zeroes."
>>>
>>> So I think you can get rid of virtio_iommu_fill_none_prop() and fill th=
e
>>> rest of the buffer with zeroes here instead.
>=20
> will do changes accordingly.
>=20
> Stay Safe !!
>=20
> Thanks
> -Bharat
>>>
>>> Thanks,
>>> Jean
>>>
>>>> +    return VIRTIO_IOMMU_S_OK;
>>>> +failure:
>>>> +    return VIRTIO_IOMMU_S_INVAL;
>>>> +}
>>>> +
>>>>  static int virtio_iommu_iov_to_req(struct iovec *iov,
>>>>                                     unsigned int iov_cnt,
>>>>                                     void *req, size_t req_sz)
>>>> @@ -519,6 +638,17 @@ virtio_iommu_handle_req(detach)
>>>>  virtio_iommu_handle_req(map)
>>>>  virtio_iommu_handle_req(unmap)
>>>>
>>>> +static int virtio_iommu_handle_probe(VirtIOIOMMU *s,
>>>> +                                     struct iovec *iov,
>>>> +                                     unsigned int iov_cnt,
>>>> +                                     uint8_t *buf)
>>>> +{
>>>> +    struct virtio_iommu_req_probe req;
>>>> +    int ret =3D virtio_iommu_iov_to_req(iov, iov_cnt, &req, sizeof(re=
q));
>>>> +
>>>> +    return ret ? ret : virtio_iommu_probe(s, &req, buf);
>>>> +}
>>>> +
>>>>  static void virtio_iommu_handle_command(VirtIODevice *vdev, VirtQueue=
 *vq)
>>>>  {
>>>>      VirtIOIOMMU *s =3D VIRTIO_IOMMU(vdev);
>>>> @@ -564,17 +694,33 @@ static void virtio_iommu_handle_command(VirtIODe=
vice *vdev, VirtQueue *vq)
>>>>          case VIRTIO_IOMMU_T_UNMAP:
>>>>              tail.status =3D virtio_iommu_handle_unmap(s, iov, iov_cnt=
);
>>>>              break;
>>>> +        case VIRTIO_IOMMU_T_PROBE:
>>>> +        {
>>>> +            struct virtio_iommu_req_tail *ptail;
>>>> +            uint8_t *buf =3D g_malloc0(s->config.probe_size + sizeof(=
tail));
>>>> +
>>>> +            ptail =3D (struct virtio_iommu_req_tail *)
>>>> +                        (buf + s->config.probe_size);
>>>> +            ptail->status =3D virtio_iommu_handle_probe(s, iov, iov_c=
nt, buf);
>>>> +
>>>> +            sz =3D iov_from_buf(elem->in_sg, elem->in_num, 0,
>>>> +                              buf, s->config.probe_size + sizeof(tail=
));
>>>> +            g_free(buf);
>>>> +            assert(sz =3D=3D s->config.probe_size + sizeof(tail));
>>>> +            goto push;
>>>> +        }
>>>>          default:
>>>>              tail.status =3D VIRTIO_IOMMU_S_UNSUPP;
>>>>          }
>>>> -        qemu_mutex_unlock(&s->mutex);
>>>>
>>>>  out:
>>>>          sz =3D iov_from_buf(elem->in_sg, elem->in_num, 0,
>>>>                            &tail, sizeof(tail));
>>>>          assert(sz =3D=3D sizeof(tail));
>>>>
>>>> -        virtqueue_push(vq, elem, sizeof(tail));
>>>> +push:
>>>> +        qemu_mutex_unlock(&s->mutex);
>>>> +        virtqueue_push(vq, elem, sz);
>>>>          virtio_notify(vdev, vq);
>>>>          g_free(elem);
>>>>      }
>>>> @@ -634,16 +780,23 @@ static IOMMUTLBEntry virtio_iommu_translate(IOMM=
UMemoryRegion *mr, hwaddr addr,
>>>>      VirtIOIOMMUEndpoint *ep;
>>>>      uint32_t sid, flags;
>>>>      bool bypass_allowed;
>>>> +    hwaddr addr_mask;
>>>>      bool found;
>>>>
>>>>      interval.low =3D addr;
>>>>      interval.high =3D addr + 1;
>>>>
>>>> +    if (sdev->page_size_mask) {
>>>> +        addr_mask =3D (1 << ctz32(sdev->page_size_mask)) - 1;
>>>> +    } else {
>>>> +        addr_mask =3D (1 << ctz32(s->config.page_size_mask)) - 1;
>>>> +    }
>>>> +
>>>>      IOMMUTLBEntry entry =3D {
>>>>          .target_as =3D &address_space_memory,
>>>>          .iova =3D addr,
>>>>          .translated_addr =3D addr,
>>>> -        .addr_mask =3D (1 << ctz32(s->config.page_size_mask)) - 1,
>>>> +        .addr_mask =3D addr_mask,
>>>>          .perm =3D IOMMU_NONE,
>>>>      };
>>>>
>>>> @@ -831,6 +984,7 @@ static void virtio_iommu_device_realize(DeviceStat=
e *dev, Error **errp)
>>>>      s->config.page_size_mask =3D TARGET_PAGE_MASK;
>>>>      s->config.input_range.end =3D -1UL;
>>>>      s->config.domain_range.end =3D 32;
>>>> +    s->config.probe_size =3D VIOMMU_PROBE_SIZE;
>>>>
>>>>      virtio_add_feature(&s->features, VIRTIO_RING_F_EVENT_IDX);
>>>>      virtio_add_feature(&s->features, VIRTIO_RING_F_INDIRECT_DESC);
>>>> @@ -840,6 +994,7 @@ static void virtio_iommu_device_realize(DeviceStat=
e *dev, Error **errp)
>>>>      virtio_add_feature(&s->features, VIRTIO_IOMMU_F_MAP_UNMAP);
>>>>      virtio_add_feature(&s->features, VIRTIO_IOMMU_F_BYPASS);
>>>>      virtio_add_feature(&s->features, VIRTIO_IOMMU_F_MMIO);
>>>> +    virtio_add_feature(&s->features, VIRTIO_IOMMU_F_PROBE);
>>>>
>>>>      qemu_mutex_init(&s->mutex);
>>>>
>>>> diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
>>>> index 8bae651191..b0a6e4bda3 100644
>>>> --- a/hw/virtio/trace-events
>>>> +++ b/hw/virtio/trace-events
>>>> @@ -76,3 +76,5 @@ virtio_iommu_report_fault(uint8_t reason, uint32_t f=
lags, uint32_t endpoint, uin
>>>>  virtio_iommu_notify_map(const char *name, uint64_t iova, uint64_t pad=
dr, uint64_t map_size) "mr=3D%s iova=3D0x%"PRIx64" pa=3D0x%" PRIx64" size=
=3D0x%"PRIx64
>>>>  virtio_iommu_notify_unmap(const char *name, uint64_t iova, uint64_t m=
ap_size) "mr=3D%s iova=3D0x%"PRIx64" size=3D0x%"PRIx64
>>>>  virtio_iommu_remap(uint64_t iova, uint64_t pa, uint64_t size) "iova=
=3D0x%"PRIx64" pa=3D0x%" PRIx64" size=3D0x%"PRIx64""
>>>> +virtio_iommu_fill_none_property(uint32_t devid) "devid=3D%d"
>>>> +virtio_iommu_fill_pgsize_mask_property(uint32_t devid, uint64_t pgsiz=
e_mask, size_t filled) "dev=3D %d, pgsize_mask=3D0x%"PRIx64" filled=3D0x%lx=
"
>>>> --
>>>> 2.17.1
>>>>
>>>
>>
>=20


