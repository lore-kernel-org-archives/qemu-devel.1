Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F322C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 12:54:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 602B120757
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 12:54:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="jGantC11"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 602B120757
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFzci-00011E-I6
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 08:54:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53340)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1kFza7-00069o-L2; Wed, 09 Sep 2020 08:52:13 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:51210)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1kFza4-0000Zb-IK; Wed, 09 Sep 2020 08:52:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=VXfY1r7rQS0sTs3bmapu1e9mk3gFDjJHHSztYno2sEk=; 
 b=jGantC11FfUiOuz4fCZo5xXOYX8+/DmJTaktQY7ywZq3JWLxZZQXTVK+pVzpDLydJtDY2j5YHQmd7h7CNsI9pNpiKVazUmNm8gpQ5mHSZx12ByM9Kd85cgh6vGj30fSRHR2PAE4EENQ/wTon0vVI51K1oJ4fx3O35n2V0hd4A8wCTFCwHoxbpFBs0t9jkSDAoZIzzAkZPx6f6QDBNfJ2gKqkejWSnVe6PyCIn5LZPyNtqrLkSMt5wW957Ibl0ZzxcULaLlsKRR8MCPKpdEFGy6yKDvOWhwF5IAxmGuipXjGR3Pi9ZNkubPeX9chcrIDS2BeOg8Q1pezKY8NUSndzZQ==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1kFza1-0001jr-80; Wed, 09 Sep 2020 14:52:05 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1kFza0-000760-Uy; Wed, 09 Sep 2020 14:52:04 +0200
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH v2] qcow2: Skip copy-on-write when allocating a zero
 cluster
In-Reply-To: <20200827145350.26686-1-berto@igalia.com>
References: <20200827145350.26686-1-berto@igalia.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Wed, 09 Sep 2020 14:52:04 +0200
Message-ID: <w517dt3864r.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 08:37:57
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
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

ping

On Thu 27 Aug 2020 04:53:50 PM CEST, Alberto Garcia wrote:
> Since commit c8bb23cbdbe32f5c326365e0a82e1b0e68cdcd8a when a write
> request results in a new allocation QEMU first tries to see if the
> rest of the cluster outside the written area contains only zeroes.
>
> In that case, instead of doing a normal copy-on-write operation and
> writing explicit zero buffers to disk, the code zeroes the whole
> cluster efficiently using pwrite_zeroes() with BDRV_REQ_NO_FALLBACK.
>
> This improves performance very significantly but it only happens when
> we are writing to an area that was completely unallocated before. Zero
> clusters (QCOW2_CLUSTER_ZERO_*) are treated like normal clusters and
> are therefore slower to allocate.
>
> This happens because the code uses bdrv_is_allocated_above() rather
> bdrv_block_status_above(). The former is not as accurate for this
> purpose but it is faster. However in the case of qcow2 the underlying
> call does already report zero clusters just fine so there is no reason
> why we cannot use that information.
>
> After testing 4KB writes on an image that only contains zero clusters
> this patch results in almost five times more IOPS.

Berto

