Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C43FEC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 11:50:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CD16204EC
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 11:50:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="HGctZZXs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CD16204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k95Yx-0007EF-TD
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 07:50:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47444)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1k95Ro-0005R5-Sr; Fri, 21 Aug 2020 07:43:05 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:33386)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1k95Rm-0002cj-1s; Fri, 21 Aug 2020 07:43:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=byw5FHP0QNR9zGuxmfXyJoD9uwLZ4Jn9n8QdBxcGVW0=; 
 b=HGctZZXsiJrdzbcJNaA3CwgEdC//xAQz06bOlUjUhb5G3isxxiColxa1dvVfBOZ9Coc9X+xzRWoB3srnAUttlwOWhIXN9tt/Mf8Hoi1XpU/RCNiOhpEoP7A5kdUZj+R8PpdPhj/AkZPB62/TFW9M0S+Mif3K8ipIGEU7ZEnaBIJqbjL3jlKXJfaSxG6rjskWjNr7ToRYiPsVBhsH2jNQsVQlRvSD421qvVKgsX27fBdOG/vYMc7KwVP9YQC2ML0MmmsNY37Jqmwf5BTL5JxLYlhMwRsskuE5x49SA9qfjNL/SEf7pNpc2kMcpRCfzL5fcHNOEJsOe/aHcOREw1qklg==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1k95Rc-0006Wj-Rq; Fri, 21 Aug 2020 13:42:52 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1k95Rc-0004rL-HW; Fri, 21 Aug 2020 13:42:52 +0200
From: Alberto Garcia <berto@igalia.com>
To: Brian Foster <bfoster@redhat.com>, Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 0/1] qcow2: Skip copy-on-write when allocating a zero
 cluster
In-Reply-To: <20200821110506.GB212879@bfoster>
References: <cover.1597416317.git.berto@igalia.com>
 <20200817101019.GD11402@linux.fritz.box>
 <w518sedz3td.fsf@maestria.local.igalia.com>
 <20200817155307.GS11402@linux.fritz.box>
 <w51pn7memr7.fsf@maestria.local.igalia.com>
 <20200819150711.GE10272@linux.fritz.box> <20200819175300.GA141399@bfoster>
 <w51v9hdultt.fsf@maestria.local.igalia.com>
 <20200820215811.GC7941@dread.disaster.area> <20200821110506.GB212879@bfoster>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Fri, 21 Aug 2020 13:42:52 +0200
Message-ID: <w51364gjkcj.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 07:08:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 linux-xfs@vger.kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri 21 Aug 2020 01:05:06 PM CEST, Brian Foster <bfoster@redhat.com> wrote:
>> > 1) off: for every write request QEMU initializes the cluster (64KB)
>> >         with fallocate(ZERO_RANGE) and then writes the 4KB of data.
>> > 
>> > 2) off w/o ZERO_RANGE: QEMU writes the 4KB of data and fills the rest
>> >         of the cluster with zeroes.
>> > 
>> > 3) metadata: all clusters were allocated when the image was created
>> >         but they are sparse, QEMU only writes the 4KB of data.
>> > 
>> > 4) falloc: all clusters were allocated with fallocate() when the image
>> >         was created, QEMU only writes 4KB of data.
>> > 
>> > 5) full: all clusters were allocated by writing zeroes to all of them
>> >         when the image was created, QEMU only writes 4KB of data.
>> > 
>> > As I said in a previous message I'm not familiar with xfs, but the
>> > parts that I don't understand are
>> > 
>> >    - Why is (4) slower than (1)?
>> 
>> Because fallocate() is a full IO serialisation barrier at the
>> filesystem level. If you do:
>> 
>> fallocate(whole file)
>> <IO>
>> <IO>
>> <IO>
>> .....
>> 
>> The IO can run concurrent and does not serialise against anything in
>> the filesysetm except unwritten extent conversions at IO completion
>> (see answer to next question!)
>> 
>> However, if you just use (4) you get:
>> 
>> falloc(64k)
>>   <wait for inflight IO to complete>
>>   <allocates 64k as unwritten>
>> <4k io>
>>   ....
>> falloc(64k)
>>   <wait for inflight IO to complete>
>>   ....
>>   <4k IO completes, converts 4k to written>
>>   <allocates 64k as unwritten>
>> <4k io>
>> falloc(64k)
>>   <wait for inflight IO to complete>
>>   ....
>>   <4k IO completes, converts 4k to written>
>>   <allocates 64k as unwritten>
>> <4k io>
>>   ....
>> 
>
> Option 4 is described above as initial file preallocation whereas
> option 1 is per 64k cluster prealloc. Prealloc mode mixup aside, Berto
> is reporting that the initial file preallocation mode is slower than
> the per cluster prealloc mode. Berto, am I following that right?

Option (1) means that no qcow2 cluster is allocated at the beginning of
the test so, apart from updating the relevant qcow2 metadata, each write
request clears the cluster first (with fallocate(ZERO_RANGE)) then
writes the requested 4KB of data. Further writes to the same cluster
don't need changes on the qcow2 metadata so they go directly to the area
that was cleared with fallocate().

Option (4) means that all clusters are allocated when the image is
created and they are initialized with fallocate() (actually with
posix_fallocate() now that I read the code, I suppose it's the same for
xfs?). Only after that the test starts. All write requests are simply
forwarded to the disk, there is no need to touch any qcow2 metadata nor
do anything else.

And yes, (4) is a bit slower than (1) in my tests. On ext4 I get 10%
more IOPS.

I just ran the tests with aio=native and with a raw image instead of
qcow2, here are the results:

qcow2:
|----------------------+-------------+------------|
| preallocation        | aio=threads | aio=native |
|----------------------+-------------+------------|
| off                  |        8139 |       7649 |
| off (w/o ZERO_RANGE) |        2965 |       2779 |
| metadata             |        7768 |       8265 |
| falloc               |        7742 |       7956 |
| full                 |       41389 |      56668 |
|----------------------+-------------+------------|

raw:
|---------------+-------------+------------|
| preallocation | aio=threads | aio=native |
|---------------+-------------+------------|
| off           |        7647 |       7928 |
| falloc        |        7662 |       7856 |
| full          |       45224 |      58627 |
|---------------+-------------+------------|

A qcow2 file with preallocation=metadata is more or less similar to a
sparse raw file (and the numbers are indeed similar).

preallocation=off on qcow2 does not have an equivalent on raw files.

Berto

