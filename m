Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA50C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 18:21:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEB5620736
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 18:21:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PYi8JWDI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEB5620736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYD3X-0001Ml-Nb
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 14:21:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41626)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jYCya-0004te-7b
 for qemu-devel@nongnu.org; Mon, 11 May 2020 14:16:28 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:26473
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jYCyX-0006eh-NO
 for qemu-devel@nongnu.org; Mon, 11 May 2020 14:16:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589220983;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KfC1cJocgshHEQAVE0zfVFHK/KNW0mNUW+CwwuDywdM=;
 b=PYi8JWDIkUTzZsEngoP9FaQefLE46FbNugNtq4PmY/9b8ESKwErvMjGF3mQhd/bjh3f41i
 9MkHoDs0vSrkUjutovHpij9joX7Zf5oJUbr8gQm3+zcm3AHYs7QzJPFapWJOTkuqTKuyB5
 XUuZKximXJ5EPqjdorXqAgsuT+Hibj0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-i0uRLES3OP6RNU1se6-HUA-1; Mon, 11 May 2020 14:16:19 -0400
X-MC-Unique: i0uRLES3OP6RNU1se6-HUA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1654A18FE866;
 Mon, 11 May 2020 18:16:18 +0000 (UTC)
Received: from [10.3.116.145] (ovpn-116-145.phx2.redhat.com [10.3.116.145])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 926BD7D8DE;
 Mon, 11 May 2020 18:16:17 +0000 (UTC)
Subject: Re: [PATCH v3 3/9] block: Make it easier to learn which BDS support
 bitmaps
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
References: <20200508180340.675712-1-eblake@redhat.com>
 <20200508180340.675712-4-eblake@redhat.com>
 <aba3eddd-1201-9182-6011-9fe0bbca1b76@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <b6c61cc5-8a7c-ef2c-76f1-def580827e14@redhat.com>
Date: Mon, 11 May 2020 13:16:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <aba3eddd-1201-9182-6011-9fe0bbca1b76@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 01:43:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/11/20 4:21 AM, Max Reitz wrote:
> On 08.05.20 20:03, Eric Blake wrote:
>> Upcoming patches will enhance bitmap support in qemu-img, but in doing
>> so, it turns out to be nice to suppress output when bitmaps make no
>> sense (such as on a qcow2 v2 image).  Add a hook to make this easier
>> to query.
>>
>> In the future, when we improve the ability to look up bitmaps through
>> a filter, we will probably also want to teach the block layer to
>> automatically let filters pass this request on through.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---
>>   block/qcow2.h                | 1 +
>>   include/block/block_int.h    | 1 +
>>   include/block/dirty-bitmap.h | 1 +
>>   block/dirty-bitmap.c         | 9 +++++++++
>>   block/qcow2-bitmap.c         | 7 +++++++
>>   block/qcow2.c                | 1 +
>>   6 files changed, 20 insertions(+)
>>
>> diff --git a/block/qcow2.h b/block/qcow2.h
>> index f4de0a27d5c3..fb2b2b5a7b4d 100644
>> --- a/block/qcow2.h
>> +++ b/block/qcow2.h
>> @@ -764,6 +764,7 @@ bool qcow2_co_can_store_new_dirty_bitmap(BlockDriverState *bs,
>>   int qcow2_co_remove_persistent_dirty_bitmap(BlockDriverState *bs,
>>                                               const char *name,
>>                                               Error **errp);
>> +bool qcow2_dirty_bitmap_supported(BlockDriverState *bs);
>>
>>   ssize_t coroutine_fn
>>   qcow2_co_compress(BlockDriverState *bs, void *dest, size_t dest_size,
>> diff --git a/include/block/block_int.h b/include/block/block_int.h
>> index df6d0273d679..cb1082da4c43 100644
>> --- a/include/block/block_int.h
>> +++ b/include/block/block_int.h
>> @@ -560,6 +560,7 @@ struct BlockDriver {
>>                                uint64_t parent_perm, uint64_t parent_shared,
>>                                uint64_t *nperm, uint64_t *nshared);
>>
>> +    bool (*bdrv_dirty_bitmap_supported)(BlockDriverState *bs);
> 
> All BDSs support bitmaps, but only some support persistent dirty
> bitmaps, so I think the name should reflect that.

How about .bdrv_dirty_bitmap_supports_persistent?

> 
> Conceptually, this looks reasonable.  This information might indeed be
> nice to have, and I’m not sure whether we should extend any existing
> interface to return it.
> 
> (The interfaces that come to my mind are:
> (1) bdrv_can_store_new_dirty_bitmap() below, which we could make accept
> a NULL @name to return basically the same information.  But it’s still a
> bit different, because I’d expect that function to return whether any
> bitmap can be stored then, not whether the node supports bitmaps at all.
>   So e.g. if there are already too many bitmaps, it should return false,
> even though the node itself does support bitmaps.

[which reminds me - a while ago, we had patches for qcow2 handling with 
64k bitmaps, or whatever insane number it took to overflow data 
structures, and I don't know if those ever got applied...]

> 
> (2) bdrv_get_info()/BlockDriverInfo: This information would fit in very
> nicely here, but do we have to put it here just because it does?  I
> don’t think so.  This patch adds 20 lines of code, that shows that it’s
> very simple to add a dedicated method, and it’s certainly a bit easier
> to use than to invoke bdrv_get_info() and throw away all the other
> information.  Perhaps this patch only shows that BlockDriverInfo doesn’t
> make much sense in the first place, and most of its fields should have
> been scalar return values from dedicated functions.)

Indeed, you (re-)discovered some of the very reasons why I chose to make 
a new interface.  I could tweak the commit message to mention 
alternatives, if that would help.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


