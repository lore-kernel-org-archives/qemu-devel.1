Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C438EC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 15:38:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AF22207FF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 15:38:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="A64VMJg4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AF22207FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8QAB-0004ZV-OC
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 11:38:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37872)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1k8Q9P-00048x-Pb; Wed, 19 Aug 2020 11:37:20 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:55339)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1k8Q9M-00027Y-Cm; Wed, 19 Aug 2020 11:37:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=0T4RlsT2sSUKUGPqYvw5XiBU2ZIeTCZIyh7Mpg1z6xI=; 
 b=A64VMJg41OeI27A+16EhWaHLt1RfYF9P8k4elxmZQ8UjXMo36wCjTfbtR2t6ijbvDL863ipBZI9fS0iXADkqORFHnx0KlciMFs2rNK3LzGuoouNVnkkyD0qAbLuyVXIVPeYCZFXnLt9QuiyTQFXSqKJNTM6lkEKkp14NL8wKK7lfdUICbpKjfdEWpYHxY5yofrRYf01SQbK0NnuKP05Mq6q4WT2XKS6yiaIExhQWmY+rxsqyvQWqhouxoyjk/wfPOCM4gxlB6ivpd+kcIxa7tLVT5K86K3rjzzVIpWE9ttrPmtgQXxeZax6be7DS2HsULm5CJZ3GGDi29pslakfeHA==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1k8Q9I-0002oF-OA; Wed, 19 Aug 2020 17:37:12 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1k8Q9I-0002Na-Et; Wed, 19 Aug 2020 17:37:12 +0200
From: Alberto Garcia <berto@igalia.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH 0/1] qcow2: Skip copy-on-write when allocating a zero
 cluster
In-Reply-To: <20200819150711.GE10272@linux.fritz.box>
References: <cover.1597416317.git.berto@igalia.com>
 <20200817101019.GD11402@linux.fritz.box>
 <w518sedz3td.fsf@maestria.local.igalia.com>
 <20200817155307.GS11402@linux.fritz.box>
 <w51pn7memr7.fsf@maestria.local.igalia.com>
 <20200819150711.GE10272@linux.fritz.box>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Wed, 19 Aug 2020 17:37:12 +0200
Message-ID: <w51mu2qejfb.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 10:25:17
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
Cc: bfoster@redhat.com, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed 19 Aug 2020 05:07:11 PM CEST, Kevin Wolf wrote:
>> I checked with xfs on my computer. I'm not very familiar with that
>> filesystem so I was using the default options and I didn't tune
>> anything.
>> 
>> What I got with my tests (using fio):
>> 
>> - Using extent_size_hint didn't make any difference in my test case (I
>>   do see a clear difference however with the test case described in
>>   commit ffa244c84a).
>
> Hm, interesting. What is your exact fio configuration? Specifically,
> which iodepth are you using? I guess with a low iodepth (and O_DIRECT),
> the effect of draining the queue might not be as visible.

fio --filename=/dev/vdb --direct=1 --randrepeat=1 --eta=always
    --ioengine=libaio --iodepth=32 --numjobs=1 --name=test --size=25G
    --io_limit=25G --ramp_time=5 --rw=randwrite --bs=4k --runtime=60

>> - preallocation=off is still faster than preallocation=metadata.
>
> Brian, can you help us here with some input?
>
> Essentially what we're having here is a sparse image file on XFS that
> is opened with O_DIRECT (presumably - Berto, is this right?), and
> Berto is seeing cases where a random write benchmark is faster if
> we're doing the 64k ZERO_RANGE + 4k pwrite when touching a 64k cluster
> for the first time compared to always just doing the 4k pwrite. This
> is with a 1 MB extent size hint.

A couple of notes:

- Yes, it's O_DIRECT (the image is opened with cache=none and fio uses
  --direct=1).

- The extent size hint is the default one, I didn't change or set
  anything for this test (or should I have?).

> From the discussions we had the other day [1][2] I took away that your
> suggestion is that we should not try to optimise things with
> fallocate(), but just write the areas we really want to write and let
> the filesystem deal with the sparse parts. Especially with the extent
> size hint that we're now setting, I'm surprised to hear that doing a
> ZERO_RANGE first still seems to improve the performance.
>
> Do you have any idea why this is happening and what we should be doing
> with this?
>
> [1] https://bugzilla.redhat.com/show_bug.cgi?id=1850660
> [2] https://bugzilla.redhat.com/show_bug.cgi?id=1666864
>
>>   If I disable handle_alloc_space() (so there is no ZERO_RANGE used)
>>   then it is much slower.
>
> This makes some sense because then we're falling back to writing
> explicit zero buffers (unless you disabled that, too).

Exactly, this happens on both ext4 and xfs.

>> - With preallocation=falloc I get the same results as with
>>   preallocation=metadata.
>
> Interesting, this means that the fallocate() call costs you basically
> no time. I would have expected preallocation=falloc to be a little
> faster.

I would expect preallocation=falloc to be at least as fast as
preallocation=off (and it is, on ext4). However on xfs it seems to be
slower (?). It doesn't make sense to me.

>> - preallocation=full is the fastest by far.
>
> I guess this saves the conversion of unwritten extents to fully
> allocated ones?

However it is *much* *much* faster. I assume I must be missing something
on how the filesystem works.

I ran the test again on a newly created filesystem just to make sure,
here are the full results (numbers are IOPS):

|----------------------+-------+-------|
| preallocation        |  ext4 |   xfs |
|----------------------+-------+-------|
| off                  | 11688 |  6981 |
| off (w/o ZERO_RANGE) |  2780 |  3196 |
| metadata             |  9132 |  5764 |
| falloc               | 13108 |  5727 |
| full                 | 16351 | 40759 |
|----------------------+-------+-------|

Berto

