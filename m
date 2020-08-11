Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC951C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 17:11:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58D7A2076B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 17:11:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="coCvaF4A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58D7A2076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5XoD-0007H7-HK
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 13:11:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50518)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1k5XnX-0006rI-Uk
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 13:10:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44151
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1k5XnW-0005sv-1l
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 13:10:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597165848;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0c+/RDUxoBrihJpOXMVhPjtf1LIF4Sr8WdMCTJvcPs0=;
 b=coCvaF4AIzx0JuV1UW0C0j1pK5IueU0nmNjFzCfX/yx+ONuwFncvushf+YBGdyp1skl5QI
 PiTRQY9AEBgup8GQcbsjDF16PgofKtXbOCZYVn05vaJiH774oUt9FoZUFhh5U6m1UUuM+E
 L2IeALxTeT+fDyLAW1rNuN+hdXTntHE=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-180-0vSRDuqAME2apwtuYCzKRw-1; Tue, 11 Aug 2020 13:10:46 -0400
X-MC-Unique: 0vSRDuqAME2apwtuYCzKRw-1
Received: by mail-qt1-f199.google.com with SMTP id q19so10303309qtp.0
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2020 10:10:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=0c+/RDUxoBrihJpOXMVhPjtf1LIF4Sr8WdMCTJvcPs0=;
 b=eCeKa1qP6viHUw2SDfWRhOiCoZTbJfFuu/IbCK2m0OqDVCa/P5Khsp5TfmKIjzUYWF
 V4ffoosb4BFauPtoGWlnOX2PXV317Ne3Cu+LJtv7kWN0TpRhrCa4Eav8ZozkIC2V6rMh
 tqqP/ntbteaXrPEeaz/xlb1Td3yz6h5rX1x/0t/9QgdQRnCDx2avdKRkltdR4FYyp/u4
 cQS0vQDV+50TiVd/FGGS78vtiJ4/wUwwd0TqsdREAunC1HiYwYsBcnG84iYAjyUAaRaA
 wIaPSxd2dpp8tggE5mOlczwFUPE5mCLfWaIcSoGm2igarginqGtCZzK0j1lbwatgSyAF
 CAzw==
X-Gm-Message-State: AOAM532hz18zIPbmQ+ssJLl/cwjP5/2X+S8D3ii7WOQR+x9iFx/md717
 o0BNiHFta5LRWLVEJsyZJsACxzjeq7mHluCfX78aCLK0tsQ8FC/6bIMNto45WR5oLv2PiYKm6YH
 JTGmzqBdSFzIDJfgK7btM/8lcbPmSudA=
X-Received: by 2002:a05:620a:2:: with SMTP id j2mr2145577qki.497.1597165845773; 
 Tue, 11 Aug 2020 10:10:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwWL6ByGpXED/zne80/UpjKPW0AEhIq+xR9SgwYf2NNPHl9ZzuNj4had8uAx9PvjdZGgGkg44Gbf7078Ap5I6E=
X-Received: by 2002:a05:620a:2:: with SMTP id j2mr2145548qki.497.1597165845479; 
 Tue, 11 Aug 2020 10:10:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200626064122.9252-1-eperezma@redhat.com>
 <20200626064122.9252-2-eperezma@redhat.com>
 <20200626212917.GD175520@xz-x1>
 <CAJaqyWf5=fwwcgZgOdipt54mq=vPZkQLGp9xWRG7Tnw-E9xjCA@mail.gmail.com>
In-Reply-To: <CAJaqyWf5=fwwcgZgOdipt54mq=vPZkQLGp9xWRG7Tnw-E9xjCA@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 11 Aug 2020 19:10:09 +0200
Message-ID: <CAJaqyWdbvS7+8f5d8jQjdmuVio+QvoFE77kNJNA1buaGsk_JAw@mail.gmail.com>
Subject: Re: [RFC v2 1/1] memory: Delete assertion in
 memory_region_unregister_iommu_notifier
To: Peter Xu <peterx@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eperezma@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eperezma@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/11 02:18:06
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
 Juan Quintela <quintela@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Eric Auger <eric.auger@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Aug 11, 2020 at 7:01 PM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Fri, Jun 26, 2020 at 11:29 PM Peter Xu <peterx@redhat.com> wrote:
> >
> > Hi, Eugenio,
> >
> > (CCing Eric, Yan and Michael too)
> >
> > On Fri, Jun 26, 2020 at 08:41:22AM +0200, Eugenio P=C3=A9rez wrote:
> > > diff --git a/memory.c b/memory.c
> > > index 2f15a4b250..7f789710d2 100644
> > > --- a/memory.c
> > > +++ b/memory.c
> > > @@ -1915,8 +1915,6 @@ void memory_region_notify_one(IOMMUNotifier *no=
tifier,
> > >          return;
> > >      }
> > >
> > > -    assert(entry->iova >=3D notifier->start && entry_end <=3D notifi=
er->end);
> >
> > I can understand removing the assertion should solve the issue, however=
 imho
> > the major issue is not about this single assertion but the whole addr_m=
ask
> > issue behind with virtio...
> >
> > For normal IOTLB invalidations, we were trying our best to always make
> > IOMMUTLBEntry contain a valid addr_mask to be 2**N-1.  E.g., that's wha=
t we're
> > doing with the loop in vtd_address_space_unmap().
> >
> > But this is not the first time that we may want to break this assumptio=
n for
> > virtio so that we make the IOTLB a tuple of (start, len), then that len=
 can be
> > not a address mask any more.  That seems to be more efficient for thing=
s like
> > vhost because iotlbs there are not page based, so it'll be inefficient =
if we
> > always guarantee the addr_mask because it'll be quite a lot more roundt=
rips of
> > the same range of invalidation.  Here we've encountered another issue o=
f
> > triggering the assertion with virtio-net, but only with the old RHEL7 g=
uest.
> >
> > I'm thinking whether we can make the IOTLB invalidation configurable by
> > specifying whether the backend of the notifier can handle arbitary addr=
ess
> > range in some way.  So we still have the guaranteed addr_masks by defau=
lt
> > (since I still don't think totally break the addr_mask restriction is w=
ise...),
> > however we can allow the special backends to take adavantage of using a=
rbitary
> > (start, len) ranges for reasons like performance.
> >
> > To do that, a quick idea is to introduce a flag IOMMU_NOTIFIER_ARBITRAR=
Y_MASK
> > to IOMMUNotifierFlag, to declare that the iommu notifier (and its backe=
nd) can
> > take arbitrary address mask, then it can be any value and finally becom=
es a
> > length rather than an addr_mask.  Then for every iommu notify() we can =
directly
> > deliver whatever we've got from the upper layer to this notifier.  With=
 the new
> > flag, vhost can do iommu_notifier_init() with UNMAP|ARBITRARY_MASK so i=
t
> > declares this capability.  Then no matter for device iotlb or normal io=
tlb, we
> > skip the complicated procedure to split a big range into small ranges t=
hat are
> > with strict addr_mask, but directly deliver the message to the iommu no=
tifier.
> > E.g., we can skip the loop in vtd_address_space_unmap() if the notifier=
 is with
> > ARBITRARY flag set.
> >
> > Then, the assert() is not accurate either, and may become something lik=
e:
> >
> > diff --git a/memory.c b/memory.c
> > index 2f15a4b250..99d0492509 100644
> > --- a/memory.c
> > +++ b/memory.c
> > @@ -1906,6 +1906,7 @@ void memory_region_notify_one(IOMMUNotifier *noti=
fier,
> >  {
> >      IOMMUNotifierFlag request_flags;
> >      hwaddr entry_end =3D entry->iova + entry->addr_mask;
> > +    IOMMUTLBEntry tmp =3D *entry;
> >
> >      /*
> >       * Skip the notification if the notification does not overlap
> > @@ -1915,7 +1916,13 @@ void memory_region_notify_one(IOMMUNotifier *not=
ifier,
> >          return;
> >      }
> >
> > -    assert(entry->iova >=3D notifier->start && entry_end <=3D notifier=
->end);
> > +    if (notifier->notifier_flags & IOMMU_NOTIFIER_ARBITRARY_MASK) {
> > +        tmp.iova =3D MAX(tmp.iova, notifier->start);
>
> Hi!
>
> If I modify the tmp.iova, the guest will complain (in dmesg):
> [  154.426828] DMAR: DRHD: handling fault status reg 2
> [  154.427700] DMAR: [DMA Read] Request device [01:00.0] fault addr
> ffff90d53fada000 [fault reason 04] Access beyond MGAW
>
> And will not forward packets anymore on that interface. Guests are
> totally ok if I only modify addr_mask.
>
> Still investigating the issue.
>
> Thanks!
>

Sorry it seems that I lost the nitpick Yan pointed out :).

Sending RFC v3.

>
> > +        tmp.addr_mask =3D MIN(tmp.addr_mask, notifier->end);
> > +        assert(tmp.iova <=3D tmp.addr_mask);
> > +    } else {
> > +        assert(entry->iova >=3D notifier->start && entry_end <=3D noti=
fier->end);
> > +    }
> >
> >      if (entry->perm & IOMMU_RW) {
> >          request_flags =3D IOMMU_NOTIFIER_MAP;
> > @@ -1924,7 +1931,7 @@ void memory_region_notify_one(IOMMUNotifier *noti=
fier,
> >      }
> >
> >      if (notifier->notifier_flags & request_flags) {
> > -        notifier->notify(notifier, entry);
> > +        notifier->notify(notifier, &tmp);
> >      }
> >  }
> >
> > Then we can keep the assert() for e.g. vfio, however vhost can skip it =
and even
> > get some further performance boosts..  Does that make sense?
> >
> > Thanks,
> >
> > --
> > Peter Xu
> >


