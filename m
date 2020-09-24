Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF737C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 16:41:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E08AE20738
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 16:41:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="JXWeGBHQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E08AE20738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLUJe-0001In-UH
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 12:41:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33326)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1kLTzQ-0007KJ-V0; Thu, 24 Sep 2020 12:21:00 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:45730)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1kLTzN-0006UV-LQ; Thu, 24 Sep 2020 12:21:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=bIxYOukvuVLNA62gPP9pTjTnW+BVNzF3xYkYcFNXXiM=; 
 b=JXWeGBHQy1zs7d314u/haJi6IhXaUX/5BYUPSw+1ZV7vVmODf94tYAbUnWquGMuPyUUGvbx3Kgd2AjMQufTo2mwbs9ViLc5NhaZTzX2YH5tOgqjyrRnHvbamcIAJBphlb+7PSQ7JrR119IT0Yf3oBWEdi+6cFOP01LHepaCGMi7+UxaYGk6zTemx+0cCEgR6CYF1kgUAHhAgQTNZQZyQc+Omkbhzyxt2nXD6MBs79Ys+2ueqI87B1agwgHdWfLxpd5iqyRflKOI3MS6ZKKgSJgARkV73QLi7gS0Y53gdw4jdipgbIOywxvPDGDc2goUAmCFGyIM+vtOoBAVTbuSXbw==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1kLTyz-0008Bh-L0; Thu, 24 Sep 2020 18:20:33 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1kLTyz-00046O-9d; Thu, 24 Sep 2020 18:20:33 +0200
From: Alberto Garcia <berto@igalia.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
Subject: Re: [PATCH v6 1/5] block/io: fix bdrv_co_block_status_above
In-Reply-To: <20200916122008.20303-2-vsementsov@virtuozzo.com>
References: <20200916122008.20303-1-vsementsov@virtuozzo.com>
 <20200916122008.20303-2-vsementsov@virtuozzo.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Thu, 24 Sep 2020 18:20:33 +0200
Message-ID: <w514knnqh7y.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 12:20:35
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
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed 16 Sep 2020 02:20:04 PM CEST, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> wrote:
> bdrv_co_block_status_above has several design problems with handling
> short backing files:
>
> 1. With want_zeros=true, it may return ret with BDRV_BLOCK_ZERO but
> without BDRV_BLOCK_ALLOCATED flag, when actually short backing file
> which produces these after-EOF zeros is inside requested backing
> sequence.
>
> 2. With want_zero=false, it may return pnum=0 prior to actual EOF,
> because of EOF of short backing file.
>
> Fix these things, making logic about short backing files clearer.
>
> With fixed bdrv_block_status_above we also have to improve is_zero in
> qcow2 code, otherwise iotest 154 will fail, because with this patch we
> stop to merge zeros of different types (produced by fully unallocated
> in the whole backing chain regions vs produced by short backing files).
>
> Note also, that this patch leaves for another day the general problem
> around block-status: misuse of BDRV_BLOCK_ALLOCATED as is-fs-allocated
> vs go-to-backing.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto

