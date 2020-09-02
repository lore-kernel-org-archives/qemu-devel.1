Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C974C433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 13:21:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DA16207D3
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 13:21:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MMHT8aJt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DA16207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDShF-00054l-4R
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 09:21:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42612)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1kDSfP-0002pi-6f
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 09:19:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53056)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1kDSfM-0001JM-Lp
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 09:19:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599052747;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vokX5IhimzXKFKd0xKRaomnE8niEi6oTsQ8sDeTvoUY=;
 b=MMHT8aJtlkLwRXVmX3Lb3Rux+cUhHDU7jgMuYL8xhCP9luZYs4DNO7ExTJC5dsvDHAOmjb
 w8vm8O4N+7MRCiRdljP8gv/R2LOAdTUCZpEA+N7bF8oq0AGCU8IjDpE1Td4jB+6oVjXL57
 wIdQeD4DZOFaf/DWbqwz4hUxLPqhC3Y=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-567-TQXLwIy2PdiMuTbkPtfC-Q-1; Wed, 02 Sep 2020 09:19:04 -0400
X-MC-Unique: TQXLwIy2PdiMuTbkPtfC-Q-1
Received: by mail-qt1-f198.google.com with SMTP id z16so3420474qtq.16
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 06:19:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=vokX5IhimzXKFKd0xKRaomnE8niEi6oTsQ8sDeTvoUY=;
 b=TL7Yz/vqUPZlTJ1GjCRgoZNwTaHV9QiwN1+7eE02fvX87bqnc3Z8w5D2CuQYM1QwX5
 YkkLhPnRFFQBBZv7K8ktDk7k01k6stLY4krQVqW+mkHkegZYmptzCzLI/YN/r4ghoXG2
 0kT0Z1nFlwxa8Xiz8aduGqoobKnRNLsJ4eJ3d/jxuDD/ZwwY4CkaVlrLP5KnndmI3JR6
 ccAJnWNg/YZeqOalSX0B3TAgrglMdglZSmfEhuoeTHp8zS0Pr4zAMlKmlw+fxyL+J2sL
 IQkAmpG3SyWYnQjAlHFX2CrkEWHow1XzPDc4YOJIdeGL/mDnK9XTHsgcAwgPgOMCOXGY
 h/jA==
X-Gm-Message-State: AOAM532EB3m55TgKgL2DNTpM7vwN7JEcBp7okcStB4ToSOL8VuVhK048
 b6TGXr2rhcN6OJbWLIHnnw7iyjpvVc2Rsz04oCAq2AkFC37EZRmlbWMqPHM1xr0FePkO6/4VBn2
 btTjlWJNECyt1DaU9JR+djbRlII2Swq8=
X-Received: by 2002:ac8:7051:: with SMTP id y17mr6731353qtm.22.1599052743164; 
 Wed, 02 Sep 2020 06:19:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwu8BQy6M1mhiej0HbcTWG8NjXJ83DaH086hg44dSul/OADodhEgieUwkK1D9o0iq+9NN13TQaXuWp4/U/Ndlk=
X-Received: by 2002:ac8:7051:: with SMTP id y17mr6731296qtm.22.1599052742547; 
 Wed, 02 Sep 2020 06:19:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200901142608.24481-1-eperezma@redhat.com>
 <20200901142608.24481-3-eperezma@redhat.com>
 <00f148d1-9922-6a57-18da-91bbbbaf8f9e@redhat.com>
In-Reply-To: <00f148d1-9922-6a57-18da-91bbbbaf8f9e@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 2 Sep 2020 15:18:26 +0200
Message-ID: <CAJaqyWeM53WFuT9FernakkiRNacqCcOj8ALAvUYubqOxpitUsw@mail.gmail.com>
Subject: Re: [RFC v8 2/5] memory: Add IOMMUTLBEvent
To: Auger Eric <eric.auger@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eperezma@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.205.24.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 01:13:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Yan Zhao <yan.y.zhao@intel.com>, Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Juan Quintela <quintela@redhat.com>, qemu-level <qemu-devel@nongnu.org>,
 Peter Xu <peterx@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Avi Kivity <avi@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 2, 2020 at 12:17 PM Auger Eric <eric.auger@redhat.com> wrote:
>
> Hi Eugenio,
>
> On 9/1/20 4:26 PM, Eugenio P=C3=A9rez wrote:
> > This way we can tell between regulars IOMMURLBEntries (entry of IOMMU
> > hardware) and notifications.>
> > In the notifications, we set explicitly if it is a MAPs or an UNMAP,
> > instead of trusting in entry permissions to differenciate them.
> differentiate
>
> Is it the real justification or is the rationale behind adding this type
> to be able to add new types of events?

Hi Eric,

Actually, the flag is to be able to tell the difference between
pre-existing events that were mixed. No new type of event involved,
just making it explicit.

> >
> > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > ---
> >  hw/arm/smmu-common.c  | 13 ++++---
> >  hw/arm/smmuv3.c       | 13 ++++---
> >  hw/i386/intel_iommu.c | 88 ++++++++++++++++++++++++-------------------
> >  hw/misc/tz-mpc.c      | 32 +++++++++-------
> >  hw/ppc/spapr_iommu.c  | 15 ++++----
> >  include/exec/memory.h | 31 ++++++++-------
> >  softmmu/memory.c      | 16 +++-----
> >  7 files changed, 112 insertions(+), 96 deletions(-)
>
> you may add "orderFile =3D scripts/git.orderfile" in your .git/config dif=
f
> section to get headers first
>
> [diff]
>         orderFile =3D scripts/git.orderfile
>

Didn't realize that, thanks!

> >
> > diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
> > index 88d2c454f0..405d5c5325 100644
> > --- a/hw/arm/smmu-common.c
> > +++ b/hw/arm/smmu-common.c
> > @@ -465,14 +465,15 @@ IOMMUMemoryRegion *smmu_iommu_mr(SMMUState *s, ui=
nt32_t sid)
> >  /* Unmap the whole notifier's range */
> >  static void smmu_unmap_notifier_range(IOMMUNotifier *n)
> >  {
> > -    IOMMUTLBEntry entry;
> > +    IOMMUTLBEvent event;
> >
> > -    entry.target_as =3D &address_space_memory;
> > -    entry.iova =3D n->start;
> > -    entry.perm =3D IOMMU_NONE;
> > -    entry.addr_mask =3D n->end - n->start;
> > +    event.type =3D IOMMU_NOTIFIER_UNMAP;
> > +    event.entry.target_as =3D &address_space_memory;
> > +    event.entry.iova =3D n->start;
> > +    event.entry.perm =3D IOMMU_NONE;
> > +    event.entry.addr_mask =3D n->end - n->start;
> >
> > -    memory_region_notify_iommu_one(n, &entry);
> > +    memory_region_notify_iommu_one(n, &event);
> >  }
> >
> >  /* Unmap all notifiers attached to @mr */
> > diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> > index 0a893ae918..62b0e289ca 100644
> > --- a/hw/arm/smmuv3.c
> > +++ b/hw/arm/smmuv3.c
> > @@ -799,7 +799,7 @@ static void smmuv3_notify_iova(IOMMUMemoryRegion *m=
r,
> >                                 uint8_t tg, uint64_t num_pages)
> >  {
> >      SMMUDevice *sdev =3D container_of(mr, SMMUDevice, iommu);
> > -    IOMMUTLBEntry entry;
> > +    IOMMUTLBEvent event;
> >      uint8_t granule =3D tg;
> >
> >      if (!tg) {
> > @@ -822,12 +822,13 @@ static void smmuv3_notify_iova(IOMMUMemoryRegion =
*mr,
> >          granule =3D tt->granule_sz;
> >      }
> >
> > -    entry.target_as =3D &address_space_memory;
> > -    entry.iova =3D iova;
> > -    entry.addr_mask =3D num_pages * (1 << granule) - 1;
> > -    entry.perm =3D IOMMU_NONE;
> > +    event.type =3D IOMMU_NOTIFIER_UNMAP;
> > +    event.entry.target_as =3D &address_space_memory;
> > +    event.entry.iova =3D iova;
> > +    event.entry.addr_mask =3D num_pages * (1 << granule) - 1;
> > +    event.entry.perm =3D IOMMU_NONE;
> >
> > -    memory_region_notify_iommu_one(n, &entry);
> > +    memory_region_notify_iommu_one(n, &event);
> >  }
> >
> >  /* invalidate an asid/iova range tuple in all mr's */
> > diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> > index 2ad6b9d796..0c4aef5cb5 100644
> > --- a/hw/i386/intel_iommu.c
> > +++ b/hw/i386/intel_iommu.c
> > @@ -1073,7 +1073,7 @@ static int vtd_iova_to_slpte(IntelIOMMUState *s, =
VTDContextEntry *ce,
> >      }
> >  }
> >
> > -typedef int (*vtd_page_walk_hook)(IOMMUTLBEntry *entry, void *private)=
;
> > +typedef int (*vtd_page_walk_hook)(IOMMUTLBEvent *event, void *private)=
;
> >
> >  /**
> >   * Constant information used during page walking
> > @@ -1094,11 +1094,12 @@ typedef struct {
> >      uint16_t domain_id;
> >  } vtd_page_walk_info;
> >
> > -static int vtd_page_walk_one(IOMMUTLBEntry *entry, vtd_page_walk_info =
*info)
> > +static int vtd_page_walk_one(IOMMUTLBEvent *event, vtd_page_walk_info =
*info)
> >  {
> >      VTDAddressSpace *as =3D info->as;
> >      vtd_page_walk_hook hook_fn =3D info->hook_fn;
> >      void *private =3D info->private;
> > +    IOMMUTLBEntry *entry =3D &event->entry;
> >      DMAMap target =3D {
> >          .iova =3D entry->iova,
> >          .size =3D entry->addr_mask,
> > @@ -1107,7 +1108,7 @@ static int vtd_page_walk_one(IOMMUTLBEntry *entry=
, vtd_page_walk_info *info)
> >      };
> >      DMAMap *mapped =3D iova_tree_find(as->iova_tree, &target);
> >
> > -    if (entry->perm =3D=3D IOMMU_NONE && !info->notify_unmap) {
> > +    if (event->type =3D=3D IOMMU_NOTIFIER_UNMAP && !info->notify_unmap=
) {
> >          trace_vtd_page_walk_one_skip_unmap(entry->iova, entry->addr_ma=
sk);
> >          return 0;
> >      }
> > @@ -1115,7 +1116,7 @@ static int vtd_page_walk_one(IOMMUTLBEntry *entry=
, vtd_page_walk_info *info)
> >      assert(hook_fn);
> >
> >      /* Update local IOVA mapped ranges */
> > -    if (entry->perm) {
> > +    if (event->type =3D=3D IOMMU_NOTIFIER_MAP) {
> >          if (mapped) {
> >              /* If it's exactly the same translation, skip */
> >              if (!memcmp(mapped, &target, sizeof(target))) {
> > @@ -1141,19 +1142,21 @@ static int vtd_page_walk_one(IOMMUTLBEntry *ent=
ry, vtd_page_walk_info *info)
> >                  int ret;
> >
> >                  /* Emulate an UNMAP */
> > +                event->type =3D IOMMU_NOTIFIER_UNMAP;
> >                  entry->perm =3D IOMMU_NONE;
> >                  trace_vtd_page_walk_one(info->domain_id,
> >                                          entry->iova,
> >                                          entry->translated_addr,
> >                                          entry->addr_mask,
> >                                          entry->perm);
> > -                ret =3D hook_fn(entry, private);
> > +                ret =3D hook_fn(event, private);
> >                  if (ret) {
> >                      return ret;
> >                  }
> >                  /* Drop any existing mapping */
> >                  iova_tree_remove(as->iova_tree, &target);
> > -                /* Recover the correct permission */
> > +                /* Recover the correct type */
> > +                event->type =3D IOMMU_NOTIFIER_MAP;
> >                  entry->perm =3D cache_perm;
> >              }
> >          }
> > @@ -1170,7 +1173,7 @@ static int vtd_page_walk_one(IOMMUTLBEntry *entry=
, vtd_page_walk_info *info)
> >      trace_vtd_page_walk_one(info->domain_id, entry->iova,
> >                              entry->translated_addr, entry->addr_mask,
> >                              entry->perm);
> > -    return hook_fn(entry, private);
> > +    return hook_fn(event, private);
> >  }
> >
> >  /**
> > @@ -1191,7 +1194,7 @@ static int vtd_page_walk_level(dma_addr_t addr, u=
int64_t start,
> >      uint32_t offset;
> >      uint64_t slpte;
> >      uint64_t subpage_size, subpage_mask;
> > -    IOMMUTLBEntry entry;
> > +    IOMMUTLBEvent event;
> >      uint64_t iova =3D start;
> >      uint64_t iova_next;
> >      int ret =3D 0;
> > @@ -1245,13 +1248,15 @@ static int vtd_page_walk_level(dma_addr_t addr,=
 uint64_t start,
> >               *
> >               * In either case, we send an IOTLB notification down.
> >               */
> > -            entry.target_as =3D &address_space_memory;
> > -            entry.iova =3D iova & subpage_mask;
> > -            entry.perm =3D IOMMU_ACCESS_FLAG(read_cur, write_cur);
> > -            entry.addr_mask =3D ~subpage_mask;
> > +            event.entry.target_as =3D &address_space_memory;
> > +            event.entry.iova =3D iova & subpage_mask;
> > +            event.entry.perm =3D IOMMU_ACCESS_FLAG(read_cur, write_cur=
);
> > +            event.entry.addr_mask =3D ~subpage_mask;
> >              /* NOTE: this is only meaningful if entry_valid =3D=3D tru=
e */
> > -            entry.translated_addr =3D vtd_get_slpte_addr(slpte, info->=
aw);
> > -            ret =3D vtd_page_walk_one(&entry, info);
> > +            event.entry.translated_addr =3D vtd_get_slpte_addr(slpte, =
info->aw);
> > +            event.type =3D event.entry.perm ? IOMMU_NOTIFIER_MAP :
> > +                                            IOMMU_NOTIFIER_UNMAP;
> > +            ret =3D vtd_page_walk_one(&event, info);
> >          }
> >
> >          if (ret < 0) {
> > @@ -1430,10 +1435,10 @@ static int vtd_dev_to_context_entry(IntelIOMMUS=
tate *s, uint8_t bus_num,
> >      return 0;
> >  }
> >
> > -static int vtd_sync_shadow_page_hook(IOMMUTLBEntry *entry,
> > +static int vtd_sync_shadow_page_hook(IOMMUTLBEvent *event,
> >                                       void *private)
> >  {
> > -    memory_region_notify_iommu((IOMMUMemoryRegion *)private, 0, *entry=
);
> > +    memory_region_notify_iommu((IOMMUMemoryRegion *)private, 0, *event=
);
> >      return 0;
> >  }
> >
> > @@ -1993,14 +1998,17 @@ static void vtd_iotlb_page_invalidate_notify(In=
telIOMMUState *s,
> >                   * page tables.  We just deliver the PSI down to
> >                   * invalidate caches.
> >                   */
> > -                IOMMUTLBEntry entry =3D {
> > -                    .target_as =3D &address_space_memory,
> > -                    .iova =3D addr,
> > -                    .translated_addr =3D 0,
> > -                    .addr_mask =3D size - 1,
> > -                    .perm =3D IOMMU_NONE,
> > +                IOMMUTLBEvent event =3D {
> > +                    .type =3D IOMMU_NOTIFIER_UNMAP,
> > +                    .entry =3D {
> > +                        .target_as =3D &address_space_memory,
> > +                        .iova =3D addr,
> > +                        .translated_addr =3D 0,
> > +                        .addr_mask =3D size - 1,
> > +                        .perm =3D IOMMU_NONE,
> > +                    },
> >                  };
> > -                memory_region_notify_iommu(&vtd_as->iommu, 0, entry);
> > +                memory_region_notify_iommu(&vtd_as->iommu, 0, event);
> >              }
> >          }
> >      }
> > @@ -2412,7 +2420,7 @@ static bool vtd_process_device_iotlb_desc(IntelIO=
MMUState *s,
> >                                            VTDInvDesc *inv_desc)
> >  {
> >      VTDAddressSpace *vtd_dev_as;
> > -    IOMMUTLBEntry entry;
> > +    IOMMUTLBEvent event;
> >      struct VTDBus *vtd_bus;
> >      hwaddr addr;
> >      uint64_t sz;
> > @@ -2460,12 +2468,13 @@ static bool vtd_process_device_iotlb_desc(Intel=
IOMMUState *s,
> >          sz =3D VTD_PAGE_SIZE;
> >      }
> >
> > -    entry.target_as =3D &vtd_dev_as->as;
> > -    entry.addr_mask =3D sz - 1;
> > -    entry.iova =3D addr;
> > -    entry.perm =3D IOMMU_NONE;
> > -    entry.translated_addr =3D 0;
> > -    memory_region_notify_iommu(&vtd_dev_as->iommu, 0, entry);
> > +    event.type =3D IOMMU_NOTIFIER_UNMAP;
> > +    event.entry.target_as =3D &vtd_dev_as->as;
> > +    event.entry.addr_mask =3D sz - 1;
> > +    event.entry.iova =3D addr;
> > +    event.entry.perm =3D IOMMU_NONE;
> > +    event.entry.translated_addr =3D 0;
> > +    memory_region_notify_iommu(&vtd_dev_as->iommu, 0, event);
> >
> >  done:
> >      return true;
> > @@ -3486,19 +3495,20 @@ static void vtd_address_space_unmap(VTDAddressS=
pace *as, IOMMUNotifier *n)
> >      size =3D remain =3D end - start + 1;
> >
> >      while (remain >=3D VTD_PAGE_SIZE) {
> > -        IOMMUTLBEntry entry;
> > +        IOMMUTLBEvent event;
> >          uint64_t mask =3D get_naturally_aligned_size(start, remain, s-=
>aw_bits);
> >
> >          assert(mask);
> >
> > -        entry.iova =3D start;
> > -        entry.addr_mask =3D mask - 1;
> > -        entry.target_as =3D &address_space_memory;
> > -        entry.perm =3D IOMMU_NONE;
> > +        event.type =3D IOMMU_NOTIFIER_UNMAP;
> > +        event.entry.iova =3D start;
> > +        event.entry.addr_mask =3D mask - 1;
> > +        event.entry.target_as =3D &address_space_memory;
> > +        event.entry.perm =3D IOMMU_NONE;
> >          /* This field is meaningless for unmap */
> > -        entry.translated_addr =3D 0;
> > +        event.entry.translated_addr =3D 0;
> >
> > -        memory_region_notify_iommu_one(n, &entry);
> > +        memory_region_notify_iommu_one(n, &event);
> >
> >          start +=3D mask;
> >          remain -=3D mask;
> > @@ -3534,9 +3544,9 @@ static void vtd_address_space_refresh_all(IntelIO=
MMUState *s)
> >      vtd_switch_address_space_all(s);
> >  }
> >
> > -static int vtd_replay_hook(IOMMUTLBEntry *entry, void *private)
> > +static int vtd_replay_hook(IOMMUTLBEvent *event, void *private)
> >  {
> > -    memory_region_notify_iommu_one((IOMMUNotifier *)private, entry);
> > +    memory_region_notify_iommu_one((IOMMUNotifier *)private, event);
> >      return 0;
> >  }
> >
> > diff --git a/hw/misc/tz-mpc.c b/hw/misc/tz-mpc.c
> > index 98f151237f..30481e1c90 100644
> > --- a/hw/misc/tz-mpc.c
> > +++ b/hw/misc/tz-mpc.c
> > @@ -82,8 +82,10 @@ static void tz_mpc_iommu_notify(TZMPC *s, uint32_t l=
utidx,
> >      /* Called when the LUT word at lutidx has changed from oldlut to n=
ewlut;
> >       * must call the IOMMU notifiers for the changed blocks.
> >       */
> > -    IOMMUTLBEntry entry =3D {
> > -        .addr_mask =3D s->blocksize - 1,
> > +    IOMMUTLBEvent event =3D {
> > +        .entry =3D {
> > +            .addr_mask =3D s->blocksize - 1,
> > +        }
> >      };
> >      hwaddr addr =3D lutidx * s->blocksize * 32;
> >      int i;
> > @@ -100,26 +102,28 @@ static void tz_mpc_iommu_notify(TZMPC *s, uint32_=
t lutidx,
> >          block_is_ns =3D newlut & (1 << i);
> >
> >          trace_tz_mpc_iommu_notify(addr);
> > -        entry.iova =3D addr;
> > -        entry.translated_addr =3D addr;
> > +        event.entry.iova =3D addr;
> > +        event.entry.translated_addr =3D addr;
> >
> > -        entry.perm =3D IOMMU_NONE;
> > -        memory_region_notify_iommu(&s->upstream, IOMMU_IDX_S, entry);
> > -        memory_region_notify_iommu(&s->upstream, IOMMU_IDX_NS, entry);
> > +        event.type =3D IOMMU_NOTIFIER_UNMAP;
> > +        event.entry.perm =3D IOMMU_NONE;
> > +        memory_region_notify_iommu(&s->upstream, IOMMU_IDX_S, event);
> > +        memory_region_notify_iommu(&s->upstream, IOMMU_IDX_NS, event);
> >
> > -        entry.perm =3D IOMMU_RW;
> > +        event.type =3D IOMMU_NOTIFIER_MAP;
> > +        event.entry.perm =3D IOMMU_RW;
> >          if (block_is_ns) {
> > -            entry.target_as =3D &s->blocked_io_as;
> > +            event.entry.target_as =3D &s->blocked_io_as;
> >          } else {
> > -            entry.target_as =3D &s->downstream_as;
> > +            event.entry.target_as =3D &s->downstream_as;
> >          }
> > -        memory_region_notify_iommu(&s->upstream, IOMMU_IDX_S, entry);
> > +        memory_region_notify_iommu(&s->upstream, IOMMU_IDX_S, event);
> >          if (block_is_ns) {
> > -            entry.target_as =3D &s->downstream_as;
> > +            event.entry.target_as =3D &s->downstream_as;
> >          } else {
> > -            entry.target_as =3D &s->blocked_io_as;
> > +            event.entry.target_as =3D &s->blocked_io_as;
> >          }
> > -        memory_region_notify_iommu(&s->upstream, IOMMU_IDX_NS, entry);
> > +        memory_region_notify_iommu(&s->upstream, IOMMU_IDX_NS, event);
> >      }
> >  }
> >
> > diff --git a/hw/ppc/spapr_iommu.c b/hw/ppc/spapr_iommu.c
> > index 0fecabc135..8bc3cff05d 100644
> > --- a/hw/ppc/spapr_iommu.c
> > +++ b/hw/ppc/spapr_iommu.c
> > @@ -445,7 +445,7 @@ static void spapr_tce_reset(DeviceState *dev)
> >  static target_ulong put_tce_emu(SpaprTceTable *tcet, target_ulong ioba=
,
> >                                  target_ulong tce)
> >  {
> > -    IOMMUTLBEntry entry;
> > +    IOMMUTLBEvent event;
> >      hwaddr page_mask =3D IOMMU_PAGE_MASK(tcet->page_shift);
> >      unsigned long index =3D (ioba - tcet->bus_offset) >> tcet->page_sh=
ift;
> >
> > @@ -457,12 +457,13 @@ static target_ulong put_tce_emu(SpaprTceTable *tc=
et, target_ulong ioba,
> >
> >      tcet->table[index] =3D tce;
> >
> > -    entry.target_as =3D &address_space_memory,
> > -    entry.iova =3D (ioba - tcet->bus_offset) & page_mask;
> > -    entry.translated_addr =3D tce & page_mask;
> > -    entry.addr_mask =3D ~page_mask;
> > -    entry.perm =3D spapr_tce_iommu_access_flags(tce);
> > -    memory_region_notify_iommu(&tcet->iommu, 0, entry);
> > +    event.entry.target_as =3D &address_space_memory,
> > +    event.entry.iova =3D (ioba - tcet->bus_offset) & page_mask;
> > +    event.entry.translated_addr =3D tce & page_mask;
> > +    event.entry.addr_mask =3D ~page_mask;
> > +    event.entry.perm =3D spapr_tce_iommu_access_flags(tce);
> > +    event.type =3D entry.perm ? IOMMU_NOTIFIER_MAP : IOMMU_NOTIFIER_UN=
MAP;
> > +    memory_region_notify_iommu(&tcet->iommu, 0, event);
> >
> >      return H_SUCCESS;
> >  }
> > diff --git a/include/exec/memory.h b/include/exec/memory.h
> > index 22c5f564d1..8a56707169 100644
> > --- a/include/exec/memory.h
> > +++ b/include/exec/memory.h
> > @@ -70,11 +70,11 @@ typedef enum {
> >  #define IOMMU_ACCESS_FLAG(r, w) (((r) ? IOMMU_RO : 0) | ((w) ? IOMMU_W=
O : 0))
> >
> >  struct IOMMUTLBEntry {
> > -    AddressSpace    *target_as;
> > -    hwaddr           iova;
> > -    hwaddr           translated_addr;
> > -    hwaddr           addr_mask;  /* 0xfff =3D 4k translation */
> > -    IOMMUAccessFlags perm;
> > +    AddressSpace            *target_as;
> > +    hwaddr                   iova;
> > +    hwaddr                   translated_addr;
> > +    hwaddr                   addr_mask;  /* 0xfff =3D 4k translation *=
/
> > +    IOMMUAccessFlags         perm;
> >  };
> >
> >  /*
> > @@ -106,6 +106,11 @@ struct IOMMUNotifier {
> >  };
> >  typedef struct IOMMUNotifier IOMMUNotifier;
> >
> > +typedef struct IOMMUTLBEvent {
> > +    IOMMUTLBEntry entry;
> > +    IOMMUNotifierFlag type;
> nit: I would put the type field before the entry
> > +} IOMMUTLBEvent;
> > +
> >  /* RAM is pre-allocated and passed into qemu_ram_alloc_from_ptr */
> >  #define RAM_PREALLOC   (1 << 0)
> >
> > @@ -1265,13 +1270,13 @@ uint64_t memory_region_iommu_get_min_page_size(=
IOMMUMemoryRegion *iommu_mr);
> >   *
>
> Above there is:
>
>  * The notification type will be decided by entry.perm bits:
>  *
>  * - For UNMAP (cache invalidation) notifies: set entry.perm to IOMMU_NON=
E.
>  * - For MAP (newly added entry) notifies: set entry.perm to the
>  *   permission of the page (which is definitely !IOMMU_NONE).
>
> I think this should be updated as the main selector now is the type.
>

Definitely it needs to be updated, thanks!

> I am a little bit concerned by the fact nothing really checks perm =3D
> IOMMU_NONE is consistent with UNMAP type. New call sites may forget
> this? shouldn't we check this in memory_region_notify_(one)_iommu?
>

So it should be not checked that way from now on, but by the use of
`IOMMUTLBEvent.type`. So the caller should be responsible for set it
properly.

Another way of making it explicit is by making that type a parameter
of memory_region_notify_(one)_iommu, and to keep IOMMUTLBEvent private
tomemory.c, but I'm not sure if the notification will need more and
more parameters, and I felt it scale better this way.

Thanks!

> >   * @iommu_mr: the memory region that was changed
> >   * @iommu_idx: the IOMMU index for the translation table which has cha=
nged
> > - * @entry: the new entry in the IOMMU translation table.  The entry
> > - *         replaces all old entries for the same virtual I/O address r=
ange.
> > - *         Deleted entries have .@perm =3D=3D 0.
> > + * @event: TLB event with the new entry in the IOMMU translation table=
.
> > + *         The entry replaces all old entries for the same virtual I/O=
 address
> > + *         range.
> >   */
> >  void memory_region_notify_iommu(IOMMUMemoryRegion *iommu_mr,
> >                                  int iommu_idx,
> > -                                IOMMUTLBEntry entry);
> > +                                IOMMUTLBEvent event);
> >
> >  /**
> >   * memory_region_notify_iommu_one: notify a change in an IOMMU transla=
tion
> > @@ -1281,12 +1286,12 @@ void memory_region_notify_iommu(IOMMUMemoryRegi=
on *iommu_mr,
> >   * notifies a specific notifier, not all of them.
> >   *
> >   * @notifier: the notifier to be notified
> > - * @entry: the new entry in the IOMMU translation table.  The entry
> > - *         replaces all old entries for the same virtual I/O address r=
ange.
> > - *         Deleted entries have .@perm =3D=3D 0.
> > + * @event: TLB event with the new entry in the IOMMU translation table=
.
> > + *         The entry replaces all old entries for the same virtual I/O=
 address
> > + *         range.
> >   */
> >  void memory_region_notify_iommu_one(IOMMUNotifier *notifier,
> > -                              IOMMUTLBEntry *entry);
> > +                                    IOMMUTLBEvent *event);
> >
> >  /**
> >   * memory_region_register_iommu_notifier: register a notifier for chan=
ges to
> > diff --git a/softmmu/memory.c b/softmmu/memory.c
> > index 961c25b42f..09b3443eac 100644
> > --- a/softmmu/memory.c
> > +++ b/softmmu/memory.c
> > @@ -1891,9 +1891,9 @@ void memory_region_unregister_iommu_notifier(Memo=
ryRegion *mr,
> >  }
> >
> >  void memory_region_notify_iommu_one(IOMMUNotifier *notifier,
> > -                                    IOMMUTLBEntry *entry)
> > +                                    IOMMUTLBEvent *event)
> >  {
> > -    IOMMUNotifierFlag request_flags;
> > +    IOMMUTLBEntry *entry =3D &event->entry;
> >      hwaddr entry_end =3D entry->iova + entry->addr_mask;
> >
> >      /*
> > @@ -1906,20 +1906,14 @@ void memory_region_notify_iommu_one(IOMMUNotifi=
er *notifier,
> >
> >      assert(entry->iova >=3D notifier->start && entry_end <=3D notifier=
->end);
> >
> > -    if (entry->perm & IOMMU_RW) {
> > -        request_flags =3D IOMMU_NOTIFIER_MAP;
> > -    } else {
> > -        request_flags =3D IOMMU_NOTIFIER_UNMAP;
> > -    }
> > -
> > -    if (notifier->notifier_flags & request_flags) {
> > +    if (event->type & notifier->notifier_flags) {
> >          notifier->notify(notifier, entry);
> >      }
> >  }
> >
> >  void memory_region_notify_iommu(IOMMUMemoryRegion *iommu_mr,
> >                                  int iommu_idx,
> > -                                IOMMUTLBEntry entry)
> > +                                IOMMUTLBEvent event)
> >  {
> >      IOMMUNotifier *iommu_notifier;
> >
> > @@ -1927,7 +1921,7 @@ void memory_region_notify_iommu(IOMMUMemoryRegion=
 *iommu_mr,
> >
> >      IOMMU_NOTIFIER_FOREACH(iommu_notifier, iommu_mr) {
> >          if (iommu_notifier->iommu_idx =3D=3D iommu_idx) {
> > -            memory_region_notify_iommu_one(iommu_notifier, &entry);
> > +            memory_region_notify_iommu_one(iommu_notifier, &event);
> >          }
> >      }
> >  }
> >
> Thanks
>
> Eric
>


