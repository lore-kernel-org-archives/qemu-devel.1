Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 793E0C43461
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 10:05:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3755214F1
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 10:05:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="oAoNuiJU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3755214F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGfvy-0001Du-Pm
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 06:05:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54008)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1kGfvP-0000gp-Di; Fri, 11 Sep 2020 06:04:59 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:50520)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1kGfvN-0005AF-IA; Fri, 11 Sep 2020 06:04:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=L3M85WFIyglAa81GENKXQSmyaI3tn8tdUSjlCX1r8uI=; 
 b=oAoNuiJU/yCvW71md4EmeH/DDLK3O5yUfG2MHb/gpqrG5X+h0IYLzcOt7gXe+lDV9R1amE0mEwUmd51sekBKAjStVZGEniHraYi0Q95yzTNC4ZI05kPk1ptamCaCBOJOf28ZNNIOdubbsdt7XZvDh64pjG7EqNP1jQMuT1kSRr90uNpm7RLgINAVHfbSvaKfJoY0qtv+KcFPH2kZWhQIqgUCQNoGEMbnSRhIhPoHkr9B9Bp1PwCe0UlG4ZAu8HVO5rYtYTvoMOxTozJSz6rAG0+PL/oYBy+UeI+I7D1eHVhhve2VCB3WPBHM0pPvIP3fHl5HSf9vHyAId85Xu461ig==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1kGfvJ-0007a7-Jk; Fri, 11 Sep 2020 12:04:53 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1kGfvJ-0004Bl-9j; Fri, 11 Sep 2020 12:04:53 +0200
From: Alberto Garcia <berto@igalia.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v3 2/2] qcow2: Skip copy-on-write when allocating a zero
 cluster
In-Reply-To: <7f0ae868-07ca-2267-eb27-2787ff86e801@virtuozzo.com>
References: <cover.1599759873.git.berto@igalia.com>
 <0350dd55702eacd701e0aea924b101db7448a517.1599759873.git.berto@igalia.com>
 <7f0ae868-07ca-2267-eb27-2787ff86e801@virtuozzo.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Fri, 11 Sep 2020 12:04:53 +0200
Message-ID: <w51blichbne.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/11 06:04:54
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri 11 Sep 2020 11:34:37 AM CEST, Vladimir Sementsov-Ogievskiy wrote:
>> -        if (!is_zero_cow(bs, m)) {
>> +        ret = is_zero_cow(bs, m);
>> +        if (ret < 0) {
>> +            return ret;
>
> It's a common practice to treat block-status errors as "unknown"
> status and not error-out immediately:
>
>   - really, it's not critical, we can continue assuming non-zero
>   - if there are real problems with IO, we'll most probably fail on
>   real read or write operation, and report its status, which seems
>   better for user than block-status error

But what's the problem exactly, does this complicate the code too much?
:-?

> So, I'd keep existing logic in handle_alloc_space(). And, if you agree
> and resend, probably good to split this patch into two, one for
> block.h/io.c and one for qcow2.c (still, I'm OK with it as one patch).

Sure, I can split the patch if I have to resend it.

Berto

