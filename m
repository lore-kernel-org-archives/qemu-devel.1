Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6083C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 17:06:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C3B7206EF
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 17:06:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YnUA6Fz9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C3B7206EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDsh9-0005Ev-Fq
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 13:06:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50430)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1kDsgT-0004X0-FL
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 13:06:01 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:56813
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1kDsgR-00086d-25
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 13:06:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599152757;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l/xjPfj/tH338pdJxM7gVbr8ZOJ5LeUsNYtGEq4fxco=;
 b=YnUA6Fz9i3bcjctlAqsmhWm8WBGSnR5Tp8mgyYuBkhWCoNIdHDt1znMlf8IDWoViWNX3xs
 Nd/0VB8Jquz3M2E4lJNGdHOk809Z853wK0yGWXvUJaw/M93bv5NCIvkJ1freaUsd8fp7qg
 Vygu8VK91Be+7cUmqs+MXccC8bZBdI4=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-480-USqfGo5SPKSw_mO0mMhWHg-1; Thu, 03 Sep 2020 13:05:49 -0400
X-MC-Unique: USqfGo5SPKSw_mO0mMhWHg-1
Received: by mail-qv1-f71.google.com with SMTP id l29so2156891qve.18
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 10:05:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=l/xjPfj/tH338pdJxM7gVbr8ZOJ5LeUsNYtGEq4fxco=;
 b=thwv6PWsn7f80OhefrZuegxkoVD38tVi7Q/LlzzAIhUQBxw8Cz2GOgAvdFYDUilwbR
 6YPjLfQP1i5TRRGyd0AYJ+o70Ygz8Ot5nrrNfR7S7tZejMuQn5DQQmXl2Uq8DkG9LpI/
 +i7qf7X3Aji1iLTwQ3wUMJdA+7ZpCEpFzhq4skiNCtCWA+Mu4k720zOW2yRKDcTAO6Yr
 J0Ktnhch3380XR1aWpbG0A7rnL/pTLBO6huY1cx/K81xvVvoE8WEX2GxkpFmWMudtVL8
 1yub7sk7H0z9HTYGdERX79IlBDwcZ9blqLxfr35t4FHovKZofnNQOZE2w65Kcnlh5r09
 j9cA==
X-Gm-Message-State: AOAM530aKN3T3aJuLKFj8fQkBlpfcx52R+jM1jWejegnJRJadwHw6xPR
 WMuejZiAnOcLPWGErVNlhoG/sg+/b9n/mGslKEttMuuHD8eKAuENQLX/n8AnrptQ1dUtPeuSg0z
 IyS1TW3D8R8PY+YcZDDfnXmtbuQmoSlI=
X-Received: by 2002:ac8:4f4b:: with SMTP id i11mr4333166qtw.379.1599152748879; 
 Thu, 03 Sep 2020 10:05:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyJC+HCdObWTvpaWM1i3vcHqG6lyDUT+9Zs0KX/a2FhuZWkar/pvhxTUDgLRKPc0U3W7gJyul9+rNF8k6xdU7k=
X-Received: by 2002:ac8:4f4b:: with SMTP id i11mr4333140qtw.379.1599152748650; 
 Thu, 03 Sep 2020 10:05:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200901142608.24481-1-eperezma@redhat.com>
 <20200901142608.24481-6-eperezma@redhat.com>
 <44d9e8a5-79fa-11c8-9ec1-4c3d76929408@redhat.com>
 <20200902235737.GF1897@yekko.fritz.box>
In-Reply-To: <20200902235737.GF1897@yekko.fritz.box>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 3 Sep 2020 19:05:11 +0200
Message-ID: <CAJaqyWcto4iNFRDoAu5KsYvUiYt3GXhGHjXRm0nezRGjioMbyQ@mail.gmail.com>
Subject: Re: [RFC v8 5/5] memory: Skip bad range assertion if notifier is
 DEVIOTLB type
To: David Gibson <david@gibson.dropbear.id.au>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eperezma@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 01:28:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-ppc@nongnu.org,
 Jason Wang <jasowang@redhat.com>, Juan Quintela <quintela@redhat.com>,
 qemu-level <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>,
 Auger Eric <eric.auger@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Avi Kivity <avi@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 3, 2020 at 2:05 AM David Gibson <david@gibson.dropbear.id.au> w=
rote:
>
> On Wed, Sep 02, 2020 at 04:24:50PM +0200, Auger Eric wrote:
> > Hi Eugenio,
> >
> > On 9/1/20 4:26 PM, Eugenio P=C3=A9rez wrote:
> > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > Please could you explain in the commit message why you need to remove
> > the assert()? I know you described the assert() in the cover letter but
> > the commit msg is the one that remains.
>
> Right... neither in the cover letter nor the individual patches,
> AFAICT, does anything actually explain why that assert() could be
> hit.  Nor does it connect the dots from an assert() hitting to adding
> infrastructure for a new event type.
>

Hi!

You are right. I think I've made it clearer in the new patch sent (now
as patch instead of RFC).

Please let me know if you think further explanations are needed.

Thanks!


> > > ---
> > >  softmmu/memory.c | 13 +++++++++++--
> > >  1 file changed, 11 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/softmmu/memory.c b/softmmu/memory.c
> > > index 09b3443eac..3ee99b4dc0 100644
> > > --- a/softmmu/memory.c
> > > +++ b/softmmu/memory.c
> > > @@ -1895,6 +1895,7 @@ void memory_region_notify_iommu_one(IOMMUNotifi=
er *notifier,
> > >  {
> > >      IOMMUTLBEntry *entry =3D &event->entry;
> > >      hwaddr entry_end =3D entry->iova + entry->addr_mask;
> > > +    IOMMUTLBEntry tmp =3D *entry;
> > >
> > >      /*
> > >       * Skip the notification if the notification does not overlap
> > > @@ -1904,10 +1905,18 @@ void memory_region_notify_iommu_one(IOMMUNoti=
fier *notifier,
> > >          return;
> > >      }
> > >
> > > -    assert(entry->iova >=3D notifier->start && entry_end <=3D notifi=
er->end);
> > > +    if (notifier->notifier_flags & IOMMU_NOTIFIER_DEVIOTLB) {
> > > +        /* Crop (iova, addr_mask) to range */
> > > +        tmp.iova =3D MAX(tmp.iova, notifier->start);
> > > +        tmp.addr_mask =3D MIN(entry_end, notifier->end) - tmp.iova;
> > > +        /* Confirm no underflow */
> > > +        assert(MIN(entry_end, notifier->end) >=3D tmp.iova);
> > > +    } else {
> > > +        assert(entry->iova >=3D notifier->start && entry_end <=3D no=
tifier->end);
> > > +    }
> > >
> > >      if (event->type & notifier->notifier_flags) {
> > > -        notifier->notify(notifier, entry);
> > > +        notifier->notify(notifier, &tmp);
> > >      }
> > >  }
> > >
> > >
> > Thanks
> >
> > Eric
> >
>
> --
> David Gibson                    | I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au  | minimalist, thank you.  NOT _the_ _othe=
r_
>                                 | _way_ _around_!
> http://www.ozlabs.org/~dgibson


