Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F711C54FD0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 14:19:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 081A6208E4
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 14:19:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Ig9GaqKK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 081A6208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRch7-0008WM-4R
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 10:19:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56486)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1jRcgP-0007x0-Gi
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 10:18:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1jRcgO-0007Hh-MA
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 10:18:29 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:34518)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jRcgN-0007Eq-T2; Thu, 23 Apr 2020 10:18:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=vsydEJwmXPbHI9LL+zNmlY4ucFfFNCDeggPQFNeTsmM=; 
 b=Ig9GaqKKJxZmGCdix13b8ctZpF+v4gg2SKUb/Ikq/77l8FN7D9sNJL0dsSr/75Vn270Xi0uRmefJTOGiGvChhtgXGtC426RmCNumZv58S2IdRBv1A4ExQOlTuUlGi7h1zW040LinQ3g7VpOa/LD9+rRFYgq3sNgfdKxuG/V0TJqA7uZ4dPykIfjny1R91FyrqPZYPPinVFJGMer0f2aCrek/8geYrMs/STtT3Yxi6mzrlWHnwqhHyn1D3bgjSF9pc0IbX643puc+uCWIT4MkzIv7WLO3xQJ6KKgYggNW725BDQesJtlaeKk5/7p4Ow/smWqV81+ZYQlJwc+5CUaDrQ==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1jRcfz-0007Qr-Ea; Thu, 23 Apr 2020 16:18:03 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1jRcfz-0006yG-4U; Thu, 23 Apr 2020 16:18:03 +0200
From: Alberto Garcia <berto@igalia.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v4 20/30] qcow2: Add subcluster support to
 discard_in_l2_slice()
In-Reply-To: <7de731d4-c78e-b533-8bbb-dae57ba24c46@virtuozzo.com>
References: <cover.1584468723.git.berto@igalia.com>
 <99b45e3beb4a38b17eb50fcde1e09cdefdb99724.1584468723.git.berto@igalia.com>
 <2f284a39-64b8-ca64-4465-12f9f0f8f7e5@virtuozzo.com>
 <w51o8rjs9gj.fsf@maestria.local.igalia.com>
 <7de731d4-c78e-b533-8bbb-dae57ba24c46@virtuozzo.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Thu, 23 Apr 2020 16:18:03 +0200
Message-ID: <w511roe70bo.fsf@maestria.local.igalia.com>
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

On Wed 22 Apr 2020 08:09:53 PM CEST, Vladimir Sementsov-Ogievskiy wrote:
>> There's currently an inconsistency now that I think of it: if an image
>> has subclusters and QCOW_OFLAG_ZERO set then qcow2_get_cluster_type()
>> returns QCOW2_CLUSTER_ZERO_* but qcow2_get_subcluster_type() returns
>> QCOW2_SUBCLUSTER_INVALID.
>> 
>> Two alternatives:
>> 
>>    - We add QCOW2_CLUSTER_INVALID so we get an error in both
>>      cases. Problem: any function that calls qcow2_get_cluster_type()
>>      should be modified to handle that.
>> 
>>    - We ignore QCOW_OFLAG_ZERO. Simpler, and it would allow us to use
>>      that bit in the future if we wanted.
>> 
>
> Hmm. Actually we don't check other reserved bits. But ZERO bit is
> risky, we may miss data corruptions during transmission to the
> qcow2-subclusters world.

That's the best argument for checking that bit.

> So I'm for the first variant if it's not too huge.

The other problem is that if we ever want to use that bit for something
else then we would need to add an incompatible feature. If we just
ignore it now then we may be able to make it a compatible feature. But
the chances for that are low I think, and we still have 8 available bits
in the L2 entry.

Berto

