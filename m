Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E60F6C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 08:23:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3D6B20738
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 08:23:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bvQpDvow"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3D6B20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8JNm-0004hb-1d
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 04:23:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58520)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1k8JN7-00040y-1p
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 04:23:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50337
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1k8JN3-0001DG-CI
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 04:23:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597825376;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VXMAvdVjnwEq/4SvoxiTBch4Ojyt+xI36R9uuQaxBI4=;
 b=bvQpDvow3KEI3FOL3HAnbmqy4ssLFyfHzidiXPtj/EiWJMZdRkbIY3nT+k5LQ847W4ix7A
 O3WLUEeDkjuN9gzo61uVG6u5JITg8lmlEKYtm027/3aqo2Sif/koyDD9Lnaoy/yeZFiFxy
 cytXwS3S/C5CJEEf9QNejKz2IJWRIt0=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-g8zoQF0xOuGIZOwhQQGWyw-1; Wed, 19 Aug 2020 04:22:55 -0400
X-MC-Unique: g8zoQF0xOuGIZOwhQQGWyw-1
Received: by mail-qt1-f198.google.com with SMTP id m13so16162035qth.16
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2020 01:22:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=VXMAvdVjnwEq/4SvoxiTBch4Ojyt+xI36R9uuQaxBI4=;
 b=nBtxtIVPs7yKYcj30B2HQtcwWTuEdxKq/RB+/oUvPg2uHwvCNvlKpxQlRizrfTdK0W
 PQnBpbo01BE3QuWtbIf4eWPDiJDVRRcRrBVheCLigl1UP3wzKfRTHNLVUnL69HuFMxTV
 oO9UACu15wJ+qK/9DyOd1BUmGrlMTeKZhWfPt1juC5kWRInpH7SoNyWH8l6xOm0zxn/f
 brD0z3CzeUkK6xlxTvRvtLiD4aI2Kqk7+xIe0mud71tJvFNtMIHa4r57yuLqsvLl7YaP
 du3+LgV+2HPtAy+s6o0p75F9Vxm8bPw3gjN15Enkf474sku25ygcSYuP4v8+8iM0sXGF
 TbUQ==
X-Gm-Message-State: AOAM533TmS4MTHmCSBDO06Gp5NH3ahlth5gKvoOrbj2ZMllvIPtTi6bh
 OXKAx/AEkgr4DqD3gmXk9rpe03DLPZwKWJByjB6Y6ZE7dX16R7IOX6L6mPYjCIT5qfGgXNEHggn
 JvjeGpx2bVqX/MUHAavjj8t5UjocBwDg=
X-Received: by 2002:a05:620a:1595:: with SMTP id
 d21mr20722030qkk.203.1597825374473; 
 Wed, 19 Aug 2020 01:22:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxPm1C92KjIUObN8NYLDlLrk5bMxE+aJa4+Uel9h1T9gwiI6eE1eqNCHwi8ko5R5hu6ksHKQi9ZZ6ZZR+Z38NE=
X-Received: by 2002:a05:620a:1595:: with SMTP id
 d21mr20722017qkk.203.1597825374213; 
 Wed, 19 Aug 2020 01:22:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200626064122.9252-1-eperezma@redhat.com>
 <20200811175533.7359-1-eperezma@redhat.com>
 <20200811175533.7359-2-eperezma@redhat.com>
 <2443886f-2109-e048-b47f-886c896613ab@redhat.com>
 <CAJaqyWe0_wcXHgbAVAVNCTpG7O4YKF6FMkgKsf6SfW4dEZ4A5g@mail.gmail.com>
 <CAJaqyWe+KgnVegtprpRmVvXo7kFVFDL_erK_5Nyp4K=gTUcN=Q@mail.gmail.com>
 <eb26c5d7-465a-34ed-3f8f-bad11eda5bee@redhat.com>
In-Reply-To: <eb26c5d7-465a-34ed-3f8f-bad11eda5bee@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 19 Aug 2020 10:22:17 +0200
Message-ID: <CAJaqyWfGx5T=DvGPq-ydvvYbNg_pRR35rXAT=Lz5nTaztQAV8g@mail.gmail.com>
Subject: Re: [RFC v3 1/1] memory: Skip bad range assertion if notifier
 supports arbitrary masks
To: Jason Wang <jasowang@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eperezma@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eperezma@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 04:00:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Yan Zhao <yan.y.zhao@intel.com>,
 Juan Quintela <quintela@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, Avi Kivity <avi@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Aug 19, 2020 at 9:15 AM Jason Wang <jasowang@redhat.com> wrote:
>
>
> On 2020/8/18 =E4=B8=8B=E5=8D=8810:24, Eugenio Perez Martin wrote:
> > On Wed, Aug 12, 2020 at 10:49 AM Eugenio Perez Martin
> > <eperezma@redhat.com>  wrote:
> >> On Wed, Aug 12, 2020 at 4:24 AM Jason Wang<jasowang@redhat.com>  wrote=
:
> >>> On 2020/8/12 =E4=B8=8A=E5=8D=881:55, Eugenio P=C3=A9rez wrote:
> >>>> Signed-off-by: Eugenio P=C3=A9rez<eperezma@redhat.com>
> >>>> ---
> >>>>    hw/virtio/vhost.c     |  2 +-
> >>>>    include/exec/memory.h |  2 ++
> >>>>    softmmu/memory.c      | 10 ++++++++--
> >>>>    3 files changed, 11 insertions(+), 3 deletions(-)
> >>>>
> >>>> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> >>>> index 1a1384e7a6..e74ad9e09b 100644
> >>>> --- a/hw/virtio/vhost.c
> >>>> +++ b/hw/virtio/vhost.c
> >>>> @@ -729,7 +729,7 @@ static void vhost_iommu_region_add(MemoryListene=
r *listener,
> >>>>        iommu_idx =3D memory_region_iommu_attrs_to_index(iommu_mr,
> >>>>                                                       MEMTXATTRS_UNS=
PECIFIED);
> >>>>        iommu_notifier_init(&iommu->n, vhost_iommu_unmap_notify,
> >>>> -                        IOMMU_NOTIFIER_UNMAP,
> >>>> +                        IOMMU_NOTIFIER_UNMAP | IOMMU_NOTIFIER_IOTLB=
,
> >>> I think we can safely drop IOMMU_NOTIFIER_UNMAP here since device IOT=
LB
> >>> is sufficient.
> >>>
> >>> Btw, IOMMU_NOTIFIER_IOTLB is kind of confusing, maybe something like
> >>> IOMMU_NOTIFIER_DEVIOTLB.
> >>>
> >> Got it, will change.
> >>
> >>>>                            section->offset_within_region,
> >>>>                            int128_get64(end),
> >>>>                            iommu_idx);
> >>>> diff --git a/include/exec/memory.h b/include/exec/memory.h
> >>>> index 307e527835..4d94c1e984 100644
> >>>> --- a/include/exec/memory.h
> >>>> +++ b/include/exec/memory.h
> >>>> @@ -87,6 +87,8 @@ typedef enum {
> >>>>        IOMMU_NOTIFIER_UNMAP =3D 0x1,
> >>>>        /* Notify entry changes (newly created entries) */
> >>>>        IOMMU_NOTIFIER_MAP =3D 0x2,
> >>>> +    /* Notify changes on IOTLB entries */
> >>>> +    IOMMU_NOTIFIER_IOTLB =3D 0x04,
> >>>>    } IOMMUNotifierFlag;
> >>>>
> >>>>    #define IOMMU_NOTIFIER_ALL (IOMMU_NOTIFIER_MAP | IOMMU_NOTIFIER_U=
NMAP)
> >>>> diff --git a/softmmu/memory.c b/softmmu/memory.c
> >>>> index af25987518..e2c5f6d0e7 100644
> >>>> --- a/softmmu/memory.c
> >>>> +++ b/softmmu/memory.c
> >>>> @@ -1895,6 +1895,7 @@ void memory_region_notify_one(IOMMUNotifier *n=
otifier,
> >>> (we probably need a better name of this function, at least something
> >>> like "memory_region_iommu_notify_one").
> >>>
> >> Ok will change.
> >>
> >>>>    {
> >>>>        IOMMUNotifierFlag request_flags;
> >>>>        hwaddr entry_end =3D entry->iova + entry->addr_mask;
> >>>> +    IOMMUTLBEntry tmp =3D *entry;
> >>>>
> >>>>        /*
> >>>>         * Skip the notification if the notification does not overlap
> >>>> @@ -1904,7 +1905,12 @@ void memory_region_notify_one(IOMMUNotifier *=
notifier,
> >>>>            return;
> >>>>        }
> >>>>
> >>>> -    assert(entry->iova >=3D notifier->start && entry_end <=3D notif=
ier->end);
> >>>> +    if (notifier->notifier_flags & IOMMU_NOTIFIER_IOTLB) {
> >>>> +        tmp.iova =3D MAX(tmp.iova, notifier->start);
> >>>> +        tmp.addr_mask =3D MIN(entry_end, notifier->end) - tmp.iova;
> >>> Any reason for doing such re-calculation here, a comment would be hel=
pful.
> >>>
> >> It was proposed by Peter, but I understand as limiting the
> >> address+range we pass to the notifier. Although vhost seems to support
> >> it as long as it contains (notifier->start, notifier->end) in range, a
> >> future notifier might not.
>
>
> Yes, actually, I feel confused after reading the codes. Is
> notifier->start IOVA or GPA?
>
> In vfio.c, we did:
>
>          iommu_notifier_init(&giommu->n, vfio_iommu_map_notify,
>                              IOMMU_NOTIFIER_ALL,
>                              section->offset_within_region,
>                              int128_get64(llend),
>                              iommu_idx);
>
> So it looks to me the start and end are GPA, but the assertion above
> check it against IOVA which seems to be wrong ....
>
> Thanks
>

I see.

I didn't go so deep, I just assumed that:
* all the addresses were GPA in the vhost-net+virtio-net case,
although the name iova in IOMMUTLBEntry.
* memory region was initialized with IOVA addresses in case of VFIO.

Maybe the comment should warn about the bad "iova" name, if I'm right?

I assumed that nothing changed in the VFIO case since its notifier has
no IOMMU_NOTIFIER_DEVIOTLB flag and the new conditional in
memory_region_notify_one_iommu, but I will test with a device
passthrough and DPDK again. Do you think another test would be needed?

Maybe Peter can go deeper on this.

Thanks!

>
> >>
> >> It could be done as iommu_entry_crop(IOMMUTLBEntry *entry, const
> >> IOMMUNotifier *notifier) though.
>


