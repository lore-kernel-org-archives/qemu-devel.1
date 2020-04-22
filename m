Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C22BAC55185
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 17:44:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F8982075A
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 17:44:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="FRggf3ot"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F8982075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRJQT-000490-N0
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 13:44:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39578)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1jRJOn-0002r9-PU
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 13:43:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1jRJOm-00062y-Qc
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 13:43:01 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:55412)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jRJOl-0005q5-Iz; Wed, 22 Apr 2020 13:43:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=iVAsdtW/tvBY6Y6zEZQNgE7cPAXNM3ld/5PqfI6TMDs=; 
 b=FRggf3otWoJprq9RKuqCXbd4GjFqfo48oHJur2ZZIYtvQwJp8PLIL0bRFpCqvI3PpKiDdeAm1hQ2jOvmHpDHFj2vaDUMopObWp9NZRBmF2q5kvw9Vwyo3wZyYxvQC0EgDkFpe6PddaHHULj4TbaircY96ngS0t+AsEWED4guoKoex2IaghhQwRhpRlEG0A1yiTbTOZGbXuFrx6pTmlTJ7M/593yrpDwb6mefDyCyD2V4WtpqRZqKvZmWjY8Gc0CXWuUJznFEZNEAioyHbqjYhRd/evKhfH8TpjyUWgYxupReyDbI8bS3VFSpqB2tiaRgtcAZlFOcp/eWgqPpSQsZUA==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1jRJOf-0003ZE-53; Wed, 22 Apr 2020 19:42:53 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1jRJOe-0002Yt-Rm; Wed, 22 Apr 2020 19:42:52 +0200
From: Alberto Garcia <berto@igalia.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v4 20/30] qcow2: Add subcluster support to
 discard_in_l2_slice()
In-Reply-To: <2f284a39-64b8-ca64-4465-12f9f0f8f7e5@virtuozzo.com>
References: <cover.1584468723.git.berto@igalia.com>
 <99b45e3beb4a38b17eb50fcde1e09cdefdb99724.1584468723.git.berto@igalia.com>
 <2f284a39-64b8-ca64-4465-12f9f0f8f7e5@virtuozzo.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Wed, 22 Apr 2020 19:42:52 +0200
Message-ID: <w51o8rjs9gj.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 13:42:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic] [fuzzy]
X-Received-From: 178.60.130.6
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
Cc: Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 "Denis V . Lunev" <den@openvz.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed 22 Apr 2020 01:35:25 PM CEST, Vladimir Sementsov-Ogievskiy wrote:
> 17.03.2020 21:16, Alberto Garcia wrote:
>> Two changes are needed in this function:
>> 
>> 1) A full discard deallocates a cluster so we can skip the operation if
>>     it is already unallocated. With extended L2 entries however if any
>>     of the subclusters has the 'all zeroes' bit set then we have to
>>     clear it.
>> 
>> 2) Setting the QCOW_OFLAG_ZERO bit of the L2 entry is forbidden if an
>>     image has extended L2 entries. Instead, the individual 'all zeroes'
>>     bits must be used.
>> 
>> Signed-off-by: Alberto Garcia <berto@igalia.com>
>> ---
>>   block/qcow2-cluster.c | 18 +++++++++++++++---
>>   1 file changed, 15 insertions(+), 3 deletions(-)
>> 
>> diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
>> index 746006a117..824c710760 100644
>> --- a/block/qcow2-cluster.c
>> +++ b/block/qcow2-cluster.c
>> @@ -1790,12 +1790,20 @@ static int discard_in_l2_slice(BlockDriverState *bs, uint64_t offset,
>>            * TODO We might want to use bdrv_block_status(bs) here, but we're
>>            * holding s->lock, so that doesn't work today.
>>            *
>> -         * If full_discard is true, the sector should not read back as zeroes,
>> +         * If full_discard is true, the cluster should not read back as zeroes,
>>            * but rather fall through to the backing file.
>>            */
>>           switch (qcow2_get_cluster_type(bs, old_l2_entry)) {
>>           case QCOW2_CLUSTER_UNALLOCATED:
>> -            if (full_discard || !bs->backing) {
>> +            if (full_discard) {
>> +                /* If the image has extended L2 entries we can only
>> +                 * skip this operation if the L2 bitmap is zero. */
>> +                uint64_t bitmap = has_subclusters(s) ?
>> +                    get_l2_bitmap(s, l2_slice, l2_index + i) : 0;
>> +                if (bitmap == 0) {
>> +                    continue;
>> +                }
>> +            } else if (!bs->backing) {
>>                   continue;
>>               }
>
> Hmm, so you do continue if full_discard is false AND bitmap != 0 &
> !bs->backing,

> but you do not continue if full_discard is true AND bitmap != 0 &
> !bs->backing (as you will not go to "else") branch.

1. If full_discard is true it means that the entry and the bitmap should
   always be set to 0, regardless of whether there's a backing file or
   any other consideration.

   This is used e.g when shrinking an image, or by qcow2_make_empty().

   We can only skip this operation if both the entry and the bitmap are
   already 0 (the former we know because of QCOW2_CLUSTER_UNALLOCATED).

2. If full_discard is false it means that we must ensure that the
   cluster reads back as zeroes, but there's no need to clear the bitmap
   (in fact we must set QCOW_OFLAG_ZERO or QCOW_L2_BITMAP_ALL_ZEROES
   depending on the type of image).

   We can skip this operation if there's no backing file and the cluster
   is already unallocated (because then we know that it already reads as
   zeroes).

   One optimization would be to skip the operation also if the image has
   subclusters and the bitmap is QCOW_L2_BITMAP_ALL_ZEROES, I can do
   that for the next version.

> In case QCOW2_CLUSTER_ZERO_PLAIN, worth assert !has_subclusters(s) or
> mark image corrupted ?

I think that should be handled directly in qcow2_get_cluster_type().

There's currently an inconsistency now that I think of it: if an image
has subclusters and QCOW_OFLAG_ZERO set then qcow2_get_cluster_type()
returns QCOW2_CLUSTER_ZERO_* but qcow2_get_subcluster_type() returns
QCOW2_SUBCLUSTER_INVALID.

Two alternatives:

  - We add QCOW2_CLUSTER_INVALID so we get an error in both
    cases. Problem: any function that calls qcow2_get_cluster_type()
    should be modified to handle that.

  - We ignore QCOW_OFLAG_ZERO. Simpler, and it would allow us to use
    that bit in the future if we wanted.

Berto

