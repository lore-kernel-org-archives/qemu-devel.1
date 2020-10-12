Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4736C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 11:11:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FFDB2076E
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 11:11:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ql8MKAv2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FFDB2076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRvjf-0007do-WC
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 07:11:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35052)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kRviW-0006hR-FA
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 07:10:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39401)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kRviU-0003sz-S5
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 07:10:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602501009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=62XZAi3VhkH78CxFoYSzl1E7Gz28bTG1EphD9ksuyJs=;
 b=Ql8MKAv2SVQS+1A5tcojq5en0I1O2R+nbJ5d6fWjY4zZJ7mblpaE22KfljAaXCvaSx/OOo
 4fCvjynq0NtfWfXVtsXN+Ie+QbBhN9jfGKetOpNCRBeMdYk5mXyni4aXN28pHiBGcUnbxX
 p8enrEobfDFQhnOpiO/0EBk+hUmo9nI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-429-UXn5dEZfMDa-K8vbfI0oDg-1; Mon, 12 Oct 2020 07:10:06 -0400
X-MC-Unique: UXn5dEZfMDa-K8vbfI0oDg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E5D13879517;
 Mon, 12 Oct 2020 11:10:04 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.193.240])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9D9ED10013BD;
 Mon, 12 Oct 2020 11:10:01 +0000 (UTC)
Subject: Re: [PATCH 1/3] block: push error reporting into bdrv_all_*_snapshot
 functions
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20201008174803.2696619-1-philmd@redhat.com>
 <20201008174803.2696619-2-philmd@redhat.com>
 <8f2e2439-4100-a64d-b52e-c03d439cb743@redhat.com>
 <7a77479f-5ce5-d89a-bee1-02bd2a521495@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Autocrypt: addr=mreitz@redhat.com; prefer-encrypt=mutual; keydata=
 mQENBFXOJlcBCADEyyhOTsoa/2ujoTRAJj4MKA21dkxxELVj3cuILpLTmtachWj7QW+TVG8U
 /PsMCFbpwsQR7oEy8eHHZwuGQsNpEtNC2G/L8Yka0BIBzv7dEgrPzIu+W3anZXQW4702+uES
 U29G8TP/NGfXRRHGlbBIH9KNUnOSUD2vRtpOLXkWsV5CN6vQFYgQfFvmp5ZpPeUe6xNplu8V
 mcTw8OSEDW/ZnxJc8TekCKZSpdzYoxfzjm7xGmZqB18VFwgJZlIibt1HE0EB4w5GsD7x5ekh
 awIe3RwoZgZDLQMdOitJ1tUc8aqaxvgA4tz6J6st8D8pS//m1gAoYJWGwwIVj1DjTYLtABEB
 AAG0HU1heCBSZWl0eiA8bXJlaXR6QHJlZGhhdC5jb20+iQFTBBMBCAA9AhsDBQkSzAMABQsJ
 CAcCBhUICQoLAgQWAgMBAh4BAheABQJVzie5FRhoa3A6Ly9rZXlzLmdudXBnLm5ldAAKCRD0
 B9sAYdXPQDcIB/9uNkbYEex1rHKz3mr12uxYMwLOOFY9fstP5aoVJQ1nWQVB6m2cfKGdcRe1
 2/nFaHSNAzT0NnKz2MjhZVmcrpyd2Gp2QyISCfb1FbT82GMtXFj1wiHmPb3CixYmWGQUUh+I
 AvUqsevLA+WihgBUyaJq/vuDVM1/K9Un+w+Tz5vpeMidlIsTYhcsMhn0L9wlCjoucljvbDy/
 8C9L2DUdgi3XTa0ORKeflUhdL4gucWoAMrKX2nmPjBMKLgU7WLBc8AtV+84b9OWFML6NEyo4
 4cP7cM/07VlJK53pqNg5cHtnWwjHcbpGkQvx6RUx6F1My3y52vM24rNUA3+ligVEgPYBuQEN
 BFXOJlcBCADAmcVUNTWT6yLWQHvxZ0o47KCP8OcLqD+67T0RCe6d0LP8GsWtrJdeDIQk+T+F
 xO7DolQPS6iQ6Ak2/lJaPX8L0BkEAiMuLCKFU6Bn3lFOkrQeKp3u05wCSV1iKnhg0UPji9V2
 W5eNfy8F4ZQHpeGUGy+liGXlxqkeRVhLyevUqfU0WgNqAJpfhHSGpBgihUupmyUg7lfUPeRM
 DzAN1pIqoFuxnN+BRHdAecpsLcbR8sQddXmDg9BpSKozO/JyBmaS1RlquI8HERQoe6EynJhd
 64aICHDfj61rp+/0jTIcevxIIAzW70IadoS/y3DVIkuhncgDBvGbF3aBtjrJVP+5ABEBAAGJ
 ASUEGAEIAA8FAlXOJlcCGwwFCRLMAwAACgkQ9AfbAGHVz0CbFwf9F/PXxQR9i4N0iipISYjU
 sxVdjJOM2TMut+ZZcQ6NSMvhZ0ogQxJ+iEQ5OjnIputKvPVd5U7WRh+4lF1lB/NQGrGZQ1ic
 alkj6ocscQyFwfib+xIe9w8TG1CVGkII7+TbS5pXHRxZH1niaRpoi/hYtgzkuOPp35jJyqT/
 /ELbqQTDAWcqtJhzxKLE/ugcOMK520dJDeb6x2xVES+S5LXby0D4juZlvUj+1fwZu+7Io5+B
 bkhSVPb/QdOVTpnz7zWNyNw+OONo1aBUKkhq2UIByYXgORPFnbfMY7QWHcjpBVw9MgC4tGeF
 R4bv+1nAMMxKmb5VvQCExr0eFhJUAHAhVg==
Message-ID: <f68d175a-68f0-3d6a-78d0-8a5981a9d983@redhat.com>
Date: Mon, 12 Oct 2020 13:09:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <7a77479f-5ce5-d89a-bee1-02bd2a521495@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/11 23:52:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12.10.20 12:16, Philippe Mathieu-Daudé wrote:
> On 10/12/20 12:07 PM, Max Reitz wrote:
>> On 08.10.20 19:48, Philippe Mathieu-Daudé wrote:
>>> From: Daniel P. Berrangé <berrange@redhat.com>
>>>
>>> The bdrv_all_*_snapshot functions return a BlockDriverState pointer
>>> for the invalid backend, which the callers then use to report an
>>> error message. In some cases multiple callers are reporting the
>>> same error message, but with slightly different text. In the future
>>> there will be more error scenarios for some of these methods, which
>>> will benefit from fine grained error message reporting. So it is
>>> helpful to push error reporting down a level.
>>>
>>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
>>> ---
>>>   include/block/snapshot.h       | 14 +++----
>>>   block/monitor/block-hmp-cmds.c |  7 ++--
>>>   block/snapshot.c               | 77 +++++++++++++++++-----------------
>>>   migration/savevm.c             | 37 +++++-----------
>>>   monitor/hmp-cmds.c             |  7 +---
>>>   replay/replay-debugging.c      |  4 +-
>>>   tests/qemu-iotests/267.out     | 10 ++---
>>>   7 files changed, 67 insertions(+), 89 deletions(-)
>>
>> Looks good overall to me, but for some reason this patch pulls in the
>> @ok and @ret variables from the top scope of all concerned functions
>> into the inner scopes of the BDS loops, and drops their initialization.
>>   That’s wrong, because we only call the respective snapshotting
>> functions on some BDSs, so the return value stays uninitialized for all
>> other BDSs:
> 
> Indeed, thanks for catching that.
> 
> [...]
>>>   int bdrv_all_create_snapshot(QEMUSnapshotInfo *sn,
>>>                                BlockDriverState *vm_state_bs,
>>>                                uint64_t vm_state_size,
>>> -                             BlockDriverState **first_bad_bs)
>>> +                             Error **errp)
>>>   {
>>> -    int err = 0;
>>>       BlockDriverState *bs;
>>>       BdrvNextIterator it;
>>>         for (bs = bdrv_first(&it); bs; bs = bdrv_next(&it)) {
>>>           AioContext *ctx = bdrv_get_aio_context(bs);
>>> +        int ret;
>>
>> And one final time.
>>
>> Max
>>
>>>           aio_context_acquire(ctx);
>>>           if (bs == vm_state_bs) {
>>>               sn->vm_state_size = vm_state_size;
>>> -            err = bdrv_snapshot_create(bs, sn);
>>> +            ret = bdrv_snapshot_create(bs, sn);
>>>           } else if (bdrv_all_snapshots_includes_bs(bs)) {
>>>               sn->vm_state_size = 0;
>>> -            err = bdrv_snapshot_create(bs, sn);
>>> +            ret = bdrv_snapshot_create(bs, sn);
> 
> This one is not needed.

Why not?  Is bdrv_all_snapshots_includes_bs(bs) guaranteed to be true?
(I don’t see any a plain “else” branch, or where ret would be set
outside of these two “if” blocks.)

Max

>>>           }
>>>           aio_context_release(ctx);
>>> -        if (err < 0) {
>>> +        if (ret < 0) {
>>> +            error_setg(errp, "Could not create snapshot '%s' on '%s'",
>>> +                       sn->name, bdrv_get_device_or_node_name(bs));
>>>               bdrv_next_cleanup(&it);
>>> -            goto fail;
>>> +            return -1;
>>>           }
>>>       }
>>
> 


