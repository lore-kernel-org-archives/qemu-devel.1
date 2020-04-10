Return-Path: <SRS0=FIxb=52=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F76C2BA2B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 16:43:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 187CA20769
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 16:43:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="ccHw1LfC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 187CA20769
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMwkZ-0002P1-7p
	for qemu-devel@archiver.kernel.org; Fri, 10 Apr 2020 12:43:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39929)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1jMwjm-0001vO-3i
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 12:42:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1jMwjj-0006gZ-4H
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 12:42:37 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:41008)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1jMwjh-0006de-Hx; Fri, 10 Apr 2020 12:42:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=W7N2zDutPcb+wf3Yub3ll025wkKHdVw1o3eCrYUxKVs=; 
 b=ccHw1LfCLbrL7T1y51AC4xHEwYgXvoyyjLgURdUFJL9G6MoHFuBWPjjKtLv4NWOVJbsb1qPrGWH3O59oeVkwuF7J3H0PMzZ0GMvdvNw90lYGCQEZBkVYAtvZeNT4coUJOuSOpgB2Jzr/zf8Bef0xTqCJoA9JSKdUi2JnCI3kIM8SmK0YtIYUBCrH3vhMbTk/q4o6r9OU4RPgyp86MZGnD9NGWRV76H+svpsOjKtRccs0DuOAHYPXfJS6R9K8jSUFc6CYzH56hNXixT8iag9rb5LOSWwdBm3/nTvWJnGDASz6NZEaLkCSQP46r4aqY/9ZGzRuP+iC71FF2awIniKyAA==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1jMwje-0002Is-Cm; Fri, 10 Apr 2020 18:42:30 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1jMwje-000669-3S; Fri, 10 Apr 2020 18:42:30 +0200
From: Alberto Garcia <berto@igalia.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 27/30] qcow2: Assert that expand_zero_clusters_in_l1()
 does not support subclusters
In-Reply-To: <45fe195e-4635-de14-39af-1f44a155c102@redhat.com>
References: <cover.1584468723.git.berto@igalia.com>
 <5cc70489bfeb7d2f8f6c8a113dc530cab504db9e.1584468723.git.berto@igalia.com>
 <45fe195e-4635-de14-39af-1f44a155c102@redhat.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Fri, 10 Apr 2020 18:42:30 +0200
Message-ID: <w51h7xr5m2x.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
 timestamps) [generic] [fuzzy]
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
 qemu-block@nongnu.org, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu 09 Apr 2020 12:27:36 PM CEST, Max Reitz wrote:
>> +=== Testing version downgrade with extended L2 entries ===
>> +
>> +Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
>> +qemu-img: Cannot downgrade an image with incompatible features 0x10 set
>
> This test fails in this commit, because extended_l2 is only available
> after the next commit.  The code changes and the test itself look good
> to me, though.

You're right, thanks! Since this one only adds an assertion I'll just
swap both commits.

Berto

