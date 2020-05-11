Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AF17C54E8E
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 16:32:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEF552075E
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 16:32:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="dc00S49F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEF552075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYBM7-0001pV-UJ
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 12:32:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53564)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jYBKZ-0000pu-82; Mon, 11 May 2020 12:31:03 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:43166)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jYBKW-0006yR-9i; Mon, 11 May 2020 12:31:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=2HhhcguJPx8BAZKMp7yQPsiRYgpsc4FZYLbQHuxLWlI=; 
 b=dc00S49F7eK3x7xaIx9HTw7nTPc9Tn6GKHH9wXjaCBSsjtFyetpJfhrvEiRhLRyLZBmgxcIYYXUvoRoBoOuMpnvF45XTiWeH7SGK8wcj8qG8Knndg3++DX4bSfL4L3eA2TpyVcIXKONA2qUpS2XsNVXCYy5Z+e+00t9zVzZ0Q+JA+hMlk7s+YGuOE1C3P7AyFXayscX0BEnfmgwebje+U3FPGbneeOR4pHpfBO1f1SVnn4aIbPdrBM4vmCT34K+xzxCkCSCuTcUHWINWiuda0/b5mh1dVutw+kMXkHf1n6cxa1inDkpjS/1W2FH9oyxWmO3vZAZnPwGlAsNOvYlL4g==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1jYBKP-0002UN-J7; Mon, 11 May 2020 18:30:53 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1jYBKP-0006Au-9i; Mon, 11 May 2020 18:30:53 +0200
From: Alberto Garcia <berto@igalia.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
Subject: Re: [PATCH v3 04/17] block/io: use int64_t bytes in driver wrappers
In-Reply-To: <20200430111033.29980-5-vsementsov@virtuozzo.com>
References: <20200430111033.29980-1-vsementsov@virtuozzo.com>
 <20200430111033.29980-5-vsementsov@virtuozzo.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Mon, 11 May 2020 18:30:53 +0200
Message-ID: <w517dxio2ma.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 11:28:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, fam@euphon.net, integration@gluster.org,
 sheepdog@lists.wpkg.org, pavel.dovgaluk@ispras.ru, dillaman@redhat.com,
 qemu-devel@nongnu.org, sw@weilnetz.de, pl@kamp.de, ronniesahlberg@gmail.com,
 mreitz@redhat.com, den@openvz.org, vsementsov@virtuozzo.com,
 stefanha@redhat.com, namei.unix@gmail.com, pbonzini@redhat.com,
 jsnow@redhat.com, ari@tuxera.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu 30 Apr 2020 01:10:20 PM CEST, Vladimir Sementsov-Ogievskiy wrote:
> We are generally moving to int64_t for both offset and bytes parameters
> on all io paths.
>
> Main motivation is realization of 64-bit write_zeroes operation for
> fast zeroing large disk chunks, up to the whole disk.
>
> We chose signed type, to be consistent with off_t (which is signed) and
> with possibility for signed return type (where negative value means
> error).
>
> So, convert driver wrappers parameters which are already 64bit to
> signed type.
>
> Patch-correctness audit by Eric Blake:
>
>   bdrv_driver_preadv
>
>     Remains 64 bits, the question is whether any caller could pass in
>     something larger than 63 bits.  Callers are:
>
>     bdrv_co_do_copy_on_readv() - passes 'int64_t pnum', but sets pnum
>       in a fragmenting loop, MAX_BOUNCE_BUFFER when copy-on-read is
>       needed, or max_transfer bounded by BDRV_REQUEST_MAX_BYTES
>       otherwise
>     bdrv_aligned_preadv() - passes 'unsigned int bytes' further limited
>       by fragmenting loop on max_transfer <= INT_MAX
>
>     Input is bounded to < 2G, internal use of 'bytes' is:
>
>     drv->bdrv_co_preadv_part(uint64_t) - safe
>     qemu_iovec_init_slice(size_t) - potential truncation on 32-bit
>       platform [*]
>     drv->bdrv_co_preadv(uint64_t) - safe
>     drv->bdrv_aio_preadv(uint64_t) - safe
>     drv->bdrv_co_readv(int) after assertion of <2G - safe
>
>   bdrv_driver_pwritev
>
>     Remains 64 bits, the question is whether any caller could pass in
>     something larger than 63.  Callers are:
>
>     bdrv_co_do_copy_on_readv() - passes 'int64_t pnum', but set in a
>       fragmenting loop bounded by MAX_BOUNCE_BUFFER
>     bdrv_co_do_pwrite_zeroes() - passes 'int num'
>     bdrv_aligned_pwritev() - passes 'unsigned int bytes' further
>       limited by fragmenting loop on max_transfer <= INT_MAX
>
>     Input is bounded to < 2G, internal use of 'bytes' is:
>
>     drv->bdrv_co_pwritev_part(uint64_t) - safe
>     qemu_iovec_init_slice(size_t) - potential truncation on 32-bit
>       platform [*]
>     drv->bdrv_co_pwritev(uint64_t) - safe
>     drv->bdrv_aio_pwritev(uint64_t) - safe
>     drv->bdrv_co_writev(int) after assertion of <2G - safe
>
>   bdrv_driver_pwritev_compressed
>
>     bdrv_aligned_pwritev() - passes 'unsigned int bytes'
>
>     Input is bounded to < 4G, internal use of 'bytes' is:
>
>     drv->bdrv_co_pwritev_compressed_part(uint64_t) - safe
>     drv->bdrv_co_pwritev_compressed(uint64_t) - safe
>     qemu_iovec_init_slice(size_t) - potential truncation on 32-bit
>       platform [*]
>
> [*]: QEMUIOVector is in-RAM data, so size_t seems a valid type for
> it's operation. To avoid truncations we should require max_transfer to
> be not greater than SIZE_MAX, limiting RAM-occupying operations and
> QEMUIOVector usage. Still, 64bit discard and write_zeroes (which
> doesn't use QEMUIOVector) should work even on 32bit machines, not being
> limited by max_transfer.
>
> For now, we safe anyway, as all input goes through
> bdrv_aligned_pwritev() and bdrv_aligned_preadv(), which are limiting
> max_transfer to INT_MAX.
>
> Series: 64bit-block-status
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto

