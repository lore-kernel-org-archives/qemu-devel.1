Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C3FC169F9
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 19:13:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5EAD24671
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 19:13:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VX9WIogg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5EAD24671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4Un4-0001UH-PS
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 14:13:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39080)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1j4UmQ-0000iN-Jg
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 14:13:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1j4UmP-0005aM-8m
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 14:13:06 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29108
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1j4UmP-0005YZ-40
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 14:13:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582139584;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GuNLnJ9qFhRVs1COdJKidJTHUE1NDWnJucQ2st20eUQ=;
 b=VX9WIoggoYzJyjS2dpA7AX1HQLRuuLqi5ZwpZJwllswsiVDupGG2T8BkkkUbpD5vaCmnR3
 lWYqr7alfi9IW0eG5XZ6y4EkDg2zpKHvER0QynVHjcnzeDUTIdyVAfy5ZmZssO8Ah9NhwA
 R2bfDwkNWZXDptUkqFRvQQ3oJ7hESgI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-38-VeCClMwsORG4PtYVul2GfQ-1; Wed, 19 Feb 2020 14:12:58 -0500
X-MC-Unique: VeCClMwsORG4PtYVul2GfQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3FBE01800D42
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2020 19:12:57 +0000 (UTC)
Received: from [10.3.116.180] (ovpn-116-180.phx2.redhat.com [10.3.116.180])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 683025DA76;
 Wed, 19 Feb 2020 19:12:54 +0000 (UTC)
Subject: Re: [PATCH 8/9] virStorageFileGetMetadataRecurse: Allow format
 probing under special circumstances
To: Peter Krempa <pkrempa@redhat.com>
References: <cover.1581959449.git.pkrempa@redhat.com>
 <e6d268fcb8b2e92f2cf0c6b29bab3a9f645a7051.1581959449.git.pkrempa@redhat.com>
 <ef597fda-4b3f-d270-824f-82df391ff223@redhat.com>
 <20200219164034.GF1011498@angien.pipo.sk>
 <fa77907b-1378-b4ed-3a40-fa19fe67f7cf@redhat.com>
 <20200219185740.GA3423556@angien.pipo.sk>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <6d228d74-0b74-14e0-60cf-5c69dad2a65b@redhat.com>
Date: Wed, 19 Feb 2020 13:12:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200219185740.GA3423556@angien.pipo.sk>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: libvir-list@redhat.com, QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

[adding qemu]

On 2/19/20 12:57 PM, Peter Krempa wrote:

>>> Namely a user creates an overlay on top of single raw/qcow2 image and
>>> expects it to work. And it's not just random users, libguestfs and
>>> openstack also neglected to set the backing format.
>>>
>>
>> Yes, and they are getting patched.  Belatedly, but better late than never.
> 
> In that case, qemu-img should also be fixed to forbid 'create' without
> -F. Otherwise it's hard to argue that it's a wrong thing to do.

Allowing -b without -F when the backing file probes as raw is safe, but 
yes, I agree qemu-img create should start a deprecation period of 
warning if -F is omitted, and turn it into a hard error when enough time 
elapses.

> 
>>>>> The price for this is that libvirt will need to keep the image format
>>>>> detector still current and working or replace it by invocation of
>>>>> qemu-img.
>>>>
>>>> Maybe.  Any format that qemu recognizes but libvirt does not risks a case
>>>> where libvirt probes the image as raw but lets qemu re-probe the image and
>>>
>>> That doesn't happen with blockdev. We dont' let qemu probe.
>>
>> We are just shifting the burden on who causes the data corruption when a
>> probe goes wrong - it used to be qemu, now it is libvirt.
>>
>>
>>>>
>>>> I disagree with the logic here.  What we really need is:
>>>>
>>>> If the backing format was not specified, we probe to see what is there. If
>>>> the result of that probe is raw, it is safe to treat the image as raw.  If
>>>> the result is anything else, we must report an error stating that what we
>>>> probed could not be trusted unless the user adds an explicit backing format
>>>> (either confirming that our probe was correct, or with the correct format
>>>> overriding what we mis-probed).
>>>
>>> As noted above, using this logic would be pointless. We are better off
>>> just reporting the error always if we also don't allow qcow2 without
>>> backing file to be used as it was previously used.
>>
>> Then report the error always.
> 
> Well that's what we do right now. It seems kind of tempting to call this
> a right thing but let me summarize the semantics:
> 
> - The "true" detection cases are not problematic
>      - advantage is that existing (arguably suboptimal) configurations
>        will keep working if we detect
> - For the "false" detection cases:
>    - misdetection does not breach security (given that sVirt is used)
>    - data corruption can occur if libvirt detects something else than
>      qemu
>      - this is true both directions (qcow2->raw, raw->qcow2)
> 
> and the tradeoff:
> 
> 1) If we allow detection, we trade compatibility for the (small)
> possibility of having to deal with corruption.
> 
> 2) If we disallow detection we trade regression of behaviour for data
> corruption not being our problem.
> 
> I started this trhead because I feel that the value of 1) is more than
> 2). Especially short term since qemu-img's default behaviour is allowing
> creation of images which would break with libvirt and the fact that
> we've tolerated the wrong behaviour for years.
> 
> Additionally I think that we could just get rid of the copy of the image
> detection copy in libvirt and replace it by invocation of qemu-img. That
> way we could avoid any discrepancies in the detection process in the
> first place.

Now there's an interesting thought.  Since data corruption occurs when 
there is disagreement about which mode to use, getting libvirt out of 
the probing business by deferring all decisions to qemu-img info is a 
smart move - if qemu says an image probes as qcow2 (in an environment 
where probing is safe), then libvirt passing an explicit qcow2 to qemu 
for guest usage (in an environment where probing is not safe) will at 
least see the same guest-visible data.  Less code to maintain in 
libvirt, and no chance for a mismatch between the two projects on which 
format a probe should result in.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


