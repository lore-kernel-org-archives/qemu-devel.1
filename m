Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D476C4332E
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 13:55:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B884320663
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 13:54:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eQzA0B6R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B884320663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEvdS-0003GK-Ur
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 09:54:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42004)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1jEvcs-0002pg-Ew
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 09:54:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1jEvcq-0005Yd-E9
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 09:54:21 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:36825)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1jEvcq-0005Wm-5L
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 09:54:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584626059;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=lschYoQmHv2k/3n6CIzr4nP1qjxFMX0gEXDZbsLCFHM=;
 b=eQzA0B6R8CBXjvbragqDgGJUvuxhZrwY8pafA7DMjO53ouRR9LWqgI1H1UUyQzkt9HKibQ
 0wFOBiit9XePz6n1/lXkh02W9dwsd0L611D7OsNv783M02tVktvVD+q5oFmb0vYkf0gp4q
 5iMrkvigcw6WgrBg6nQqpsFNpOtfyls=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-311-kaPOs9n7M8ac8g3YyyCrDw-1; Thu, 19 Mar 2020 09:54:17 -0400
X-MC-Unique: kaPOs9n7M8ac8g3YyyCrDw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6A08B8010C4;
 Thu, 19 Mar 2020 13:54:16 +0000 (UTC)
Received: from [10.36.114.197] (ovpn-114-197.ams2.redhat.com [10.36.114.197])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C82D55D9CD;
 Thu, 19 Mar 2020 13:54:12 +0000 (UTC)
Subject: Re: [PATCH v5 07/18] s390x: protvirt: Inhibit balloon when switching
 to protected mode
To: Halil Pasic <pasic@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>
References: <20200226122038.61481-1-frankja@linux.ibm.com>
 <20200226122038.61481-8-frankja@linux.ibm.com>
 <ed51d194-1b63-1c54-953a-d2031336a90e@redhat.com>
 <58a51f40-21c7-5737-4f4c-568fdd2477fa@linux.ibm.com>
 <20200227132402.67a38047.pasic@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <8622efeb-1a4a-338f-d363-53818b00d195@redhat.com>
Date: Thu, 19 Mar 2020 14:54:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200227132402.67a38047.pasic@linux.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, cohuck@redhat.com,
 qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 27.02.20 13:24, Halil Pasic wrote:
> On Wed, 26 Feb 2020 16:11:03 +0100
> Janosch Frank <frankja@linux.ibm.com> wrote:
>=20
>> On 2/26/20 3:59 PM, David Hildenbrand wrote:
>>> On 26.02.20 13:20, Janosch Frank wrote:
>>>> Ballooning in protected VMs can only be done when the guest shares the
>>>> pages it gives to the host. Hence, until we have a solution for this
>>>> in the guest kernel, we inhibit ballooning when switching into
>>>> protected mode and reverse that once we move out of it.
>>>
>>> I don't understand what you mean here, sorry. zapping a page will mean
>>> that a fresh one will be faulted in when accessed. And AFAIK, that mean=
s
>>> it will be encrypted again when needed.
>>
>> Yes, as soon as the host alters non-shared memory we'll run into
>> integrity issues.
>>
>>
>> I've been talking to Halil after I sent this out and it looks like we'll
>> rather try to automatically enable the IOMMU for all devices when
>> switching into protected mode. He said that if the IOMMU is set the
>> balloon code will do an early exit on feature negotiation.
>>
>=20
> I have a discussion starter RFC for you.
>=20
> --------------------------8<---------------------------------------------=
-
> From: Halil Pasic <pasic@linux.ibm.com>
> Date: Wed, 26 Feb 2020 16:48:21 +0100
> Subject: [RFC PATCH 1/1] virtio-ccw: auto-manage VIRTIO_F_IOMMU_PLATFORM
>=20
> The virtio specification tells that the device is to present
> VIRTIO_F_ACCESS_PLATFORM (a.k.a. VIRTIO_F_IOMMU_PLATFORM) when the
> device "can only access certain memory addresses with said access
> specified and/or granted by the platform". This is the case for a
> protected VM, as the device can access only memory addresses that are in
> pages that are currently shared (only the guest can share/unsare its
> page).
>=20
> No VM however starts out as a protected VM, but some VMs may be
> converted to protected VMs if the guest decides so.
>=20
> Making the end user explicitly manage the VIRTIO_F_ACCESS_PLATFORM via
> the property iommu_on is a minor disaster. If the correctness of the
> paravirtualized virtio devices depends (and thus in a sense the
> correctness of the hypervisor), then the hypervisor should have the last
> word about whether VIRTIO_F_ACCESS_PLATFORM is to be presented or not.
>=20
> Let's manage the VIRTIO_F_ACCESS_PLATFORM virtio feature automatically
> for virtio-ccw devices, so that we set it before we start the protected
> configuration, and unset it when our VM is not protected.
>=20
> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> ---
> NOTES:
> * I wanted to have a discussion starter fast, there are multiple open
> questions.
>=20
> * Doing more than one system_resets() is hackish.  We
> should look into this.
>=20
> * The user interface implications of this patch are also an ugly can of
> worms. Needs to be discussed.
>=20
> * We should consider keeping the original value if !pv and restoring it
> on pv --> !pv, instead of forcing to unset when leaving pv, and actually
> not forcing unset when !pv.
>=20
> * It might make sense to do something like this in virtio core, but I
>   decided start the discussion with a ccw-only change.
>=20
> * Maybe we need a machine option that enables this sort of behavior,
> especially if we decide not to do the conserving/restoring.
>=20
> * Lightly tested.
> ---
>  hw/s390x/s390-virtio-ccw.c |  4 ++--
>  hw/s390x/virtio-ccw.c      | 13 +++++++++++++
>  2 files changed, 15 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index 0f4455d1df..996124f152 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -337,7 +337,7 @@ static void s390_machine_unprotect(S390CcwMachineStat=
e *ms)
>          ms->pv =3D false;
>      }
>      migrate_del_blocker(pv_mig_blocker);
> -    qemu_balloon_inhibit(false);
> +    subsystem_reset();
>  }
> =20
>  static int s390_machine_protect(S390CcwMachineState *ms)
> @@ -346,7 +346,6 @@ static int s390_machine_protect(S390CcwMachineState *=
ms)
>      CPUState *t;
>      int rc;
> =20
> -    qemu_balloon_inhibit(true);
>      if (!pv_mig_blocker) {
>          error_setg(&pv_mig_blocker,
>                     "protected VMs are currently not migrateable.");
> @@ -384,6 +383,7 @@ static int s390_machine_protect(S390CcwMachineState *=
ms)
>      if (rc) {
>          goto out_err;
>      }
> +    subsystem_reset();
>      return rc;
> =20
>  out_err:
> diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
> index 13f57e7b67..48bb54f68e 100644
> --- a/hw/s390x/virtio-ccw.c
> +++ b/hw/s390x/virtio-ccw.c
> @@ -869,12 +869,24 @@ static void virtio_ccw_notify(DeviceState *d, uint1=
6_t vector)
>      }
>  }
> =20
> +static inline void virtio_ccw_pv_enforce_features(VirtIODevice *vdev)
> +{
> +    S390CcwMachineState *ms =3D S390_CCW_MACHINE(qdev_get_machine());
> +
> +    if (ms->pv) {
> +        virtio_add_feature(&vdev->host_features, VIRTIO_F_IOMMU_PLATFORM=
);
> +    } else {
> +        virtio_clear_feature(&vdev->host_features, VIRTIO_F_IOMMU_PLATFO=
RM);
> +    }
> +}
> +
>  static void virtio_ccw_reset(DeviceState *d)
>  {
>      VirtioCcwDevice *dev =3D VIRTIO_CCW_DEVICE(d);
>      VirtIODevice *vdev =3D virtio_bus_get_device(&dev->bus);
>      VirtIOCCWDeviceClass *vdc =3D VIRTIO_CCW_DEVICE_GET_CLASS(dev);
> =20
> +    virtio_ccw_pv_enforce_features(vdev);
>      virtio_ccw_reset_virtio(dev, vdev);
>      if (vdc->parent_reset) {
>          vdc->parent_reset(d);
> @@ -1103,6 +1115,7 @@ static void virtio_ccw_pre_plugged(DeviceState *d, =
Error **errp)
>      if (dev->max_rev >=3D 1) {
>          virtio_add_feature(&vdev->host_features, VIRTIO_F_VERSION_1);
>      }
> +    virtio_ccw_pv_enforce_features(vdev);
>  }
> =20
>  /* This is called by virtio-bus just after the device is plugged. */
>=20
> base-commit: 8665f2475f5999d4c9f33598f1360f0b0797c489
>=20

I asked this question already to Michael (cc) via a different channel,
but hare is it again:

Why does the balloon driver not support VIRTIO_F_IOMMU_PLATFORM? It is
absolutely not clear to me. The introducing commit mentioned that it
"bypasses DMA". I fail to see that.

At least the communication via the SG mechanism should work perfectly
fine with an IOMMU enabled. So I assume it boils down to the pages that
we inflate/deflate not being referenced via IOVA?

I don't think they have to be IOVA addresses. We're neither reading nor
writing these pages. We really speak about "physical memory in the
system" when ballooning. Everything else doesn't really make sense.
There is no need to map/unmap pages we inflate/deflate AFAIKs.

IMHO, we should not try to piggy-back on VIRTIO_F_IOMMU_PLATFORM here,
but instead explicitly disable it either in the hypervisor or the guest.

I hope someone can clarify what the real issue with an IOMMU and
ballooning is, because I'll be having the same "issue" with virtio-mem.

--=20
Thanks,

David / dhildenb


