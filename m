Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A54D6C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 20:15:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F5D0206BE
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 20:15:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="MlM+wTTO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F5D0206BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAIs6-0007u9-Kh
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 16:15:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55286)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1kAIrV-0007QP-Qz; Mon, 24 Aug 2020 16:14:38 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:49072)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1kAIrT-00058M-CJ; Mon, 24 Aug 2020 16:14:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=CVc+StmM4+XfHzMbz+hMfqM8LqOD19wh0yzhM0+l0Xw=; 
 b=MlM+wTTOmO9KU4nS6UGyNk/GHrTqWJh44IWfCDmvr28giiCT0F1+zlWMVrCja4oMZ2CMQPkzn7UTxqY8h2t/hN/W7e5EZ4hWa2D94RjWhvlNDMu2ZeCZEspKbWkOgnsl+Yidl673kjEQLFaRiKk6Z5hgjVxJYptzXC29NLdUXZU01xiR9qyIafBavzcNi+AZiPGR+OYirqw8zF7lqrbX4DQcKHuVCY/oMYomWMbk+nhupQW4gBFBNdvJSHKAb7ewxqmpvfPM8O4PdadWy6rALxFnH2BRUpbhF51eih41jaPCmTz8fQmvWBJ75M7D5czGmEfz2FhJYqkJHeRqOW0o+A==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1kAIr1-0006yi-WC; Mon, 24 Aug 2020 22:14:08 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1kAIr1-0007Mx-Mo; Mon, 24 Aug 2020 22:14:07 +0200
From: Alberto Garcia <berto@igalia.com>
To: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 0/1] qcow2: Skip copy-on-write when allocating a zero
 cluster
In-Reply-To: <20200823215907.GH7941@dread.disaster.area>
References: <w518sedz3td.fsf@maestria.local.igalia.com>
 <20200817155307.GS11402@linux.fritz.box>
 <w51pn7memr7.fsf@maestria.local.igalia.com>
 <20200819150711.GE10272@linux.fritz.box> <20200819175300.GA141399@bfoster>
 <w51v9hdultt.fsf@maestria.local.igalia.com>
 <20200820215811.GC7941@dread.disaster.area> <20200821110506.GB212879@bfoster>
 <w51364gjkcj.fsf@maestria.local.igalia.com>
 <w51zh6oi4en.fsf@maestria.local.igalia.com>
 <20200823215907.GH7941@dread.disaster.area>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Mon, 24 Aug 2020 22:14:07 +0200
Message-ID: <w51wo1nu7hs.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/24 16:14:12
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org,
 Brian Foster <bfoster@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, linux-xfs@vger.kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun 23 Aug 2020 11:59:07 PM CEST, Dave Chinner wrote:
>> >> Option 4 is described above as initial file preallocation whereas
>> >> option 1 is per 64k cluster prealloc. Prealloc mode mixup aside, Berto
>> >> is reporting that the initial file preallocation mode is slower than
>> >> the per cluster prealloc mode. Berto, am I following that right?
>> 
>> After looking more closely at the data I can see that there is a peak of
>> ~30K IOPS during the first 5 or 6 seconds and then it suddenly drops to
>> ~7K for the rest of the test.
>
> How big is the filesystem, how big is the log? (xfs_info output,
> please!)

The size of the filesystem is 126GB and here's the output of xfs_info:

meta-data=/dev/vg/test           isize=512    agcount=4, agsize=8248576 blks
         =                       sectsz=512   attr=2, projid32bit=1
         =                       crc=1        finobt=1, sparse=1, rmapbt=0
         =                       reflink=0
data     =                       bsize=4096   blocks=32994304, imaxpct=25
         =                       sunit=0      swidth=0 blks
naming   =version 2              bsize=4096   ascii-ci=0, ftype=1
log      =internal log           bsize=4096   blocks=16110, version=2
         =                       sectsz=512   sunit=0 blks, lazy-count=1
realtime =none                   extsz=4096   blocks=0, rtextents=0

>> I was running fio with --ramp_time=5 which ignores the first 5 seconds
>> of data in order to let performance settle, but if I remove that I can
>> see the effect more clearly. I can observe it with raw files (in 'off'
>> and 'prealloc' modes) and qcow2 files in 'prealloc' mode. With qcow2 and
>> preallocation=off the performance is stable during the whole test.
>
> What does "preallocation=off" mean again? Is that using
> fallocate(ZERO_RANGE) prior to the data write rather than
> preallocating the metadata/entire file?

Exactly, it means that. One fallocate() call before each data write
(unless the area has been allocated by a previous write).

> If so, I would expect the limiting factor is the rate at which IO can
> be issued because of the fallocate() triggered pipeline bubbles. That
> leaves idle device time so you're not pushing the limits of the
> hardware and hence none of the behaviours above will be evident...

The thing is that with raw (i.e. non-qcow2) images the number of IOPS is
similar, but in that case there are no fallocate() calls, only the data
writes.

Berto

