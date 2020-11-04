Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DBC0C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 17:30:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C592320759
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 17:30:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aOEzlxPy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C592320759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaMc6-0008I3-OG
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 12:30:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32910)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kaMY4-0002XV-It
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 12:26:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31756)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kaMY2-0008Nq-PV
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 12:26:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604510774;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0Z6fh5MibMBZ+e6Oyy41PqhZNiid1iiNVY4mVFY8TCI=;
 b=aOEzlxPys1GuwGAFKGbae6ETOJRXOdiQeXZXkaTwltZuzhHAbRJ/mswWXLWU9S2lptXlFA
 BJ+FAS5EOUeRKjZCNUG3ITS6/2hDij4LHWrjRKI6XzgIg2You9Fmqnm2Dzna1AGv+KMBE7
 FUJowUtFf4Nhwh3az553hGuXAXzzKv8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-19-T5nneksvOgGJgGzHfAnQHA-1; Wed, 04 Nov 2020 12:26:10 -0500
X-MC-Unique: T5nneksvOgGJgGzHfAnQHA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D0C3618A6285;
 Wed,  4 Nov 2020 17:26:08 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.194.145])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 864575577D;
 Wed,  4 Nov 2020 17:26:06 +0000 (UTC)
Subject: Re: [PATCH v2 08/20] block/block-copy: add block_copy_cancel
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200601181118.579-1-vsementsov@virtuozzo.com>
 <20200601181118.579-9-vsementsov@virtuozzo.com>
 <93e0a82c-71eb-66f3-cf02-a06e3be7c9e8@redhat.com>
 <3d3f31e0-e5ca-9a6a-7acb-90302de50ba3@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <12fa4bf8-7a3b-6833-674d-5b6d3de3833b@redhat.com>
Date: Wed, 4 Nov 2020 18:26:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <3d3f31e0-e5ca-9a6a-7acb-90302de50ba3@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, wencongyang2@huawei.com, xiechanglong.d@gmail.com,
 armbru@redhat.com, qemu-devel@nongnu.org, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22.10.20 22:50, Vladimir Sementsov-Ogievskiy wrote:
> 22.07.2020 14:28, Max Reitz wrote:
>> On 01.06.20 20:11, Vladimir Sementsov-Ogievskiy wrote:
>>> Add function to cancel running async block-copy call. It will be used
>>> in backup.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>> ---
>>>   include/block/block-copy.h |  7 +++++++
>>>   block/block-copy.c         | 22 +++++++++++++++++++---
>>>   2 files changed, 26 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/include/block/block-copy.h b/include/block/block-copy.h
>>> index d40e691123..370a194d3c 100644
>>> --- a/include/block/block-copy.h
>>> +++ b/include/block/block-copy.h
>>> @@ -67,6 +67,13 @@ BlockCopyCallState
>>> *block_copy_async(BlockCopyState *s,
>>>   void block_copy_set_speed(BlockCopyState *s, BlockCopyCallState
>>> *call_state,
>>>                             uint64_t speed);
>>>   +/*
>>> + * Cancel running block-copy call.
>>> + * Cancel leaves block-copy state valid: dirty bits are correct and
>>> you may use
>>> + * cancel + <run block_copy with same parameters> to emulate
>>> pause/resume.
>>> + */
>>> +void block_copy_cancel(BlockCopyCallState *call_state);
>>> +
>>>   BdrvDirtyBitmap *block_copy_dirty_bitmap(BlockCopyState *s);
>>>   void block_copy_set_skip_unallocated(BlockCopyState *s, bool skip);
>>>   diff --git a/block/block-copy.c b/block/block-copy.c
>>> index 851d9c8aaf..b551feb6c2 100644
>>> --- a/block/block-copy.c
>>> +++ b/block/block-copy.c
>>> @@ -44,6 +44,8 @@ typedef struct BlockCopyCallState {
>>>       bool failed;
>>>       bool finished;
>>>       QemuCoSleepState *sleep_state;
>>> +    bool cancelled;
>>> +    Coroutine *canceller;
>>>         /* OUT parameters */
>>>       bool error_is_read;
>>> @@ -582,7 +584,7 @@ block_copy_dirty_clusters(BlockCopyCallState
>>> *call_state)
>>>       assert(QEMU_IS_ALIGNED(offset, s->cluster_size));
>>>       assert(QEMU_IS_ALIGNED(bytes, s->cluster_size));
>>>   -    while (bytes && aio_task_pool_status(aio) == 0) {
>>> +    while (bytes && aio_task_pool_status(aio) == 0 &&
>>> !call_state->cancelled) {
>>>           BlockCopyTask *task;
>>>           int64_t status_bytes;
>>>   @@ -693,7 +695,7 @@ static int coroutine_fn
>>> block_copy_common(BlockCopyCallState *call_state)
>>>       do {
>>>           ret = block_copy_dirty_clusters(call_state);
>>>   -        if (ret == 0) {
>>> +        if (ret == 0 && !call_state->cancelled) {
>>>               ret = block_copy_wait_one(call_state->s,
>>> call_state->offset,
>>>                                         call_state->bytes);
>>>           }
>>> @@ -707,13 +709,18 @@ static int coroutine_fn
>>> block_copy_common(BlockCopyCallState *call_state)
>>>            * 2. We have waited for some intersecting block-copy request
>>>            *    It may have failed and produced new dirty bits.
>>>            */
>>> -    } while (ret > 0);
>>> +    } while (ret > 0 && !call_state->cancelled);
>>
>> Would it be cleaner if block_copy_dirty_cluster() just returned
>> -ECANCELED?  Or would that pose a problem for its callers or the async
>> callback?
>>
> 
> I'd prefer not to merge io ret with block-copy logic: who knows what
> underlying operations may return.. Can't it be _another_ ECANCELED?
> And it would be just a sugar for block_copy_dirty_clusters() call, I'll
> have to check ->cancelled after block_copy_wait_one() anyway.
> Also, for the next version I try to make it more obvious that finished
> block-copy call is in one of thee states:
>  - success
>  - failed
>  - cancelled

OK.

Max


