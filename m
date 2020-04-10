Return-Path: <SRS0=FIxb=52=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D5F9C2BA2B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 11:13:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5522206F7
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 11:13:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="rfU6bPbM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5522206F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMrba-0004fk-3D
	for qemu-devel@archiver.kernel.org; Fri, 10 Apr 2020 07:13:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58684)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1jMraE-0003L7-2z
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 07:12:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1jMraC-0005lO-Pf
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 07:12:25 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:48726)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1jMraC-0005Zx-7e; Fri, 10 Apr 2020 07:12:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=3bCHbqPAuLZy7lYbzXuiMl+UtbpBQO+m28vx3rtiymE=; 
 b=rfU6bPbMiG0Uf5QHFAWY+J5HCVIhYu4KcXN8cHsOJPsfPUJ/QTw3RuwVDZyXU8dNc0ntiabFuEMcLthJ9VVheGljAb0N0u9QTFxi7BoT8KuUY0VzDc+eOz6++PoJzF5d+ueTbbvsN2bUNgFdO4bYpYRiwpmvBzxJUEX+owUGJPTehIoYCmIkQTL4yjnOVTeWT75bXOC/aPnJzG+696gscC4IlU3FR3KCAFgJypKvFPYlqyAdVjdQRcvYopTGd0Siy7GApAkNjY37wkJy13M/NkkS4Y/FdsKt8mMGRnGYJHM0hsjWNsNNKHSVhWtfloQqws5yTgNV3tH/rATA6bhMVw==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1jMrZr-0002Bg-Lz; Fri, 10 Apr 2020 13:12:03 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1jMrZr-0000wM-Cf; Fri, 10 Apr 2020 13:12:03 +0200
From: Alberto Garcia <berto@igalia.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Subject: Re: [PATCH v12 2/3] qcow2: Allow writing compressed data of multiple
 clusters
In-Reply-To: <5bbb126f-37c0-f107-c3b3-667ed43670fa@virtuozzo.com>
References: <1575288906-551879-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1575288906-551879-3-git-send-email-andrey.shinkevich@virtuozzo.com>
 <w51y2r41u4d.fsf@maestria.local.igalia.com>
 <5bbb126f-37c0-f107-c3b3-667ed43670fa@virtuozzo.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Fri, 10 Apr 2020 13:12:03 +0200
Message-ID: <w51pncf61do.fsf@maestria.local.igalia.com>
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
Cc: kwolf@redhat.com, den@openvz.org, armbru@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu 09 Apr 2020 08:39:12 PM CEST, Vladimir Sementsov-Ogievskiy wrote:
>> Because of this a test cannot expect that running the same commands on
>> an empty image produces always the same results.
>> 
>> Is this something that we should be concerned about?
>
> Parallel writing compressed clusters is significant improvement, as it
> allow compressing in really parallel threads.

I see, I just wasn't sure if you were aware of this side effect.

> So, I don't think we should make specific workaround for
> testing... What exactly is the case?

I noticed this while writing some tests for the subcluster allocation
feature, but this is not a problem for me. Many of our iotests make
assumptions about the location of L2 and refcount tables so changing
those would break a lot of them. This thing only changes the offset of
the compressed data clusters (and their L2 entries), but as far as I'm
aware no one relies on them being predictable. I just need to make sure
that I don't do it either.

Berto

