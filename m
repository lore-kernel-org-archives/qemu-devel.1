Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86782C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 11:59:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5036020776
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 11:59:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZUSw8JsC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5036020776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jedfW-0005WX-HI
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 07:59:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50848)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jedeZ-0004WN-23
 for qemu-devel@nongnu.org; Fri, 29 May 2020 07:58:23 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:43950
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jedeX-00043y-3h
 for qemu-devel@nongnu.org; Fri, 29 May 2020 07:58:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590753500;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MNgffQSG2/9UIbTG8D15DwNaiAywNtMJ9/xNPKkq8/I=;
 b=ZUSw8JsCLsoHzgPcEigMrVJF8UuaTbe9iLznmoTf0PAdx2H4uldPtJU/urvpHE24/dKOyn
 plM4JCP47PsKFK1AZ3+6znLvgjljw3RocE+m7k8DmM0flcfrhMdM+kXTIOzRoRAxr+BnYJ
 htN+Y8ixrIxI+BBrM9YCCVQsxEJ82gk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-w-_hSrvqPQ6_ylkxA02Pmw-1; Fri, 29 May 2020 07:58:15 -0400
X-MC-Unique: w-_hSrvqPQ6_ylkxA02Pmw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B40EB1005510;
 Fri, 29 May 2020 11:58:13 +0000 (UTC)
Received: from [10.3.112.88] (ovpn-112-88.phx2.redhat.com [10.3.112.88])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 39D595C1B0;
 Fri, 29 May 2020 11:58:09 +0000 (UTC)
Subject: Re: [PATCH v2 00/22] Fix error handling during bitmap postcopy
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20200217150246.29180-1-vsementsov@virtuozzo.com>
 <0bfccf62-30e4-8ef7-7f26-1af3a3824a6d@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <090c8382-192e-bbb3-749e-d83a7df7fba3@redhat.com>
Date: Fri, 29 May 2020 06:58:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <0bfccf62-30e4-8ef7-7f26-1af3a3824a6d@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/29 03:05:19
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 quintela@redhat.com, qemu-stable@nongnu.org, dgilbert@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 andrey.shinkevich@virtuozzo.com, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/2/20 2:42 AM, Vladimir Sementsov-Ogievskiy wrote:
> Ping!
> 
> It's a fix, but not a degradation and I'm afraid too big for 5.0.
> 
> Still, I think I should ping it anyway. John, I'm afraid, that this all 
> is for your branch :)

Just noticing this thread, now that we've shuffled bitmaps maintainers. 
Is there anything here that we still need to include in 5.1?

> 
> 
> 17.02.2020 18:02, Vladimir Sementsov-Ogievskiy wrote:
>> Original idea of bitmaps postcopy migration is that bitmaps are non
>> critical data, and their loss is not serious problem. So, using postcopy
>> method on any failure we should just drop unfinished bitmaps and
>> continue guest execution.
>>
>> However, it doesn't work so. It crashes, fails, it goes to
>> postcopy-recovery feature. It does anything except for behavior we want.
>> These series fixes at least some problems with error handling during
>> bitmaps migration postcopy.
>>
>> v1 was "[PATCH 0/7] Fix crashes on early shutdown during bitmaps 
>> postcopy"
>>
>> v2:
>>
>> Most of patches are new or changed a lot.
>> Only patches 06,07 mostly unchanged, just rebased on refactorings.
>>
>> Vladimir Sementsov-Ogievskiy (22):
>>    migration/block-dirty-bitmap: fix dirty_bitmap_mig_before_vm_start
>>    migration/block-dirty-bitmap: rename state structure types
>>    migration/block-dirty-bitmap: rename dirty_bitmap_mig_cleanup
>>    migration/block-dirty-bitmap: move mutex init to dirty_bitmap_mig_init
>>    migration/block-dirty-bitmap: refactor state global variables
>>    migration/block-dirty-bitmap: rename finish_lock to just lock
>>    migration/block-dirty-bitmap: simplify dirty_bitmap_load_complete
>>    migration/block-dirty-bitmap: keep bitmap state for all bitmaps
>>    migration/block-dirty-bitmap: relax error handling in incoming part
>>    migration/block-dirty-bitmap: cancel migration on shutdown
>>    migration/savevm: don't worry if bitmap migration postcopy failed
>>    qemu-iotests/199: fix style
>>    qemu-iotests/199: drop extra constraints
>>    qemu-iotests/199: better catch postcopy time
>>    qemu-iotests/199: improve performance: set bitmap by discard
>>    qemu-iotests/199: change discard patterns
>>    qemu-iotests/199: increase postcopy period
>>    python/qemu/machine: add kill() method
>>    qemu-iotests/199: prepare for new test-cases addition
>>    qemu-iotests/199: check persistent bitmaps
>>    qemu-iotests/199: add early shutdown case to bitmaps postcopy
>>    qemu-iotests/199: add source-killed case to bitmaps postcopy
>>
>> Cc: John Snow <jsnow@redhat.com>
>> Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> Cc: Stefan Hajnoczi <stefanha@redhat.com>
>> Cc: Fam Zheng <fam@euphon.net>
>> Cc: Juan Quintela <quintela@redhat.com>
>> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>> Cc: Eduardo Habkost <ehabkost@redhat.com>
>> Cc: Cleber Rosa <crosa@redhat.com>
>> Cc: Kevin Wolf <kwolf@redhat.com>
>> Cc: Max Reitz <mreitz@redhat.com>
>> Cc: qemu-block@nongnu.org
>> Cc: qemu-devel@nongnu.org
>> Cc: qemu-stable@nongnu.org # for patch 01
>>
>>   migration/migration.h          |   3 +-
>>   migration/block-dirty-bitmap.c | 444 +++++++++++++++++++++------------
>>   migration/migration.c          |  15 +-
>>   migration/savevm.c             |  37 ++-
>>   python/qemu/machine.py         |  12 +-
>>   tests/qemu-iotests/199         | 244 ++++++++++++++----
>>   tests/qemu-iotests/199.out     |   4 +-
>>   7 files changed, 529 insertions(+), 230 deletions(-)
>>
> 
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


