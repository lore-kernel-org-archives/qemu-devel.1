Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA15C4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 11:24:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0783920673
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 11:24:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="lQTkvwPh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0783920673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJySo-00032y-6Z
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 07:24:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49234)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1iJyRA-0001Mt-Kp
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 07:22:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1iJyR9-00088J-Ih
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 07:22:52 -0400
Received: from 6.130.60.178.static.reverse-mundo-r.com ([178.60.130.6]:43442
 helo=fanzine.igalia.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1iJyR9-000863-4G; Mon, 14 Oct 2019 07:22:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=QeYmsx23ggp5o7Ri22dWYdyGfnV3ov0eSML2CtDoTDg=; 
 b=lQTkvwPhjYlKk8hXHTpXow5iggq2vcXX0ozkKVKL61thaQuoRCqhcltF1Gf5u3JvZ70+9ZWuq68sWCkA2zd0M/oMmfdP6Ax3WjsnxlAKYqqM/7lURlOh4AXKmEd3LV40SxwYnOiWtGDXOqJRJrt6lFCXxrVYvQWzGnjo41alPPyzsxJ+CwBrp7+9kle/ufh7E+5iB0I4ph5wrOb9hwJEZJkrLtsfRxdqn61fy49mUu0oecCKIVt7S8ZRmk4vH/xB5sk8SiDv4FRXWoBRthKM5nWtRoCq5eb5KQQYasdK7LoV5AVxnyhIxCstXuWac0fZ2UVu3q+ESzTFc55WFiInjQ==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1iJyR6-0005Iz-3F; Mon, 14 Oct 2019 13:22:48 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1iJyR6-0007ni-0B; Mon, 14 Oct 2019 13:22:48 +0200
From: Alberto Garcia <berto@igalia.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v2] block: Reject misaligned write requests with
 BDRV_REQ_NO_FALLBACK
In-Reply-To: <20191014092601.GA7173@localhost.localdomain>
References: <20191014081545.29694-1-berto@igalia.com>
 <20191014092601.GA7173@localhost.localdomain>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Mon, 14 Oct 2019 13:22:47 +0200
Message-ID: <w5136fvtvug.fsf@maestria.local.igalia.com>
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
Cc: Nir Soffer <nsoffer@redhat.com>,
 Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon 14 Oct 2019 11:26:01 AM CEST, Kevin Wolf wrote:
>> Signed-off-by: Alberto Garcia <berto@igalia.com>
>
> Thanks, applied to the block branch.

I'm a bit late now, but a possible trivial optimization is to flip the
conditions, because checking the flag should be faster than checking the
alignment and it's going to be false in almost all cases:

    if ((flags & BDRV_REQ_NO_FALLBACK) &&
        !QEMU_IS_ALIGNED(offset | bytes, align)) {
        return -ENOTSUP;
    }

Feel free to edit the commit if you want.

Berto

