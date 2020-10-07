Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D142FC4727F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 16:43:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43E9A206BE
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 16:43:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="XKvZvr0P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43E9A206BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQCXQ-0001D5-4m
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 12:43:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35214)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1kQBup-0006NM-5X; Wed, 07 Oct 2020 12:03:43 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:54926)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1kQBuk-0001Sq-Nu; Wed, 07 Oct 2020 12:03:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=M6KJSNHjziQgjjDm3jqlOAWE3wt+M4set/Bj8vieMW0=; 
 b=XKvZvr0PrqWMthJf455u1R3hmqLzao9IqNCp/d0HY6DEIDqlaqoiGf21JXs2gjT0naEE65qdFgT9PXNZgG1djruxWOMZeBbhX/JzM5uf2TCztO4trkRcQXZzCYFKPrggmN3t5EB6bmRs3RKdmysy0hfdoXR4bNTOpFOR1UUZ85LflHdBhKigZSAHl/S0b0KPJ6Bp9qlbjMkfd56xtXQo/YoiM9PCJlWbPoqtcmTHUKa1CO9uLnCOkEQqSGBW3JtKX7R5M+JUrd18s9oIOYb8zxCjLQxIWHbNISDC/uFOMe54w74Q+sxNjk6zJBpRYXMdHTQ1x2vOuayq/iV9LVC0fg==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1kQBuf-0006am-W5; Wed, 07 Oct 2020 18:03:34 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1kQBuf-0006Hh-GK; Wed, 07 Oct 2020 18:03:33 +0200
From: Alberto Garcia <berto@igalia.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] qcow2: Document and enforce the QCowL2Meta invariants
In-Reply-To: <9105bbe6-dd05-4568-b2ee-9eb8f943c535@virtuozzo.com>
References: <20201007115217.18013-1-berto@igalia.com>
 <f53af87c-15e3-4de5-42e0-213363759231@virtuozzo.com>
 <w51d01uavxi.fsf@maestria.local.igalia.com>
 <9105bbe6-dd05-4568-b2ee-9eb8f943c535@virtuozzo.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Wed, 07 Oct 2020 18:03:33 +0200
Message-ID: <w51a6wyauqy.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 11:38:02
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

On Wed 07 Oct 2020 05:47:32 PM CEST, Vladimir Sementsov-Ogievskiy wrote:
> 07.10.2020 18:38, Alberto Garcia wrote:
>> On Wed 07 Oct 2020 04:42:37 PM CEST, Vladimir Sementsov-Ogievskiy wrote:
>>>>        /**
>>>> -     * The COW Region between the start of the first allocated cluster and the
>>>> -     * area the guest actually writes to.
>>>> +     * The COW Region immediately before the area the guest actually
>>>> +     * writes to. This (part of the) write request starts at
>>>> +     * cow_start.offset + cow_start.nb_bytes.
>>>
>>> "starts at" is a bit misleading.. As here is not guest offset, not
>>> host offset, but offset relative to QCowL2Meta.offset
>> 
>> I thought it was clear by the context since Qcow2COWRegion.offset is
>> defined to be relative to QCowL2Meta.offset
>> 
>>>> @@ -1049,6 +1049,8 @@ int qcow2_alloc_cluster_link_l2(BlockDriverState *bs, QCowL2Meta *m)
>>>>        qcow2_cache_entry_mark_dirty(s->l2_table_cache, l2_slice);
>>>>    
>>>>        assert(l2_index + m->nb_clusters <= s->l2_slice_size);
>>>> +    assert(m->cow_end.offset + m->cow_end.nb_bytes <=
>>>> +           m->nb_clusters << s->cluster_bits);
>>>
>>> should we also assert that cow_end.offset + cow_end.nb_bytes is not
>>> zero?
>> 
>> No, a write request that fills a complete cluster has no COW but still
>> needs to call qcow2_alloc_cluster_link_l2() to update the L2 metadata.
>
> but cow_end.offset will not be zero still? I suggest it because you
> actually rely on this fact by dropping written_to conditional
> assignment.

No, cow_end.offset must not be 0 but the offset where the data region
ends, this is already enforced by this assertion in perform_cow():

    assert(start->offset + start->nb_bytes <= end->offset);

And it is explicitly mentioned in the commit message:

    Even when those regions themselves are empty their offsets must be
    correct because they are used to know the location of the middle
    region.

and also in qcow2.h:

  /**
   * The COW Region immediately after the area the guest actually
   * writes to. This (part of the) write request ends at cow_end.offset
   * (which must always be set even when cow_end.nb_bytes is 0).
   */
  Qcow2COWRegion cow_end;

Berto

