Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87613C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 14:26:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E7A92076E
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 14:26:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="TAzHyBAp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E7A92076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8P2S-0002Nl-Hm
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 10:26:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43990)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1k8P1n-0001tc-WB; Wed, 19 Aug 2020 10:25:24 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:41649)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1k8P1l-0008Mn-0w; Wed, 19 Aug 2020 10:25:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=bmTOdycsi+/DSc9HRJbtzGFxOWXqK4qfIg1yiai7eFw=; 
 b=TAzHyBApXMaAiqJCSVKqjhtYh2yaNASmYkIjCneslwsuwj4EuoDqPad6SMenr31cftINdfhNwvaBe3jnKPUwUPSiatCTt1pEQwSoK5EpkpSWG9RTL9/+S8qQJ8uNSpDJAJM6uGuBpqWDFKKSoUpTuPJPruqNxFGVpF2RZDhNBxhCDlh0sm/k3uDHIw3iC8Qda5WixlaRfbbtgD6thDG4k3eAEgic/uC2eJlLS7P7u4k5FvrwRbe9Szw8zJy3CDriuo56edyMHuKSz936LSsSxedYMFDavxFCfdqFirlclS2FrY4KuentKojuwqiR+hoPeSjUXhZDvM4yWN4QLZwk6A==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1k8P1h-0007G9-59; Wed, 19 Aug 2020 16:25:17 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1k8P1g-0006eN-Rm; Wed, 19 Aug 2020 16:25:16 +0200
From: Alberto Garcia <berto@igalia.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH 0/1] qcow2: Skip copy-on-write when allocating a zero
 cluster
In-Reply-To: <20200817155307.GS11402@linux.fritz.box>
References: <cover.1597416317.git.berto@igalia.com>
 <20200817101019.GD11402@linux.fritz.box>
 <w518sedz3td.fsf@maestria.local.igalia.com>
 <20200817155307.GS11402@linux.fritz.box>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Wed, 19 Aug 2020 16:25:16 +0200
Message-ID: <w51pn7memr7.fsf@maestria.local.igalia.com>
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon 17 Aug 2020 05:53:07 PM CEST, Kevin Wolf wrote:
>> > Or are you saying that ZERO_RANGE + pwrite on a sparse file (=
>> > cluster allocation) is faster for you than just the pwrite alone (=
>> > writing to already allocated cluster)?
>> 
>> Yes, 20% faster in my tests (4KB random writes), but in the latter
>> case the cluster is already allocated only at the qcow2 level, not on
>> the filesystem. preallocation=falloc is faster than
>> preallocation=metadata (preallocation=off sits in the middle).
>
> Hm, this feels wrong. Doing more operations should never be faster
> than doing less operations.
>
> Maybe the difference is in allocating 64k at once instead of doing a
> separate allocation for every 4k block? But with the extent size hint
> patches to file-posix, we should allocate 1 MB at once by default now
> (if your test image was newly created). Can you check whether this is
> in effect for your image file?

I checked with xfs on my computer. I'm not very familiar with that
filesystem so I was using the default options and I didn't tune
anything.

What I got with my tests (using fio):

- Using extent_size_hint didn't make any difference in my test case (I
  do see a clear difference however with the test case described in
  commit ffa244c84a).

- preallocation=off is still faster than preallocation=metadata. If I
  disable handle_alloc_space() (so there is no ZERO_RANGE used) then it
  is much slower.

- With preallocation=falloc I get the same results as with
  preallocation=metadata.

- preallocation=full is the fastest by far.

Berto

