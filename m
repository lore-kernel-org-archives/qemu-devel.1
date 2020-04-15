Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC68C3815B
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 18:18:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0943D2076D
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 18:18:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MaXb1zAl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0943D2076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOmbt-0003rD-6o
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 14:18:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49858)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1jOmay-0003Rj-Gt
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 14:17:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1jOmaw-00015W-SS
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 14:17:08 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:55588
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1jOmaw-000155-Nz
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 14:17:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586974625;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=hM41k27kUax8oUYBOwLtFTIyVnh6nrdCBGoZTTPr5Q8=;
 b=MaXb1zAl+C4K1TF8jLzUwGV7RA3W+rL4hXmSXS1nsT0eTsAlmCNCm14fIGVHmcoXIvAaML
 Ah+Ecgoj7JXYcevoo73ttJ/UVUD2qiQHUPNgXFQOT62vK2MShj54sTwxALGjMtmw28nEuL
 UiiruSKrkRzhry5T/yIh680XR76X1rY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-343-85Kmu7RYOEK26hASZijjBw-1; Wed, 15 Apr 2020 14:17:03 -0400
X-MC-Unique: 85Kmu7RYOEK26hASZijjBw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C4BBC8018A1;
 Wed, 15 Apr 2020 18:17:02 +0000 (UTC)
Received: from [10.36.114.144] (ovpn-114-144.ams2.redhat.com [10.36.114.144])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D23B3116D7C;
 Wed, 15 Apr 2020 18:16:58 +0000 (UTC)
Subject: Re: [PATCH v19 QEMU 1/4] virtio-balloon: Implement support for page
 poison tracking feature
To: Alexander Duyck <alexander.duyck@gmail.com>
References: <20200410033729.24738.22879.stgit@localhost.localdomain>
 <20200410034129.24738.36022.stgit@localhost.localdomain>
 <b6f97131-89dc-064a-5b87-2bf68437176d@redhat.com>
 <CAKgT0UcgbhKASE3RahdVZR35HHcnMVFGvh=q3qewgL7Yxin27w@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <515a7bd8-8840-6534-e76d-6bc2d4edbb72@redhat.com>
Date: Wed, 15 Apr 2020 20:16:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAKgT0UcgbhKASE3RahdVZR35HHcnMVFGvh=q3qewgL7Yxin27w@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 virtio-dev@lists.oasis-open.org, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

>=20
> The comment above explains the "why". Basically poisoning a page will
> dirty it. So why hint a page as free when that will drop it back into
> the guest and result in it being dirtied again. What you end up with
> is all the pages that were temporarily placed in the balloon are dirty
> after the hinting report is finished at which point you made things
> worse instead of helping to improve them.

Let me think this through. What happens on free page hinting is that

a) we tell the guest that migration starts
b) it allocates pages (alloc_pages()), sends them to us and adds them to
   a list
b) we exclude these pages on migration
c) we tell the guest that migration is over
d) the guest frees all allocated pages

The "issue" with VIRTIO_BALLOON_F_PAGE_POISON is, that in d), the guest
will fill all pages again with a pattern (or zero).

AFAIKs, it's either

1) Not performing free page hinting, migrating pages filled with a
poison value (or zero).
2) Performing free page hinting, not migrating pages filled with a
poison value (or zero), letting only the guest fill them again.

I have the feeling, that 2) is still better for migration, because we
don't migrate useless pages and let the guest reconstruct the content?
(having a poison value of zero might be debatable)

Can you tell me what I am missing? :)

>=20
>>
>>> +        return;
>>> +    }
>>> +
>>>      if (s->free_page_report_cmd_id =3D=3D UINT_MAX) {
>>>          s->free_page_report_cmd_id =3D
>>>                         VIRTIO_BALLOON_FREE_PAGE_REPORT_CMD_ID_MIN;
>>
>> We should rename all "free_page_report" stuff we can to
>> "free_page_hint"/"free_page_hinting" to avoid confusion (e.g., on my
>> side :) ) before adding free page reporting .
>>
>> (looking at the virtio-balloon linux header, it's also confusing but
>> we're stuck with that - maybe we should add better comments)
>=20
> Are we stuck? Couldn't we just convert it to an anonymous union with
> free_page_hint_cmd_id and then use that where needed?

Saw your patch already :)

>=20
>>> @@ -618,12 +627,10 @@ static size_t virtio_balloon_config_size(VirtIOBa=
lloon *s)
>>>      if (s->qemu_4_0_config_size) {
>>>          return sizeof(struct virtio_balloon_config);
>>>      }
>>> -    if (virtio_has_feature(features, VIRTIO_BALLOON_F_PAGE_POISON)) {
>>> +    if (virtio_has_feature(features, VIRTIO_BALLOON_F_PAGE_POISON) ||
>>> +        virtio_has_feature(features, VIRTIO_BALLOON_F_FREE_PAGE_HINT))=
 {
>>>          return sizeof(struct virtio_balloon_config);
>>>      }
>>> -    if (virtio_has_feature(features, VIRTIO_BALLOON_F_FREE_PAGE_HINT))=
 {
>>> -        return offsetof(struct virtio_balloon_config, poison_val);
>>> -    }
>>
>> I am not sure this change is completely sane. Why is that necessary at a=
ll?
>=20
> The poison_val is stored at the end of the structure and is required
> in order to make free page hinting to work. What this change is doing

Required to make it work? In the kernel,

commit 2e991629bcf55a43681aec1ee096eeb03cf81709
Author: Wei Wang <wei.w.wang@intel.com>
Date:   Mon Aug 27 09:32:19 2018 +0800

    virtio-balloon: VIRTIO_BALLOON_F_PAGE_POISON

was merged after

commit 86a559787e6f5cf662c081363f64a20cad654195
Author: Wei Wang <wei.w.wang@intel.com>
Date:   Mon Aug 27 09:32:17 2018 +0800

    virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT

So I assume it's perfectly fine to not have it.

I'd say it's the responsibility of the guest to *not* use
VIRTIO_BALLOON_F_FREE_PAGE_HINT in case it is using page poisoning
without VIRTIO_BALLOON_F_PAGE_POISON. Otherwise it will shoot itself
into the foot.

> is forcing it so that we report the config size as the full size if
> either poisoning or hinting are enabled since the poison val is the
> last member of the config structure.
>=20
> If the question is why bother reducing the size if free page hinting
> is not present then I guess we could simplify this and just report
> report the size of the config for all cases.

I guess the idea is that if you migrate from one QEMU to another, your
config size will not suddenly change (fenced by a feature set that will
not change during migration, observable by a running guest).

My guess would be that we cannot simply change existing configurations
(defined via feature bits) as you do here - see e.g., qemu-4-0-config-size.

[...]

>>>
>>> @@ -706,6 +717,9 @@ static uint64_t virtio_balloon_get_features(VirtIOD=
evice *vdev, uint64_t f,
>>>      VirtIOBalloon *dev =3D VIRTIO_BALLOON(vdev);
>>>      f |=3D dev->host_features;
>>>      virtio_add_feature(&f, VIRTIO_BALLOON_F_STATS_VQ);
>>> +    if (virtio_has_feature(f, VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
>>> +        virtio_add_feature(&f, VIRTIO_BALLOON_F_PAGE_POISON);
>>> +    }
>>>
>>>      return f;
>>>  }
>>> @@ -854,6 +868,8 @@ static void virtio_balloon_device_reset(VirtIODevic=
e *vdev)
>>>          g_free(s->stats_vq_elem);
>>>          s->stats_vq_elem =3D NULL;
>>>      }
>>> +
>>> +    s->poison_val =3D 0;
>>>  }
>>>
>>>  static void virtio_balloon_set_status(VirtIODevice *vdev, uint8_t stat=
us)
>>> @@ -916,6 +932,8 @@ static Property virtio_balloon_properties[] =3D {
>>>                      VIRTIO_BALLOON_F_DEFLATE_ON_OOM, false),
>>>      DEFINE_PROP_BIT("free-page-hint", VirtIOBalloon, host_features,
>>>                      VIRTIO_BALLOON_F_FREE_PAGE_HINT, false),
>>> +    DEFINE_PROP_BIT("x-page-poison", VirtIOBalloon, host_features,
>>> +                    VIRTIO_BALLOON_F_PAGE_POISON, false),
>>
>> Just curious, why an x- feature?
>=20
> It was something I didn't expect the users to enable. It gets enabled
> when either free page hinting or free page reporting is enabled. So if
> you look you will see that in virtio_balloon_get_features the page
> poison feature is added if free page hinting is present. The guest
> will clear the feature bit if poisoning is not enabled in the guest.
> That results in the vdev getting the bit cleared.

The weird thing is that setting it to "false" will still enable it
automatically, depending on other features. Not sure how helpful that is.

I'd prefer to simply always enable it, similar to
VIRTIO_BALLOON_F_STATS_VQ - but it's late and I am confused how
migration with compat machines will work. :)

So, I wonder if we need this feature bit here at all.

--=20
Thanks,

David / dhildenb


