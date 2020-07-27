Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D82C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 07:38:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AC152072E
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 07:38:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OQ9GL7jc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AC152072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jzxir-0007PQ-Mx
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 03:38:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35906)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jzxiK-0006zZ-9N
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 03:38:24 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:53883
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jzxiI-0005N3-7k
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 03:38:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595835501;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DVlbR1bTvBnmcNaW9GPKIlaNfsUOAvii3cAgvko70G4=;
 b=OQ9GL7jc6aTYqyA429TKl9zOx4JIPj9G+6NujLrt4vsBt2nNYmueCWagyG13n7/R8X6xNG
 sHSXX2uorlHvk1OaZU5FpIea0YTh+iK0CLdHo0Ru0cvoSP5aH3wCzCtgJHCQET1HhuBAYi
 yw7TOaxE0nBe1evzdOvkFOwmUJ3PWWk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-193-Mkj057WgP3alQQVU_9JxOw-1; Mon, 27 Jul 2020 03:38:19 -0400
X-MC-Unique: Mkj057WgP3alQQVU_9JxOw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D1C55800597;
 Mon, 27 Jul 2020 07:38:18 +0000 (UTC)
Received: from [10.72.12.200] (ovpn-12-200.pek2.redhat.com [10.72.12.200])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A7F8090E62;
 Mon, 27 Jul 2020 07:38:13 +0000 (UTC)
Subject: Re: [BUG] vhost-vdpa: qemu-system-s390x crashes with second
 virtio-net-ccw device
To: Cornelia Huck <cohuck@redhat.com>
References: <20200724152718.4e1cbc9e.cohuck@redhat.com>
 <20200724092906-mutt-send-email-mst@kernel.org>
 <20200724165627.70c6dfd6.cohuck@redhat.com>
 <20200724111512-mutt-send-email-mst@kernel.org>
 <20200724173448.18773aec.cohuck@redhat.com>
 <5a0dfa0b-5a1d-e7d2-1785-8cca6ddb9db8@redhat.com>
 <20200727084310.7d29ec6d.cohuck@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <676ce079-adf6-a279-c2ea-68f43146e2ac@redhat.com>
Date: Mon, 27 Jul 2020 15:38:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200727084310.7d29ec6d.cohuck@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 03:37:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Cindy Lu <lulu@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/7/27 下午2:43, Cornelia Huck wrote:
> On Sat, 25 Jul 2020 08:40:07 +0800
> Jason Wang <jasowang@redhat.com> wrote:
>
>> On 2020/7/24 下午11:34, Cornelia Huck wrote:
>>> On Fri, 24 Jul 2020 11:17:57 -0400
>>> "Michael S. Tsirkin"<mst@redhat.com>  wrote:
>>>   
>>>> On Fri, Jul 24, 2020 at 04:56:27PM +0200, Cornelia Huck wrote:
>>>>> On Fri, 24 Jul 2020 09:30:58 -0400
>>>>> "Michael S. Tsirkin"<mst@redhat.com>  wrote:
>>>>>       
>>>>>> On Fri, Jul 24, 2020 at 03:27:18PM +0200, Cornelia Huck wrote:
>>>>>>> When I start qemu with a second virtio-net-ccw device (i.e. adding
>>>>>>> -device virtio-net-ccw in addition to the autogenerated device), I get
>>>>>>> a segfault. gdb points to
>>>>>>>
>>>>>>> #0  0x000055d6ab52681d in virtio_net_get_config (vdev=<optimized out>,
>>>>>>>       config=0x55d6ad9e3f80 "RT") at /home/cohuck/git/qemu/hw/net/virtio-net.c:146
>>>>>>> 146	    if (nc->peer->info->type == NET_CLIENT_DRIVER_VHOST_VDPA) {
>>>>>>>
>>>>>>> (backtrace doesn't go further)
>>>>> The core was incomplete, but running under gdb directly shows that it
>>>>> is just a bog-standard config space access (first for that device).
>>>>>
>>>>> The cause of the crash is that nc->peer is not set... no idea how that
>>>>> can happen, not that familiar with that part of QEMU. (Should the code
>>>>> check, or is that really something that should not happen?)
>>>>>
>>>>> What I don't understand is why it is set correctly for the first,
>>>>> autogenerated virtio-net-ccw device, but not for the second one, and
>>>>> why virtio-net-pci doesn't show these problems. The only difference
>>>>> between -ccw and -pci that comes to my mind here is that config space
>>>>> accesses for ccw are done via an asynchronous operation, so timing
>>>>> might be different.
>>>> Hopefully Jason has an idea. Could you post a full command line
>>>> please? Do you need a working guest to trigger this? Does this trigger
>>>> on an x86 host?
>>> Yes, it does trigger with tcg-on-x86 as well. I've been using
>>>
>>> s390x-softmmu/qemu-system-s390x -M s390-ccw-virtio,accel=tcg -cpu qemu,zpci=on
>>> -m 1024 -nographic -device virtio-scsi-ccw,id=scsi0,devno=fe.0.0001
>>> -drive file=/path/to/image,format=qcow2,if=none,id=drive-scsi0-0-0-0
>>> -device scsi-hd,bus=scsi0.0,channel=0,scsi-id=0,lun=0,drive=drive-scsi0-0-0-0,id=scsi0-0-0-0,bootindex=1
>>> -device virtio-net-ccw
>>>
>>> It seems it needs the guest actually doing something with the nics; I
>>> cannot reproduce the crash if I use the old advent calendar moon buggy
>>> image and just add a virtio-net-ccw device.
>>>
>>> (I don't think it's a problem with my local build, as I see the problem
>>> both on my laptop and on an LPAR.)
>>
>> It looks to me we forget the check the existence of peer.
>>
>> Please try the attached patch to see if it works.
> Thanks, that patch gets my guest up and running again. So, FWIW,
>
> Tested-by: Cornelia Huck <cohuck@redhat.com>
>
> Any idea why this did not hit with virtio-net-pci (or the autogenerated
> virtio-net-ccw device)?


It can be hit with virtio-net-pci as well (just start without peer).

For autogenerated virtio-net-cww, I think the reason is that it has 
already had a peer set.

Thanks


>
>


