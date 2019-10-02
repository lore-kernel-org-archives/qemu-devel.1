Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 155ABC4360C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 19:05:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E155F218DE
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 19:05:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E155F218DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFjwG-000730-35
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 15:05:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52573)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iFjvZ-0006XV-Ul
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 15:04:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iFjvY-0003Jp-MV
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 15:04:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40030)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>)
 id 1iFjvU-0003I1-KB; Wed, 02 Oct 2019 15:04:40 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E2B9730A7B9B;
 Wed,  2 Oct 2019 19:04:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 254BC5C22C;
 Wed,  2 Oct 2019 19:04:30 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6C719113864A; Wed,  2 Oct 2019 21:04:28 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH v2 0/6] qcow2: advanced compression options
References: <157002883347.27524.13510585852065141081@8230166b0665>
 <75c7393b-5ad0-66d5-9592-388f0260a0de@virtuozzo.com>
 <5106e252-43d4-0ed5-ee65-a71a5e569bf7@redhat.com>
Date: Wed, 02 Oct 2019 21:04:28 +0200
In-Reply-To: <5106e252-43d4-0ed5-ee65-a71a5e569bf7@redhat.com> (Max Reitz's
 message of "Wed, 2 Oct 2019 17:58:57 +0200")
Message-ID: <87imp7q88z.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Wed, 02 Oct 2019 19:04:39 +0000 (UTC)
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, "fam@euphon.net" <fam@euphon.net>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "patchew-devel@redhat.com" <patchew-devel@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Max Reitz <mreitz@redhat.com> writes:

> On 02.10.19 17:35, Vladimir Sementsov-Ogievskiy wrote:
>> Hi,
>> 
>> 02.10.2019 18:07, no-reply@patchew.org wrote:
>>> Patchew URL: https://patchew.org/QEMU/1570026166-748566-1-git-send-email-andrey.shinkevich@virtuozzo.com/
>>>
>>>
>>>
>>> Hi,
>>>
>>> This series failed the docker-quick@centos7 build test. Please find the testing commands and
>>> their output below. If you have Docker installed, you can probably reproduce it
>>> locally.
>>>
>>> === TEST SCRIPT BEGIN ===
>>> #!/bin/bash
>>> make docker-image-centos7 V=1 NETWORK=1
>>> time make docker-test-quick@centos7 SHOW_ENV=1 J=14 NETWORK=1
>>> === TEST SCRIPT END ===
>>>
>>>    CC      block/parallels.o
>>>    CC      block/blklogwrites.o
>>>    CC      block/block-backend.o
>>> /tmp/qemu-test/src/block/qcow2.c:4077:64: error: unknown type name 'AioTask'
>>>   static coroutine_fn int qcow2_co_pwritev_compressed_task_entry(AioTask *task)
>>>                                                                  ^
>>> /tmp/qemu-test/src/block/qcow2.c: In function 'qcow2_co_pwritev_compressed_part':
>>> /tmp/qemu-test/src/block/qcow2.c:4098:5: error: unknown type name 'AioTaskPool'
>>>       AioTaskPool *aio = NULL;
>>>       ^
>> 
>> 
>> Who knows, what is wrong with it? Seems patchew ignores Based-on: tag in cover-letter,
>> which is written as "Based-on: https://github.com/XanClic/qemu.git block"...
>> These new types and functions are defined in Max's block branch.
>
> It would be news to me if Patchew supported such URLs.  I just put it
> into my cover letter for human reviewers...
>
> (Actually, it would be news to me if Patchew supported Based-on at all
> reliably...)

https://github.com/patchew-project/patchew/commit/5e461e7c49c1913cb34349f45cc7566627b37288

I use Based-on: <Message-Id> all the time, and it works reliably for me.

