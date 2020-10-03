Return-Path: <SRS0=be0Y=DK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E9AC4363D
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2020 17:40:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AA4B206CD
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2020 17:40:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f3wx6NRS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AA4B206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOlWQ-0006rO-W6
	for qemu-devel@archiver.kernel.org; Sat, 03 Oct 2020 13:40:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47468)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kOlUY-0006E9-In
 for qemu-devel@nongnu.org; Sat, 03 Oct 2020 13:38:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31922)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kOlUW-0002lu-DG
 for qemu-devel@nongnu.org; Sat, 03 Oct 2020 13:38:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601746718;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+D2c6ujyyOEbPrPvvt7uf0MRMdBuIQ/si50uMbIbuk8=;
 b=f3wx6NRSiE+irI0OOsKbLDqMXY7APoRuQsyu0Kv6WkMEeom9Wpk5PmbnsqAhBvQ+9OHugf
 vjkMvs91Da2diiNKLEgPed6+8cpwfmyxGrT+po70XiimcAkN3CIDW7Ay81QGIkrAqgCFpu
 QL2vsIqsUbC9+EGHvwcP3/Lmv+9M7Io=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-F-aKLuCHNq6yjhLRvuvRsg-1; Sat, 03 Oct 2020 13:38:37 -0400
X-MC-Unique: F-aKLuCHNq6yjhLRvuvRsg-1
Received: by mail-wr1-f69.google.com with SMTP id j7so2010621wro.14
 for <qemu-devel@nongnu.org>; Sat, 03 Oct 2020 10:38:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=+D2c6ujyyOEbPrPvvt7uf0MRMdBuIQ/si50uMbIbuk8=;
 b=UnneYLWVPDZ/grtmgTKvHuSZaH7VCDh/8+Wx2VD/5LOkkPdAaRAhio1SFkvcY/s4in
 9wakHLzN0w2sXLYPXlty6pkbGBoEBdPuxr4mmhAyPSjm+VnsBXy1bYctqoMXCJUSWZpQ
 xPWwFUVEs+1fTSMmjXyWzZsqgJlDGx3+51TqId3LyZneU9kcHWS+0K3i9TrQE28sWzbb
 QkvmIFq9uFOcOnb40b3lRGy1jzGB4aLZQnuKoFVRm12Ku2cCOf9a4xOv2/EEfUzVCBRL
 sKkQqcnuv/uH6haGgVPPM2hj18kWGv9sPPwBSv0EOVJmtojLafV5ybvoew87jrP/ZUBT
 NnRg==
X-Gm-Message-State: AOAM5323ITYcP5i+zV3Ka0BRBM79yUWV8GcsA8/s762GImI2HvVcR6jE
 aoX0w9hwz4FDBCkaM19xj7+PhESMewLSsl7FAQQAxbVfuWKCRvm+Y1uTii3KHBW/CIKUQP3f11a
 WOFyfXQ4C1Iu/m88=
X-Received: by 2002:a1c:2cc2:: with SMTP id s185mr8846806wms.77.1601746716072; 
 Sat, 03 Oct 2020 10:38:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzpYnpRr/JA8nho6bhvv/HX+rbl6214PbpEp80Wt100VRg/qpcl8yxOpuQCnhp6KIS0eals1w==
X-Received: by 2002:a1c:2cc2:: with SMTP id s185mr8846760wms.77.1601746715682; 
 Sat, 03 Oct 2020 10:38:35 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id s11sm5817858wrt.43.2020.10.03.10.38.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Oct 2020 10:38:34 -0700 (PDT)
Date: Sat, 3 Oct 2020 13:38:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH 5/5] memory: Skip bad range assertion if notifier is
 DEVIOTLB_UNMAP type
Message-ID: <20201003082953-mutt-send-email-mst@kernel.org>
References: <20200625191651.5817-1-eperezma@redhat.com>
 <20200903161446.29615-1-eperezma@redhat.com>
 <20200903161446.29615-6-eperezma@redhat.com>
 <d3e2098d-e150-7f99-a1ee-4a997daf4a5c@redhat.com>
 <CAJaqyWfwGP7_Ex=NhG_po+A1BkN3OCV=+3Vwi8uhLJ_e4UA5NQ@mail.gmail.com>
 <20200928174857.GC59869@xz-x1>
MIME-Version: 1.0
In-Reply-To: <20200928174857.GC59869@xz-x1>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/03 13:38:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Yan Zhao <yan.y.zhao@intel.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>,
 qemu-level <qemu-devel@nongnu.org>, Eugenio Perez Martin <eperezma@redhat.com>,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Avi Kivity <avi@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Sep 28, 2020 at 01:48:57PM -0400, Peter Xu wrote:
> On Mon, Sep 28, 2020 at 11:05:01AM +0200, Eugenio Perez Martin wrote:
> > On Fri, Sep 4, 2020 at 6:34 AM Jason Wang <jasowang@redhat.com> wrote:
> > >
> > >
> > > On 2020/9/4 上午12:14, Eugenio Pérez wrote:
> > > > Device IOTLB invalidations can unmap arbitrary ranges, eiter outside of
> > > > the memory region or even [0, ~0ULL] for all the space. The assertion
> > > > could be hit by a guest, and rhel7 guest effectively hit it.
> > > >
> > > > Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
> > > > Reviewed-by: Peter Xu <peterx@redhat.com>
> > > > Reviewed-by: Juan Quintela <quintela@redhat.com>
> > > > ---
> > > >   softmmu/memory.c | 13 +++++++++++--
> > > >   1 file changed, 11 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/softmmu/memory.c b/softmmu/memory.c
> > > > index 8694fc7cf7..e723fcbaa1 100644
> > > > --- a/softmmu/memory.c
> > > > +++ b/softmmu/memory.c
> > > > @@ -1895,6 +1895,7 @@ void memory_region_notify_iommu_one(IOMMUNotifier *notifier,
> > > >   {
> > > >       IOMMUTLBEntry *entry = &event->entry;
> > > >       hwaddr entry_end = entry->iova + entry->addr_mask;
> > > > +    IOMMUTLBEntry tmp = *entry;
> > > >
> > > >       if (event->type == IOMMU_NOTIFIER_UNMAP) {
> > > >           assert(entry->perm == IOMMU_NONE);
> > > > @@ -1908,10 +1909,18 @@ void memory_region_notify_iommu_one(IOMMUNotifier *notifier,
> > > >           return;
> > > >       }
> > > >
> > > > -    assert(entry->iova >= notifier->start && entry_end <= notifier->end);
> > > > +    if (notifier->notifier_flags & IOMMU_NOTIFIER_DEVIOTLB_UNMAP) {
> > > > +        /* Crop (iova, addr_mask) to range */
> > > > +        tmp.iova = MAX(tmp.iova, notifier->start);
> > > > +        tmp.addr_mask = MIN(entry_end, notifier->end) - tmp.iova;
> > > > +        /* Confirm no underflow */
> > > > +        assert(MIN(entry_end, notifier->end) >= tmp.iova);
> > >
> > >
> > > It's still not clear to me why we need such assert. Consider
> > > notifier->end is the possible IOVA range but not possible device IOTLB
> > > invalidation range (e.g it allows [0, ULLONG_MAX]).
> > >
> > > Thanks
> > >
> > 
> > As far as I understood the device should admit that out of bounds
> > notifications in that case,
> > and the assert just makes sure that there was no underflow in
> > tmp.addr_mask, i.e., that something
> > very wrong that should never happen in production happened.
> > 
> > Peter, would you mind to confirm/correct it?
> 
> I think Jason is right - since we have checked at the entry that the two
> regions cross over each other:
> 
>     /*
>      * Skip the notification if the notification does not overlap
>      * with registered range.
>      */
>     if (notifier->start > entry_end || notifier->end < entry->iova) {
>         return;
>     }
> 
> Then I don't see how this assertion can fail any more.
> 
> But imho not a big problem either, and it shouldn't hurt to even keep the
> assertion of above isn't that straightforward.
> 
> > 
> > Is there anything else needed to pull this patch?
> 
> I didn't post a pull for this only because I shouldn't :) - the plan was that
> all vt-d patches will still go via Michael's tree, iiuc.  Though at least to me
> I think this series is acceptable for merging.

Sure, that's ok.

Eugenio, you sent patch 0 as a response to another series, which
made me miss the series. Pls don't do that in the future.

Looks like Jason reviewed the series - Jason, is that right? -
so I'd like his ack if possible.


> Though it would always be good too if Jason would still like to review it.
> 
> Jason, what's your opinion?
> 
> Thanks,
> 
> -- 
> Peter Xu


