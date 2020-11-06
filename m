Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A186C2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 15:30:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD27C208C7
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 15:30:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="mDeRqjbU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD27C208C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kb3hX-00087O-OG
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 10:30:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38120)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1kb3eX-0003S2-T7; Fri, 06 Nov 2020 10:27:49 -0500
Received: from fanzine.igalia.com ([178.60.130.6]:50525)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1kb3eU-0001H7-W9; Fri, 06 Nov 2020 10:27:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=rkaa9y+jAxESvktP8MWpDIOBYmljprZovdGPU/SPVYY=; 
 b=mDeRqjbUoZmu4EQabYcaE+6ES1VXwWDE4ZVmBEY71p7R0rvDI/JWpNvgeuWv7Z5gpdLOPeJwS8NSYVsalBEDhuXeJTNHRxK4Ag+9lYYWK462epX5yv24B/H2YfbgewFUQX1fqFXBR7v0HuvO9w/SVG+h34eQjpnxloWULuWzsjVGwJQ4F2IG6S8FDwhLZKkKK14utGuzzRG2lbJt5xC+87xdrqvmWdBExOTpPqGbb3qk5Dh8SYyhMi7R0AmxWXtf32i+eyADkONxjHxQhTrgKG/PNpysQymvbobC0HaZuuA8rIbXufeVcM6WtPWCzGwUy51kq7h129rhQTt1AJoz2w==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1kb3eP-0004Ji-Pd; Fri, 06 Nov 2020 16:27:41 +0100
Received: from berto by mail.igalia.com with local (Exim)
 id 1kb3eP-0001Qh-Fv; Fri, 06 Nov 2020 16:27:41 +0100
From: Alberto Garcia <berto@igalia.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
Subject: Re: [PATCH v2 2/7] block: add bdrv_replace_node_common()
In-Reply-To: <20201106124241.16950-3-vsementsov@virtuozzo.com>
References: <20201106124241.16950-1-vsementsov@virtuozzo.com>
 <20201106124241.16950-3-vsementsov@virtuozzo.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Fri, 06 Nov 2020 16:27:41 +0100
Message-ID: <w51wnyy8pzm.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/06 10:12:15
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
Cc: kwolf@redhat.com, den@openvz.org, vsementsov@virtuozzo.com,
 qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri 06 Nov 2020 01:42:36 PM CET, Vladimir Sementsov-Ogievskiy wrote:
> Add new parameter to bdrv_replace_node(): auto_skip. With
> auto_skip=false we'll have stricter behavior: update _all_ from
> parents or fail. New behaviour will be used in the following commit in
> block.c, so keep original function name as public interface.
>
> Note: new error message is a bit funny in contrast with further
> "Cannot" in case of frozen child, but we'd better keep some difference
> to make it possible to distinguish one from another on failure. Still,
> actually we'd better refactor should_update_child() call to distinguish
> also different kinds of "should not". Let's do it later.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto

