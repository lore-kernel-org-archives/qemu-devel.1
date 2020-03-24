Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F3ECC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 14:28:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4813720788
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 14:28:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UhDiIdb3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4813720788
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGkXR-0002gX-FS
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 10:28:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57862)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jGkWm-0002Fj-6X
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 10:27:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jGkWl-0005Yd-2Y
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 10:27:36 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:40071)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jGkWk-0005Xe-V5
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 10:27:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585060054;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7xrM0PHZpg7C2Jv96/o7YMBNf3iH+uz2hwFSpoof/+o=;
 b=UhDiIdb3Op9vtDpZVus9YVchzdAiIl5iwKeGlquH499hjU/dwZQuILDymV+2HqOEwYXqBi
 ZajBmOdvK0ZSBZ5i5xq86xMsTaBJI7hzKsF6I2nMDsY1S8qR6V3/AJqC1HmDuW3r8x32aE
 ghMT9VjbOBY7EuvlIAkUoM2eEEOI8wU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-ehrPteA1P9yDlENAlHb1Vw-1; Tue, 24 Mar 2020 10:27:31 -0400
X-MC-Unique: ehrPteA1P9yDlENAlHb1Vw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 637DA13F9;
 Tue, 24 Mar 2020 14:27:30 +0000 (UTC)
Received: from [10.3.113.103] (ovpn-113-103.phx2.redhat.com [10.3.113.103])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B092919C6A;
 Tue, 24 Mar 2020 14:27:29 +0000 (UTC)
Subject: Re: [PATCH] block: make BlockConf.*_size properties 32-bit
To: Roman Kagan <rvkagan@yandex-team.ru>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org
References: <20200211115401.43230-1-rvkagan@yandex-team.ru>
 <c79721ac-357f-6b9f-6d71-53f2cb72ef6e@redhat.com>
 <20200213080151.GA85593@rvkaganb>
 <d869f498-0d6b-1a7f-72b5-bc5f2088b119@redhat.com>
 <20200213135544.GA103102@rvkaganb>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <e38e1ab9-5cdc-87be-299a-c451894cabf8@redhat.com>
Date: Tue, 24 Mar 2020 09:27:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200213135544.GA103102@rvkaganb>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/13/20 7:55 AM, Roman Kagan wrote:
> On Thu, Feb 13, 2020 at 06:47:10AM -0600, Eric Blake wrote:
>> On 2/13/20 2:01 AM, Roman Kagan wrote:
>>> On Wed, Feb 12, 2020 at 03:44:19PM -0600, Eric Blake wrote:
>>>> On 2/11/20 5:54 AM, Roman Kagan wrote:
>>>>> Devices (virtio-blk, scsi, etc.) and the block layer are happy to use
>>>>> 32-bit for logical_block_size, physical_block_size, and min_io_size.
>>>>> However, the properties in BlockConf are defined as uint16_t limiting
>>>>> the values to 32768.
>>>>>
>>>>> This appears unnecessary tight, and we've seen bigger block sizes handy
>>>>> at times.
>>>>
>>>> What larger sizes?  I could see 64k or maybe even 1M block sizes,...
>>>
>>> We played exactly with these two :)
>>>
>>>>>
>>>>> Make them 32 bit instead and lift the limitation.

>>>>> @@ -716,30 +716,32 @@ const PropertyInfo qdev_prop_pci_devfn = {
>>>>>     /* --- blocksize --- */
>>>>> +#define MIN_BLOCK_SIZE 512
>>>>> +#define MAX_BLOCK_SIZE 2147483648
>>>>
>>>> ...but 2G block sizes are going to have tremendous performance problems.
>>>>
>>>> I'm not necessarily opposed to the widening to a 32-bit type, but think you
>>>> need more justification or a smaller number for the max block size,
>>>
>>> I thought any smaller value would just be arbitrary and hard to reason
>>> about, so I went ahead with the max value that fit in the type and could
>>> be made visibile to the guest.
>>
>> You've got bigger problems than what is visible to the guest. block/qcow2.c
>> operates on a cluster at a time; if you are stating that it now requires
>> reading multiple clusters to operate on one, qcow2 will have to do lots of
>> wasteful read-modify-write cycles.
> 
> I'm failing to see how this is supposed to happen.  The guest will issue
> requests bigger than the cluster size; why would it cause RMW?
> 
> Big logical_block_size would cause RMW in the guest if it wants to
> perform smaller writes, but that's up to the user to take this tradeoff,
> isn't it?
> 
>> You really need a strong reason to
>> support a maximum larger than 2M other than just "so the guest can
>> experiment with it".
> 
> Do I get you right that your suggestion is to cap the block size
> property at 2MB?

Yes, for now, I think 2M is a better maximum than 2G or 4G unless you 
have benchmark data to prove that a larger maximum does not cause problems.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


