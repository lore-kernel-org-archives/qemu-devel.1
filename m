Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC06BC10F14
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 16:11:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8361121835
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 16:11:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8361121835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIb1y-0005a3-Jz
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 12:11:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35742)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iIaY8-0005c2-P1
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 11:40:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iIaY5-00023v-3D
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 11:40:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49320)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1iIaXz-0001yH-LM; Thu, 10 Oct 2019 11:40:11 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EB8B180F7C;
 Thu, 10 Oct 2019 15:40:08 +0000 (UTC)
Received: from [10.3.116.168] (ovpn-116-168.phx2.redhat.com [10.3.116.168])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B71B2194BB;
 Thu, 10 Oct 2019 15:39:50 +0000 (UTC)
Subject: Re: [PATCH] qcow2-bitmaps: fix qcow2_can_store_new_dirty_bitmap
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20190607184802.100945-1-vsementsov@virtuozzo.com>
 <f218e52c-8b0b-07cc-519f-23e9612b2320@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <6fde60fa-a4fb-eaf8-3830-5d358afb121f@redhat.com>
Date: Thu, 10 Oct 2019 10:39:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <f218e52c-8b0b-07cc-519f-23e9612b2320@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Thu, 10 Oct 2019 15:40:09 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/7/19 1:53 PM, Vladimir Sementsov-Ogievskiy wrote:
> 07.06.2019 21:48, Vladimir Sementsov-Ogievskiy wrote:
>> qcow2_can_store_new_dirty_bitmap works wrong, as it considers only
>> bitmaps already stored in the qcow2 image and ignores persistent
>> BdrvDirtyBitmap objects.
>>
>> So, let's instead count persistent BdrvDirtyBitmaps. We load all qcow2
>> bitmaps on open, so there should not be any bitmap in the image for
>> which we don't have BdrvDirtyBitmaps version. If it is - it's a kind of
>> corruption, and no reason to check for corruptions here (open() and
>> close() are better places for it).
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>
>> Hi!
>>
>> Patch is better than discussing I thing, so here is my counter-suggestion for
>> "[PATCH 0/5] block/dirty-bitmap: check number and size constraints against queued bitmaps"
>> by John.
>>
>> It's of course needs some additional refactoring, as first assert shows bad design,
>> I just wrote it in such manner to make minimum changes to fix the bug.
>>

>> +    assert(!bdrv_find_dirty_bitmap(bs, name));
> 
> exactly bad, this should be checked in qmp_block_dirty_bitmap_add(), before checks around
> persistence. and aio_context_acquire may be dropped..
> 
> But anyway, idea is clear I think, consider it as RFC patch

Are you planning to post a v2, as this affects at least 
https://bugzilla.redhat.com/show_bug.cgi?id=1712636

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org

