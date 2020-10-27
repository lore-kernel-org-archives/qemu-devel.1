Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A14D7C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 17:18:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E2B720657
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 17:18:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="cWlWhS01"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E2B720657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXSbo-0007cz-J1
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 13:18:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35818)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1kXSao-00076l-IV; Tue, 27 Oct 2020 13:17:06 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:46292)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1kXSak-0008Ct-He; Tue, 27 Oct 2020 13:17:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=rAziTs66zSbDouwgSpSDyDknEnsSVe3TfVeMWh0wzBg=; 
 b=cWlWhS01xFyKrk+G2XiOsPhOGXO0vpYtzT1mAHruskYoACJnbFZFAr91lah4sAQcDOQbz0dTi9vVvOEe9GTd84lzvcM8Ncd9gUCqneCMaVWhwHlxs/iVOInc6UodSbeZnFHAhzGUGrPmObYN/hAf8nm2uJ7DqiLN2mJyuizbVql8QwRiP7bnsbFchtixZP+PiIpJOebnOoPofZT6+7F18DktA72U5++bNFGTgw+PDGw+ugxBm6GhNy9kkPsId6pHW/qgnKiE8D1LpGXM+XdmlhVpEfiNMaB1T0uaI35GYgwcmgRkWJ6qAAzuW7sky2hxKqf671FQS+rGP4m3ZlpAqg==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1kXSaM-0002uR-M7; Tue, 27 Oct 2020 18:16:38 +0100
Received: from berto by mail.igalia.com with local (Exim)
 id 1kXSaM-0006ee-Cg; Tue, 27 Oct 2020 18:16:38 +0100
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH v2] qcow2: Document and enforce the QCowL2Meta invariants
In-Reply-To: <20201007161323.4667-1-berto@igalia.com>
References: <20201007161323.4667-1-berto@igalia.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Tue, 27 Oct 2020 18:16:38 +0100
Message-ID: <w514kmfd1xl.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 13:16:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

ping

On Wed 07 Oct 2020 06:13:23 PM CEST, Alberto Garcia wrote:
> The QCowL2Meta structure is used to store information about a part of
> a write request that touches clusters that need changes in their L2
> entries. This happens with newly-allocated clusters or subclusters.
>
> This structure has changed a bit since it was first created and its
> current documentation is not quite up-to-date.
>
> A write request can span a region consisting of a combination of
> clusters of different types, and qcow2_alloc_host_offset() can
> repeatedly call handle_copied() and handle_alloc() to add more
> clusters to the mix as long as they all are contiguous on the image
> file.
>
> Because of this a write request has a list of QCowL2Meta structures,
> one for each part of the request that needs changes in the L2
> metadata.
>
> Each one of them spans nb_clusters and has two copy-on-write regions
> located immediately before and after the middle region touched by that
> part of the write request. Even when those regions themselves are
> empty their offsets must be correct because they are used to know the
> location of the middle region.
>
> This was not always the case but it is not a problem anymore
> because the only two places where QCowL2Meta structures are created
> (calculate_l2_meta() and qcow2_co_truncate()) ensure that the
> copy-on-write regions are correctly defined, and so do assertions like
> the ones in perform_cow().
>
> The conditional initialization of the 'written_to' variable is
> therefore unnecessary and is removed by this patch.
>
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

