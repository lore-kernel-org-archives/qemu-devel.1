Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D66D5C433E4
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 15:17:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CCC3207DA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 15:17:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AuPduhLp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CCC3207DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k83N4-0001Pf-PK
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 11:17:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37020)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1k82Xq-0003QS-Q8
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 10:24:58 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:21695
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1k82Xo-0000fn-3V
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 10:24:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597760695;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bnVjv2E9MXPIek9BeP6uPAv77BN+S21x4krPCFjqD6w=;
 b=AuPduhLpj/g1XA9raU6wM6DpKl7VI/z6tJgi/BWS6O0q2DWwBwtqsw1//UBNYu3R9GACym
 EEHG+0BkqCJIMEEYzBrBoCSbIwyj1p+YIZUCk6NbjBH+fBToZNobCcdPdpvPhoI+SmCfnb
 Dyu7oD4OGnAFiEy6OmqMIy/1/VzoKHs=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-243-hoEIjvb-PBGrrh8zIiXEhQ-1; Tue, 18 Aug 2020 10:24:51 -0400
X-MC-Unique: hoEIjvb-PBGrrh8zIiXEhQ-1
Received: by mail-qt1-f199.google.com with SMTP id e14so14529451qtm.5
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2020 07:24:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=bnVjv2E9MXPIek9BeP6uPAv77BN+S21x4krPCFjqD6w=;
 b=i6hTCh2I50F8PLDhmrYdtYQDbH3apUiUAKLRy0/PKFEJjwV7ip2AcK6bP/5un4M5S2
 hOh/IreE6gkdFJSBvOnpgtt9po4DzvD0+vpHIO9SFObzHLP1/JDSA/tde5vz6LWiA8lw
 gAE6jyKtJ5MPRvtBn2F7puAZ6mxlpDTeq5ZdwA5L0Y1wnCdhWy0EVOIKq54FhYT+8fd6
 2+3mTwAfEmUsxX9dJOVMLeYH7j5PzpgfXLDgzVbOzOs8za/QHanllLG4jNqrm5ZXjW5u
 1jGBE4p5QCgt5F0I6gIhmLV4fRIqmI/Ucuonv014iyoXVmIniShf44AwCjEnAN1yl98j
 J0gg==
X-Gm-Message-State: AOAM5329ph2aGxNQ1xWqQMpvpb1t2YMJ8KCFTIfZBEci2K1KEc/C7iHP
 Ad72GXT0FMJCgRRdW/4Jdvp0LIxbYJTUkVIaeTfb3Ulc145B5IkKoO468jJ9V8xUZz9hZV34Cit
 +ao3zC5pYhPX5QsO1DEqBohA0/8DNiOY=
X-Received: by 2002:a05:620a:1595:: with SMTP id
 d21mr17439778qkk.203.1597760691040; 
 Tue, 18 Aug 2020 07:24:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwRFwzvWpICHYl9Pb7Pt332bo70VHU7hKuV9Z1SfAmKAOsh056cPo7CEJLKpLI+3ysuPXSpPbsVUibtzJriZX8=
X-Received: by 2002:a05:620a:1595:: with SMTP id
 d21mr17439752qkk.203.1597760690754; 
 Tue, 18 Aug 2020 07:24:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200626064122.9252-1-eperezma@redhat.com>
 <20200811175533.7359-1-eperezma@redhat.com>
 <20200811175533.7359-2-eperezma@redhat.com>
 <2443886f-2109-e048-b47f-886c896613ab@redhat.com>
 <CAJaqyWe0_wcXHgbAVAVNCTpG7O4YKF6FMkgKsf6SfW4dEZ4A5g@mail.gmail.com>
In-Reply-To: <CAJaqyWe0_wcXHgbAVAVNCTpG7O4YKF6FMkgKsf6SfW4dEZ4A5g@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 18 Aug 2020 16:24:12 +0200
Message-ID: <CAJaqyWe+KgnVegtprpRmVvXo7kFVFDL_erK_5Nyp4K=gTUcN=Q@mail.gmail.com>
Subject: Re: [RFC v3 1/1] memory: Skip bad range assertion if notifier
 supports arbitrary masks
To: Jason Wang <jasowang@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eperezma@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 08:01:06
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

On Wed, Aug 12, 2020 at 10:49 AM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Wed, Aug 12, 2020 at 4:24 AM Jason Wang <jasowang@redhat.com> wrote:
> >
> >
> > On 2020/8/12 =E4=B8=8A=E5=8D=881:55, Eugenio P=C3=A9rez wrote:
> > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > ---
> > >   hw/virtio/vhost.c     |  2 +-
> > >   include/exec/memory.h |  2 ++
> > >   softmmu/memory.c      | 10 ++++++++--
> > >   3 files changed, 11 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> > > index 1a1384e7a6..e74ad9e09b 100644
> > > --- a/hw/virtio/vhost.c
> > > +++ b/hw/virtio/vhost.c
> > > @@ -729,7 +729,7 @@ static void vhost_iommu_region_add(MemoryListener=
 *listener,
> > >       iommu_idx =3D memory_region_iommu_attrs_to_index(iommu_mr,
> > >                                                      MEMTXATTRS_UNSPE=
CIFIED);
> > >       iommu_notifier_init(&iommu->n, vhost_iommu_unmap_notify,
> > > -                        IOMMU_NOTIFIER_UNMAP,
> > > +                        IOMMU_NOTIFIER_UNMAP | IOMMU_NOTIFIER_IOTLB,
> >
> >
> > I think we can safely drop IOMMU_NOTIFIER_UNMAP here since device IOTLB
> > is sufficient.
> >
> > Btw, IOMMU_NOTIFIER_IOTLB is kind of confusing, maybe something like
> > IOMMU_NOTIFIER_DEVIOTLB.
> >
>
> Got it, will change.
>
> >
> > >                           section->offset_within_region,
> > >                           int128_get64(end),
> > >                           iommu_idx);
> > > diff --git a/include/exec/memory.h b/include/exec/memory.h
> > > index 307e527835..4d94c1e984 100644
> > > --- a/include/exec/memory.h
> > > +++ b/include/exec/memory.h
> > > @@ -87,6 +87,8 @@ typedef enum {
> > >       IOMMU_NOTIFIER_UNMAP =3D 0x1,
> > >       /* Notify entry changes (newly created entries) */
> > >       IOMMU_NOTIFIER_MAP =3D 0x2,
> > > +    /* Notify changes on IOTLB entries */
> > > +    IOMMU_NOTIFIER_IOTLB =3D 0x04,
> > >   } IOMMUNotifierFlag;
> > >
> > >   #define IOMMU_NOTIFIER_ALL (IOMMU_NOTIFIER_MAP | IOMMU_NOTIFIER_UNM=
AP)
> > > diff --git a/softmmu/memory.c b/softmmu/memory.c
> > > index af25987518..e2c5f6d0e7 100644
> > > --- a/softmmu/memory.c
> > > +++ b/softmmu/memory.c
> > > @@ -1895,6 +1895,7 @@ void memory_region_notify_one(IOMMUNotifier *no=
tifier,
> >
> >
> > (we probably need a better name of this function, at least something
> > like "memory_region_iommu_notify_one").
> >
>
> Ok will change.
>
> >
> > >   {
> > >       IOMMUNotifierFlag request_flags;
> > >       hwaddr entry_end =3D entry->iova + entry->addr_mask;
> > > +    IOMMUTLBEntry tmp =3D *entry;
> > >
> > >       /*
> > >        * Skip the notification if the notification does not overlap
> > > @@ -1904,7 +1905,12 @@ void memory_region_notify_one(IOMMUNotifier *n=
otifier,
> > >           return;
> > >       }
> > >
> > > -    assert(entry->iova >=3D notifier->start && entry_end <=3D notifi=
er->end);
> > > +    if (notifier->notifier_flags & IOMMU_NOTIFIER_IOTLB) {
> > > +        tmp.iova =3D MAX(tmp.iova, notifier->start);
> > > +        tmp.addr_mask =3D MIN(entry_end, notifier->end) - tmp.iova;
> >
> >
> > Any reason for doing such re-calculation here, a comment would be helpf=
ul.
> >
>
> It was proposed by Peter, but I understand as limiting the
> address+range we pass to the notifier. Although vhost seems to support
> it as long as it contains (notifier->start, notifier->end) in range, a
> future notifier might not.
>
> It could be done as iommu_entry_crop(IOMMUTLBEntry *entry, const
> IOMMUNotifier *notifier) though.
>
> >
> > > +    } else {
> > > +        assert(entry->iova >=3D notifier->start && entry_end <=3D no=
tifier->end);
> >
> >
> > I wonder if it's better to convert the assert so some kind of log or
> > warn here.
> >
>
> I think that if we transform that assert to a log, we should also tell
> the guest that something went wrong. Or would it be enough notifying
> the bad range?
>
> If a malicious guest cannot reach that point, I think that leaving it
> as an assertion allows us to detect earlier the fail in my opinion
> (Assert early and assert often).
>
> Thanks!
>

Hi Jason.

I just sent v4, please let me know if the changes are ok for you or
you think it should be done otherwise.

Is it ok for you to just let the assert, or you think we should still
change to a conditional?

Thanks!

> > Thanks
> >
> >
> > > +    }
> > >
> > >       if (entry->perm & IOMMU_RW) {
> > >           request_flags =3D IOMMU_NOTIFIER_MAP;
> > > @@ -1913,7 +1919,7 @@ void memory_region_notify_one(IOMMUNotifier *no=
tifier,
> > >       }
> > >
> > >       if (notifier->notifier_flags & request_flags) {
> > > -        notifier->notify(notifier, entry);
> > > +        notifier->notify(notifier, &tmp);
> > >       }
> > >   }
> > >
> >


