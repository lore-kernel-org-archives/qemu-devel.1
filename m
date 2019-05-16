Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07575C04AAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 14:28:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7545F20833
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 14:28:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="hFlxa9XH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7545F20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58992 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRHMu-0004W4-B3
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 10:28:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hRHLu-0003zn-1p
	for qemu-devel@nongnu.org; Thu, 16 May 2019 10:27:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hRHLt-0002wK-7Y
	for qemu-devel@nongnu.org; Thu, 16 May 2019 10:27:22 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:51168)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>)
	id 1hRHLq-0002sm-Mp; Thu, 16 May 2019 10:27:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; 
	h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
	bh=5fE7bVQ5ZOyTTRC0f9Ac/+0/2J3Mvcf+qPivqhi/fu4=; 
	b=hFlxa9XH87b43V10JlZ21ijkefl47Nys5CqMLkLGo+fAsLGFOLn5lsfphofb2k/gPCQlxwRAz8iafth1GHo16PexjLqFR+6+ln7G8kORkmWIerQER/mwkA28q1L+G42FnuFFMBDGgybYpOSLbZca1NnfJJj93Zcq8Zp5Ss445SdEF1Sht31AOII9xHZhRIvnh+WOom5stu8SxufDs0VZou0DDo4iSMd0sb9QejpwsZ1qI/e5sdVJq9RlWCWJ/xyE3STATeLkSVv5Wmva4zvq7VlZUbZWrhSHYn5HZVhaqalq3HLL1OCsz+PNNvhbmL6nLLC8A+LbIEtRz9jOlf7t5g==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
	by fanzine.igalia.com with esmtps 
	(Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
	id 1hRHLn-0001rt-L9; Thu, 16 May 2019 16:27:15 +0200
Received: from berto by mail.igalia.com with local (Exim)
	id 1hRHLn-0007j1-IS; Thu, 16 May 2019 16:27:15 +0200
From: Alberto Garcia <berto@igalia.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
In-Reply-To: <20190515201503.19069-5-mreitz@redhat.com>
References: <20190515201503.19069-1-mreitz@redhat.com>
	<20190515201503.19069-5-mreitz@redhat.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
	(i586-pc-linux-gnu)
Date: Thu, 16 May 2019 16:27:15 +0200
Message-ID: <w515zqav5j0.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
	timestamps) [generic] [fuzzy]
X-Received-From: 91.117.99.155
Subject: Re: [Qemu-devel] [PATCH 4/4] iotests: Make 245 faster and more
 reliable
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
	Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed 15 May 2019 10:15:03 PM CEST, Max Reitz wrote:
> Sometimes, 245 fails for me because some stream job has already finished
> while the test expects it to still be active.  (With -c none, it fails
> basically every time.) The most reliable way to fix this is to simply
> set auto_finalize=false so the job will remain in the block graph as
> long as we need it.  This allows us to drop the rate limiting, too,
> which makes the test faster.
>
> The only problem with this is that there is a single place that yields a
> different error message depending on whether the stream job is still
> copying data (so COR is enabled) or not (COR has been disabled, but the
> job still has the WRITE_UNCHANGED permission on the target node).  We
> can easily address that by expecting either error message.
>
> Note that we do not need auto_finalize=false (or rate limiting) for the
> active commit job, because It never completes without an explicit
> block-job-complete anyway.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto

