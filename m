Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7421DC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 19:12:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49865207BC
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 19:12:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ACVFIa7n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49865207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeNwu-0004FP-CZ
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 15:12:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37010)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jeNwL-0003oe-FZ
 for qemu-devel@nongnu.org; Thu, 28 May 2020 15:11:41 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:57720
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jeNwJ-00081w-RG
 for qemu-devel@nongnu.org; Thu, 28 May 2020 15:11:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590693097;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qoHmuYITB9VyuergFeembIQ/Eu1kdKqmFCwJpoJQo6Q=;
 b=ACVFIa7nd89/u9PVxo7A0vprAxJSDUGCNro6GgOKgpEgk7r8XL+yX5AjLkCpsx2NijNNcJ
 hRM7HFL2IpArudjOs9rpgo5ks98PP8yMVeXIrY8BA+/Wi7kRdYWsQD8FxeR2pF9hklZQDo
 sZMnrJKctrph7No4IIH2/B3Yx9tskng=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-109--9JgHaspPL6-Rs8eLNVe4Q-1; Thu, 28 May 2020 15:11:10 -0400
X-MC-Unique: -9JgHaspPL6-Rs8eLNVe4Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7EC5D1005510;
 Thu, 28 May 2020 19:11:09 +0000 (UTC)
Received: from [10.3.112.88] (ovpn-112-88.phx2.redhat.com [10.3.112.88])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D15DD1A91F;
 Thu, 28 May 2020 19:11:07 +0000 (UTC)
Subject: Re: [PATCH v7 28/32] qcow2: Add subcluster support to
 qcow2_co_pwrite_zeroes()
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1590429901.git.berto@igalia.com>
 <e037ed54599e7bf4d76bf8cd8db1904a20ffc6dd.1590429901.git.berto@igalia.com>
 <467e4184-2cee-a9e9-9cf0-ee6050ea4319@redhat.com>
 <w51sgfkt81f.fsf@maestria.local.igalia.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <0adafac6-15e8-96eb-6c3f-bb9c182fb2d1@redhat.com>
Date: Thu, 28 May 2020 14:11:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <w51sgfkt81f.fsf@maestria.local.igalia.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 02:50:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

On 5/28/20 10:04 AM, Alberto Garcia wrote:
> On Wed 27 May 2020 07:58:10 PM CEST, Eric Blake wrote:
>>> There is just one thing to take into account for a possible future
>>> improvement: compressed clusters cannot be partially zeroized so
>>> zero_l2_subclusters() on the head or the tail can return -ENOTSUP.
>>> This makes the caller repeat the *complete* request and write actual
>>> zeroes to disk. This is sub-optimal because
>>>
>>>      1) if the head area was compressed we would still be able to use
>>>         the fast path for the body and possibly the tail.
>>>
>>>      2) if the tail area was compressed we are writing zeroes to the
>>>         head and the body areas, which are already zeroized.
>>
>> Is this true?  The block layer tries hard to break zero requests up so
>> that any non-cluster-aligned requests do not cross cluster boundaries.
>> In practice, that means that when you have an unaligned request, the
>> head and tail cluster will be the same cluster, and there is no body in
>> play, so that returning -ENOTSUP is correct because there really is no
>> other work to do and repeating the entire request (which is less than a
>> cluster in length) is the right approach.
> 
> Let's use an example.
> 
> cluster size is 64KB, subcluster size is 2KB, and we get this request:
> 
>     write -z 31k 130k
> 
> Since pwrite_zeroes_alignment equals the cluster size (64KB), this
> would result in 3 calls to qcow2_co_pwrite_zeroes():
> 
>     offset=31k  size=33k    [-ENOTSUP, writes actual zeros]
>     offset=64k  size=64k    [zeroized using the relevant metadata bits]
>     offset=128k size=33k    [-ENOTSUP, writes actual zeros]
> 
> However this patch changes the alignment:
> 
>      bs->bl.pwrite_zeroes_alignment = s->subcluster_size;

Ah, I missed that trick.  But it is nice, and indeed...

> 
> so we get these instead:
> 
>     offset=31k  size=1k     [-ENOTSUP, writes actual zeros]
>     offset=32k  size=128k   [zeroized using the relevant metadata bits]
>     offset=160k size=1k     [-ENOTSUP, writes actual zeros]
> 
> So far, so good. Reducing the alignment requirements allows us to
> maximize the number of subclusters to zeroize.

...we can now hit a request that is not cluster-aligned.

> 
> Now let's suppose we have this request:
> 
>     write -z 32k 128k
> 
> This one is aligned so it goes directly to qcow2_co_pwrite_zeroes().
> However if the third cluster is compressed then the function will
> return -ENOTSUP after having zeroized the first 96KB of the request,
> forcing the caller to repeat it completely using the slow path.
> 
> I think the problem also exists in the current code (without my
> patches). If you zeroize 10 clusters and the last one is compressed
> you have to repeat the request after having zeroized 9 clusters.

Hmm. In the pre-patch code, qcow2_co_pwrite_zeroes() calls 
qcow2_cluster_zeroize() which can fail with -ENOTSUP up front, but not 
after the fact.  Once it starts the while loop over clusters, its use of 
zero_in_l2_slice() handles compressed clusters just fine; as far as I 
can tell, only your new subcluster handling lets it now fail with 
-ENOTSUP after earlier clusters have been visited.

But isn't this something we could solve recursively?  Instead of 
returning -ENOTSUP, we could have zero_in_l2_slice() call 
bdrv_pwrite_zeroes() on the (sub-)clusters associated with a compressed 
cluster.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


