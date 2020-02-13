Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D69C2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 12:48:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41F952168B
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 12:48:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BYM+8I1w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41F952168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2Dun-0003NY-FM
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 07:48:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43031)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1j2Dtq-0002vc-Od
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 07:47:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1j2Dto-0002B1-Ab
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 07:47:22 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:45183
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1j2Dto-0002AE-6d
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 07:47:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581598038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SrhUWHbuo2+hzsFW2k27Wzo8kufp8Phw+1/+5XPZwrQ=;
 b=BYM+8I1wCxnDFsDbchkCfUEGfzOjN5flk0VbuZq2CCbSCFSR7lgx15/t2T7biRB6Rvn94/
 U+Cf7G6WfJUBXwuGYiNC13A1H/yDivybhPahUitVf96qaCd7ggZT4bd4AX4hcqBpDee8Au
 9iTvpoYk0ZUT2gYU20Cm8phfaRF6Mww=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-29-wv6dz4wTOUOIbU5GmvWOrg-1; Thu, 13 Feb 2020 07:47:13 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F22AA100550E;
 Thu, 13 Feb 2020 12:47:11 +0000 (UTC)
Received: from [10.3.116.180] (ovpn-116-180.phx2.redhat.com [10.3.116.180])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4268126FCF;
 Thu, 13 Feb 2020 12:47:11 +0000 (UTC)
Subject: Re: [PATCH] block: make BlockConf.*_size properties 32-bit
To: Roman Kagan <rvkagan@yandex-team.ru>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org
References: <20200211115401.43230-1-rvkagan@yandex-team.ru>
 <c79721ac-357f-6b9f-6d71-53f2cb72ef6e@redhat.com>
 <20200213080151.GA85593@rvkaganb>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <d869f498-0d6b-1a7f-72b5-bc5f2088b119@redhat.com>
Date: Thu, 13 Feb 2020 06:47:10 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200213080151.GA85593@rvkaganb>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: wv6dz4wTOUOIbU5GmvWOrg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/13/20 2:01 AM, Roman Kagan wrote:
> On Wed, Feb 12, 2020 at 03:44:19PM -0600, Eric Blake wrote:
>> On 2/11/20 5:54 AM, Roman Kagan wrote:
>>> Devices (virtio-blk, scsi, etc.) and the block layer are happy to use
>>> 32-bit for logical_block_size, physical_block_size, and min_io_size.
>>> However, the properties in BlockConf are defined as uint16_t limiting
>>> the values to 32768.
>>>
>>> This appears unnecessary tight, and we've seen bigger block sizes handy
>>> at times.
>>
>> What larger sizes?  I could see 64k or maybe even 1M block sizes,...
> 
> We played exactly with these two :)
> 
>>>
>>> Make them 32 bit instead and lift the limitation.
>>>
>>> Signed-off-by: Roman Kagan <rvkagan@yandex-team.ru>
>>> ---
>>>    hw/core/qdev-properties.c    | 21 ++++++++++++---------
>>>    include/hw/block/block.h     |  8 ++++----
>>>    include/hw/qdev-properties.h |  2 +-
>>>    3 files changed, 17 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
>>> index 7f93bfeb88..5f84e4a3b8 100644
>>> --- a/hw/core/qdev-properties.c
>>> +++ b/hw/core/qdev-properties.c
>>> @@ -716,30 +716,32 @@ const PropertyInfo qdev_prop_pci_devfn = {
>>>    /* --- blocksize --- */
>>> +#define MIN_BLOCK_SIZE 512
>>> +#define MAX_BLOCK_SIZE 2147483648
>>
>> ...but 2G block sizes are going to have tremendous performance problems.
>>
>> I'm not necessarily opposed to the widening to a 32-bit type, but think you
>> need more justification or a smaller number for the max block size,
> 
> I thought any smaller value would just be arbitrary and hard to reason
> about, so I went ahead with the max value that fit in the type and could
> be made visibile to the guest.

You've got bigger problems than what is visible to the guest. 
block/qcow2.c operates on a cluster at a time; if you are stating that 
it now requires reading multiple clusters to operate on one, qcow2 will 
have to do lots of wasteful read-modify-write cycles.  You really need a 
strong reason to support a maximum larger than 2M other than just "so 
the guest can experiment with it".

> 
> Besides this is a property that is set explicitly, so I don't see a
> problem leaving this up to the user.
> 
>> particularly since qcow2 refuses to use cluster sizes larger than 2M and it
>> makes no sense to allow a block size larger than a cluster size.
> 
> This still doesn't contradict passing a bigger value to the guest, for
> experimenting if nothing else.
> 
> Thanks,
> Roman.
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


