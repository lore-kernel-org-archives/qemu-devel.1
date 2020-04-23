Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9BE5C54FD0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 16:17:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64B9620704
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 16:17:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VoKgrLZE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64B9620704
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jReXu-000873-Gt
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 12:17:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35310)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jReVi-00065m-S1
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 12:15:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jReVg-0003W9-Ll
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 12:15:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54853
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jReVg-0003US-7o
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 12:15:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587658530;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z1OkTWa8W1NRHorM6rYgNiwHC1gBxCrPR8uLUg+jWHc=;
 b=VoKgrLZEPSoX12wNZqYGfbfOuo+8j4Aug0A8C4kHMi8MYn9wpPt7sjgjqW7jnWbWrQjXrq
 3k18OSaxkCupDK+aLSG1ioW1bEFFjnhn9kuWgABAqPhflc2OkDNYY2MSrQ3PkSE+Ohdpm+
 Sip1OXf7OnJgVaQ5T7iK7z+DXH0bzXY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-FQFzZ5fTN0GwiS3kfX7vTA-1; Thu, 23 Apr 2020 12:15:17 -0400
X-MC-Unique: FQFzZ5fTN0GwiS3kfX7vTA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2BC84463;
 Thu, 23 Apr 2020 16:15:16 +0000 (UTC)
Received: from [10.10.116.80] (ovpn-116-80.rdu2.redhat.com [10.10.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 315E65C1BD;
 Thu, 23 Apr 2020 16:15:15 +0000 (UTC)
Subject: Re: [PATCH v6 10/10] qcow2: Forward ZERO_WRITE flag for full
 preallocation
To: Kevin Wolf <kwolf@redhat.com>
References: <20200423150127.142609-1-kwolf@redhat.com>
 <20200423150127.142609-11-kwolf@redhat.com>
 <fca340c2-5bee-b287-e43e-28dc679ea372@redhat.com>
 <20200423160410.GF23654@linux.fritz.box>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <61610f75-0e2c-3b59-573e-e2944ae02ad1@redhat.com>
Date: Thu, 23 Apr 2020 11:15:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200423160410.GF23654@linux.fritz.box>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 05:42:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: vsementsov@virtuozzo.com, berto@igalia.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/23/20 11:04 AM, Kevin Wolf wrote:

>> Hmm.  When we get block status, it is very easy to tell that something reads
>> as zero when the qcow2 file has the zero bit set, but when the qcow2 file
>> does not have the zero bit set, we have to then query the format layer
>> whether it reads as zeros (which is expensive enough for some format layers
>> that we no longer report things as reading as zero). I'm worried that
>> optimizing this case could penalize later block status.
> 
> That's just how preallocation works. If you don't want that, you need
> preallocation=off.

Good point. And if I recall, didn't we already have a discussion (or 
even patches) to optimize whether querying the format layer during block 
status was even worth the effort, depending on heuristics of the size of 
the format layer which in turn is based on whether there was 
preallocation?  So not a show-stopper.

> 
>> We already can tell the difference between a cluster that has the zero bit
>> set but is not preallocated, vs. has the zero bit set and is preallocated.
>> Are we really forcing a copy-on-write to a cluster that is marked zero but
>> preallocated?  Is the problem that we don't have a way to distinguish
>> between 'reads as zeroes, allocated, but we don't know state of format
>> layer' and 'reads as zeroes, allocated, and we know format layer reads as
>> zeroes'?
> 
> Basically, yes. If we had this, we could have a type of cluster where
> writing to it still involves a metadata update (to clear the zero flag),
> but never copy-on-write, even for partial writes.
> 
> I'm not sure if this would cover a very relevant case, though.

I also wonder if Berto's subcluster patches might play into this scenario.

>>
>> Hmm - just noticing things: how does this series interplay with the existing
>> bdrv_has_zero_init_truncate?  Should this series automatically handle
>> BDRV_REQ_ZERO_WRITE on a bdrv_co_truncate(PREALLOC_NONE) request for all
>> drivers that report true, even if that driver does not advertise support for
>> the BDRV_REQ_ZERO_WRITE flag?
> 
> Hmm... It feels risky to me.

Or worded differently, is bdrv_has_zero_init_truncate even still 
necessary (when it is documented only to cover the PREALLOC_NONE case), 
or should we get rid of it in favor of using BDRV_REQ_ZERO_WRITE 
everywhere instead?  (Which in turn involves visiting all drivers that 
previously advertised bdrv_has_zero_init_truncate... but I already have 
work in my tree trying to do that as part of preparing to add an 
autoclear bit to qcow2 to make it faster to report when a qcow2 image is 
known all-zero content...)

Looks like I'll be rebasing my work on top of this series.

> 
>>> +        } else {
>>> +            ret = -1;
>>> +        }
>>
>> Here, ret == -1 does not imply whether errp is set - but annoyingly, errp
>> CAN be set if bdrv_co_truncate() failed.
>>
>>> +        if (ret < 0) {
>>> +            ret = bdrv_co_truncate(bs->file, new_file_size, false, prealloc, 0,
>>> +                                   errp);
>>
>> And here, you are passing a possibly-set errp back to bdrv_co_truncate().
>> That is a bug that can abort.  You need to pass NULL to the first
>> bdrv_co_truncate() call or else clear errp prior to trying a fallback to
>> this second bdrv_co_truncate() call.
> 
> Yes, you're right. If nothing else comes up, I'll fix this while
> applying.
> 
> Kevin
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


