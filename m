Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E34AC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 19:47:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20079208C3
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 19:47:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="chPnxy4n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20079208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlHYk-0007lc-El
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 15:47:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50010)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jlHXs-0007G2-SS
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 15:46:56 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:42597
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jlHXq-0000K1-Fj
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 15:46:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592336813;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3G9RZIWMH8EfFWPaobeHCrbAIbgQqBeYr6tvNti8Ot0=;
 b=chPnxy4nvU2cV7WQ70tjNBqz1a5O5MnqzWFnNoqk4Sl8IByp5hsY5KDQTgLBFGMRfIC08a
 Evd03D0XvC2ic+d+Q4CKlVz+VrkZgpU276QmYb91OHYYCFIbFteSAZLc10QGLKGGQ+Kvqp
 5DljrlhYG0f1hRuUeHZEjXPc13SDeKs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-sA5WcuL4PZWvP-n1VABaAQ-1; Tue, 16 Jun 2020 15:46:48 -0400
X-MC-Unique: sA5WcuL4PZWvP-n1VABaAQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4D5D5105250D;
 Tue, 16 Jun 2020 19:46:42 +0000 (UTC)
Received: from [10.3.112.27] (ovpn-112-27.phx2.redhat.com [10.3.112.27])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 804D678F0F;
 Tue, 16 Jun 2020 19:46:41 +0000 (UTC)
Subject: Re: [PATCH RFC v2 1/5] block: add bitmap-populate job
To: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>
References: <20200514034922.24834-1-jsnow@redhat.com>
 <20200514034922.24834-2-jsnow@redhat.com>
 <20200604090140.GB4512@linux.fritz.box>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <bb9a31cf-99e0-ef35-3739-bb3ff270735d@redhat.com>
Date: Tue, 16 Jun 2020 14:46:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200604090140.GB4512@linux.fritz.box>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 02:01:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: pkrempa@redhat.com, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, vsementsov@virtuozzo.com,
 Cleber Rosa <crosa@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/4/20 4:01 AM, Kevin Wolf wrote:
> Am 14.05.2020 um 05:49 hat John Snow geschrieben:
>> This job copies the allocation map into a bitmap. It's a job because
>> there's no guarantee that allocation interrogation will be quick (or
>> won't hang), so it cannot be retrofit into block-dirty-bitmap-merge.
>>
>> It was designed with different possible population patterns in mind,
>> but only top layer allocation was implemented for now.

Other patterns that might make sense someday:
all-ones (we already have bitmap-clear for all zeroes)
an inverse flag (set bits for all unallocated portions)
compressed (set bits for portions that are compressed)

but yeah, I don't see it worth implementing any of them without a client.

>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>   qapi/block-core.json      |  48 +++++++++
>>   qapi/job.json             |   2 +-
>>   include/block/block_int.h |  21 ++++
>>   block/bitmap-alloc.c      | 207 ++++++++++++++++++++++++++++++++++++++
> 
> bitmap-populate.c to be more consistent with the actual job name?

Seems reasonable to me.

> 
>>   blockjob.c                |   3 +-
>>   block/Makefile.objs       |   1 +
>>   6 files changed, 280 insertions(+), 2 deletions(-)
>>   create mode 100644 block/bitmap-alloc.c
> 
> [...]
> 
>> +BlockJob *bitpop_job_create(

>> +    if (bdrv_op_is_blocked(bs, BLOCK_OP_TYPE_BACKUP_SOURCE, errp)) {
>> +        return NULL;
>> +    }
> 
> What does this protect? And why does BACKUP_SOURCE describe acccurately
> what this job does?

I'm less certain what the BLOCK_OP_TYPE_* constants are supposed to 
block, or if this is just copy/paste from backup.c. Does BlockOpType in 
block.h need a new entry?

> 
>> +    if (bdrv_dirty_bitmap_check(target_bitmap, BDRV_BITMAP_DEFAULT, errp)) {
>> +        return NULL;
>> +    }
>> +
>> +    if (pattern != BITMAP_PATTERN_ALLOCATION_TOP) {
>> +        error_setg(errp, "Unrecognized bitmap pattern");
>> +        return NULL;
>> +    }
>> +
>> +    len = bdrv_getlength(bs);
>> +    if (len < 0) {
>> +        error_setg_errno(errp, -len, "unable to get length for '%s'",
>> +                         bdrv_get_device_name(bs));
> 
> This operates on the node level, so bdrv_get_device_or_node_name() is
> necessary to avoid empty strings in the message.

Easy to fix.

> 
>> +        return NULL;
>> +    }
>> +
>> +    /* NB: new bitmap is anonymous and enabled */
>> +    cluster_size = bdrv_dirty_bitmap_granularity(target_bitmap);
>> +    new_bitmap = bdrv_create_dirty_bitmap(bs, cluster_size, NULL, errp);
>> +    if (!new_bitmap) {
>> +        return NULL;
>> +    }
>> +
>> +    /* Take ownership; we reserve the right to write into this on-commit. */
>> +    bdrv_dirty_bitmap_set_busy(target_bitmap, true);
>> +
>> +    job = block_job_create(job_id, &bitpop_job_driver, txn, bs,
>> +                           BLK_PERM_CONSISTENT_READ,
> 
> I don't think we actually rely on CONSISTENT_READ, but then, using the
> job on inconsistent nodes probably makes little sense and we can always
> relax the restriction later if necessary.
> 
>> +                           BLK_PERM_ALL & ~BLK_PERM_RESIZE,
>> +                           0, creation_flags,
>> +                           cb, opaque, errp);
>> +    if (!job) {
>> +        bdrv_dirty_bitmap_set_busy(target_bitmap, false);
>> +        bdrv_release_dirty_bitmap(new_bitmap);
>> +        return NULL;
>> +    }
>> +
>> +    job->bs = bs;
>> +    job->on_error = on_error;
>> +    job->target_bitmap = target_bitmap;
>> +    job->new_bitmap = new_bitmap;
>> +    job->len = len;
>> +    job_progress_set_remaining(&job->common.job, job->len);
>> +
>> +    return &job->common;
>> +}
> 
> Kevin
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


