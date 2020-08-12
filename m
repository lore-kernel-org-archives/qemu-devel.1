Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C1AC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 08:51:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C8422076B
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 08:51:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B5VvU7Ai"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C8422076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5mTX-0002Um-DK
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 04:51:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60446)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1k5mSk-0001Ya-6t
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 04:50:22 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:50968
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1k5mSh-0000nG-Q9
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 04:50:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597222217;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bkkD4axUHnynepEZqDYt6MeTi35bJTmiS/z93ROSeBY=;
 b=B5VvU7AihxXjybRxEQn05jPw9mV06g94Uc6U5FH2zuUmcSI8iS+66LQpo6JHJwomIvp3t3
 Zc4Ccp9Jk508dIHZLCsdPdDPZ43moap9aGDGzmI5W5P2RfQp4bzfTbWxyvhU0lEwQ+zHiX
 1C6gQVRtKnuW3PUeOtdjzpvLEszKJek=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-342-yMPjr0mUOViXmv7SqHnMnw-1; Wed, 12 Aug 2020 04:50:16 -0400
X-MC-Unique: yMPjr0mUOViXmv7SqHnMnw-1
Received: by mail-qv1-f70.google.com with SMTP id n5so998009qvx.2
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2020 01:50:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=bkkD4axUHnynepEZqDYt6MeTi35bJTmiS/z93ROSeBY=;
 b=IsL69LsxA6OzCdzrXu1zyjXJd4ekkltsXSfZcn2RKBZqhoeLDzEOBnQAlWxrqwLRsN
 oTodnDA2x0s0l6R4wBC4AsuIPUYljsosAYFQiqo/VuUMBdd6DRZqjrnW55hgIz5u3zXG
 hKF7zmE8GtUHPsY04A6TCqdnOcTDohhpM5lfumX4RZeQR5JZsgoOmZOkBujko3Qs1ccM
 Rwa3Wh80Qw5nk5rbn+IWQPoiamFeeVoWXgqE/k+nwBcYP1rIQmtxneH4IxANO4rTWpPw
 A4Ang3Iw9tA3aZZAl2Pk9re5KpYn81aDdSnA8aOt7LsRFcvY47WkYpBqpPQvFjqFpmRM
 zq2A==
X-Gm-Message-State: AOAM530v9ym/1O/HLGmRMpUoCQf/3ggTyNcbsZAF8bNHqzy7yzBhk94k
 FynJanMj4dwCHlEOoaA4fDxSF0PBqenOSxJ3bM4y5GY34C//FmseFxrTXVCY3JQLR4B59zgW9l0
 lvY4+/Ym/BNsIx7v5yu4wjhywM1GZFeA=
X-Received: by 2002:a37:9ccf:: with SMTP id f198mr5191426qke.168.1597222215753; 
 Wed, 12 Aug 2020 01:50:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyb+4mytdzPLz18il6EDzZyYk66J7iskfwps7suhKc+pvoauusN/MySoQS3raMiIFMKO4+8aE4bPVdgw2HO2tk=
X-Received: by 2002:a37:9ccf:: with SMTP id f198mr5191407qke.168.1597222215462; 
 Wed, 12 Aug 2020 01:50:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200626064122.9252-1-eperezma@redhat.com>
 <20200811175533.7359-1-eperezma@redhat.com>
 <20200811175533.7359-2-eperezma@redhat.com>
 <2443886f-2109-e048-b47f-886c896613ab@redhat.com>
In-Reply-To: <2443886f-2109-e048-b47f-886c896613ab@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 12 Aug 2020 10:49:39 +0200
Message-ID: <CAJaqyWe0_wcXHgbAVAVNCTpG7O4YKF6FMkgKsf6SfW4dEZ4A5g@mail.gmail.com>
Subject: Re: [RFC v3 1/1] memory: Skip bad range assertion if notifier
 supports arbitrary masks
To: Jason Wang <jasowang@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eperezma@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/12 04:50:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Yan Zhao <yan.y.zhao@intel.com>,
 Juan Quintela <quintela@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, Avi Kivity <avi@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Aug 12, 2020 at 4:24 AM Jason Wang <jasowang@redhat.com> wrote:
>
>
> On 2020/8/12 =E4=B8=8A=E5=8D=881:55, Eugenio P=C3=A9rez wrote:
> > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > ---
> >   hw/virtio/vhost.c     |  2 +-
> >   include/exec/memory.h |  2 ++
> >   softmmu/memory.c      | 10 ++++++++--
> >   3 files changed, 11 insertions(+), 3 deletions(-)
> >
> > diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> > index 1a1384e7a6..e74ad9e09b 100644
> > --- a/hw/virtio/vhost.c
> > +++ b/hw/virtio/vhost.c
> > @@ -729,7 +729,7 @@ static void vhost_iommu_region_add(MemoryListener *=
listener,
> >       iommu_idx =3D memory_region_iommu_attrs_to_index(iommu_mr,
> >                                                      MEMTXATTRS_UNSPECI=
FIED);
> >       iommu_notifier_init(&iommu->n, vhost_iommu_unmap_notify,
> > -                        IOMMU_NOTIFIER_UNMAP,
> > +                        IOMMU_NOTIFIER_UNMAP | IOMMU_NOTIFIER_IOTLB,
>
>
> I think we can safely drop IOMMU_NOTIFIER_UNMAP here since device IOTLB
> is sufficient.
>
> Btw, IOMMU_NOTIFIER_IOTLB is kind of confusing, maybe something like
> IOMMU_NOTIFIER_DEVIOTLB.
>

Got it, will change.

>
> >                           section->offset_within_region,
> >                           int128_get64(end),
> >                           iommu_idx);
> > diff --git a/include/exec/memory.h b/include/exec/memory.h
> > index 307e527835..4d94c1e984 100644
> > --- a/include/exec/memory.h
> > +++ b/include/exec/memory.h
> > @@ -87,6 +87,8 @@ typedef enum {
> >       IOMMU_NOTIFIER_UNMAP =3D 0x1,
> >       /* Notify entry changes (newly created entries) */
> >       IOMMU_NOTIFIER_MAP =3D 0x2,
> > +    /* Notify changes on IOTLB entries */
> > +    IOMMU_NOTIFIER_IOTLB =3D 0x04,
> >   } IOMMUNotifierFlag;
> >
> >   #define IOMMU_NOTIFIER_ALL (IOMMU_NOTIFIER_MAP | IOMMU_NOTIFIER_UNMAP=
)
> > diff --git a/softmmu/memory.c b/softmmu/memory.c
> > index af25987518..e2c5f6d0e7 100644
> > --- a/softmmu/memory.c
> > +++ b/softmmu/memory.c
> > @@ -1895,6 +1895,7 @@ void memory_region_notify_one(IOMMUNotifier *noti=
fier,
>
>
> (we probably need a better name of this function, at least something
> like "memory_region_iommu_notify_one").
>

Ok will change.

>
> >   {
> >       IOMMUNotifierFlag request_flags;
> >       hwaddr entry_end =3D entry->iova + entry->addr_mask;
> > +    IOMMUTLBEntry tmp =3D *entry;
> >
> >       /*
> >        * Skip the notification if the notification does not overlap
> > @@ -1904,7 +1905,12 @@ void memory_region_notify_one(IOMMUNotifier *not=
ifier,
> >           return;
> >       }
> >
> > -    assert(entry->iova >=3D notifier->start && entry_end <=3D notifier=
->end);
> > +    if (notifier->notifier_flags & IOMMU_NOTIFIER_IOTLB) {
> > +        tmp.iova =3D MAX(tmp.iova, notifier->start);
> > +        tmp.addr_mask =3D MIN(entry_end, notifier->end) - tmp.iova;
>
>
> Any reason for doing such re-calculation here, a comment would be helpful=
.
>

It was proposed by Peter, but I understand as limiting the
address+range we pass to the notifier. Although vhost seems to support
it as long as it contains (notifier->start, notifier->end) in range, a
future notifier might not.

It could be done as iommu_entry_crop(IOMMUTLBEntry *entry, const
IOMMUNotifier *notifier) though.

>
> > +    } else {
> > +        assert(entry->iova >=3D notifier->start && entry_end <=3D noti=
fier->end);
>
>
> I wonder if it's better to convert the assert so some kind of log or
> warn here.
>

I think that if we transform that assert to a log, we should also tell
the guest that something went wrong. Or would it be enough notifying
the bad range?

If a malicious guest cannot reach that point, I think that leaving it
as an assertion allows us to detect earlier the fail in my opinion
(Assert early and assert often).

Thanks!

> Thanks
>
>
> > +    }
> >
> >       if (entry->perm & IOMMU_RW) {
> >           request_flags =3D IOMMU_NOTIFIER_MAP;
> > @@ -1913,7 +1919,7 @@ void memory_region_notify_one(IOMMUNotifier *noti=
fier,
> >       }
> >
> >       if (notifier->notifier_flags & request_flags) {
> > -        notifier->notify(notifier, entry);
> > +        notifier->notify(notifier, &tmp);
> >       }
> >   }
> >
>


