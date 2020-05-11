Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F60C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 15:58:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBA092064A
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 15:58:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="XhR+p0nn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBA092064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYApE-0004YC-Sg
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 11:58:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46030)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jYAo1-0003cm-Ek; Mon, 11 May 2020 11:57:25 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:50934)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jYAny-0004Cm-VN; Mon, 11 May 2020 11:57:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=FNkzgSDB7XY2WpcrXwd7XVlahAFIFg+AHngM32gHXUE=; 
 b=XhR+p0nnwhu2JGdAnuryN2N11aazW9m1kCHEykPWDPBfgThzMtT3DQH5n0w8WG3wv5qrbRzN9tu97C56Gv6YJuukvZAN48eON68Y/0FGlbvdr64TGcddj2mhxoFKGbPQ0Sfv6J5vOM92ol6Xa6m7I83XnK1/8U3zwGsm2nSYGwBV+VNOMRngDmn0sxinL60JYW8pvWqWECesIgk7qPIWp92s+0BhPRfEQ/EP3zOKn/4oJZsIByaKLvro+kPuslfJ1nWvstO1VUtCJF8rV7nA9NjWFxERILJL47fkP8rzZCltrSEtyWQFbzzEHoXJ9wU641bo6BN2n9R8+1+GDoqu6g==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1jYAnr-00050u-UQ; Mon, 11 May 2020 17:57:15 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1jYAnr-0000BU-Kk; Mon, 11 May 2020 17:57:15 +0200
From: Alberto Garcia <berto@igalia.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
Subject: Re: [PATCH v3 03/17] block/io: use int64_t bytes parameter in
 bdrv_check_byte_request()
In-Reply-To: <20200430111033.29980-4-vsementsov@virtuozzo.com>
References: <20200430111033.29980-1-vsementsov@virtuozzo.com>
 <20200430111033.29980-4-vsementsov@virtuozzo.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Mon, 11 May 2020 17:57:15 +0200
Message-ID: <w51a72eo46c.fsf@maestria.local.igalia.com>
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

On Thu 30 Apr 2020 01:10:19 PM CEST, Vladimir Sementsov-Ogievskiy wrote:
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
> So, convert bdrv_check_byte_request() now.
>
> Patch-correctness audit by Eric Blake:
>
>   This changes an unsigned to signed value on 64-bit machines, and
>   additionally widens the parameter on 32-bit machines.  Existing
>   callers:
>
>   bdrv_co_preadv_part() with 'unsigned int' - no impact
>   bdrv_co_pwritev_part() with 'unsigned int' - no impact
>   bdrv_co_copy_range_internal() with 'uint64_t' -
>       potentially fixes a latent bug on 32-bit machines. Requires a
>       larger audit to see how bdrv_co_copy_range() and friends are
>       used:
>
>   block/block-backend.c:blk_co_copy_range() - passes 'int', thus < 2G
>   block/block-copy.c:block_copy_do_copy() -
>       passes 'int64_t', but only after assert(nbytes < INT_MAX); also
>       it has a BLOCK_COPY_MAX_COPY_RANGE set to 16M that factors into
>       its calculations on how much to do per iteration
>
>   So it looks like at present we are safe.
>
> Series: 64bit-block-status
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto

