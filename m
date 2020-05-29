Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B46A1C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 16:07:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F6A72072D
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 16:07:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="mIr3iP7S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F6A72072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jehY5-0005G0-NG
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 12:07:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54482)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jehWx-0004b4-7L; Fri, 29 May 2020 12:06:47 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:50919)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jehWv-0008TW-2f; Fri, 29 May 2020 12:06:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=WvvQCIvwekoS/kY4NSTaXzv4TT6EdBEo6/pD/7vfBD8=; 
 b=mIr3iP7SR66K1U9KJth9CrgFQfZV4npLVjjC1Q05vy6NS3V6WqoEksktdXzWJeI1x0t5uxuxJ8KlvSHWWowlhqv+ebDVu0aMKR7ktTJVKETf+yffdgobUWv79dclVkd+cuhbYtgRf7ZKMQbGsKcmxbTvJcVwaU0U0rmm9pa8ajDe5k9PIejgc+GeVa3toRnEUxSyKzRBBoGDGchFn9kQumNhO22MoZz3Vxpi2cZw6S1yMIgu9M4VatjBV2likf/aSxGrts6AeTvFDKjumlgrMvlVqg0K9FcY+/cygONvcD21cJhnzPNoS3qYpEb7aSH+3GZW6Y34nUBrDO7AKEMPZA==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1jehWq-0006l6-BM; Fri, 29 May 2020 18:06:40 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1jehWq-0004kk-2L; Fri, 29 May 2020 18:06:40 +0200
From: Alberto Garcia <berto@igalia.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v7 28/32] qcow2: Add subcluster support to
 qcow2_co_pwrite_zeroes()
In-Reply-To: <0adafac6-15e8-96eb-6c3f-bb9c182fb2d1@redhat.com>
References: <cover.1590429901.git.berto@igalia.com>
 <e037ed54599e7bf4d76bf8cd8db1904a20ffc6dd.1590429901.git.berto@igalia.com>
 <467e4184-2cee-a9e9-9cf0-ee6050ea4319@redhat.com>
 <w51sgfkt81f.fsf@maestria.local.igalia.com>
 <0adafac6-15e8-96eb-6c3f-bb9c182fb2d1@redhat.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Fri, 29 May 2020 18:06:40 +0200
Message-ID: <w51sgfivi7j.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/29 11:07:06
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
Cc: Kevin Wolf <kwolf@redhat.com>, Derek Su <dereksu@qnap.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu 28 May 2020 09:11:07 PM CEST, Eric Blake wrote:
>> I think the problem also exists in the current code (without my
>> patches). If you zeroize 10 clusters and the last one is compressed
>> you have to repeat the request after having zeroized 9 clusters.
>
> Hmm. In the pre-patch code, qcow2_co_pwrite_zeroes() calls
> qcow2_cluster_zeroize() which can fail with -ENOTSUP up front, but not
> after the fact.  Once it starts the while loop over clusters, its use
> of zero_in_l2_slice() handles compressed clusters just fine;

You're right, complete compressed clusters can always be handled, the
problem is just when there's subclusters.

> But isn't this something we could solve recursively?  Instead of
> returning -ENOTSUP, we could have zero_in_l2_slice() call
> bdrv_pwrite_zeroes() on the (sub-)clusters associated with a
> compressed cluster.

I suppose we could, as long as BDRV_REQ_NO_FALLBACK is not used.

Berto

