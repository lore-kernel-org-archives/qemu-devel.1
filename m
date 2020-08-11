Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 607AFC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 17:03:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 130612076B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 17:03:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TVn7cboY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 130612076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5XgF-0004p5-6Q
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 13:03:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48440)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1k5XfX-0004OI-Bi
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 13:02:35 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:24824
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1k5XfV-0004si-4f
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 13:02:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597165351;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+hZTyLJkrEYFqIVAG40xdHZbH7z9NrJCNt+IihoLhxg=;
 b=TVn7cboYiCuUPbkp+Jx2N+jDQgTpPM5/yvt6YGPMzDP/C3FMwI+krpjU60FefnE9sbk4ck
 MCL+xmBdW6GiaFaWq+Z4kfEIYEdPydkELLtvgoKUCSZ/GRT2Qos2+UR8yNVjbUpY54mzi4
 qYmLRn06I0KcFA1yWmsGod1+ZM27oNw=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-jJhBAX7jM0y49RRQOA89DQ-1; Tue, 11 Aug 2020 13:02:30 -0400
X-MC-Unique: jJhBAX7jM0y49RRQOA89DQ-1
Received: by mail-qt1-f199.google.com with SMTP id n12so10241984qtr.6
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2020 10:02:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=+hZTyLJkrEYFqIVAG40xdHZbH7z9NrJCNt+IihoLhxg=;
 b=frwAV/BBXi7K0U99fOW/Z9HvRJOgq7RBpAfTJpQ+mHWqaI5937usy8SqUFpeFwhFMP
 Oom4IgYc0dLJAwhAc+QsWD+VvrjOuSEYDy+ksBGx0JtuigTNeHy+WNG1IVbOjiP/4TFV
 82ADpnoZxfz0Pf9AfKQCny2pLCffBPwgD89Jjdi/D/FekZWCOpO82Gpx8mKMUZu+XTAr
 sEjHxFSUWdH/0mQBnWcl6wG8EBKzYrMm9+HDDRZnVB0WPF4pOxImvsznHxomDJL3vZBt
 dqKb017ks8GKE7OvWx8QS9lrxis+rQRmerex1vc7Oo+bQC1t8onsV3tzZu+EoPLaou/l
 ulRw==
X-Gm-Message-State: AOAM531B0hz8gjO6kK5puawyVKsojqgpwwlqbR0ElffNPKHW1yR74AV5
 TkOk9Y9mo3ZQXQNd5CvfjDtn8Rg3iN0ERs01eT5j2cpDLFn6frhJXviPelRRV4XAmR/WfKW+PBE
 ixvgSTxrqF/xxo64vNswrzHhRqKr/WLo=
X-Received: by 2002:ac8:72cc:: with SMTP id o12mr2047789qtp.27.1597165349440; 
 Tue, 11 Aug 2020 10:02:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxIVFmKLLRciiUUj0PNk7Za7poMaEaPwXuZ6xpeQIAyr+8i+WTHfkCPGza4IE9DWbqGj5/Xk++kjr8ZF5h/JUc=
X-Received: by 2002:ac8:72cc:: with SMTP id o12mr2047753qtp.27.1597165349053; 
 Tue, 11 Aug 2020 10:02:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200626064122.9252-1-eperezma@redhat.com>
 <20200626064122.9252-2-eperezma@redhat.com>
 <20200626212917.GD175520@xz-x1>
In-Reply-To: <20200626212917.GD175520@xz-x1>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 11 Aug 2020 19:01:52 +0200
Message-ID: <CAJaqyWf5=fwwcgZgOdipt54mq=vPZkQLGp9xWRG7Tnw-E9xjCA@mail.gmail.com>
Subject: Re: [RFC v2 1/1] memory: Delete assertion in
 memory_region_unregister_iommu_notifier
To: Peter Xu <peterx@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eperezma@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/11 10:41:43
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
 Juan Quintela <quintela@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Eric Auger <eric.auger@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jun 26, 2020 at 11:29 PM Peter Xu <peterx@redhat.com> wrote:
>
> Hi, Eugenio,
>
> (CCing Eric, Yan and Michael too)
>
> On Fri, Jun 26, 2020 at 08:41:22AM +0200, Eugenio P=C3=A9rez wrote:
> > diff --git a/memory.c b/memory.c
> > index 2f15a4b250..7f789710d2 100644
> > --- a/memory.c
> > +++ b/memory.c
> > @@ -1915,8 +1915,6 @@ void memory_region_notify_one(IOMMUNotifier *noti=
fier,
> >          return;
> >      }
> >
> > -    assert(entry->iova >=3D notifier->start && entry_end <=3D notifier=
->end);
>
> I can understand removing the assertion should solve the issue, however i=
mho
> the major issue is not about this single assertion but the whole addr_mas=
k
> issue behind with virtio...
>
> For normal IOTLB invalidations, we were trying our best to always make
> IOMMUTLBEntry contain a valid addr_mask to be 2**N-1.  E.g., that's what =
we're
> doing with the loop in vtd_address_space_unmap().
>
> But this is not the first time that we may want to break this assumption =
for
> virtio so that we make the IOTLB a tuple of (start, len), then that len c=
an be
> not a address mask any more.  That seems to be more efficient for things =
like
> vhost because iotlbs there are not page based, so it'll be inefficient if=
 we
> always guarantee the addr_mask because it'll be quite a lot more roundtri=
ps of
> the same range of invalidation.  Here we've encountered another issue of
> triggering the assertion with virtio-net, but only with the old RHEL7 gue=
st.
>
> I'm thinking whether we can make the IOTLB invalidation configurable by
> specifying whether the backend of the notifier can handle arbitary addres=
s
> range in some way.  So we still have the guaranteed addr_masks by default
> (since I still don't think totally break the addr_mask restriction is wis=
e...),
> however we can allow the special backends to take adavantage of using arb=
itary
> (start, len) ranges for reasons like performance.
>
> To do that, a quick idea is to introduce a flag IOMMU_NOTIFIER_ARBITRARY_=
MASK
> to IOMMUNotifierFlag, to declare that the iommu notifier (and its backend=
) can
> take arbitrary address mask, then it can be any value and finally becomes=
 a
> length rather than an addr_mask.  Then for every iommu notify() we can di=
rectly
> deliver whatever we've got from the upper layer to this notifier.  With t=
he new
> flag, vhost can do iommu_notifier_init() with UNMAP|ARBITRARY_MASK so it
> declares this capability.  Then no matter for device iotlb or normal iotl=
b, we
> skip the complicated procedure to split a big range into small ranges tha=
t are
> with strict addr_mask, but directly deliver the message to the iommu noti=
fier.
> E.g., we can skip the loop in vtd_address_space_unmap() if the notifier i=
s with
> ARBITRARY flag set.
>
> Then, the assert() is not accurate either, and may become something like:
>
> diff --git a/memory.c b/memory.c
> index 2f15a4b250..99d0492509 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -1906,6 +1906,7 @@ void memory_region_notify_one(IOMMUNotifier *notifi=
er,
>  {
>      IOMMUNotifierFlag request_flags;
>      hwaddr entry_end =3D entry->iova + entry->addr_mask;
> +    IOMMUTLBEntry tmp =3D *entry;
>
>      /*
>       * Skip the notification if the notification does not overlap
> @@ -1915,7 +1916,13 @@ void memory_region_notify_one(IOMMUNotifier *notif=
ier,
>          return;
>      }
>
> -    assert(entry->iova >=3D notifier->start && entry_end <=3D notifier->=
end);
> +    if (notifier->notifier_flags & IOMMU_NOTIFIER_ARBITRARY_MASK) {
> +        tmp.iova =3D MAX(tmp.iova, notifier->start);

Hi!

If I modify the tmp.iova, the guest will complain (in dmesg):
[  154.426828] DMAR: DRHD: handling fault status reg 2
[  154.427700] DMAR: [DMA Read] Request device [01:00.0] fault addr
ffff90d53fada000 [fault reason 04] Access beyond MGAW

And will not forward packets anymore on that interface. Guests are
totally ok if I only modify addr_mask.

Still investigating the issue.

Thanks!


> +        tmp.addr_mask =3D MIN(tmp.addr_mask, notifier->end);
> +        assert(tmp.iova <=3D tmp.addr_mask);
> +    } else {
> +        assert(entry->iova >=3D notifier->start && entry_end <=3D notifi=
er->end);
> +    }
>
>      if (entry->perm & IOMMU_RW) {
>          request_flags =3D IOMMU_NOTIFIER_MAP;
> @@ -1924,7 +1931,7 @@ void memory_region_notify_one(IOMMUNotifier *notifi=
er,
>      }
>
>      if (notifier->notifier_flags & request_flags) {
> -        notifier->notify(notifier, entry);
> +        notifier->notify(notifier, &tmp);
>      }
>  }
>
> Then we can keep the assert() for e.g. vfio, however vhost can skip it an=
d even
> get some further performance boosts..  Does that make sense?
>
> Thanks,
>
> --
> Peter Xu
>


