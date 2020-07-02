Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED4CC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 14:59:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B2DA20737
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 14:59:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eA/aebxt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B2DA20737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr0gC-0001JI-91
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 10:59:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35150)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jr0fW-0008JS-1L
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 10:58:30 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:20786
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jr0fU-0006WQ-8y
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 10:58:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593701907;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=amQojgLjoSQ4GSYQBBsKQNhuIwqQALBy+vrI1dt78ro=;
 b=eA/aebxtQAn51Q1nmA7zbfEZWdGeBteeELN0xdWgLjZTOJeJZBMvP7QoNcN4udVOpXUL6u
 8m8VG1zZb5S01VCK/ZokTmSc8cAEJqT84LIvmcKb4/em+3joUVVkqXjsb+4GNY2vbpLelB
 S1h3evsWCEyke3q7Z225Aws16klwvY4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-e4uV6n0-PCWa6KYwAssJZg-1; Thu, 02 Jul 2020 10:58:19 -0400
X-MC-Unique: e4uV6n0-PCWa6KYwAssJZg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0DD5A879510;
 Thu,  2 Jul 2020 14:58:18 +0000 (UTC)
Received: from [10.3.112.202] (ovpn-112-202.phx2.redhat.com [10.3.112.202])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 789481974A;
 Thu,  2 Jul 2020 14:58:16 +0000 (UTC)
Subject: Re: [PATCH v9 30/34] qcow2: Add prealloc field to QCowL2Meta
To: Max Reitz <mreitz@redhat.com>, Alberto Garcia <berto@igalia.com>,
 qemu-devel@nongnu.org
References: <cover.1593342067.git.berto@igalia.com>
 <0dd88b3b4d3e90b28267267d7686cf5350d9dea0.1593342067.git.berto@igalia.com>
 <cadd98f7-1fc4-3a54-5999-b988cc79e618@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <687f5402-2316-e06a-2fd1-37375a4fa119@redhat.com>
Date: Thu, 2 Jul 2020 09:58:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <cadd98f7-1fc4-3a54-5999-b988cc79e618@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 04:18:28
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
Cc: Kevin Wolf <kwolf@redhat.com>, Derek Su <dereksu@qnap.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/2/20 9:50 AM, Max Reitz wrote:
> On 28.06.20 13:02, Alberto Garcia wrote:
>> This field allows us to indicate that the L2 metadata update does not
>> come from a write request with actual data but from a preallocation
>> request.
>>
>> For traditional images this does not make any difference, but for
>> images with extended L2 entries this means that the clusters are
>> allocated normally in the L2 table but individual subclusters are
>> marked as unallocated.
>>
>> This will allow preallocating images that have a backing file.
>>
>> There is one special case: when we resize an existing image we can
>> also request that the new clusters are preallocated. If the image
>> already had a backing file then we have to hide any possible stale
>> data and zero out the new clusters (see commit 955c7d6687 for more
>> details).
>>
>> In this case the subclusters cannot be left as unallocated so the L2
>> bitmap must be updated.
>>
>> Signed-off-by: Alberto Garcia <berto@igalia.com>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>> ---
>>   block/qcow2.h         | 8 ++++++++
>>   block/qcow2-cluster.c | 2 +-
>>   block/qcow2.c         | 6 ++++++
>>   3 files changed, 15 insertions(+), 1 deletion(-)
> 
> Sounds good, but I’m just not quite sure about the details on
> falloc/full allocation: With .prealloc = true, writing to the
> preallocated subclusters will require a COW operation.  That’s not
> ideal, and avoiding those COWs may be a reason to do preallocation in
> the first place.

I'm not sure I follow the complaint.  If a cluster is preallocated but 
the subcluster is marked unallocated, then doing a partial write to that 
subcluster must provide the correct contents for the rest of the 
subcluster (either filling with zero, or reading from a backing file) - 
but this COW can be limited to just the portion of the subcluster, and 
is no different than the COW you have to perform without subclusters 
when doing a write to a preallocated cluster in general.

> 
> Now, with backing files, it’s entirely correct.  You need a COW
> operation, because that’s the point of having a backing file.
> 
> But without a backing file I wonder if it wouldn’t be better to set
> .prealloc = false to avoid that COW.

Without a backing file, there is no read required - writing to an 
unallocated subcluster within a preallocated cluster merely has to 
provide zeros to the rest of the write.  And depending on whether we can 
intelligently guarantee that the underlying protocol already reads as 
zeroes when preallocated, we even have an optimization where even that 
is not necessary.  We can still lump it in the "COW" terminology, in 
that our write is more complex than merely writing in place, but it 
isn't a true copy-on-write operation as there is nothing to be copied.

> 
> Of course, if we did that, you couldn’t create the overlay separately
> from the backing file, preallocate it, and only then attach the backing
> file to the overlay.  But is that a problem?
> 
> (Or are there other problems to consider?)
> 
> Max
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


