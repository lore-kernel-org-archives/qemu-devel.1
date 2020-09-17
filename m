Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC231C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 14:56:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F06B1206DC
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 14:56:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Ex4d/vsN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F06B1206DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIvKZ-0004DU-25
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 10:56:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50824)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1kIvCR-00052I-Dj; Thu, 17 Sep 2020 10:47:51 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:52417)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1kIvCO-0007R8-OV; Thu, 17 Sep 2020 10:47:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=MAbxPQhcB4q9/bAXd9UpPqfjnp4OiDoyrxWmg9eT538=; 
 b=Ex4d/vsNPOMgx/ZyFclkot3fs4iPjihPF8pAqX3R6qrW93E6JoezMAKwmrIUGDmteA0LRApiB2sM2nL3pLHsq8/uN3sK3OTNxKjLvxfxxt0toA6VUevLfQ6xsV4tmQnSR7qOCt0gTMnRl7cJi64tIz36nGQzb5MIkyTuZycFpT1f05AMDb9SnkFNtYygENKU1C0lNWuI/9vbr+kE7oNW5UTx0N4y6beHe1nGz8KcJX2mMoN5MIaMRjf0sA6uA1Jswg3iuwOTq6uzRX6vgC/1QF+qRhjMYhEMrfKPwOpXCY+jLRUAd8Hl77ymg9vzz2AhLCkmcPbn/s0wUSny+SVeAA==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1kIvCI-0000Rv-BY; Thu, 17 Sep 2020 16:47:42 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1kIvCI-0002JL-28; Thu, 17 Sep 2020 16:47:42 +0200
From: Alberto Garcia <berto@igalia.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
Subject: Re: [PATCH 03/14] block: check return value of bdrv_open_child and
 drop error propagation
In-Reply-To: <20200909185930.26524-4-vsementsov@virtuozzo.com>
References: <20200909185930.26524-1-vsementsov@virtuozzo.com>
 <20200909185930.26524-4-vsementsov@virtuozzo.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Thu, 17 Sep 2020 16:47:42 +0200
Message-ID: <w51v9gcxxwx.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 09:56:37
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, pavel.dovgaluk@ispras.ru,
 qemu-devel@nongnu.org, armbru@redhat.com, groug@kaod.org, stefanha@redhat.com,
 pbonzini@redhat.com, mreitz@redhat.com, jsnow@redhat.com, ari@tuxera.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed 09 Sep 2020 08:59:19 PM CEST, Vladimir Sementsov-Ogievskiy wrote:
> This patch is generated by cocci script:
>
> @@
> symbol bdrv_open_child, errp, local_err;
> expression file;
> @@
>
>   file = bdrv_open_child(...,
> -                        &local_err
> +                        errp
>                         );
> - if (local_err)
> + if (!file)
>   {
>       ...
> -     error_propagate(errp, local_err);
>       ...
>   }
>
> with command
>
> spatch --sp-file x.cocci --macro-file scripts/cocci-macro-file.h \
> --in-place --no-show-diff --max-width 80 --use-gitgrep block
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto

