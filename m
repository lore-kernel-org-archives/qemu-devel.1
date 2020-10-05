Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ABADC4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 06:35:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62F1920674
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 06:35:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="guuJHOYQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62F1920674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPK5l-0000K8-CH
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 02:35:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42356)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1kPK3h-00082U-AQ
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 02:33:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43060)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1kPK3f-00025I-Hq
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 02:33:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601879593;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tYhPG5upwMkpIHxG+0Upc1PqbqAzbVxFJ+rcnlZQ0A8=;
 b=guuJHOYQtl0oJAHXZtBBYuHPzLtLy5QkSTGJTKp+18RA6JMUNJjlMIboAJEUkkjzzTldoJ
 EaklFyCiZqfzjNV0vWGAg6Qf/qtG2a3hpzJoAl5csDjhG05D16U2pftORmEJyOYj9UHODf
 FBTzeU3HoEDO+VE2TrukqIJuLUja/08=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-zzV4fownOgu29hNHcsyAOA-1; Mon, 05 Oct 2020 02:33:08 -0400
X-MC-Unique: zzV4fownOgu29hNHcsyAOA-1
Received: by mail-qt1-f200.google.com with SMTP id m13so5803081qtu.10
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2020 23:33:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=tYhPG5upwMkpIHxG+0Upc1PqbqAzbVxFJ+rcnlZQ0A8=;
 b=G/LbvIflhYRlTyL8fIh4ydes1NyTguSMYQvoh88D3RF5cfrAGz1w5i5baloIeN3/am
 NMNGl1hVxPQNeW9A8dL+AbYQWNQH+Km5HuVQvNH4352kf3drDHAswoQye6xxKQxVRknf
 0xEWxt9wFnByjUXtgmsFgHCgrQlObB+CDBOk8bjafD+FKb/hX0fk/adi9UP4hB+fFuu3
 uI3e4Tafpf1VGgYQXSfOnZjxmiaL8THPVPVwhAj8QvIAaquRnj+GMNtKOPR82jkoEpSz
 nCYoxoWnBR6E2Ctk6hoG6aedK+1vO8jy2tcNA9ueFvoDJKelFLzb6Y4s8jnTrlRXNyhj
 ohyw==
X-Gm-Message-State: AOAM531CTBBMcWZbTTgnN7RWfj0RpgwxLoiaJ65rU/SD9RI6j9dHERJ/
 YBQThwt36GdoOFgn5ZrP3svRMOIr+Hv96dZ+OUbeDNOYDdZjTYQZYOewk0+SOJ6jO7smcRtc1Qs
 4lzPkcyq9iiRyNXhwFlkHsLdlSaUCvMg=
X-Received: by 2002:a37:e214:: with SMTP id g20mr12131154qki.89.1601879588430; 
 Sun, 04 Oct 2020 23:33:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyFvOmpfw217IRR/oC1goKocBDZHm4mjH4D9IXW69kz2YKHJJwBXREyODPrEZNX8hNBQqo6pHx5P2lF9vyZAlM=
X-Received: by 2002:a37:e214:: with SMTP id g20mr12131134qki.89.1601879588140; 
 Sun, 04 Oct 2020 23:33:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200625191651.5817-1-eperezma@redhat.com>
 <20200903161446.29615-1-eperezma@redhat.com>
 <20200903161446.29615-6-eperezma@redhat.com>
 <d3e2098d-e150-7f99-a1ee-4a997daf4a5c@redhat.com>
 <CAJaqyWfwGP7_Ex=NhG_po+A1BkN3OCV=+3Vwi8uhLJ_e4UA5NQ@mail.gmail.com>
 <20200928174857.GC59869@xz-x1> <20201003082953-mutt-send-email-mst@kernel.org>
In-Reply-To: <20201003082953-mutt-send-email-mst@kernel.org>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 5 Oct 2020 08:32:31 +0200
Message-ID: <CAJaqyWc1rrGu_YYNcANquXqd+LCBvoOZYYHdtsG3XQJDDbWohg@mail.gmail.com>
Subject: Re: [PATCH 5/5] memory: Skip bad range assertion if notifier is
 DEVIOTLB_UNMAP type
To: "Michael S. Tsirkin" <mst@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eperezma@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=63.128.21.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/05 01:25:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.745,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
 Juan Quintela <quintela@redhat.com>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 qemu-level <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Avi Kivity <avi@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Oct 3, 2020 at 7:38 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Sep 28, 2020 at 01:48:57PM -0400, Peter Xu wrote:
> > On Mon, Sep 28, 2020 at 11:05:01AM +0200, Eugenio Perez Martin wrote:
> > > On Fri, Sep 4, 2020 at 6:34 AM Jason Wang <jasowang@redhat.com> wrote=
:
> > > >
> > > >
> > > > On 2020/9/4 =E4=B8=8A=E5=8D=8812:14, Eugenio P=C3=A9rez wrote:
> > > > > Device IOTLB invalidations can unmap arbitrary ranges, eiter outs=
ide of
> > > > > the memory region or even [0, ~0ULL] for all the space. The asser=
tion
> > > > > could be hit by a guest, and rhel7 guest effectively hit it.
> > > > >
> > > > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > > > Reviewed-by: Peter Xu <peterx@redhat.com>
> > > > > Reviewed-by: Juan Quintela <quintela@redhat.com>
> > > > > ---
> > > > >   softmmu/memory.c | 13 +++++++++++--
> > > > >   1 file changed, 11 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/softmmu/memory.c b/softmmu/memory.c
> > > > > index 8694fc7cf7..e723fcbaa1 100644
> > > > > --- a/softmmu/memory.c
> > > > > +++ b/softmmu/memory.c
> > > > > @@ -1895,6 +1895,7 @@ void memory_region_notify_iommu_one(IOMMUNo=
tifier *notifier,
> > > > >   {
> > > > >       IOMMUTLBEntry *entry =3D &event->entry;
> > > > >       hwaddr entry_end =3D entry->iova + entry->addr_mask;
> > > > > +    IOMMUTLBEntry tmp =3D *entry;
> > > > >
> > > > >       if (event->type =3D=3D IOMMU_NOTIFIER_UNMAP) {
> > > > >           assert(entry->perm =3D=3D IOMMU_NONE);
> > > > > @@ -1908,10 +1909,18 @@ void memory_region_notify_iommu_one(IOMMU=
Notifier *notifier,
> > > > >           return;
> > > > >       }
> > > > >
> > > > > -    assert(entry->iova >=3D notifier->start && entry_end <=3D no=
tifier->end);
> > > > > +    if (notifier->notifier_flags & IOMMU_NOTIFIER_DEVIOTLB_UNMAP=
) {
> > > > > +        /* Crop (iova, addr_mask) to range */
> > > > > +        tmp.iova =3D MAX(tmp.iova, notifier->start);
> > > > > +        tmp.addr_mask =3D MIN(entry_end, notifier->end) - tmp.io=
va;
> > > > > +        /* Confirm no underflow */
> > > > > +        assert(MIN(entry_end, notifier->end) >=3D tmp.iova);
> > > >
> > > >
> > > > It's still not clear to me why we need such assert. Consider
> > > > notifier->end is the possible IOVA range but not possible device IO=
TLB
> > > > invalidation range (e.g it allows [0, ULLONG_MAX]).
> > > >
> > > > Thanks
> > > >
> > >
> > > As far as I understood the device should admit that out of bounds
> > > notifications in that case,
> > > and the assert just makes sure that there was no underflow in
> > > tmp.addr_mask, i.e., that something
> > > very wrong that should never happen in production happened.
> > >
> > > Peter, would you mind to confirm/correct it?
> >
> > I think Jason is right - since we have checked at the entry that the tw=
o
> > regions cross over each other:
> >
> >     /*
> >      * Skip the notification if the notification does not overlap
> >      * with registered range.
> >      */
> >     if (notifier->start > entry_end || notifier->end < entry->iova) {
> >         return;
> >     }
> >
> > Then I don't see how this assertion can fail any more.
> >
> > But imho not a big problem either, and it shouldn't hurt to even keep t=
he
> > assertion of above isn't that straightforward.
> >
> > >
> > > Is there anything else needed to pull this patch?
> >
> > I didn't post a pull for this only because I shouldn't :) - the plan wa=
s that
> > all vt-d patches will still go via Michael's tree, iiuc.  Though at lea=
st to me
> > I think this series is acceptable for merging.
>
> Sure, that's ok.
>
> Eugenio, you sent patch 0 as a response to another series, which
> made me miss the series. Pls don't do that in the future.
>

Sorry, noted for the next time.

Thanks!

> Looks like Jason reviewed the series - Jason, is that right? -
> so I'd like his ack if possible.
>
>
> > Though it would always be good too if Jason would still like to review =
it.
> >
> > Jason, what's your opinion?
> >
> > Thanks,
> >
> > --
> > Peter Xu
>


