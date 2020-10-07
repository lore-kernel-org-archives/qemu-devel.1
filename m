Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE497C41604
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 15:38:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA1FF216C4
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 15:38:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Pl9m65Bv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA1FF216C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQBWh-0006N6-Pg
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 11:38:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57668)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1kQBW6-0005qv-1d; Wed, 07 Oct 2020 11:38:10 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:36781)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1kQBW2-0005rO-Ne; Wed, 07 Oct 2020 11:38:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=/eizcVXQGRkLxDWQ2lpdKa3LyG2ZJolxWQ4YaWXIfyM=; 
 b=Pl9m65Bv1vDVc1EzencOCOji00ypsXP6rrN7gPs3YxbijxPVNH4+j34fq1OfpmqDQZ+r5k5YtpZAzunHYsyWImUIr3FXLZ5+uX9tqkOVtgt91syDyQkJh0tP/sUuZTTjQx5QfzVh2Ap2BSdDYdXWY1749tXRcuKD4ByM0bPuUfywA3RrjCtSVL00XTld4/DtqSSlMplBvnqxwN8JnVhbb1bdWzHVQiVKsFRUjshch2CoWApSU8J9UCZKwnBYFaPuD3sGGlJ8ZRN//IZU+llrAGGvNcY5ZhbJrWNxVwgrggmo75wQg2T1UbwgcGTMOnDCIHwBADKp7cN8B3U7zJvS7Q==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1kQBVx-0003WI-UD; Wed, 07 Oct 2020 17:38:01 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1kQBVx-0002re-Ia; Wed, 07 Oct 2020 17:38:01 +0200
From: Alberto Garcia <berto@igalia.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] qcow2: Document and enforce the QCowL2Meta invariants
In-Reply-To: <f53af87c-15e3-4de5-42e0-213363759231@virtuozzo.com>
References: <20201007115217.18013-1-berto@igalia.com>
 <f53af87c-15e3-4de5-42e0-213363759231@virtuozzo.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Wed, 07 Oct 2020 17:38:01 +0200
Message-ID: <w51d01uavxi.fsf@maestria.local.igalia.com>
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

On Wed 07 Oct 2020 04:42:37 PM CEST, Vladimir Sementsov-Ogievskiy wrote:
>>       /**
>> -     * The COW Region between the start of the first allocated cluster and the
>> -     * area the guest actually writes to.
>> +     * The COW Region immediately before the area the guest actually
>> +     * writes to. This (part of the) write request starts at
>> +     * cow_start.offset + cow_start.nb_bytes.
>
> "starts at" is a bit misleading.. As here is not guest offset, not
> host offset, but offset relative to QCowL2Meta.offset

I thought it was clear by the context since Qcow2COWRegion.offset is
defined to be relative to QCowL2Meta.offset

>> @@ -1049,6 +1049,8 @@ int qcow2_alloc_cluster_link_l2(BlockDriverState *bs, QCowL2Meta *m)
>>       qcow2_cache_entry_mark_dirty(s->l2_table_cache, l2_slice);
>>   
>>       assert(l2_index + m->nb_clusters <= s->l2_slice_size);
>> +    assert(m->cow_end.offset + m->cow_end.nb_bytes <=
>> +           m->nb_clusters << s->cluster_bits);
>
> should we also assert that cow_end.offset + cow_end.nb_bytes is not
> zero?

No, a write request that fills a complete cluster has no COW but still
needs to call qcow2_alloc_cluster_link_l2() to update the L2 metadata.

>> -        /* The end region must be immediately after the data (middle)
>> -         * region */
>> +        /* The write request should end immediately before the second
>> +         * COW region (see above for why it does not always happen) */
>>           if (m->offset + m->cow_end.offset != offset + bytes) {
>> +            assert(offset + bytes > m->offset + m->cow_end.offset);
>> +            assert(m->cow_end.nb_bytes == 0);
>>               continue;
>>           }
>
> Then it's interesting, why not to merge if we have this zero-length
> cow region? What's the problem with it?

We do merge the request and the COW if one of the COW regions has zero
length, visually:

 1)
    <>                      <--- cow_end --->
    <--- write request ---->

 2)
    <--- cow_start --->                      <>
                       <--- write request ---->

In this case however the problem is not that the region is empty, but
that the request starts *before* (or after) that region and that there's
probably another QCowL2Meta earlier (or later):

    <----  1st QCowL2Meta  ---->         <---- 2nd QCowL2Meta ---->
    <--- cow_start --->       <>         <>       <--- cow_end --->
                       <---- write request ------>

What we would need here is to merge all QCowL2Meta into one, but I don't
think that we want to do that because it looks like complicating the
code for a scenario that does not happen very often.

Berto

