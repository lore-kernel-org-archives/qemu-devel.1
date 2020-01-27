Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E06B4C32771
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 09:19:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC74B214AF
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 09:19:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EzfXbzVQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC74B214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw0YD-0002Ry-S4
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 04:19:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55440)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1iw0XZ-0001yO-4M
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 04:18:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1iw0XX-0005iC-Ds
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 04:18:40 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:49829
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1iw0XX-0005hy-9z
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 04:18:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580116718;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=oVrXW/xJ8FH8tV0EP95wVtDPHWCSVPuwt84dOsiYoOQ=;
 b=EzfXbzVQfpnTEgc7zmym9TRbNoLZG+u9V6DJkmJfeyY+cNzXk74mw9sR1Y9cCl2b/QTp1h
 X1x1xqbY/qR3j0zqebVHHJaN5UsqLux54KE9oilGUCma0T/TDOoWFljO1KHPnraB8iuhlg
 651dS+omTMzp39aSPNuDS0gqZOZLp3Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-763o-aChO3SDzW_llQYbdw-1; Mon, 27 Jan 2020 04:18:36 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5EC7A800D41
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2020 09:18:35 +0000 (UTC)
Received: from [10.36.118.65] (unknown [10.36.118.65])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AEE9B8E60C;
 Mon, 27 Jan 2020 09:18:26 +0000 (UTC)
Subject: Re: [PATCH 2/2] virtio-balloon: Reject qmp_balloon during hot-unplug
To: Julia Suvorova <jusual@redhat.com>
References: <20200115224025.538368-1-jusual@redhat.com>
 <20200115224025.538368-3-jusual@redhat.com>
 <38fdd88d-1399-effb-b74b-e02b7343f044@redhat.com>
 <CAMDeoFX1eFToYOWmBaVOYHTnNka8Fwruq6PtX7GsAGTuS++u8w@mail.gmail.com>
 <095236a0-ba8c-55c6-f9fc-e2a4a809b274@redhat.com>
 <CAMDeoFWJJbLs_Dtkb2rqXYW-PMA=9Qwy83SnkqS2_-EOaNtiSg@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <0c84dd1a-4bef-1f68-3b42-cba547210e63@redhat.com>
Date: Mon, 27 Jan 2020 10:18:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <CAMDeoFWJJbLs_Dtkb2rqXYW-PMA=9Qwy83SnkqS2_-EOaNtiSg@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: 763o-aChO3SDzW_llQYbdw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 23.01.20 16:46, Julia Suvorova wrote:
> On Thu, Jan 23, 2020 at 3:17 PM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 23.01.20 15:08, Julia Suvorova wrote:
>>> On Thu, Jan 16, 2020 at 1:36 PM David Hildenbrand <david@redhat.com> wrote:
>>>>
>>>> On 15.01.20 23:40, Julia Suvorova wrote:
>>>>> Hot-unplug takes some time due to communication with the guest.
>>>>> Do not change the device while freeing up resources.
>>>>>
>>>>> Signed-off-by: Julia Suvorova <jusual@redhat.com>
>>>>> ---
>>>>>  balloon.c                  | 2 +-
>>>>>  hw/virtio/virtio-balloon.c | 9 ++++++++-
>>>>>  include/sysemu/balloon.h   | 2 +-
>>>>>  3 files changed, 10 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/balloon.c b/balloon.c
>>>>> index f104b42961..998ec53a0f 100644
>>>>> --- a/balloon.c
>>>>> +++ b/balloon.c
>>>>> @@ -119,5 +119,5 @@ void qmp_balloon(int64_t target, Error **errp)
>>>>>      }
>>>>>
>>>>>      trace_balloon_event(balloon_opaque, target);
>>>>> -    balloon_event_fn(balloon_opaque, target);
>>>>> +    balloon_event_fn(balloon_opaque, target, errp);
>>>>>  }
>>>>> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
>>>>> index 57f3b9f22d..0fa4e4454b 100644
>>>>> --- a/hw/virtio/virtio-balloon.c
>>>>> +++ b/hw/virtio/virtio-balloon.c
>>>>> @@ -717,12 +717,19 @@ static void virtio_balloon_stat(void *opaque, BalloonInfo *info)
>>>>>                                               VIRTIO_BALLOON_PFN_SHIFT);
>>>>>  }
>>>>>
>>>>> -static void virtio_balloon_to_target(void *opaque, ram_addr_t target)
>>>>> +static void virtio_balloon_to_target(void *opaque, ram_addr_t target,
>>>>> +                                     Error **errp)
>>>>>  {
>>>>> +    DeviceState *bus_dev = qdev_get_bus_device(DEVICE(opaque));
>>>>>      VirtIOBalloon *dev = VIRTIO_BALLOON(opaque);
>>>>>      VirtIODevice *vdev = VIRTIO_DEVICE(dev);
>>>>>      ram_addr_t vm_ram_size = get_current_ram_size();
>>>>>
>>>>> +    if (bus_dev && bus_dev->pending_deleted_event) {
>>>>> +        error_setg(errp, "Hot-unplug of %s is in progress", vdev->name);
>>>>> +        return;
>>>>> +    }
>>>>> +
>>>>
>>>> How exactly does this help? The guest is free to inflate/deflate
>>>> whenever it wants.
>>>
>>> Guest is aware of hot-unplug start, and virtio driver should not
>>> initiate any operations. This patch just restricts issuing commands
>>> from qmp monitor.
>>
>> Why shouldn't the guest driver inflate/deflate while memory hotplug is
>> going on?
>>
>> Simple balloon compaction in a Linux guest -> deflate/inflate triggered
>> in the hypervisor.
> 
> QEMU crashes if inflate happens after powering-off PCI slot. Guest is
> unable to interact with virtio-balloon device then, driver is
> unloaded. But inflate can still happen if initiated from qmp.

Ah guest can inflate/deflate whenever it wants. What am I missing?

IMHO, the right approach is to discard inflate/deflate requests on these
areas instead.


-- 
Thanks,

David / dhildenb


