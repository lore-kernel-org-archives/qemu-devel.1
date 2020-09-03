Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 223D3C433E7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 10:15:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA29520767
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 10:15:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VeEQ84+K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA29520767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDmGx-00045V-N7
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 06:15:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48690)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1kDmGL-0003R2-GA
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 06:14:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35940
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1kDmGJ-0006R3-4Y
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 06:14:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599128073;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6kL2CH6UwWqRslXBpITScixS5axdiZInfiwVOoQvCfg=;
 b=VeEQ84+KA6mUlVfH0AdBfmdil0AePxoDxhTU73wed+6lvU+ceyy4Nrm2KJ2O0QUdQWM8z+
 qAJBtY6dJwD7sRELdDjDfZR9rZrK8ffxcCqxr+PlY+KyEejNSPPjS0jws1eb+blbjlep/F
 9xMf34qLks/Z3SFNFzvSFBhi7I/bGcg=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-561-8wjnVxlWOTuk-FkevUEtJg-1; Thu, 03 Sep 2020 06:14:30 -0400
X-MC-Unique: 8wjnVxlWOTuk-FkevUEtJg-1
Received: by mail-qt1-f200.google.com with SMTP id e14so1816112qtm.5
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 03:14:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=6kL2CH6UwWqRslXBpITScixS5axdiZInfiwVOoQvCfg=;
 b=EQeuuqg0mHfw/zzI0Q6164x7jn4yDF1HDNlP1eUOH23Egj+rXOeRf37WkTL9H4mCEp
 PctFUYiKVKfry7lVV+VYJtZrmo3bRrlwF2aTWwTIHjg4ZFJWbsd4obYnZ5HFhizHlbQN
 Ftoq8Y2fEM+eXMnGh0EXASbMwOIuvxLFwOdJWN6rfK9+XWnVROhwXTO5mPp+Ibb88tIL
 xO5zL4Ykf2g+0MjykDsveJlCXVrom0Jh4kkPwwST9ll39D35CYzqgQ08ZiNOhOQNe0h9
 coRnMxUNPLTvgIs/ebHIH2Te1Uy+d6FHIn6Sn1ka/Y0WX+3U07fctK7KBJFFDNAxXbH+
 jEhQ==
X-Gm-Message-State: AOAM53047px09ZWZf45kTROiDenhyDgLt21UyV+kv6P9fUVwbqDa3q1N
 azqUVj4RMbs17bkdPGMJwePNfCoTYg25/uGAsf2K4s4yeCazdMyTWzojnt7umZlCBDIIu65cIff
 D8UICKqLKZ2djGQt1L9UU8nMJBrP/jUE=
X-Received: by 2002:a05:620a:b1a:: with SMTP id
 t26mr2281946qkg.353.1599128069995; 
 Thu, 03 Sep 2020 03:14:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxWJ3LwnuL76qNRU25XF4Te9LW9ardYVCq2a3Co+8OAcHgBMyNtXYt4U+0BFJHR6ibFYkRWg/7crUBL3qRpa8M=
X-Received: by 2002:a05:620a:b1a:: with SMTP id
 t26mr2281934qkg.353.1599128069745; 
 Thu, 03 Sep 2020 03:14:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200901142608.24481-1-eperezma@redhat.com>
 <20200901142608.24481-4-eperezma@redhat.com>
 <58783cf8-ef7f-1481-8c5e-acd76a8b752f@redhat.com>
In-Reply-To: <58783cf8-ef7f-1481-8c5e-acd76a8b752f@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 3 Sep 2020 12:13:53 +0200
Message-ID: <CAJaqyWeTruYQGz5CedQW3ogMNO_B77QFRYW-+M_e-pemjvoobg@mail.gmail.com>
Subject: Re: [RFC v8 3/5] memory: Add IOMMU_DEVIOTLB_UNMAP
 IOMMUTLBNotificationType
To: Auger Eric <eric.auger@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eperezma@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eperezma@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 00:24:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

Hi Eric,

On Wed, Sep 2, 2020 at 12:32 PM Auger Eric <eric.auger@redhat.com> wrote:
>
> Hi Eugenio,
>
> On 9/1/20 4:26 PM, Eugenio P=C3=A9rez wrote:
> > Adapt intel and vhost to use this new notification type
> I think you should explain in the commit message what is the benefice to
> introduce this new event type.

Will do, thanks!

> >
> > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > ---
> >  hw/i386/intel_iommu.c | 2 +-
> >  hw/virtio/vhost.c     | 2 +-
> >  include/exec/memory.h | 2 ++
> >  3 files changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> > index 0c4aef5cb5..cdddb089e7 100644
> > --- a/hw/i386/intel_iommu.c
> > +++ b/hw/i386/intel_iommu.c
> > @@ -2468,7 +2468,7 @@ static bool vtd_process_device_iotlb_desc(IntelIO=
MMUState *s,
> >          sz =3D VTD_PAGE_SIZE;
> >      }
> >
> > -    event.type =3D IOMMU_NOTIFIER_UNMAP;
> > +    event.type =3D IOMMU_NOTIFIER_DEVIOTLB;
> If this is used only for device IOTLB cache invalidation, shouldn't this
> be named IOMMU_NOTIFIER_DEVIOTLB_UNMAP to be consistent with the rest?
> >      event.entry.target_as =3D &vtd_dev_as->as;
> >      event.entry.addr_mask =3D sz - 1;
> >      event.entry.iova =3D addr;
> > diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> > index 1a1384e7a6..6ca168b47e 100644
> > --- a/hw/virtio/vhost.c
> > +++ b/hw/virtio/vhost.c
> > @@ -729,7 +729,7 @@ static void vhost_iommu_region_add(MemoryListener *=
listener,
> >      iommu_idx =3D memory_region_iommu_attrs_to_index(iommu_mr,
> >                                                     MEMTXATTRS_UNSPECIF=
IED);
> >      iommu_notifier_init(&iommu->n, vhost_iommu_unmap_notify,
> > -                        IOMMU_NOTIFIER_UNMAP,
> > +                        IOMMU_NOTIFIER_DEVIOTLB,
> >                          section->offset_within_region,
> >                          int128_get64(end),
> >                          iommu_idx);
> > diff --git a/include/exec/memory.h b/include/exec/memory.h
> > index 8a56707169..215e23973d 100644
> > --- a/include/exec/memory.h
> > +++ b/include/exec/memory.h
> > @@ -87,6 +87,8 @@ typedef enum {
> >      IOMMU_NOTIFIER_UNMAP =3D 0x1,
> >      /* Notify entry changes (newly created entries) */
> >      IOMMU_NOTIFIER_MAP =3D 0x2,
> > +    /* Notify changes on device IOTLB entries */
> > +    IOMMU_NOTIFIER_DEVIOTLB =3D 0x04,
> >  } IOMMUNotifierFlag;
> >
> >  #define IOMMU_NOTIFIER_ALL (IOMMU_NOTIFIER_MAP | IOMMU_NOTIFIER_UNMAP)
> shouldn't we rename this one??
> >
>

Agree, but I'm not sure about the right name. IOMMU_NOTIFIER_ALL_ROOT?
IOMMU_NOTIFIER_ALL_REGULAR?

Thanks!

> Thanks
>
> Eric
>


