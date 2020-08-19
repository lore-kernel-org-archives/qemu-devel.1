Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA1F4C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 11:35:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71FB7206FA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 11:35:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="s2d/3lBY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71FB7206FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8MN1-0003R9-LU
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 07:35:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51570)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1k8MMS-0002xp-Eu; Wed, 19 Aug 2020 07:34:32 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:50754)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1k8MMP-0001T2-MG; Wed, 19 Aug 2020 07:34:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=i/7RcPoMUyC9rwFDuA/4n3z2fJixO74uHsRtVHvzpec=; 
 b=s2d/3lBY6htkx8w++y2zAw8Wa2xnT06DnQjL+1hsTeRBrJhO8QBacwZ4GTvbSUAvlkFc4+p+X6Wu86wGjxDqwhXgvRRtYSkWwDdvHqa7x0aYAN1YNNAH6/1NzWv1+l32Pw+qG3HmmRS+7KW/bUDpVoJWPqoec19F3lKggvusr7QrIG/UzI7sMeRyIOn+R7jJp7mqBZzEuOnZmldqHR3g/GR93nzrpK+QT7R5U1SKNojVH2roMVuCqdRQl91brk6H2sKLS5d4KPhyGyzf4w+xUIS/Y3iwpQeyQ8xR1DDlQ9WwqW83lvKJkkWOl6iu5t0W8fQ6RtTTrxOo3tXf/McyqA==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1k8MMJ-00039m-75; Wed, 19 Aug 2020 13:34:23 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1k8MMI-0003JK-Tl; Wed, 19 Aug 2020 13:34:22 +0200
From: Alberto Garcia <berto@igalia.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
Subject: Re: [PATCH v5 1/5] block/io: fix bdrv_co_block_status_above
In-Reply-To: <57758b78-227a-c753-db9e-fe503b163927@virtuozzo.com>
References: <20200610120426.12826-1-vsementsov@virtuozzo.com>
 <20200610120426.12826-2-vsementsov@virtuozzo.com>
 <w51lficjb0d.fsf@maestria.local.igalia.com>
 <57758b78-227a-c753-db9e-fe503b163927@virtuozzo.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Wed, 19 Aug 2020 13:34:22 +0200
Message-ID: <w51v9heeuo1.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 07:34:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: fam@euphon.net, kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com,
 stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed 19 Aug 2020 11:48:25 AM CEST, Vladimir Sementsov-Ogievskiy wrote:
>>> +             * The top layer deferred to this layer, and because this layer is
>>> +             * short, any zeroes that we synthesize beyond EOF behave as if they
>>> +             * were allocated at this layer
>>>                */
>>> +            assert(ret & BDRV_BLOCK_EOF);
>>>               *pnum = bytes;
>>> +            if (file) {
>>> +                *file = p;
>>> +            }
>>> +            return BDRV_BLOCK_ZERO | BDRV_BLOCK_ALLOCATED;
>> 
>> You don't add BDRV_BLOCK_EOF to the return code here ?
>
> No we shouldn't, as this is the end of backing file when the top layer
> is larger.

Ok, but maybe the original request also reaches EOF on the top layer.

An example that does not actually involve short backing files: let's say
that the size of the active image is 1MB and the backing file is 2MB.

We do 'write -z 960k 63k', that zeroes the last cluster minus a 1KB
tail, so qcow2_co_pwrite_zeroes() calls is_zero() to check if that last
1KB already contains zeroes.

bdrv_co_block_status_above() on the top layer returns BDRV_BLOCK_EOF: no
allocation, no zeros, we simply reached EOF. So we go to the backing
image to see what's there. This is also unallocated, there's no backing
file this time and want_zero is set, so this returns BDRV_BLOCK_ZERO.
However the backing file is longer so bdrv_co_block_status() does not
return BDRV_BLOCK_EOF this time.

If the backing file would have been the same size (1MB) we would have
BDRV_BLOCK_ZERO | BDRV_BLOCK_EOF, but if it's longer or (with your
patch) shorter then BDRV_BLOCK_EOF disappears.

Now, I don't see anyone else using BDRV_BLOCK_EOF for anything so this
does not have any practical effect at the moment, but is this worth
fixing?.

>>> +        res = bdrv_block_status_above(bs, NULL, offset, bytes, &nr, NULL, NULL);
>>> +        offset += nr;
>>> +        bytes -= nr;
>>> +    } while (res >= 0 && (res & BDRV_BLOCK_ZERO) && nr && bytes);
>> 
>> About this last "... && nr && bytes", I think 'nr' already implies
>> 'bytes', maybe you want to use an assertion instead?
>
> No, on the last iteration, bytes would be 0 and nr is a last
> chunk. So, if we check only nr, we'll do one extra call of
> bdrv_block_status_above with bytes=0, I don't want do it.

You're right !

Berto

