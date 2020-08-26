Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC7FBC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 18:35:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D8692083B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 18:35:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="bmi0CLc7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D8692083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kB0H3-0004X6-Ld
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 14:35:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57250)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1kB0Fu-0002yV-V1; Wed, 26 Aug 2020 14:34:42 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:54343)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1kB0Fs-0008PK-A5; Wed, 26 Aug 2020 14:34:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=/hZsxkMu//hdGcZkF5Nm74Qa9GNadrEHHn2DxAUVZIU=; 
 b=bmi0CLc7gmloG25iu/MacY9fKilBV5Nr4ohkoFSXdpWnKCDDLjx/QC6KwXFp6S31dCWTw0876dfiJC+JWHR4W/YpTiGyOlmGQ7QSlVgUjrE5nwD4ycQLQWtmxOeDqH2QFagkrhbZCepO44yHFL+fTuDxAHqJ4jDW2ua1HJrYNOU8K1WMcIJ2KY3OCVqv82Yd/d46cFqMy+/qlKoW5oCqPCOqEf/FDpAaBAsB3OlWjkUGo9EUyIpXDr3mWGktuk4naoyjXGd5P+dnwQk8my8mFv9L4mWreppAPHn9PX/IVtPjLyL7GEUvonKeiK+QssAeFZ8lNAlouthQJg5uL0rVxQ==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1kB0Fk-0007fI-GJ; Wed, 26 Aug 2020 20:34:32 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1kB0Fk-00026U-6m; Wed, 26 Aug 2020 20:34:32 +0200
From: Alberto Garcia <berto@igalia.com>
To: Brian Foster <bfoster@redhat.com>
Subject: Re: [PATCH 0/1] qcow2: Skip copy-on-write when allocating a zero
 cluster
In-Reply-To: <20200825194724.GA338144@bfoster>
References: <20200819175300.GA141399@bfoster>
 <w51v9hdultt.fsf@maestria.local.igalia.com>
 <20200820215811.GC7941@dread.disaster.area> <20200821110506.GB212879@bfoster>
 <w51364gjkcj.fsf@maestria.local.igalia.com>
 <w51zh6oi4en.fsf@maestria.local.igalia.com> <20200821170232.GA220086@bfoster>
 <w51d03evrol.fsf@maestria.local.igalia.com> <20200825165415.GB321765@bfoster>
 <w51d03etzj8.fsf@maestria.local.igalia.com> <20200825194724.GA338144@bfoster>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Wed, 26 Aug 2020 20:34:32 +0200
Message-ID: <w51wo1l6ytj.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 14:00:31
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
 Dave Chinner <david@fromorbit.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, linux-xfs@vger.kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue 25 Aug 2020 09:47:24 PM CEST, Brian Foster <bfoster@redhat.com> wrote:
> My fio fallocates the entire file by default with this command. Is that
> the intent of this particular test? I added --fallocate=none to my test
> runs to incorporate the allocation cost in the I/Os.

That wasn't intentional, you're right, it should use --fallocate=none (I
don't see a big difference in my test anyway).

>> The Linux version is 4.19.132-1 from Debian.
>
> Thanks. I don't have LUKS in the mix on my box, but I was running on a
> more recent kernel (Fedora 5.7.15-100). I threw v4.19 on the box and
> saw a bit more of a delta between XFS (~14k iops) and ext4 (~24k). The
> same test shows ~17k iops for XFS and ~19k iops for ext4 on v5.7. If I
> increase the size of the LVM volume from 126G to >1TB, ext4 runs at
> roughly the same rate and XFS closes the gap to around ~19k iops as
> well. I'm not sure what might have changed since v4.19, but care to
> see if this is still an issue on a more recent kernel?

Ok, I gave 5.7.10-1 a try but I still get similar numbers.

Perhaps with a larger filesystem there would be a difference? I don't
know.

Berto

