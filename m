Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B30C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 12:52:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D494820679
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 12:52:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Eq/Tkbor"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D494820679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfjvv-0000fL-50
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 08:52:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55298)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jfjvH-00005V-EH
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 08:52:11 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:36370
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jfjvG-0006cj-2C
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 08:52:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591015928;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D9/AjvjTTd1SK5m34QwcPedo4A4TpGLJqi68dsmuOfI=;
 b=Eq/Tkbor7pSw4GkjJj2uKztjJNbVAbgafEXWNYe6KuaTkcE0PPqkzN2Fte/+xTe0GSQ5wF
 KwMFmvdtTfmYYK+V0GaLPK+7aBiwq4qSCnaXvBnVzXbVRFntEMOQeEyG4XXix3zzvU1p6R
 kOaE76CB9oK87BxM3eNM7+J3UBgyza8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-482-feb2DuEgPsWAmCpZCwQgnQ-1; Mon, 01 Jun 2020 08:52:03 -0400
X-MC-Unique: feb2DuEgPsWAmCpZCwQgnQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A2FFA8730EE;
 Mon,  1 Jun 2020 12:52:02 +0000 (UTC)
Received: from [10.72.12.97] (ovpn-12-97.pek2.redhat.com [10.72.12.97])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EDD805C1D6;
 Mon,  1 Jun 2020 12:51:44 +0000 (UTC)
Subject: Re: [PATCH 2/5] vhost: involve device backends in feature negotiation
To: Stefan Hajnoczi <stefanha@redhat.com>
References: <20200522171726.648279-1-stefanha@redhat.com>
 <20200522171726.648279-3-stefanha@redhat.com>
 <c99670df-8f73-2a13-1e41-0d0a3aac0133@redhat.com>
 <20200529135641.GC367530@stefanha-x1.localdomain>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <2edb0864-723a-c8e5-7d49-a73540f9f069@redhat.com>
Date: Mon, 1 Jun 2020 20:51:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200529135641.GC367530@stefanha-x1.localdomain>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/01 08:52:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 cohuck@redhat.com, qemu-devel@nongnu.org,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 "Gonglei \(Arei\)" <arei.gonglei@huawei.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Fam Zheng <fam@euphon.net>, Max Reitz <mreitz@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/5/29 下午9:56, Stefan Hajnoczi wrote:
> On Fri, May 29, 2020 at 03:04:54PM +0800, Jason Wang wrote:
>> On 2020/5/23 上午1:17, Stefan Hajnoczi wrote:
>>> Many vhost devices in QEMU currently do not involve the device backend
>>> in feature negotiation. This seems fine at first glance for device types
>>> without their own feature bits (virtio-net has many but other device
>>> types have none).
>>>
>>> This overlooks the fact that QEMU's virtqueue implementation and the
>>> device backend's implementation may support different features.  QEMU
>>> must not report features to the guest that the the device backend
>>> doesn't support.
>>>
>>> For example, QEMU supports VIRTIO 1.1 packed virtqueues while many
>>> existing vhost device backends do not. When the user sets packed=on the
>>> device backend breaks. This should have been handled gracefully by
>>> feature negotiation instead.
>>>
>>> Introduce vhost_get_default_features() and update all vhost devices in
>>> QEMU to involve the device backend in feature negotiation.
>>>
>>> This patch fixes the following error:
>>>
>>>     $ x86_64-softmmu/qemu-system-x86_64 \
>>>         -drive if=virtio,file=test.img,format=raw \
>>>         -chardev socket,path=/tmp/vhost-user-blk.sock,id=char0 \
>>>         -device vhost-user-blk-pci,chardev=char0,packed=on \
>>>         -object memory-backend-memfd,size=1G,share=on,id=ram0 \
>>>         -M accel=kvm,memory-backend=ram0
>>>     qemu-system-x86_64: Failed to set msg fds.
>>>     qemu-system-x86_64: vhost VQ 0 ring restore failed: -1: Success (0)
>>
>> It looks to me this could be fixed simply by adding VIRTIO_F_RING_PACKED
>> into user_feature_bits in vhost-user-blk.c.
>>
>> And for the rest, we need require them to call vhost_get_features() with the
>> proper feature bits that needs to be acked by the backend.
> There is a backwards-compatibility problem: we cannot call
> vhost_get_features() with the full set of feature bits that each device
> type supports because existing vhost-user backends don't advertise
> features properly. QEMU disables features not advertised by the
> vhost-user backend.
>
> For example, if we add VIRTIO_RING_F_EVENT_IDX then it will always be
> disabled for existing libvhost-user backends because they don't
> advertise this bit :(.


Agree.


>
> The reason I introduced vhost_get_default_features() is to at least
> salvage VIRTIO_F_IOMMU_PLATFORM and VIRTIO_F_RING_PACKED. These bits can
> be safely negotiated for all devices.
>
> Any new transport/vring VIRTIO feature bits can also be added to
> vhost_get_default_features() safely.
>
> If a vhost-user device wants to use device type-specific feature bits
> then it really needs to call vhost_get_features() directly as you
> suggest. But it's important to check whether existing vhost-user
> backends actually advertise them - because if they don't advertise them
> but rely on them then we'll break existing backends.
>
> Would you prefer a different approach?


I get you now so I think not.

Maybe we need document the expected behavior of VHOST_USER_GET_FEATURES 
e.g which set of features that must be advertised explicitly.

And for the set you mention here, we probably need to add:

VIRTIO_F_ORDER_PLATFORM,
VIRTIO_F_ANY_LAYOUT (not sure if it was too late).

And

VIRTIO_F_IN_ORDER


>
>>> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
>>> index aff98a0ede..f8a144dcd0 100644
>>> --- a/hw/virtio/vhost.c
>>> +++ b/hw/virtio/vhost.c
>>> @@ -48,6 +48,23 @@ static unsigned int used_memslots;
>>>    static QLIST_HEAD(, vhost_dev) vhost_devices =
>>>        QLIST_HEAD_INITIALIZER(vhost_devices);
>>> +/*
>>> + * Feature bits that device backends must explicitly report. Feature bits not
>>> + * listed here maybe set by QEMU without checking with the device backend.
>>> + * Ideally all feature bits would be listed here but existing vhost device
>>> + * implementations do not explicitly report bits like VIRTIO_F_VERSION_1, so we
>>> + * can only assume they are supported.
>>
>> For most backends, we care about the features for datapath. So this is not
>> true at least for networking device, since VIRTIO_F_VERSION_1 have impact on
>> the length of vnet header length.
> The net device is in good shape and doesn't use vhost_default_feature_bits[].
>
> vhost_default_feature_bits[] is for devices that haven't been
> negotiating feature bits properly. The goal is start involving them in
> feature negotiation without breaking existing backends.
>
> Would you like me to rephrase this comment in some way?


That will be better.


>
>>> + *
>>> + * New feature bits added to the VIRTIO spec should usually be included here
>>> + * so that existing vhost device backends that do not support them yet continue
>>> + * to work.
>>
>> It actually depends on the type of backend.
>>
>> Kernel vhost-net does not validate GSO features since qemu can talk directly
>> to TAP and vhost doesn't report those features. But for vhost-user GSO
>> features must be validated by qemu since qemu can't see what is behind
>> vhost-user.
> Maybe the comment should say "New transport/vring feature bits". I'm
> thinking about things like VIRTIO_F_RING_PACKED that are not
> device-specific but require backend support.
>
> The GSO features you mentioned are device-specific. Devices that want to
> let the backend advertise device-specific features cannot use
> vhost_default_feature_bits[].
>
>>> + */
>>> +static const int vhost_default_feature_bits[] = {
>>> +    VIRTIO_F_IOMMU_PLATFORM,
>>> +    VIRTIO_F_RING_PACKED,
>>> +    VHOST_INVALID_FEATURE_BIT
>>> +};
>>> +
>>>    bool vhost_has_free_slot(void)
>>>    {
>>>        unsigned int slots_limit = ~0U;
>>> @@ -1468,6 +1485,11 @@ uint64_t vhost_get_features(struct vhost_dev *hdev, const int *feature_bits,
>>>        return features;
>>>    }
>>> +uint64_t vhost_get_default_features(struct vhost_dev *hdev, uint64_t features)
>>> +{
>>> +    return vhost_get_features(hdev, vhost_default_feature_bits, features);
>>> +}
>>
>> There's probably no need for a new helper, we can do all these inside
>> vhost_get_features().
> Would you prefer:
>
>    extern const int vhost_default_feature_bits[];
>
> And then callers do:
>
>    vhost_get_features(hdev, vhost_default_feature_bits, features);
>
> ?


That's fine or maybe just do features |= vhost_default_feature_bits 
inside vhost_get_features().

Thanks



