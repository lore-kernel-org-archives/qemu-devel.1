Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD82C2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 17:58:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67A2F2223E
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 17:58:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="mdLm4EUF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67A2F2223E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL92b-0003T9-A4
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 13:58:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45736)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1kL8s6-00016d-Ts; Wed, 23 Sep 2020 13:48:04 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:42268)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1kL8s4-00041V-FK; Wed, 23 Sep 2020 13:48:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=uaj/cq26YHhVXUVVWrAwZeFzMC8INHC65wIDXf8YewA=; 
 b=mdLm4EUFKGhyO1SmMetF1rZN1MDjmtjlHrhnCn9r8R/oomwaa1v/f5J0AnEPuVegYmhthpBQDRVL8a3im38LDK3hpPgumB5TwC/ARYxfwmS9iE7NhMh/TdBsbKKibjmgdgEgxOR6i1vLM7+4DcZRS4CFb48uAcsHiZt7XfQBwQunfNRomlYBed4aDcpuw7Wt1wES8aiQTI6FY/QMcrBOudyUJiVRveIVDdkxKtRe2aDyMGN6l/nBaDo6y7yGsZloISSMm3Ff6CHZRd27KcRfy0hV519vOnjzHIjWNv+vzfId2/pgjoTU3m82AkNrWEsQJrAlhEfLWR5+DkRUYbWW6A==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1kL8ry-0004sR-Rn; Wed, 23 Sep 2020 19:47:54 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1kL8ry-0003JO-Hz; Wed, 23 Sep 2020 19:47:54 +0200
From: Alberto Garcia <berto@igalia.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
Subject: Re: [PATCH v6 2/5] block/io: bdrv_common_block_status_above: support
 include_base
In-Reply-To: <6181089a-8910-442e-35ed-e1bca0bde3eb@virtuozzo.com>
References: <20200916122008.20303-1-vsementsov@virtuozzo.com>
 <20200916122008.20303-3-vsementsov@virtuozzo.com>
 <w51tuvoa2l8.fsf@maestria.local.igalia.com>
 <6181089a-8910-442e-35ed-e1bca0bde3eb@virtuozzo.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Wed, 23 Sep 2020 19:47:54 +0200
Message-ID: <w51o8lw9ygl.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 11:59:29
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
Cc: fam@euphon.net, kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com,
 stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed 23 Sep 2020 07:11:57 PM CEST, Vladimir Sementsov-Ogievskiy wrote:
>>     BlockDriverState *last_bs = include_base ? base : backing_bs(base);
>
> hmm, in case when include_base is false, last bs is not
> backing_bs(base) but the parent of base.

Oops, yes, it should be the other way around %-)

>> But why do we need include_base at all? Can't the caller just pass
>> backing_bs(base) instead? I'm talking also about the existing case of
>> bdrv_is_allocated_above().
>
> include_base was introduced for the case when caller doesn't own
> backing_bs(base), and therefore shouldn't do operations that may yield
> (block_status can) dependent on backing_bs(base). In particular, in
> block stream, where link to base is not frozen.

You're right, thanks!

Berto

