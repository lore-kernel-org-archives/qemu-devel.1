Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A27E7C4727E
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 18:02:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40494208D5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 18:02:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H+czfGtH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40494208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMxTs-00071d-Vf
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 14:02:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53892)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kMxGt-0001u2-1h
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 13:49:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37594)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kMxGq-0002H3-SF
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 13:49:06 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601315343;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N+wk5azjipVwb/ehom8hAby13QOSHxndVwpdQUEw6bY=;
 b=H+czfGtHpIa/XiUQTzZcI9tE/td5EWT6JXiM/SKhN1Hu1ecS+F5nipWDufeseMDtRm2t9U
 Rxbd4WpdKcyKjIM/O87L1wMa2jGBE40wEvtDWLHqXQ2Pxoa7wmCsW+NHDZgULl3nO7iR4c
 tF8edA9o+XCSaKJkOcIqFkV1zRT+OwY=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-1JWyu-N0PPCQ-q9HrI-pBQ-1; Mon, 28 Sep 2020 13:49:01 -0400
X-MC-Unique: 1JWyu-N0PPCQ-q9HrI-pBQ-1
Received: by mail-qt1-f198.google.com with SMTP id g44so1192778qtb.15
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2020 10:49:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=N+wk5azjipVwb/ehom8hAby13QOSHxndVwpdQUEw6bY=;
 b=phGoIFTDpo73ui7YSh0jfr00wzoc2c4pGCB0QHEZHv64jJJiX9cWEjCvCs2jBsgfsI
 X143ngVsgNc+nnXVzMV9WEKvDh2kMaDPMYHlRm5Y5gF9wa4spK2AlOvRd3UfIbt6ycd/
 COah692e7yWMwUy3y2V2IABBQb4qnr2xxWGof2u2dLtLJR7+R1nX3QDaJpGkXqxnLQS0
 Z+p45KewKMhxOin4iMeQ46kIE8f3PiHqVGdoKBN07O9D19+MdfyMLbSKMeMc0cAxWWZK
 rCT1LdO6f1OUt5NkSHqP6AopxGKMFkbddIKxnH/oSUy1zThPigRlKWcagdeZHssWKS49
 4bkw==
X-Gm-Message-State: AOAM531VOAXxDEJ91egvqMFEQog+WlYF4MjC049mJ6kz8mTqlcTaYuwV
 bTey/PP5S6Je77dr58cvNHwm7R/58Z95T5PPFkDi44MkR5GUv+7Q/d4v1niiEhTA87SOirJg/qk
 J2iItwymzwP5Xcus=
X-Received: by 2002:a05:6214:1225:: with SMTP id
 p5mr687487qvv.29.1601315341035; 
 Mon, 28 Sep 2020 10:49:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxwt4nWj6QmS003v1Bz6EuXFFkUACIVtJlUYYHIn28GP80jEsIUzaaKB5AWQoglE6syryUULQ==
X-Received: by 2002:a05:6214:1225:: with SMTP id
 p5mr687448qvv.29.1601315340679; 
 Mon, 28 Sep 2020 10:49:00 -0700 (PDT)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca.
 [70.53.122.15])
 by smtp.gmail.com with ESMTPSA id u10sm1191583qkk.14.2020.09.28.10.48.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2020 10:48:59 -0700 (PDT)
Date: Mon, 28 Sep 2020 13:48:57 -0400
From: Peter Xu <peterx@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Subject: Re: [PATCH 5/5] memory: Skip bad range assertion if notifier is
 DEVIOTLB_UNMAP type
Message-ID: <20200928174857.GC59869@xz-x1>
References: <20200625191651.5817-1-eperezma@redhat.com>
 <20200903161446.29615-1-eperezma@redhat.com>
 <20200903161446.29615-6-eperezma@redhat.com>
 <d3e2098d-e150-7f99-a1ee-4a997daf4a5c@redhat.com>
 <CAJaqyWfwGP7_Ex=NhG_po+A1BkN3OCV=+3Vwi8uhLJ_e4UA5NQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJaqyWfwGP7_Ex=NhG_po+A1BkN3OCV=+3Vwi8uhLJ_e4UA5NQ@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=peterx@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 03:29:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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
 Juan Quintela <quintela@redhat.com>,
 =?utf-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>,
 qemu-level <qemu-devel@nongnu.org>, Eric Auger <eric.auger@redhat.com>,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Avi Kivity <avi@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Sep 28, 2020 at 11:05:01AM +0200, Eugenio Perez Martin wrote:
> On Fri, Sep 4, 2020 at 6:34 AM Jason Wang <jasowang@redhat.com> wrote:
> >
> >
> > On 2020/9/4 上午12:14, Eugenio Pérez wrote:
> > > Device IOTLB invalidations can unmap arbitrary ranges, eiter outside of
> > > the memory region or even [0, ~0ULL] for all the space. The assertion
> > > could be hit by a guest, and rhel7 guest effectively hit it.
> > >
> > > Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
> > > Reviewed-by: Peter Xu <peterx@redhat.com>
> > > Reviewed-by: Juan Quintela <quintela@redhat.com>
> > > ---
> > >   softmmu/memory.c | 13 +++++++++++--
> > >   1 file changed, 11 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/softmmu/memory.c b/softmmu/memory.c
> > > index 8694fc7cf7..e723fcbaa1 100644
> > > --- a/softmmu/memory.c
> > > +++ b/softmmu/memory.c
> > > @@ -1895,6 +1895,7 @@ void memory_region_notify_iommu_one(IOMMUNotifier *notifier,
> > >   {
> > >       IOMMUTLBEntry *entry = &event->entry;
> > >       hwaddr entry_end = entry->iova + entry->addr_mask;
> > > +    IOMMUTLBEntry tmp = *entry;
> > >
> > >       if (event->type == IOMMU_NOTIFIER_UNMAP) {
> > >           assert(entry->perm == IOMMU_NONE);
> > > @@ -1908,10 +1909,18 @@ void memory_region_notify_iommu_one(IOMMUNotifier *notifier,
> > >           return;
> > >       }
> > >
> > > -    assert(entry->iova >= notifier->start && entry_end <= notifier->end);
> > > +    if (notifier->notifier_flags & IOMMU_NOTIFIER_DEVIOTLB_UNMAP) {
> > > +        /* Crop (iova, addr_mask) to range */
> > > +        tmp.iova = MAX(tmp.iova, notifier->start);
> > > +        tmp.addr_mask = MIN(entry_end, notifier->end) - tmp.iova;
> > > +        /* Confirm no underflow */
> > > +        assert(MIN(entry_end, notifier->end) >= tmp.iova);
> >
> >
> > It's still not clear to me why we need such assert. Consider
> > notifier->end is the possible IOVA range but not possible device IOTLB
> > invalidation range (e.g it allows [0, ULLONG_MAX]).
> >
> > Thanks
> >
> 
> As far as I understood the device should admit that out of bounds
> notifications in that case,
> and the assert just makes sure that there was no underflow in
> tmp.addr_mask, i.e., that something
> very wrong that should never happen in production happened.
> 
> Peter, would you mind to confirm/correct it?

I think Jason is right - since we have checked at the entry that the two
regions cross over each other:

    /*
     * Skip the notification if the notification does not overlap
     * with registered range.
     */
    if (notifier->start > entry_end || notifier->end < entry->iova) {
        return;
    }

Then I don't see how this assertion can fail any more.

But imho not a big problem either, and it shouldn't hurt to even keep the
assertion of above isn't that straightforward.

> 
> Is there anything else needed to pull this patch?

I didn't post a pull for this only because I shouldn't :) - the plan was that
all vt-d patches will still go via Michael's tree, iiuc.  Though at least to me
I think this series is acceptable for merging.

Though it would always be good too if Jason would still like to review it.

Jason, what's your opinion?

Thanks,

-- 
Peter Xu


