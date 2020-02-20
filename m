Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B09AC11D05
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 14:18:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 569BE206E2
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 14:18:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="mwyqXiFN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 569BE206E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4meo-0007zX-Hl
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 09:18:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39401)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1j4mdZ-00072F-2D
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 09:17:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1j4mdX-0002vT-Qj
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 09:17:08 -0500
Received: from fanzine.igalia.com ([178.60.130.6]:51729)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1j4mdX-0002oY-H4; Thu, 20 Feb 2020 09:17:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=4bOnWiYqEVbhSbPDu5eRoRbmWCb7I9+Ufy5V11wHe98=; 
 b=mwyqXiFNKJ4PZqPSG5uaoTwWzs6gys0yoqxR5RNI8Q9cYc9N6532HZ4Gz2x6YTWCQXgjwj2Z6HqW60RRnL49lJ7R0HjjmI9p25cOE6inw718f02YiGiOxkJGik56wH3zGYjtlxYBGdoKYcVmmo7qp2LiySetYzmezkB3O5Bjov58bVOguk8xjFV1eh0vkSwDKcSk6/4clRSOoX42rUgKW0fYR+Go4xpOw0G0Z3N3HpLGnMpnWNh8/HQDHolPlywV9n9zC8PefB3vqbFPMd+73OGsA1pgXs+zgBH3NXj5t0n8X3RPgRy7Ml9ZETF3v/OT2dsMY0AIVOMM+CkV23eVug==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1j4mdE-0003Kx-Df; Thu, 20 Feb 2020 15:16:48 +0100
Received: from berto by mail.igalia.com with local (Exim)
 id 1j4mdE-0000Xu-4N; Thu, 20 Feb 2020 15:16:48 +0100
From: Alberto Garcia <berto@igalia.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [RFC PATCH v3 25/27] qcow2: Add the 'extended_l2' option and the
 QCOW2_INCOMPAT_EXTL2 bit
In-Reply-To: <ac259d2c-72cc-370f-322d-58b15892f667@redhat.com>
References: <cover.1577014346.git.berto@igalia.com>
 <a4892ab10ae557f30dd901d218f06239bca2cd7a.1577014346.git.berto@igalia.com>
 <ac259d2c-72cc-370f-322d-58b15892f667@redhat.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Thu, 20 Feb 2020 15:16:48 +0100
Message-ID: <w51pne9bay7.fsf@maestria.local.igalia.com>
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
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu 20 Feb 2020 03:12:19 PM CET, Eric Blake wrote:
>> +            {
>> +                .type = QCOW2_FEAT_TYPE_INCOMPATIBLE,
>> +                .bit  = QCOW2_INCOMPAT_EXTL2_BITNR,
>> +                .name = "extended L2 entries",
>> +            },
>
> I'd sort this to be grouped with the other INCOMPATIBLE bits (after
> "external data file", rather than placing a COMPATIBLE bit in the
> middle.

Ok I'll change that.

> Rebase conflict with my patches proposing the addition of an AUTOCLEAR
> bit, here and in the impacted iotests.  Should be trivial to resolve,
> by whoever lands second.

Sure, although since this is a trivial change this is not that important
at this point (RFC). But of course I'll make sure that the bit is the
correct one.

Berto

