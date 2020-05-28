Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE8E9C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 15:06:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AABC2075F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 15:06:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="DHTF+UfE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AABC2075F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeK6y-0007BW-JZ
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 11:06:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55268)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jeK5n-0006AZ-Mh; Thu, 28 May 2020 11:05:11 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:51129)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jeK5l-0004a7-Jy; Thu, 28 May 2020 11:05:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=mPChjVqcYELyPfpwpRwe6ptSBDotoAJcA7LuuOuiYAE=; 
 b=DHTF+UfEhVGyd6StCqLlo8B93Pboo+wj2w8u3MvMkjaQe53efyKKaTSjpNiQaqLT2mMREV8yssGbJmb1s+d0eDO5Ijxy50T9HF3arfUiVeFb5OLddY5uoXF0HhvWOTBPv6tHCgcek/bjUS/TqA/imZX7OZrNpXKskPCyt/NigD/X+r0aPXp05pzdE63g9wOk+1qb0rRZPsTMbpuepvqQUdtGlvaKLO4YTm5MZgApxdO+fq/OsZEzrA2aCZDIr2IzxWSyJhld/Q4gDp6gmhmznRKrpd+EFgDm2widzt5GfNXqqsjjCxcvUAsPBnlJoVd8XhJ1oZt4OWyihTjAAlsOFw==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1jeK5M-0006hH-B5; Thu, 28 May 2020 17:04:44 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1jeK5M-0001t5-1Z; Thu, 28 May 2020 17:04:44 +0200
From: Alberto Garcia <berto@igalia.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v7 28/32] qcow2: Add subcluster support to
 qcow2_co_pwrite_zeroes()
In-Reply-To: <467e4184-2cee-a9e9-9cf0-ee6050ea4319@redhat.com>
References: <cover.1590429901.git.berto@igalia.com>
 <e037ed54599e7bf4d76bf8cd8db1904a20ffc6dd.1590429901.git.berto@igalia.com>
 <467e4184-2cee-a9e9-9cf0-ee6050ea4319@redhat.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Thu, 28 May 2020 17:04:44 +0200
Message-ID: <w51sgfkt81f.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 11:04:45
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

On Wed 27 May 2020 07:58:10 PM CEST, Eric Blake wrote:
>> There is just one thing to take into account for a possible future
>> improvement: compressed clusters cannot be partially zeroized so
>> zero_l2_subclusters() on the head or the tail can return -ENOTSUP.
>> This makes the caller repeat the *complete* request and write actual
>> zeroes to disk. This is sub-optimal because
>> 
>>     1) if the head area was compressed we would still be able to use
>>        the fast path for the body and possibly the tail.
>> 
>>     2) if the tail area was compressed we are writing zeroes to the
>>        head and the body areas, which are already zeroized.
>
> Is this true?  The block layer tries hard to break zero requests up so 
> that any non-cluster-aligned requests do not cross cluster boundaries. 
> In practice, that means that when you have an unaligned request, the 
> head and tail cluster will be the same cluster, and there is no body in 
> play, so that returning -ENOTSUP is correct because there really is no 
> other work to do and repeating the entire request (which is less than a 
> cluster in length) is the right approach.

Let's use an example.

cluster size is 64KB, subcluster size is 2KB, and we get this request:

   write -z 31k 130k

Since pwrite_zeroes_alignment equals the cluster size (64KB), this
would result in 3 calls to qcow2_co_pwrite_zeroes():

   offset=31k  size=33k    [-ENOTSUP, writes actual zeros]
   offset=64k  size=64k    [zeroized using the relevant metadata bits]
   offset=128k size=33k    [-ENOTSUP, writes actual zeros]

However this patch changes the alignment:

    bs->bl.pwrite_zeroes_alignment = s->subcluster_size;

so we get these instead:

   offset=31k  size=1k     [-ENOTSUP, writes actual zeros]
   offset=32k  size=128k   [zeroized using the relevant metadata bits]
   offset=160k size=1k     [-ENOTSUP, writes actual zeros]

So far, so good. Reducing the alignment requirements allows us to
maximize the number of subclusters to zeroize.

Now let's suppose we have this request:

   write -z 32k 128k

This one is aligned so it goes directly to qcow2_co_pwrite_zeroes().
However if the third cluster is compressed then the function will
return -ENOTSUP after having zeroized the first 96KB of the request,
forcing the caller to repeat it completely using the slow path.

I think the problem also exists in the current code (without my
patches). If you zeroize 10 clusters and the last one is compressed
you have to repeat the request after having zeroized 9 clusters.

Berto

