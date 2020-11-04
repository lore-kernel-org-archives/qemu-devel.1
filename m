Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A726C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 17:21:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FC5420781
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 17:21:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WHmZau9s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FC5420781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaMSx-0006Gg-1q
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 12:20:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59854)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kaMRs-0005VU-Dc
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 12:19:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50238)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kaMRq-0007B1-Hv
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 12:19:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604510388;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OkEFQZPfTFWgj/6c5/dfK1WAFoW6wYCEGqIJI3ciFSU=;
 b=WHmZau9s27oh5DTbdhj1Rmi+L7cQFbl1tU+yRznuEyiExfXRWv55wN3NY3iUuqqAB8HS9c
 Hp8oOP+d0vzXi/Rfzzb/MluY3z4Yr0R36fjqKpAnkhvXXiTmIg6NJ28IojMdu3LZIRQ8Vl
 VY994wRTJFLeHYN7m5Rqfd1RzX+/pGA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-84-KbaOz27kMXWUSmwhwcpg1w-1; Wed, 04 Nov 2020 12:19:44 -0500
X-MC-Unique: KbaOz27kMXWUSmwhwcpg1w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AFEE31882FB1;
 Wed,  4 Nov 2020 17:19:42 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.194.145])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 26A0C5577D;
 Wed,  4 Nov 2020 17:19:39 +0000 (UTC)
Subject: Re: [PATCH v2 11/20] qapi: backup: add x-max-chunk and x-max-workers
 parameters
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200601181118.579-1-vsementsov@virtuozzo.com>
 <20200601181118.579-12-vsementsov@virtuozzo.com>
 <2117c54a-c9b3-59c6-c0b2-9fd84cb965b6@redhat.com>
 <b0334bde-2e84-9833-8228-a578dc064e32@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <f9aa552a-3de7-662b-3797-03959163d971@redhat.com>
Date: Wed, 4 Nov 2020 18:19:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <b0334bde-2e84-9833-8228-a578dc064e32@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 22:09:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: kwolf@redhat.com, wencongyang2@huawei.com, xiechanglong.d@gmail.com,
 armbru@redhat.com, qemu-devel@nongnu.org, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22.10.20 22:35, Vladimir Sementsov-Ogievskiy wrote:
> 22.07.2020 15:22, Max Reitz wrote:
>> On 01.06.20 20:11, Vladimir Sementsov-Ogievskiy wrote:
>>> Add new parameters to configure future backup features. The patch
>>> doesn't introduce aio backup requests (so we actually have only one
>>> worker) neither requests larger than one cluster. Still, formally we
>>> satisfy these maximums anyway, so add the parameters now, to facilitate
>>> further patch which will really change backup job behavior.
>>>
>>> Options are added with x- prefixes, as the only use for them are some
>>> very conservative iotests which will be updated soon.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>> ---
>>>   qapi/block-core.json      |  9 ++++++++-
>>>   include/block/block_int.h |  7 +++++++
>>>   block/backup.c            | 21 +++++++++++++++++++++
>>>   block/replication.c       |  2 +-
>>>   blockdev.c                |  5 +++++
>>>   5 files changed, 42 insertions(+), 2 deletions(-)
>>>
> 
> [..]
> 
>>> @@ -422,6 +436,11 @@ BlockJob *backup_job_create(const char *job_id,
>>> BlockDriverState *bs,
>>>       if (cluster_size < 0) {
>>>           goto error;
>>>       }
>>> +    if (max_chunk && max_chunk < cluster_size) {
>>> +        error_setg(errp, "Required max-chunk (%" PRIi64") is less
>>> than backup "
>>
>> (missing a space after PRIi64)
>>
>>> +                   "cluster size (%" PRIi64 ")", max_chunk,
>>> cluster_size);
>>
>> Should this be noted in the QAPI documentation?
> 
> Hmm.. It makes sense, but I don't know what to write: should be >= job
> cluster_size? But then I'll have to describe the logic of
> backup_calculate_cluster_size()...

Isn’t the logic basically just “cluster size of the target image file
(min 64k)”?  The other cases just cover error cases, and they always
return 64k, which would effectively be documented by stating that 64k is
the minimum.

But in the common cases (qcow2 or raw), we’ll never get an error anyway.

I think it’d be good to describe the cluster size somewhere, because
otherwise I find it a bit malicious to throw an error at the user that
they could not have anticipated because they have no idea what valid
values for the parameter are (until they try).

>>  (And perhaps the fact
>> that without copy offloading, we’ll never copy anything bigger than one
>> cluster at a time anyway?)
> 
> This is a parameter for background copying. Look at
> block_copy_task_create(), if call_state has own max_chunk, it's used
> instead of common copy_size (derived from cluster_size). But at a moment
> of this patch background process through async block-copy is not  yet
> implemented, and the parameter doesn't work, which is described in
> commit message.

Ah, OK.  Right.

Max


