Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB225C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 10:58:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4C142067D
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 10:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZCskIWaC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4C142067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqDyV-00038s-2Q
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 06:58:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45400)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jqDxr-0002gu-N5
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 06:58:11 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:55128
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jqDxp-0005YG-M6
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 06:58:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593514688;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tiRSnwlai02SrCbWYOS64wFvhX4MFgahajoCzyjqVp0=;
 b=ZCskIWaCEhExFgI/+pNfeRjwEEXlIWtWobl/B6PJ/u+ei1QiUZrJYJ+ce/y/0UTIq+OGs4
 9UWyk2omtgbdDdPD4ezGh71V2dr9yBYS/a8vZ5q/1iUpOks0TVzo3YwB/iSxcjmjv40GXv
 7UywIuSUVZTuM6ds8hAQnUdPiYbEFis=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-49-HTjl7r_EOxO04mpa26DksQ-1; Tue, 30 Jun 2020 06:58:06 -0400
X-MC-Unique: HTjl7r_EOxO04mpa26DksQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6149C1B18BC1;
 Tue, 30 Jun 2020 10:58:05 +0000 (UTC)
Received: from [10.72.13.159] (ovpn-13-159.pek2.redhat.com [10.72.13.159])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 46A1D7BEB5;
 Tue, 30 Jun 2020 10:57:55 +0000 (UTC)
Subject: Re: [PATCH] net: tap: check if the file descriptor is valid before
 using it
To: Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20200624190009.300069-1-lvivier@redhat.com>
 <20200625084835.GB1009994@redhat.com>
 <541b40c5-ee72-d37d-1c30-664775812d1b@redhat.com>
 <929203d2-20d2-7caf-e487-6bfe5b851974@redhat.com>
 <ea94fa3c-edb5-220e-e0e0-4b7fca7b90e8@redhat.com>
 <b912e24c-8dc5-7022-6ed2-cf10d72ef6e7@redhat.com>
 <20200630092318.GE1370404@redhat.com> <20200630093148.GF1370404@redhat.com>
 <247f4aa8-1846-c5ec-4fe3-1d344979ad52@redhat.com>
 <d24b43e9-5a8c-1cc0-9d1c-4ee01a8cbbca@redhat.com>
 <7a110325-0123-53da-604d-8a9374903782@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <466e86a9-eb74-c147-2c3c-cb546176b944@redhat.com>
Date: Tue, 30 Jun 2020 18:57:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <7a110325-0123-53da-604d-8a9374903782@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 02:00:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Stefan Weil <sw@weilnetz.de>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/6/30 下午6:35, Laurent Vivier wrote:
> On 30/06/2020 12:03, Jason Wang wrote:
>> On 2020/6/30 下午5:45, Laurent Vivier wrote:
>>> On 30/06/2020 11:31, Daniel P. Berrangé wrote:
>>>> On Tue, Jun 30, 2020 at 10:23:18AM +0100, Daniel P. Berrangé wrote:
>>>>> On Tue, Jun 30, 2020 at 05:21:49PM +0800, Jason Wang wrote:
>>>>>> On 2020/6/30 上午3:30, Laurent Vivier wrote:
>>>>>>> On 28/06/2020 08:31, Jason Wang wrote:
>>>>>>>> On 2020/6/25 下午7:56, Laurent Vivier wrote:
>>>>>>>>> On 25/06/2020 10:48, Daniel P. Berrangé wrote:
>>>>>>>>>> On Wed, Jun 24, 2020 at 09:00:09PM +0200, Laurent Vivier wrote:
>>>>>>>>>>> qemu_set_nonblock() checks that the file descriptor can be
>>>>>>>>>>> used and, if
>>>>>>>>>>> not, crashes QEMU. An assert() is used for that. The use of
>>>>>>>>>>> assert() is
>>>>>>>>>>> used to detect programming error and the coredump will allow
>>>>>>>>>>> to debug
>>>>>>>>>>> the problem.
>>>>>>>>>>>
>>>>>>>>>>> But in the case of the tap device, this assert() can be
>>>>>>>>>>> triggered by
>>>>>>>>>>> a misconfiguration by the user. At startup, it's not a real
>>>>>>>>>>> problem,
>>>>>>>>>>> but it
>>>>>>>>>>> can also happen during the hot-plug of a new device, and here
>>>>>>>>>>> it's a
>>>>>>>>>>> problem because we can crash a perfectly healthy system.
>>>>>>>>>> If the user/mgmt app is not correctly passing FDs, then there's
>>>>>>>>>> a whole
>>>>>>>>>> pile of bad stuff that can happen. Checking whether the FD is
>>>>>>>>>> valid is
>>>>>>>>>> only going to catch a small subset. eg consider if fd=9 refers
>>>>>>>>>> to the
>>>>>>>>>> FD that is associated with the root disk QEMU has open. We'll
>>>>>>>>>> fail to
>>>>>>>>>> setup the TAP device and close this FD, breaking the healthy
>>>>>>>>>> system
>>>>>>>>>> again.
>>>>>>>>>>
>>>>>>>>>> I'm not saying we can't check if the FD is valid, but lets be
>>>>>>>>>> clear that
>>>>>>>>>> this is not offering very much protection against a broken mgmt
>>>>>>>>>> apps
>>>>>>>>>> passing bad FDs.
>>>>>>>>>>
>>>>>>>>> I agree with you, but my only goal here is to avoid the crash in
>>>>>>>>> this
>>>>>>>>> particular case.
>>>>>>>>>
>>>>>>>>> The punishment should fit the crime.
>>>>>>>>>
>>>>>>>>> The user can think the netdev_del doesn't close the fd, and he
>>>>>>>>> can try
>>>>>>>>> to reuse it. Sending back an error is better than crashing his
>>>>>>>>> system.
>>>>>>>>> After that, if the system crashes, it will be for the good
>>>>>>>>> reasons, not
>>>>>>>>> because of an assert.
>>>>>>>> Yes. And on top of this we may try to validate the TAP via st_dev
>>>>>>>> through fstat[1].
>>>>>>> I agree, but the problem I have is to know which major(st_dev) we can
>>>>>>> allow to use.
>>>>>>>
>>>>>>> Do we allow only macvtap major number?
>>>>>> Macvtap and tuntap.
>>>>>>
>>>>>>
>>>>>>> How to know the macvtap major number at user level?
>>>>>>> [it is allocated dynamically: do we need to parse /proc/devices?]
>>>>>> I think we can get them through fstat for /dev/net/tun and
>>>>>> /dev/macvtapX.
>>>>> Don't assume QEMU has any permission to access to these device nodes,
>>>>> only the pre-opened FDs it is given by libvirt.
>>>> Actually permissions are the least of the problem - the device nodes
>>>> won't even exist, because QEMU's almost certainly running in a private
>>>> mount namespace with a minimal /dev populated
>>>>
>>> I'm working on a solution using /proc/devices.
>>
>> Similar issue with /dev. There's no guarantee that qemu can access
>> /proc/devices or it may not exist (CONFIG_PROCFS).
> There is a lot of things that will not work without /proc (several tools
> rely on /proc, like ps, top, lsof, mount, ...). Some information are
> only available from /proc, and if /proc is there, I think /proc/devices
> is always readable by everyone. Moreover /proc is already used by qemu
> in several places.
>
> It can also a best effort check.


Right.


>
> The problem with fstat() on /dev files is to guess the /dev/macvtapX as
> X varies (the same with /dev/tapY)..
>
>>> macvtap has its own major number, but tuntap use "misc" (10) major
>>> number.
> Another question: it is possible to use the "fd=" parameter with macvtap
> as macvtap creates a /dev/tapY device,


Yes.


> but how to do that with tuntap
> that does not create a /dev/tapY device?


I think there's no specific reason, it's just because it was wrote like 
that since the first version which is about 20 years ago.

Thanks


>
> Thanks,
> Laurent
>
>


