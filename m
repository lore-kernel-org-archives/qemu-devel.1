Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9614EC4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 19:39:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DA22222C2
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 19:39:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DA22222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDZc7-0002y0-MV
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 15:39:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53606)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iDZRq-0002Ua-Ft
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 15:29:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iDZRp-0005wx-Aa
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 15:29:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53796)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1iDZRm-0005rm-BH; Thu, 26 Sep 2019 15:29:02 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D63993B738;
 Thu, 26 Sep 2019 19:28:59 +0000 (UTC)
Received: from [10.3.116.249] (ovpn-116-249.phx2.redhat.com [10.3.116.249])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7BC8F1001B12;
 Thu, 26 Sep 2019 19:28:54 +0000 (UTC)
Subject: Re: [Qemu-devel] [PATCH 4/4] block/dirty-bitmap: refactor
 bdrv_dirty_bitmap_next
To: John Snow <jsnow@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20190916141911.5255-1-vsementsov@virtuozzo.com>
 <20190916141911.5255-5-vsementsov@virtuozzo.com>
 <b099f898-1d0f-d9b3-f8fb-c354f5a3fc50@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <0386d7d0-1bda-054b-89d6-6b179d37b46d@redhat.com>
Date: Thu, 26 Sep 2019 14:28:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <b099f898-1d0f-d9b3-f8fb-c354f5a3fc50@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Thu, 26 Sep 2019 19:28:59 +0000 (UTC)
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
Cc: fam@euphon.net, kwolf@redhat.com, quintela@redhat.com,
 qemu-devel@nongnu.org, armbru@redhat.com, stefanha@redhat.com, den@openvz.org,
 mreitz@redhat.com, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/26/19 1:54 PM, John Snow wrote:
> 
> 
> On 9/16/19 10:19 AM, Vladimir Sementsov-Ogievskiy wrote:
>> bdrv_dirty_bitmap_next is always used in same pattern. So, split it
>> into _next and _first, instead of combining two functions into one and
>> add FOR_EACH_DIRTY_BITMAP macro.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   include/block/dirty-bitmap.h   |  9 +++++++--
>>   block.c                        |  4 +---
>>   block/dirty-bitmap.c           | 11 +++++++----
>>   block/qcow2-bitmap.c           |  8 ++------
>>   migration/block-dirty-bitmap.c |  4 +---
>>   5 files changed, 18 insertions(+), 18 deletions(-)
> 
> I'm not as sure that this is an improvement.
> 

>>   bool bdrv_has_changed_persistent_bitmaps(BlockDriverState *bs);
>> -BdrvDirtyBitmap *bdrv_dirty_bitmap_next(BlockDriverState *bs,
>> -                                        BdrvDirtyBitmap *bitmap);
>> +
>> +BdrvDirtyBitmap *bdrv_dirty_bitmap_first(BlockDriverState *bs);
>> +BdrvDirtyBitmap *bdrv_dirty_bitmap_next(BdrvDirtyBitmap *bitmap);
>> +#define FOR_EACH_DIRTY_BITMAP(bs, bitmap) \
>> +for (bitmap = bdrv_dirty_bitmap_first(bs); bitmap; \
>> +     bitmap = bdrv_dirty_bitmap_next(bitmap))
>> +

If you want the macro, you can do that without splitting the function in 
two:

#define FOR_EACH_DIRTY_BITMAP(bs, bitmap) \
for (bitmap = bdrv_dirty_bitmap_next(bs, NULL); bitmap; \
      bitmap = bdrv_dirty_bitmap_next(bs, bitmap))


> 
> Well, I guess explicit first and next functions is harder to mess up,
> anyway.
> 
> Reviewed-by: John Snow <jsnow@redhat.com>
> 
> (Any other thoughts?)

I don't mind the macro as much (since we already use iteration macros 
for QTAILQ_FOREACH and such throughout the codebase, and since it 
somewhat isolates you from the calling conventions of passing NULL to 
prime the iteration), but introducing the macro does not imply that we 
need two functions.  So I think this is, to some extent, a question of 
the maintainer's sense of aesthetics, and not an actual problem in the code.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org

