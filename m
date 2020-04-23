Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA635C54FCB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 17:24:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 714F120728
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 17:24:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="GS0h1mYp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 714F120728
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRe8S-0004Ia-1V
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 11:51:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58308)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1jRe7J-0001mI-T3
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 11:50:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1jRe7J-0003De-CR
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 11:50:21 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:51591)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jRe7I-00031T-QI; Thu, 23 Apr 2020 11:50:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=drErQEP5JvS9q3AIfet3ApdE8eT1M9t66sO/KV2VWz0=; 
 b=GS0h1mYpSUJrUOVL4Yoy6TRqltGXW109do9PqfdyRZ8GEuOPV8w1mzm+fpal+TzQtm8tseZAy/HB6LPSbrmLKaucSCn7Y/76kKL4xY2vTguLn4yK2jqgjajCX7RnEc0JtE0CUGBMsWVKGj6/sZp1vTYV51mDEQfLxsm0RuB2JIvH1shfHN+8grNT0VvPNcqKju55gyRl5eGb0Od/terz9sP+ptYFZF8OJ8YZBvtSgujtuv2H0C0SunG92mXqzQLWjxwFU8TQJnDz4vGwRfzMh1ee3aVg06htTj9DRcCddkVnIBSkw8mLU3e1Its0A48yWVc9E79CWkalot0yKQ8vxg==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1jRe7F-00008v-JD; Thu, 23 Apr 2020 17:50:17 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1jRe7F-00067B-9I; Thu, 23 Apr 2020 17:50:17 +0200
From: Alberto Garcia <berto@igalia.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v4 22/30] qcow2: Fix offset calculation in
 handle_dependencies()
In-Reply-To: <35b102b8-d443-ec4e-ddf2-e2528ebd145a@virtuozzo.com>
References: <cover.1584468723.git.berto@igalia.com>
 <46d9ec6dca0b054a529ee776d1c04b002098c127.1584468723.git.berto@igalia.com>
 <35b102b8-d443-ec4e-ddf2-e2528ebd145a@virtuozzo.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Thu, 23 Apr 2020 17:50:17 +0200
Message-ID: <w51v9lq5hhi.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 10:18:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic] [fuzzy]
X-Received-From: 178.60.130.6
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
Cc: Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 "Denis V . Lunev" <den@openvz.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed 22 Apr 2020 02:38:54 PM CEST, Vladimir Sementsov-Ogievskiy wrote:
> 17.03.2020 21:16, Alberto Garcia wrote:
>> l2meta_cow_start() and l2meta_cow_end() are not necessarily
>> cluster-aligned if the image has subclusters, so update the
>> calculation of old_start and old_end to guarantee that no two requests
>> try to write on the same cluster.
>> 
>> Signed-off-by: Alberto Garcia <berto@igalia.com>
>> Reviewed-by: Max Reitz <mreitz@redhat.com>
>
> Somehow, this patch say me "hey, there may be a lot of other small
> places, which we forget to fix about subclusters, and you have no
> idea, how to find and check them all" :) Probably the only way is
> reviewing the whole qcow2 code, but it's too huge task.. [this is just
> thinking out loud]

:-)

> Actually, you call it "Fix", and it seems to be a fix for your "[PATCH
> v4 17/30] qcow2: Add subcluster support to
> calculate_l2_meta()". Shouldn't it be squashed in?

Maybe it't not a bad idea... I'll have a look.

Berto

