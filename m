Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B16C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 06:54:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAE8E207BC
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 06:54:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PET5LWbR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAE8E207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBBoB-0000x3-SH
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 02:54:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53090)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1kBBnR-0000Oq-KX
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 02:54:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29102)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1kBBnP-0001qm-BQ
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 02:54:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598511242;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=m6pExH/Wx7HDxG5TZe8WndVEbse8trnYUp0l8jdP0II=;
 b=PET5LWbR4bsCfoZ4lzXdAT3RGbq+u1/CssrcNLL3x0/IZmZgyfB7rspomojsK3FmGq03zY
 Vkb91NpYq8UCa7prqDx1ZW/EJJ3Rq0xOHhdcFwLEWXBvlPGsP8z2+vv6XMWpFBhlGonP7B
 lfWFhXbr951ORgDXF9GuSA5T0YieP2I=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-453-RcMkx_FAMa6SKkEx32FuRg-1; Thu, 27 Aug 2020 02:54:00 -0400
X-MC-Unique: RcMkx_FAMa6SKkEx32FuRg-1
Received: by mail-qk1-f197.google.com with SMTP id g6so3905261qko.21
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 23:54:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=m6pExH/Wx7HDxG5TZe8WndVEbse8trnYUp0l8jdP0II=;
 b=ISCsA9aqCBR0smJUD44b1GshJvS3cjSU5hXd2FgFBWpj5iNj6Yy7fgmUMA6p3urD6i
 xaAV2F3i7filrOD+asFryxiLqAZCC7jzTg3V64aXe4Soaeq2ed4yaLW4gm44Ob1Rk1Yb
 X8VmNTeZPdGNBpzCU3bOPkgdhmPBzfMvvKuzJKUc+CspxTNfGdYxZUTgNu5OTSRvBMQE
 pC1tgs7TVUy+iX1KtxX22PDEGOkyI6kVkQn+uGZIkeUdAmzhGC7jM5Z70bBKC0KG+E9/
 HbesQDSOubg5A6mzFR5d/QmpFyr7a9WEh3h8lCVtC2GtlSASEnsWOcVVx/qL39Y4+45l
 ub5Q==
X-Gm-Message-State: AOAM533I3qnz86SaI26raW+7ASFakhxNz3iXYH5Lcjfj8gRHzqDSXgJw
 qwezZE6PZwRRsbDoJXRE+09EPvvi6NqZ0puH4cS/hc1Xus++Yu+R6SspyF2UWepHOpPWeUBALNO
 lOJtDI7p6mytP8IT8XGap+FMUeirCw5M=
X-Received: by 2002:a05:620a:ed3:: with SMTP id
 x19mr15955302qkm.89.1598511239875; 
 Wed, 26 Aug 2020 23:53:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyC/TrtYCu0a1o4nFIE0pxQLuoadQcXPJcHPcYZxDJvVVf+oAn7vYaYX1zQEUfyBtBtlaJw/m2CSGV03/T1vIA=
X-Received: by 2002:a05:620a:ed3:: with SMTP id
 x19mr15955280qkm.89.1598511239638; 
 Wed, 26 Aug 2020 23:53:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200625191651.5817-1-eperezma@redhat.com>
 <20200826143651.7915-1-eperezma@redhat.com>
 <CAJaqyWf5vgSNvix99aWzrm2kDZ5xHQ_binRkpTe7WifDrLCjyw@mail.gmail.com>
 <20200826155409.GG8235@xz-x1>
In-Reply-To: <20200826155409.GG8235@xz-x1>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 27 Aug 2020 08:53:23 +0200
Message-ID: <CAJaqyWcVRrX=3TzSpiRUrVBZ8m=c0Rvt1OtN4ZQZS1EoVkCtZg@mail.gmail.com>
Subject: Re: [RFC v6 00/13] memory: Delete assertion in
 memory_region_unregister_iommu_notifier
To: Peter Xu <peterx@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eperezma@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 02:10:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
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
 Juan Quintela <quintela@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Eric Auger <eric.auger@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Avi Kivity <avi@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Aug 26, 2020 at 5:54 PM Peter Xu <peterx@redhat.com> wrote:
>
> On Wed, Aug 26, 2020 at 05:00:30PM +0200, Eugenio Perez Martin wrote:
> > Hi!
> >
> > Sending v6 to see if that is on the same page as what you meant.
> > Making each setting of "type" explicitly IOMMU_IOTLB_NONE if not used
> > in notifications. This is done in different commits in case this helps
> > review of different architectures.
>
> I've also proposed IOMMUTLBEvent in the other reply, that might help too.
>

I think IOMMUTLBEvent would be way clearer, yes :).

> Since at it, there's also another trick to use - we don't need to touch those
> "type" as long as the default type is "zero", so as long as we make sure the
> default type (IOMMU_NOTIFIER_NONE) is zero, then we don't need to set it
> everywhere either.
>

Right, I was just making it explicit.

> >
> > I think that this way we have too much freedom between entry flags
> > (currently only access type, RW) and notification type. Since not all
> > of them are valid nor used in the same context, I think this adds
> > complexity. I'm wondering if:
> >
> > Option a) We could make it private to memory.c, and make it a flag of
> > memory_region_notify_iommu (like "bool deviotlb_type)". IOW, instead
> > of making it a member of IOMMUTLBEntry, wrap the "entry" parameter of
> > memory_region_notify_iommu in a new private structure defined in
> > memory.c that adds that flag.
>
> No strong preference from me.  But since you posted the series before you
> provide the options... Maybe continue with what we have can be easier. :)
>

I just wanted to be sure I understood your proposal before comparing :)

> >
> > Option b) We could keep the IOMMUTLBNotificationType enum (open to
> > suggestions for a better name :)), but not embed it in the struct,
> > like:
> >
> > diff --git a/include/exec/memory.h b/include/exec/memory.h
> > index 477c3af24c..d9150e7b7e 100644
> > --- a/include/exec/memory.h
> > +++ b/include/exec/memory.h
> > @@ -72,7 +72,8 @@ typedef enum {
> >      IOMMU_RO   = 1,
> >      IOMMU_WO   = 2,
> >      IOMMU_RW   = 3,
> > -} IOMMUAccessFlags;
> > +    IOMMU_DEVIOTLB = 4,
> > +} IOMMUEntryFlags;
>
> Just in case you didn't notice - IOMMUAccessFlags is actaully a bitmap. :)
>

I know I know, that is why I compared with IOMMU_RW in proposed
iommu_tlb_entry_type.

Thanks!

> IMHO we can keep the IOMMUAccessFlags scemantics, since it's still correct for
> a general translated IOMMUTLBEntry object.
>
> Thanks,
>
> --
> Peter Xu
>


