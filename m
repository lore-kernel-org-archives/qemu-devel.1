Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24545C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 12:12:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E120E20989
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 12:12:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Z4xErJjD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E120E20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53453 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOhuC-0004My-6v
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 08:12:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hOhtD-0003Yq-51
	for qemu-devel@nongnu.org; Thu, 09 May 2019 08:11:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hOhtB-0007bi-SY
	for qemu-devel@nongnu.org; Thu, 09 May 2019 08:11:07 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:46559)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>)
	id 1hOhtB-0007af-8A; Thu, 09 May 2019 08:11:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; 
	h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
	bh=bhP6s96IN0mMmLaMxOyxA0GIxGU8ngGsRX5Vt8ynKE0=; 
	b=Z4xErJjDS+AZek+4NvyonlViFrSnFAF7VKmHCIKKHXjSqOOeULmKMoPzF7Zl0NH+pLtIQZLitx5LAWL2PaBU6aqgIRCIX5xtnJuMuFUivkM33xMxxENVoMJ6b5AeuBDo/yxBSfG0Pj9nVzL0C6bhHpNeVa8s9X4Trk/qbpjiKNPUHM+Q/z+AWvaY+CJ13kCVKOijA//4AVGY6M1mi7CSy97bXnJ2sT87WDe3NqUI/CPBIiNUiHLcIw2GPcPs32D+LtHSDnFSnYvGxfQa92cb2BcKgxjsTant1jgbRqC3N5ovEhlJEqc4GICbcbv8bmvcc1EH9bGnME/JPFNz99xWSg==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
	by fanzine.igalia.com with esmtps 
	(Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
	id 1hOht8-0003tb-GI; Thu, 09 May 2019 14:11:02 +0200
Received: from berto by mail.igalia.com with local (Exim)
	id 1hOht8-0007FX-Dg; Thu, 09 May 2019 14:11:02 +0200
From: Alberto Garcia <berto@igalia.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
	qemu-devel@nongnu.org, qemu-block@nongnu.org
In-Reply-To: <20190506142741.41731-7-vsementsov@virtuozzo.com>
References: <20190506142741.41731-1-vsementsov@virtuozzo.com>
	<20190506142741.41731-7-vsementsov@virtuozzo.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
	(i586-pc-linux-gnu)
Date: Thu, 09 May 2019 14:11:02 +0200
Message-ID: <w51o94bbzft.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
	timestamps) [generic] [fuzzy]
X-Received-From: 91.117.99.155
Subject: Re: [Qemu-devel] [PATCH v6 6/8] qcow2: qcow2_co_preadv: improve
 locking
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, mreitz@redhat.com,
	den@openvz.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon 06 May 2019 04:27:39 PM CEST, Vladimir Sementsov-Ogievskiy wrote:
> Background: decryption will be done in threads, to take benefit of it,
> we should move it out of the lock first.
>
> But let's go further: it turns out, that only
> qcow2_get_cluster_offset() needs locking, so reduce locking to it.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto

