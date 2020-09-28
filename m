Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29153C2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 09:07:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E61021D7F
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 09:07:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AYXLQjkz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E61021D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMp7x-0001Oc-He
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 05:07:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44722)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1kMp6N-0000Ga-R9
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 05:05:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47856)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1kMp6M-0001Br-3X
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 05:05:43 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601283940;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aSt6WEPX6H6arXqRj+mcB74HYWVBtA4o6zZCZbr+014=;
 b=AYXLQjkzT0FUXnZh0et2q//09h2F7zbHsUL1aWjRTECLc6cyExoc5Yeyx8kIlmkQtfblg0
 xDngbRtL4BpDCNrZC5aXx3ZV/5VODuweoq3aKjhHk7ntmrK4mm24a9L6BVic+Er7x1HSpz
 3TsklESpFiiMNTZwYfm/sqRcW/EgcAE=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-136-zIOkishVOLeo3lA7FEXdlQ-1; Mon, 28 Sep 2020 05:05:38 -0400
X-MC-Unique: zIOkishVOLeo3lA7FEXdlQ-1
Received: by mail-qt1-f197.google.com with SMTP id h31so172722qtd.14
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2020 02:05:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=aSt6WEPX6H6arXqRj+mcB74HYWVBtA4o6zZCZbr+014=;
 b=I0s4NIquCsKQZopwuF7DkwB61jHe8RxCBGoAbTUsghp3T7z6YC6Oan63xDhkbPS0bB
 V36jQtWyXvug+/7Cgc9qhNTUlNHz4SMGB/bkRjyWdwwQ4XZByeB8pSCqKxue98ZOeggo
 BGopqD6rGwXxmbhrOuqUyaQ8NW/uReY1B9tnWEVlB+dF/Z5JOdIuvQJyvbsvOFMoCXJ2
 IxHVQtxXi+IkzGHW8vNgZHJbLnOL0QFbF7QvpCyVGnjR2o6sPdDsP/1IhTPgeE1mFNzJ
 s9bpw4Q9m82ClN7l4eCta7zIwH4P3rIoJw8ljfBPDrw/LHORA6GfKs0Fdncm7Go9C09N
 wG5w==
X-Gm-Message-State: AOAM530uFZS7F5LskZ4jY0z0/YDgoVlDz9o6VE4cjsA78lLE1SXWz+xy
 ex8C/S+LfDZ48fXC/MNGQLTR0ZFm6DtiKrFJg5fdQ1By+DVaOYM9vLOdoPnGM18AFBWsfAujGKe
 4JSFOQsO5A5vTd0M6BHnLSMWsItgSbyo=
X-Received: by 2002:a05:6214:a11:: with SMTP id
 dw17mr10564622qvb.62.1601283938227; 
 Mon, 28 Sep 2020 02:05:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyaJe7tL4dTrpA/8apQljDcxoY2E90q6gbGssn1TbUY8BUgNOTQzfsXd1NeddjBXkPKwVVx7+HfeS+6V6MqlVs=
X-Received: by 2002:a05:6214:a11:: with SMTP id
 dw17mr10564590qvb.62.1601283937959; 
 Mon, 28 Sep 2020 02:05:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200625191651.5817-1-eperezma@redhat.com>
 <20200903161446.29615-1-eperezma@redhat.com>
 <20200903161446.29615-6-eperezma@redhat.com>
 <d3e2098d-e150-7f99-a1ee-4a997daf4a5c@redhat.com>
In-Reply-To: <d3e2098d-e150-7f99-a1ee-4a997daf4a5c@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 28 Sep 2020 11:05:01 +0200
Message-ID: <CAJaqyWfwGP7_Ex=NhG_po+A1BkN3OCV=+3Vwi8uhLJ_e4UA5NQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] memory: Skip bad range assertion if notifier is
 DEVIOTLB_UNMAP type
To: Jason Wang <jasowang@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eperezma@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=63.128.21.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 03:47:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.576,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
 "Michael S. Tsirkin" <mst@redhat.com>, Juan Quintela <quintela@redhat.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 qemu-level <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Avi Kivity <avi@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 4, 2020 at 6:34 AM Jason Wang <jasowang@redhat.com> wrote:
>
>
> On 2020/9/4 =E4=B8=8A=E5=8D=8812:14, Eugenio P=C3=A9rez wrote:
> > Device IOTLB invalidations can unmap arbitrary ranges, eiter outside of
> > the memory region or even [0, ~0ULL] for all the space. The assertion
> > could be hit by a guest, and rhel7 guest effectively hit it.
> >
> > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > Reviewed-by: Peter Xu <peterx@redhat.com>
> > Reviewed-by: Juan Quintela <quintela@redhat.com>
> > ---
> >   softmmu/memory.c | 13 +++++++++++--
> >   1 file changed, 11 insertions(+), 2 deletions(-)
> >
> > diff --git a/softmmu/memory.c b/softmmu/memory.c
> > index 8694fc7cf7..e723fcbaa1 100644
> > --- a/softmmu/memory.c
> > +++ b/softmmu/memory.c
> > @@ -1895,6 +1895,7 @@ void memory_region_notify_iommu_one(IOMMUNotifier=
 *notifier,
> >   {
> >       IOMMUTLBEntry *entry =3D &event->entry;
> >       hwaddr entry_end =3D entry->iova + entry->addr_mask;
> > +    IOMMUTLBEntry tmp =3D *entry;
> >
> >       if (event->type =3D=3D IOMMU_NOTIFIER_UNMAP) {
> >           assert(entry->perm =3D=3D IOMMU_NONE);
> > @@ -1908,10 +1909,18 @@ void memory_region_notify_iommu_one(IOMMUNotifi=
er *notifier,
> >           return;
> >       }
> >
> > -    assert(entry->iova >=3D notifier->start && entry_end <=3D notifier=
->end);
> > +    if (notifier->notifier_flags & IOMMU_NOTIFIER_DEVIOTLB_UNMAP) {
> > +        /* Crop (iova, addr_mask) to range */
> > +        tmp.iova =3D MAX(tmp.iova, notifier->start);
> > +        tmp.addr_mask =3D MIN(entry_end, notifier->end) - tmp.iova;
> > +        /* Confirm no underflow */
> > +        assert(MIN(entry_end, notifier->end) >=3D tmp.iova);
>
>
> It's still not clear to me why we need such assert. Consider
> notifier->end is the possible IOVA range but not possible device IOTLB
> invalidation range (e.g it allows [0, ULLONG_MAX]).
>
> Thanks
>

As far as I understood the device should admit that out of bounds
notifications in that case,
and the assert just makes sure that there was no underflow in
tmp.addr_mask, i.e., that something
very wrong that should never happen in production happened.

Peter, would you mind to confirm/correct it?

Is there anything else needed to pull this patch?

Thanks!

>
> > +    } else {
> > +        assert(entry->iova >=3D notifier->start && entry_end <=3D noti=
fier->end);
> > +    }
> >
> >       if (event->type & notifier->notifier_flags) {
> > -        notifier->notify(notifier, entry);
> > +        notifier->notify(notifier, &tmp);
> >       }
> >   }
> >
>


