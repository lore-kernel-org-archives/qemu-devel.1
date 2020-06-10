Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7781C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 06:23:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A6D520760
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 06:23:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZryYQ9s7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A6D520760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiu97-0003fC-Mo
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 02:23:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48718)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jiu6T-0000FJ-Kx
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 02:20:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52394
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jiu6S-0004hS-Dj
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 02:20:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591770047;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ObTzSO+C08AFl81xTaPKvR8EQzZ+H7U2lYAyGmyHRgo=;
 b=ZryYQ9s7+VfHvkozTzUNDWPDQ1kLKW6BqIRR5gfvu6pSveL+xLgY2BAs4ibgDaGyFeY3QZ
 334SsWtIV7+nJDDX+24tjumsKMWoWbLAbUX2j7O/0L+/O9OYmeJwUmKsBvQ2HnF2vAlPvB
 8mLzpkv3/7qZue3kytaysQvtqYidqGI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-450-jM8nT5-wMZW-w7bYh2HLQg-1; Wed, 10 Jun 2020 02:20:45 -0400
X-MC-Unique: jM8nT5-wMZW-w7bYh2HLQg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 85A4018FE860;
 Wed, 10 Jun 2020 06:20:44 +0000 (UTC)
Received: from [10.72.13.194] (ovpn-13-194.pek2.redhat.com [10.72.13.194])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AAE801001B2B;
 Wed, 10 Jun 2020 06:20:26 +0000 (UTC)
Subject: Re: [PATCH v2 4/7] vhost: involve device backends in feature
 negotiation
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20200609170218.246468-1-stefanha@redhat.com>
 <20200609170218.246468-5-stefanha@redhat.com>
 <20200609135007-mutt-send-email-mst@kernel.org>
 <37ac3fbb-9a9b-9290-abee-a8603c81925c@redhat.com>
 <20200610001156-mutt-send-email-mst@kernel.org>
 <1e503661-0652-b0dc-f900-8cd9aca2ccb8@redhat.com>
 <20200610020908-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <b9a9f28e-5dec-00c0-4473-218f20981027@redhat.com>
Date: Wed, 10 Jun 2020 14:20:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200610020908-mutt-send-email-mst@kernel.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=jasowang@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 23:51:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, Laurent Vivier <lvivier@redhat.com>, cohuck@redhat.com,
 qemu-devel@nongnu.org, Raphael Norwitz <raphael.norwitz@nutanix.com>,
 "Gonglei \(Arei\)" <arei.gonglei@huawei.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Max Reitz <mreitz@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/6/10 下午2:11, Michael S. Tsirkin wrote:
> On Wed, Jun 10, 2020 at 01:53:57PM +0800, Jason Wang wrote:
>> On 2020/6/10 下午12:15, Michael S. Tsirkin wrote:
>>> On Wed, Jun 10, 2020 at 11:21:50AM +0800, Jason Wang wrote:
>>>> On 2020/6/10 上午2:07, Michael S. Tsirkin wrote:
>>>>>> +/*
>>>>>> + * Default vhost_get_features() feature bits for existing device types that do
>>>>>> + * not define their own.
>>>>>> + *
>>>>>> + * This is a workaround for existing device types, do not use this in new vhost
>>>>>> + * device types. Explicitly define a list of feature bits instead.
>>>>>> + *
>>>>>> + * The following feature bits are excluded because libvhost-user device
>>>>>> + * backends did not advertise them for a long time. Therefore we cannot detect
>>>>>> + * their presence. Instead we assume they are always supported by the device
>>>>>> + * backend:
>>>>>> + * VIRTIO_F_NOTIFY_ON_EMPTY
>>>>>> + * VIRTIO_F_ANY_LAYOUT
>>>>>> + * VIRTIO_F_VERSION_1
>>>>>> + * VIRTIO_RING_F_INDIRECT_DESC
>>>>>> + * VIRTIO_RING_F_EVENT_IDX
>>>>> Weird. I remember that it's common for vhost-user not to set
>>>>> VIRTIO_RING_F_INDIRECT_DESC - they have huge queues so
>>>>> don't need it and inline descriptors give them better
>>>>> performance.
>>>>>
>>>>> So what's going on here?
>>>> I guess one reason is to support live migration between vhost-user and
>>>> vhost-net.
>>>>
>>>> Thanks
>>>>
>>> But how can we force-enable features backend doesn't want to enable?
>>
>> We can't and the code just forces qemu to validate
>> VIRTIO_RING_F_INDIRECT_DESC for each vhost backends instead of assuming the
>> support silently.
>>
>> Thanks
> So why does the comment above say:
>
>       Instead we assume they are always supported by the device backend


Sorry for being unclear. I meant, for any new type of vhost devices, 
they should advertise features as what spec said and qemu must validate 
VIRTIO_RING_F_INDIRECT_DESC.

Thanks


>
>
>
>
>>> This may or may not break backends ...
>>> I would rather just be strict and ask backends to fix their feature
>>> bits. See user_feature_bits in hw/net/vhost-net.c which supports
>>> all these features.
>>>


