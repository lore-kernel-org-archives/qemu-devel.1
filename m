Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 795A3C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 16:10:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49F55207BB
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 16:10:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="NpdT7OOv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49F55207BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k99cO-0004NO-Jt
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 12:10:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55428)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1k99ba-0003ii-Gt; Fri, 21 Aug 2020 12:09:26 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:50520)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1k99bX-0003kS-MN; Fri, 21 Aug 2020 12:09:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=HKTMsNp5hdfddF2CMEl3UvWb/KifxWfDDcTpl5rgRVU=; 
 b=NpdT7OOv3uSjYlG0n1d1NqLGxmDh4/0absUWX1et7DLHJdDyuluOh+MJwNjZkuF+Y5Wv0hNlrO9LIKCMmtw0tyFG7s5IQBPdxuFnz4dQ7kWYZYkHsBFkHKowhJYtvo/Rdr8u0OFsvvfhFwWUDmit3p+QtShaJLkHY75y9LGwzUrS8W3OcjuVO6SopYMo1BztZ6yjGKREIDbDv1krY2oVZigi3tw0BSLVMQjTa39f7Q9+Dtcoeb1N3km3R36sGbQjA8dXKtM58EKN5NVxyrs0zmdi30hHE5PeaSUPl0KNuoAc2HRPC9nlMPbT7WMHm8bA6ti6gUQVhfANvnyuN86SfA==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1k99bR-0000ar-GM; Fri, 21 Aug 2020 18:09:17 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1k99bR-0002JJ-6v; Fri, 21 Aug 2020 18:09:17 +0200
From: Alberto Garcia <berto@igalia.com>
To: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 0/1] qcow2: Skip copy-on-write when allocating a zero
 cluster
In-Reply-To: <20200820215811.GC7941@dread.disaster.area>
References: <cover.1597416317.git.berto@igalia.com>
 <20200817101019.GD11402@linux.fritz.box>
 <w518sedz3td.fsf@maestria.local.igalia.com>
 <20200817155307.GS11402@linux.fritz.box>
 <w51pn7memr7.fsf@maestria.local.igalia.com>
 <20200819150711.GE10272@linux.fritz.box> <20200819175300.GA141399@bfoster>
 <w51v9hdultt.fsf@maestria.local.igalia.com>
 <20200820215811.GC7941@dread.disaster.area>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Fri, 21 Aug 2020 18:09:17 +0200
Message-ID: <w51pn7khtg2.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 11:04:22
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
 Brian Foster <bfoster@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, linux-xfs@vger.kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu 20 Aug 2020 11:58:11 PM CEST, Dave Chinner wrote:
>> The virtual drive (/dev/vdb) is a freshly created qcow2 file stored on
>> the host (on an xfs or ext4 filesystem as the table above shows), and
>> it is attached to QEMU using a virtio-blk-pci device:
>> 
>>    -drive if=virtio,file=image.qcow2,cache=none,l2-cache-size=200M
>
> You're not using AIO on this image file, so it can't do
> concurrent IO? what happens when you add "aio=native" to this?

I sent the results on a reply to Brian.

>> cache=none means that the image is opened with O_DIRECT and
>> l2-cache-size is large enough so QEMU is able to cache all the
>> relevant qcow2 metadata in memory.
>
> What happens when you just use a sparse file (i.e. a raw image) with
> aio=native instead of using qcow2? XFS, ext4, btrfs, etc all support
> sparse files so using qcow2 to provide sparse image file support is
> largely an unnecessary layer of indirection and overhead...
>
> And with XFS, you don't need qcow2 for snapshots either because you
> can use reflink copies to take an atomic copy-on-write snapshot of the
> raw image file... (assuming you made the xfs filesystem with reflink
> support (which is the TOT default now)).

To be clear, I'm not trying to advocate for or against qcow2 on xfs, we
were just analyzing different allocation strategies for qcow2 and we
came across these results which we don't quite understand.

>> 1) off: for every write request QEMU initializes the cluster (64KB)
>>         with fallocate(ZERO_RANGE) and then writes the 4KB of data.
>> 
>> 2) off w/o ZERO_RANGE: QEMU writes the 4KB of data and fills the rest
>>         of the cluster with zeroes.
>> 
>> 3) metadata: all clusters were allocated when the image was created
>>         but they are sparse, QEMU only writes the 4KB of data.
>> 
>> 4) falloc: all clusters were allocated with fallocate() when the image
>>         was created, QEMU only writes 4KB of data.
>> 
>> 5) full: all clusters were allocated by writing zeroes to all of them
>>         when the image was created, QEMU only writes 4KB of data.
>> 
>> As I said in a previous message I'm not familiar with xfs, but the
>> parts that I don't understand are
>> 
>>    - Why is (4) slower than (1)?
>
> Because fallocate() is a full IO serialisation barrier at the
> filesystem level. If you do:
>
> fallocate(whole file)
> <IO>
> <IO>
> <IO>
> .....
>
> The IO can run concurrent and does not serialise against anything in
> the filesysetm except unwritten extent conversions at IO completion
> (see answer to next question!)
>
> However, if you just use (4) you get:
>
> falloc(64k)
>   <wait for inflight IO to complete>
>   <allocates 64k as unwritten>
> <4k io>
>   ....
> falloc(64k)
>   <wait for inflight IO to complete>
>   ....
>   <4k IO completes, converts 4k to written>
>   <allocates 64k as unwritten>
> <4k io>

I think Brian pointed it out already, but scenario (4) is rather
falloc(25GB), then QEMU is launched and the actual 4k IO requests start
to happen.

So I would expect that after falloc(25GB) all clusters are initialized
and the end result would be closer to a full preallocation (i.e. writing
25GB worth of zeroes to disk).

> IOWs, typical "write once" benchmark testing indicates the *worst*
> performance you are going to see. As the guest filesytsem ages and
> initialises more of the underlying image file, it will get faster, not
> slower.

Yes, that's clear, once everything is allocation then it is fast (and
really much faster in the case of xfs vs ext4), what we try to optimize
in qcow2 is precisely the allocation of new clusters.

Berto

