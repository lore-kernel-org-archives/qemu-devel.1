Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E45C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 10:12:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1EE620731
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 10:12:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="KEmPWqrg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1EE620731
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY5Pw-0003A0-Vc
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 06:12:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46280)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jY5P8-0002Hr-Om; Mon, 11 May 2020 06:11:22 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:37988)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jY5P5-0008BY-70; Mon, 11 May 2020 06:11:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=vmPoOnVLLSeDgAF5XFBEMGxszEbxw543sML+kt8rl3w=; 
 b=KEmPWqrgzBZwBC9h8ngdoJtYlRcGHz3gfOOyDOisw8TxHxKuLfLHblPERlSZYCQeVrwKPoaMaC3itiZy1dsWfStURGfpkmgHZJeNpI1ZxZzXOgVxLTBpEiTPR+yWRTnfIj8Jd40NlDtGdP4irXnTHrnbbCuaI7U52kF38dHRBx3w0TCuYjVpWMbShJAWTO0tCQ3svn92kDn8gCM8toNlx9qjqOr7aBad4NJCgZ2unnROVPH9LP9rV0/YaoQXtR5H4n3LHyuM7Zo9Ht4AY8SHeFQRqGfFTzYv4lpHYbeVip7u0aLSsN2U3V1VZu5toPk50FifIHJ4NRis8TiFZcmkbQ==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1jY5Og-0005mM-R6; Mon, 11 May 2020 12:10:54 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1jY5Og-00010m-Hb; Mon, 11 May 2020 12:10:54 +0200
From: Alberto Garcia <berto@igalia.com>
To: quweijie@huayun.com, qemu-devel@nongnu.org
Subject: Re: [PATCH 1/2] When del child,
 next_child_index need to subtract 1. Otherwise,
 the index will get bigger and bigger.
In-Reply-To: <1589191231-18876-1-git-send-email-quweijie@huayun.com>
References: <1589191231-18876-1-git-send-email-quweijie@huayun.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Mon, 11 May 2020 12:10:54 +0200
Message-ID: <w51imh2ok7l.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 06:10:57
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
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 "open list:Quorum" <qemu-block@nongnu.org>, quweijie <quweijie@huayun.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon 11 May 2020 12:00:30 PM CEST, quweijie@huayun.com wrote:
> diff --git a/block/quorum.c b/block/quorum.c
> index 6d7a56b..a8272fe 100644
> --- a/block/quorum.c
> +++ b/block/quorum.c
> @@ -1096,6 +1096,7 @@ static void quorum_del_child(BlockDriverState *bs, BdrvChild *child,
>      memmove(&s->children[i], &s->children[i + 1],
>              (s->num_children - i - 1) * sizeof(BdrvChild *));
>      s->children = g_renew(BdrvChild *, s->children, --s->num_children);
> +    s->next_child_index--;
>      bdrv_unref_child(bs, child);

This is not correct, quorum_del_child() allows you to remove any child
from the Quorum device, so nothing guarantees you that
next_child_index-1 is free.

Berto

