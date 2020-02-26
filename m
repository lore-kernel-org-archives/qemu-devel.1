Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0A34C4BA18
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 17:20:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BA8A206E6
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 17:20:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="d4TO4/tN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BA8A206E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j70Mg-0006Xt-IX
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 12:20:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44915)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1j70Ls-0005pQ-Tq
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 12:20:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1j70Lq-0007Ae-1e
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 12:20:04 -0500
Received: from fanzine.igalia.com ([178.60.130.6]:42864)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1j70Lp-0006y9-GR; Wed, 26 Feb 2020 12:20:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=DZSFvv2J7tBh2ELlGnfudxUzTpwD3LqGkSHb0EpKGJk=; 
 b=d4TO4/tN7cf/m5xk6NJKzwkXyngCl+x4eXFdYEnXaZCHjXyERflkbutQKojksuSwaGTjD1Hp2DKrLKGTtnYgb09KbeDm6aJOsPWGwVZCKojDWK3txyfVdaMNgemzcVjLyQHuTS4vK+/H7WoHo4kC7myIkxNWrYCSXjojXLDDPncpV6EWqcSie17/S3mEXam8x5Ble1KiMOxFOpDkhylOUgZtWZTAMK0r+d56dmUzayH6La4VbFN81WB/lE4iAMuB33uaoGkcNfEnx2h1+GG9AfOqjdH0qYr63iL1xgHV+qZnogPnLC1PCPv0FfFepodWWUceqKe44CQcqBgf65M0bw==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1j70Lk-0000RG-6y; Wed, 26 Feb 2020 18:19:56 +0100
Received: from berto by mail.igalia.com with local (Exim)
 id 1j70Lj-0008Pq-Tt; Wed, 26 Feb 2020 18:19:55 +0100
From: Alberto Garcia <berto@igalia.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [RFC PATCH v3 19/27] qcow2: Add subcluster support to
 expand_zero_clusters_in_l1()
In-Reply-To: <194970c2-07a5-41f5-bd3c-7153d6f5e1b7@redhat.com>
References: <cover.1577014346.git.berto@igalia.com>
 <d7c9c2d54c7be83eda854db37e54dd7aabb1a1e1.1577014346.git.berto@igalia.com>
 <194970c2-07a5-41f5-bd3c-7153d6f5e1b7@redhat.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Wed, 26 Feb 2020 18:19:55 +0100
Message-ID: <w51k149p8p0.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

On Fri 21 Feb 2020 03:57:27 PM CET, Max Reitz wrote:
> As noted in v2, this function is only called when downgrading qcow2
> images to v2.  It kind of made sense to just call set_l2_bitmap() in
> v2, but now with the if () conditional...  I suppose it may make more
> sense to assert that the image does not have subclusters at the
> beginning of the function and be done with it.

Hmmm, you're right.

> OTOH, well, this does make ensuring that we have subcluster =E2=80=9Csupp=
ort=E2=80=9D
> everywhere a bit easier because this way all set_l2_entry() calls are
> accompanied by an =E2=80=9Cif (subclusters) { set_l2_bitmap() }=E2=80=9D =
part.

Another alternative is to assert that the image does not have subcluster
but still leave a comment after both set_l2_entry() calls explaining why
there's no need to touch the bitmap.

I think I'll do that, unless you have a different proposal.

Berto

