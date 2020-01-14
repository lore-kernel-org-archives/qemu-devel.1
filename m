Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D42FCC33C9E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 19:05:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A324924655
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 19:05:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G4vIz7ka"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A324924655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irRVM-0002hk-Oe
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 14:05:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60324)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1irRUZ-00029C-4X
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 14:04:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1irRUU-0002BF-9J
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 14:04:42 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34551
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1irRUT-00029X-WA
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 14:04:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579028677;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MLMutjzen9vqHUm1juhpyc4tucqIKW5xD15uH/4WzuY=;
 b=G4vIz7kafl6qp/2Q0u8VKc17HIHXGgMn0mgAmvAZ3TKZWxHFWwB0dXiNjzcKKDGSy66PtE
 eEZKvNRwLmYgQ9NVgcXRvlrwRHQWbQJdYU1X9eZaHTyhW5rsWS3MwrkT4zqA+EZyv0beRS
 63aOvIauK5pHHz2Cl/+HB214kqER6jM=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-222-mjo2sruoOI6KQ90Im-H4qw-1; Tue, 14 Jan 2020 14:04:35 -0500
Received: by mail-qk1-f197.google.com with SMTP id f22so8961266qka.10
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2020 11:04:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=2TVq6wsEJRKlbCPlDGM+jSdEI5NXyrYLiluRzKmn53k=;
 b=AgemiIjV8NuaNoDGz6pwK3X3QY/QKmKuBnM3WRym6wRhl4l+CU9Wf418BHVZ4CXXkV
 /rr109JOBayjH+Ov58nWY5BkLiSSblhg4941VzHA2bQGxjc3/k7qR15NkBMqsVBe4V/y
 iu9yvKQuMpAFv4G21MSnlme7WCw/oqtgimn9Yrwq/vGA92PRjQFR6LtjQrc8hN5Jtxag
 buWXZplq/VfuiQL/jJTny3BI0t1PR7WVpOmCOaJlKd6HxkVW7uDX4Frcm10n43kch6C4
 6Qkd6VXpWbJWwxBiChpQgupz9HEd9wyJ96+CPF9gdDC8a0AK4nmfMWZk7vRF3yrjPahY
 W+Lg==
X-Gm-Message-State: APjAAAW/ymZoS24mLsjrmYerSrl0yHRw047sGA+V3+2ZL7U5I3CJc9rp
 pr2+omYCQLYAmWAYEKqhTgptS3IZ/UXK5gvjjRKcDvujvAC4sGd1dqhbKRlcuqiEikMBVBVmrUn
 OeXxxrx3ZHBPgYgc=
X-Received: by 2002:a05:6214:13ef:: with SMTP id
 ch15mr18610095qvb.183.1579028675229; 
 Tue, 14 Jan 2020 11:04:35 -0800 (PST)
X-Google-Smtp-Source: APXvYqxn3IdbUg4xZdKkJ0baYZuMAidhgrhZrWTNQljImWUpifItMTMc5LgPNSggR6XjsFQ2sWlc7A==
X-Received: by 2002:a05:6214:13ef:: with SMTP id
 ch15mr18610071qvb.183.1579028674966; 
 Tue, 14 Jan 2020 11:04:34 -0800 (PST)
Received: from xz-x1 ([104.156.64.74])
 by smtp.gmail.com with ESMTPSA id u16sm7129086qku.19.2020.01.14.11.04.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2020 11:04:34 -0800 (PST)
Date: Tue, 14 Jan 2020 14:04:33 -0500
From: Peter Xu <peterx@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v12 09/13] virtio-iommu: Implement fault reporting
Message-ID: <20200114190433.GE225163@xz-x1>
References: <20200109144319.15912-1-eric.auger@redhat.com>
 <20200109144319.15912-10-eric.auger@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200109144319.15912-10-eric.auger@redhat.com>
X-MC-Unique: mjo2sruoOI6KQ90Im-H4qw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: peter.maydell@linaro.org, kevin.tian@intel.com, tnowicki@marvell.com,
 jean-philippe@linaro.org, quintela@redhat.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com, bharatb.linux@gmail.com, qemu-arm@nongnu.org,
 mst@redhat.com, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jan 09, 2020 at 03:43:15PM +0100, Eric Auger wrote:
> The event queue allows to report asynchronous errors.
> The translate function now injects faults when relevant.
>=20
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>=20
> ---
>=20
> v11 -> v12:
> - reporting the addr associated with the fault and set the
>   VIRTIO_IOMMU_FAULT_F_ADDRESS flag.
> - added cpu_to_le<n>
>=20
> v10 -> v11:
> - change a virtio_error into an error_report_once
>   (no buffer available for output faults)
> ---
>  hw/virtio/trace-events   |  1 +
>  hw/virtio/virtio-iommu.c | 73 +++++++++++++++++++++++++++++++++++++---
>  2 files changed, 69 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
> index 095aa8b509..e83500bee9 100644
> --- a/hw/virtio/trace-events
> +++ b/hw/virtio/trace-events
> @@ -72,3 +72,4 @@ virtio_iommu_put_endpoint(uint32_t ep_id) "Free endpoin=
t=3D%d"
>  virtio_iommu_get_domain(uint32_t domain_id) "Alloc domain=3D%d"
>  virtio_iommu_put_domain(uint32_t domain_id) "Free domain=3D%d"
>  virtio_iommu_translate_out(uint64_t virt_addr, uint64_t phys_addr, uint3=
2_t sid) "0x%"PRIx64" -> 0x%"PRIx64 " for sid=3D%d"
> +virtio_iommu_report_fault(uint8_t reason, uint32_t flags, uint32_t endpo=
int, uint64_t addr) "FAULT reason=3D%d flags=3D%d endpoint=3D%d address =3D=
0x%"PRIx64
> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
> index d192bcb505..09193970ee 100644
> --- a/hw/virtio/virtio-iommu.c
> +++ b/hw/virtio/virtio-iommu.c
> @@ -477,6 +477,51 @@ out:
>      }
>  }
> =20
> +static void virtio_iommu_report_fault(VirtIOIOMMU *viommu, uint8_t reaso=
n,
> +                                      int flags, uint32_t endpoint,
> +                                      uint64_t address)
> +{
> +    VirtIODevice *vdev =3D &viommu->parent_obj;
> +    VirtQueue *vq =3D viommu->event_vq;
> +    struct virtio_iommu_fault fault;
> +    VirtQueueElement *elem;
> +    size_t sz;
> +
> +    memset(&fault, 0, sizeof(fault));
> +    fault.reason =3D reason;
> +    fault.flags =3D cpu_to_le32(flags);
> +    fault.endpoint =3D cpu_to_le32(endpoint);
> +    fault.address =3D cpu_to_le64(address);
> +
> +    for (;;) {
> +        elem =3D virtqueue_pop(vq, sizeof(VirtQueueElement));
> +
> +        if (!elem) {
> +            error_report_once(
> +                "no buffer available in event queue to report event");

(Should this also be a guest issue?  IIRC you are still using a
 mixture of both qemu_log_mask and error_report()... I'll stop
 commenting on this, assuming that you prefer both ways to be used...)

> +            return;
> +        }
> +
> +        if (iov_size(elem->in_sg, elem->in_num) < sizeof(fault)) {
> +            virtio_error(vdev, "error buffer of wrong size");
> +            virtqueue_detach_element(vq, elem, 0);
> +            g_free(elem);
> +            continue;

If virtio_error(), should we stop rather than continue?

> +        }
> +        break;
> +    }
> +    /* we have a buffer to fill in */
> +    sz =3D iov_from_buf(elem->in_sg, elem->in_num, 0,
> +                      &fault, sizeof(fault));
> +    assert(sz =3D=3D sizeof(fault));
> +
> +    trace_virtio_iommu_report_fault(reason, flags, endpoint, address);
> +    virtqueue_push(vq, elem, sz);
> +    virtio_notify(vdev, vq);
> +    g_free(elem);
> +
> +}
> +
>  static IOMMUTLBEntry virtio_iommu_translate(IOMMUMemoryRegion *mr, hwadd=
r addr,
>                                              IOMMUAccessFlags flag,
>                                              int iommu_idx)
> @@ -485,9 +530,10 @@ static IOMMUTLBEntry virtio_iommu_translate(IOMMUMem=
oryRegion *mr, hwaddr addr,
>      VirtIOIOMMUInterval interval, *mapping_key;
>      VirtIOIOMMUMapping *mapping_value;
>      VirtIOIOMMU *s =3D sdev->viommu;
> +    bool read_fault, write_fault;
>      VirtIOIOMMUEndpoint *ep;
> +    uint32_t sid, flags;
>      bool bypass_allowed;
> -    uint32_t sid;
>      bool found;
> =20
>      interval.low =3D addr;
> @@ -513,6 +559,9 @@ static IOMMUTLBEntry virtio_iommu_translate(IOMMUMemo=
ryRegion *mr, hwaddr addr,
>      if (!ep) {
>          if (!bypass_allowed) {
>              error_report_once("%s sid=3D%d is not known!!", __func__, si=
d);
> +            virtio_iommu_report_fault(s, VIRTIO_IOMMU_FAULT_R_UNKNOWN,
> +                                      VIRTIO_IOMMU_FAULT_F_ADDRESS,
> +                                      sid, addr);
>          } else {
>              entry.perm =3D flag;
>          }
> @@ -524,6 +573,9 @@ static IOMMUTLBEntry virtio_iommu_translate(IOMMUMemo=
ryRegion *mr, hwaddr addr,
>              error_report_once("%s %02x:%02x.%01x not attached to any dom=
ain",
>                                __func__, PCI_BUS_NUM(sid),
>                                PCI_SLOT(sid), PCI_FUNC(sid));
> +            virtio_iommu_report_fault(s, VIRTIO_IOMMU_FAULT_R_DOMAIN,
> +                                      VIRTIO_IOMMU_FAULT_F_ADDRESS,
> +                                      sid, addr);
>          } else {
>              entry.perm =3D flag;
>          }
> @@ -536,15 +588,26 @@ static IOMMUTLBEntry virtio_iommu_translate(IOMMUMe=
moryRegion *mr, hwaddr addr,
>      if (!found) {
>          error_report_once("%s no mapping for 0x%"PRIx64" for sid=3D%d",
>                            __func__, addr, sid);
> +        virtio_iommu_report_fault(s, VIRTIO_IOMMU_FAULT_R_MAPPING,
> +                                  VIRTIO_IOMMU_FAULT_F_ADDRESS,
> +                                  sid, addr);
>          goto unlock;
>      }
> =20
> -    if (((flag & IOMMU_RO) &&
> -            !(mapping_value->flags & VIRTIO_IOMMU_MAP_F_READ)) ||
> -        ((flag & IOMMU_WO) &&
> -            !(mapping_value->flags & VIRTIO_IOMMU_MAP_F_WRITE))) {
> +    read_fault =3D (flag & IOMMU_RO) &&
> +                    !(mapping_value->flags & VIRTIO_IOMMU_MAP_F_READ);
> +    write_fault =3D (flag & IOMMU_WO) &&
> +                    !(mapping_value->flags & VIRTIO_IOMMU_MAP_F_WRITE);
> +
> +    flags =3D read_fault ? VIRTIO_IOMMU_FAULT_F_READ : 0;
> +    flags |=3D write_fault ? VIRTIO_IOMMU_FAULT_F_WRITE : 0;
> +    if (flags) {
>          error_report_once("%s permission error on 0x%"PRIx64"(%d): allow=
ed=3D%d",
>                            __func__, addr, flag, mapping_value->flags);
> +        flags |=3D VIRTIO_IOMMU_FAULT_F_ADDRESS;
> +        virtio_iommu_report_fault(s, VIRTIO_IOMMU_FAULT_R_MAPPING,
> +                                  flags | VIRTIO_IOMMU_FAULT_F_ADDRESS,
> +                                  sid, addr);
>          goto unlock;
>      }
>      entry.translated_addr =3D addr - mapping_key->low + mapping_value->p=
hys_addr;
> --=20
> 2.20.1
>=20

--=20
Peter Xu


