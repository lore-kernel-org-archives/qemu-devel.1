Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F21C3815B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 14:11:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2FBD20B1F
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 14:11:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="VzdnTnRv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2FBD20B1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQX8a-0004iv-4p
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 10:11:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43236 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1jQX7t-0004AK-Lf
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 10:10:21 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1jQX7t-0004n1-BR
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 10:10:21 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:45828)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jQX7q-0004ds-Po; Mon, 20 Apr 2020 10:10:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=ZlxTRTUTHRcWExYKcgCEa1qjwybPvmbjfAilLfyFheg=; 
 b=VzdnTnRv3o+SrdD4/aPgP+45p6Ro9elOZqXctSwQLs8Yp9XfccUKm/viGDThpEGimoOfB8RVmbBXbMASyA14IyNJo2SIVr6J8uVsZzIXCcwiq6TnfrKM+KffwY9tZN1ltzJp9dvGmbemiHUYJrhyFBOqqO0mPxN+ywmnjqnJDlg6y2uesTLfnq/c3CwQsmZJScXl53XU5/v2JiwVBC6/z/maTpwwFAsoRssP9MJvFBe2p+K9SHCjIrkdMPR575/xRJGJGwGfh9xRB/+NOZJSfILWxQyoZng7KX0RaK+B0EgZ2LTe5+pXItmY/sBs1HUmlLvSQ9KjQYDycjdUSQuwpw==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1jQX7m-0000No-Ty; Mon, 20 Apr 2020 16:10:14 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1jQX7m-0001Y4-JU; Mon, 20 Apr 2020 16:10:14 +0200
From: Alberto Garcia <berto@igalia.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Subject: Re: [PATCH v4 7/9] block: truncate: Don't make backing file data
 visible
In-Reply-To: <20200420133214.28921-8-kwolf@redhat.com>
References: <20200420133214.28921-1-kwolf@redhat.com>
 <20200420133214.28921-8-kwolf@redhat.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Mon, 20 Apr 2020 16:10:14 +0200
Message-ID: <w51pnc2p7sp.fsf@maestria.local.igalia.com>
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

On Mon 20 Apr 2020 03:32:12 PM CEST, Kevin Wolf wrote:
> When extending the size of an image that has a backing file larger than
> its old size, make sure that the backing file data doesn't become
> visible in the guest, but the added area is properly zeroed out.
>
> Consider the following scenario where the overlay is shorter than its
> backing file:
>
>     base.qcow2:     AAAAAAAA
>     overlay.qcow2:  BBBB
>
> When resizing (extending) overlay.qcow2, the new blocks should not stay
> unallocated and make the additional As from base.qcow2 visible like
> before this patch, but zeros should be read.
>
> A similar case happens with the various variants of a commit job when an
> intermediate file is short (- for unallocated):
>
>     base.qcow2:     A-A-AAAA
>     mid.qcow2:      BB-B
>     top.qcow2:      C--C--C-
>
> After commit top.qcow2 to mid.qcow2, the following happens:
>
>     mid.qcow2:      CB-C00C0 (correct result)
>     mid.qcow2:      CB-C--C- (before this fix)
>
> Without the fix, blocks that previously read as zeros on top.qcow2
> suddenly turn into A.
>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto

