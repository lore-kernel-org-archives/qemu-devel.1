Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B0A5C3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 15:55:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 465DA20717
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 15:55:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="ZtYsakHM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 465DA20717
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9sqj-0008Bg-Fo
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 10:55:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52907)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1j9spz-0007NL-FS
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 10:55:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1j9spy-0002ok-Ij
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 10:55:03 -0500
Received: from fanzine.igalia.com ([178.60.130.6]:35423)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1j9spu-0002MF-PO; Thu, 05 Mar 2020 10:55:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=fbnXSEOGynS8dpVNygZ0GLcvtjAM0rndlL9xZWhyUyY=; 
 b=ZtYsakHMoCtPRyXR74iBLxH3MHkfKKfOtMgzxeX3pq5nTsvs/pVA8FqXrj2fVELdMUm3VcEq7JP8GYIVucZnyxA/joGwPBx1X6qztz3g/81Bp/jITrEH0xozbk2/Bh9svfYGfY8lLRrnS3a7ZHDp93pZ/2aj3BDa9CIMLO99Gyfpj56onPtjwBzydzEteL5/YJEjAzOU38I28ixmbroU4GVA88yuiUVbeKNrdCx4J0mkcJnhOETbJiHVIJs7PjfaS47oYMet0q0At6IrBQ1CUF1sdVPTkzXyQh2kSSHwTxS8j1VYh/yFRJBV71TlWdXDIYegdm7P41yRldFYtfVFoQ==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1j9spb-0005gj-SJ; Thu, 05 Mar 2020 16:54:39 +0100
Received: from berto by mail.igalia.com with local (Exim)
 id 1j9spb-0008Lu-HV; Thu, 05 Mar 2020 16:54:39 +0100
From: Alberto Garcia <berto@igalia.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Subject: Re: [PATCH 2/2] block: bdrv_reopen() with backing file in different
 AioContext
In-Reply-To: <20200227181804.15299-3-kwolf@redhat.com>
References: <20200227181804.15299-1-kwolf@redhat.com>
 <20200227181804.15299-3-kwolf@redhat.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Thu, 05 Mar 2020 16:54:39 +0100
Message-ID: <w51h7z27q68.fsf@maestria.local.igalia.com>
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
Cc: kwolf@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu 27 Feb 2020 07:18:04 PM CET, Kevin Wolf wrote:
>      /*
> -     * TODO: before removing the x- prefix from x-blockdev-reopen we
> -     * should move the new backing file into the right AioContext
> -     * instead of returning an error.
> +     * Check AioContext compatibility so that the bdrv_set_backing_hd() call in
> +     * bdrv_reopen_commit() won't fail.
>       */
> -    if (new_backing_bs) {
> -        if (bdrv_get_aio_context(new_backing_bs) != bdrv_get_aio_context(bs)) {
> -            error_setg(errp, "Cannot use a new backing file "
> -                       "with a different AioContext");
> -            return -EINVAL;
> -        }
> +    if (!bdrv_reopen_can_attach(bs->backing, bs, new_backing_bs, errp)) {
> +        return -EINVAL;
>      }

What happens here now if 'new_backing_bs' is NULL ?

It seems that you would be calling bdrv_can_set_aio_context(NULL, ...),
and it looks like that would crash.

Berto

