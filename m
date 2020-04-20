Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3DFAC3815B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 14:02:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FECF2251E
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 14:02:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="NF/K4whh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FECF2251E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQX0C-0006NY-Jl
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 10:02:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39568 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1jQWxV-0003yL-6y
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 09:59:37 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1jQWxU-0006N5-Ut
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 09:59:36 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:60211)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jQWxT-0006J9-ID; Mon, 20 Apr 2020 09:59:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=UEj8LW8YuAGRiYeOUwjoj3JnMo/fT1tsnhcO9BfFZQo=; 
 b=NF/K4whhBnE4Nl9KfunfOkZ3nLqp0EyR5texHojDfKjvtQnW5jzkRHrbd9EQBMDyj6k8YJG6XNGZCjtQ4FHhKOTmwCjYVcMxMUr/qUaLGQ6NL6U26mYfR3yn4O579LAOxvO6A+WDAUhQPGNzV5DGmEj0J2Af4uqda4t9Fo7PynwxcXB8OjMMfYASHzpNkSbqEh0rpP9D01jAmJwIUQ0Oh3qdKcofCBE93oEQw1ngW/iuI+YkTa4Ovn6rQCMotdX8iPOpU4ihM7dFhiV7bOCDAIGWTlUeE0YTA0TPX937jVsip9NCmhcUilQq4MVn4/Bl0L0fnqrkaqIwy1qwfnfl/g==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1jQWxR-0007X3-KG; Mon, 20 Apr 2020 15:59:33 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1jQWxR-0000Ln-Ah; Mon, 20 Apr 2020 15:59:33 +0200
From: Alberto Garcia <berto@igalia.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Subject: Re: [PATCH v4 3/9] block-backend: Add flags to blk_truncate()
In-Reply-To: <20200420133214.28921-4-kwolf@redhat.com>
References: <20200420133214.28921-1-kwolf@redhat.com>
 <20200420133214.28921-4-kwolf@redhat.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Mon, 20 Apr 2020 15:59:33 +0200
Message-ID: <w51368yqmuy.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs1p.gnu.org: First seen = 2020/04/20
 08:31:39
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-devel@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon 20 Apr 2020 03:32:08 PM CEST, Kevin Wolf wrote:
> Now that node level interface bdrv_truncate() supports passing request
> flags to the block driver, expose this on the BlockBackend level, too.
>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto

