Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4184C28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 17:15:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A1A820708
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 17:15:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="mgt5FbTA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A1A820708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWNe2-00022S-Mf
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 13:15:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40938)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jWNct-0001QT-Nl; Wed, 06 May 2020 13:14:31 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:48494)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jWNcr-0003D3-B8; Wed, 06 May 2020 13:14:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=8u7Sgt9fMYKrRW02McIw8M1xGPM+odtO4FYvYIPULxk=; 
 b=mgt5FbTAPuAW5l+6+CEu86Zrqf1Vt3oKh4vN4NQVcXQscbKORD0yFg8tEsds/MZSohV1tqaz5yRMr/0OTLJd5m+jkUMl1NjiMfLqbrCf9nflhCD428MSF0A3RDEYuQNagDfwhxCG7/r0KIZNeYmg/6UwSNTzXR8eKyWQAtI59S8PJrLKUFULH66u5eFXGQNxBoNk3ySbCAPoC07NT0pxfOr1XlZ/+1EAHAAR1sn18UurNYk8/dGKH1InhHXmjecbT2F4+N/yXJ9eyBvYUInsZe3JGAT+WVULZFNXuDhz7L/p9aXU6IhcSX9CvopHlnbxN5yfgna6Oc6IGHLEN2UVsQ==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1jWNcn-00027i-OE; Wed, 06 May 2020 19:14:25 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1jWNcn-0004re-F1; Wed, 06 May 2020 19:14:25 +0200
From: Alberto Garcia <berto@igalia.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v5 19/31] qcow2: Add subcluster support to
 calculate_l2_meta()
In-Reply-To: <12569151-2f16-f136-6928-2a915b25120b@redhat.com>
References: <cover.1588699789.git.berto@igalia.com>
 <907ab6846b93b441a27eb6853ff3058f1c821bf9.1588699789.git.berto@igalia.com>
 <12569151-2f16-f136-6928-2a915b25120b@redhat.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Wed, 06 May 2020 19:14:25 +0200
Message-ID: <w517dxp9ea6.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/06 11:02:53
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue 05 May 2020 11:59:18 PM CEST, Eric Blake wrote:
>> +        for (i = first_sc; i <= last_sc; i++) {
>> +            unsigned c = i / s->subclusters_per_cluster;
>> +            unsigned sc = i % s->subclusters_per_cluster;
>> +            l2_entry = get_l2_entry(s, l2_slice, l2_index + c);
>> +            l2_bitmap = get_l2_bitmap(s, l2_slice, l2_index + c);
>> +            type = qcow2_get_subcluster_type(bs, l2_entry, l2_bitmap, sc);
>> +            if (type == QCOW2_SUBCLUSTER_INVALID) {
>> +                l2_index += c; /* Point to the invalid entry */
>> +                goto fail;
>> +            }
>> +            if (type != QCOW2_SUBCLUSTER_NORMAL) {
>>                   break;
>>               }
>>           }
>
> This loop is now 32 times slower (for extended L2 entries).  Do you
> really need to check for an invalid subcluster here, or can we just
> blindly check that all 32 subclusters are NORMAL, and leave handling
> of invalid clusters for the rest of the function after we failed the
> exit-early test?  For that matter, for all but the first and last
> cluster, checking if 32 clusters are NORMAL is a simple 64-bit
> comparison rather than 32 iterations of a loop; and even for the first
> and last cluster, the _RANGE macros in 14/31 work well to mask out
> which bits must be set/cleared.  My guess is that optimizing this loop
> is worthwhile, since overwriting existing data is probably more common
> than allocating new data.

I think you're right, and now we have the _RANGE macros so it should be
doable. I'll look into it.

>> -        if (i == nb_clusters) {
>> -            return;
>> +        if (i == last_sc + 1) {
>> +            return 0;
>>           }
>>       }
>
> If we get here, then i is now the address of the first subcluster that 
> was not NORMAL, even if it is much smaller than the final subcluster 
> learned by nb_clusters for the overall request.  [1]

I'm replying to this part later in [1]

>>       /* Get the L2 entry of the first cluster */
>>       l2_entry = get_l2_entry(s, l2_slice, l2_index);
>> -    type = qcow2_get_cluster_type(bs, l2_entry);
>> +    l2_bitmap = get_l2_bitmap(s, l2_slice, l2_index);
>> +    sc_index = offset_to_sc_index(s, guest_offset);
>> +    type = qcow2_get_subcluster_type(bs, l2_entry, l2_bitmap, sc_index);
>>   
>> -    if (type == QCOW2_CLUSTER_NORMAL && keep_old) {
>> -        cow_start_from = cow_start_to;
>> +    if (type == QCOW2_SUBCLUSTER_INVALID) {
>> +        goto fail;
>> +    }
>> +
>> +    if (!keep_old) {
>> +        switch (type) {
>> +        case QCOW2_SUBCLUSTER_COMPRESSED:
>> +            cow_start_from = 0;
>> +            break;
>> +        case QCOW2_SUBCLUSTER_NORMAL:
>> +        case QCOW2_SUBCLUSTER_ZERO_ALLOC:
>> +        case QCOW2_SUBCLUSTER_UNALLOCATED_ALLOC: {
>> +            int i;
>> +            /* Skip all leading zero and unallocated subclusters */
>> +            for (i = 0; i < sc_index; i++) {
>> +                QCow2SubclusterType t;
>> +                t = qcow2_get_subcluster_type(bs, l2_entry, l2_bitmap, i);
>> +                if (t == QCOW2_SUBCLUSTER_INVALID) {
>> +                    goto fail;
>> +                } else if (t == QCOW2_SUBCLUSTER_NORMAL) {
>> +                    break;
>> +                }
>> +            }
>> +            cow_start_from = i << s->subcluster_bits;
>> +            break;
>
> Note that you are only skipping until the first normal subcluster, even 
> if other zero/unallocated clusters occur between the first normal 
> cluster and the start of the action.

That's correct.

> Or visually, suppose we have:
>
> --0-NN-0_NNNNNNNN_NNNNNNNN_NNNNNNNN
>
> as our 32 subclusters, with sc_index of 8.  You will end up skipping
> subclusters 0-3, but NOT 6 and 7.

That's correct. This function works with the assumption that the initial
COW region is located immediately before the data region, which is in
turn contiguous to the tail COW region.

I'm actually not sure that it necessarily has to be that way, but at
least it seems that functions like handle_alloc_space() rely on
that. Certainly before subclusters I don't see how there would be any
space between the COW regions and the actual data region.

While checking the documentation of QCowL2Meta I also realized that
maybe it also needs to be updated. "The COW Region between the start of
the first allocated cluster and the area the guest actually writes to",
it's not necessarily the start of the cluster anymore, although the word
"between" leaves some room for interpretation.

Anyway, even if we could do COW of subclusters 4-5 only, there's no
general way to do that without touching QCowL2Meta or using more than
one structure (imagine we have -N-N-N-N_NNNN ...). I'm also not sure
that it's worth it.

> Still, even though we spend time copying the allocated contents of
> those two subclusters, we also copy the subcluster status, and the
> guest still ends up reading the same data as before.

No, the subcluster status is updated and those subclusters are marked
now as allocated. That's actually why we can use the _RANGE masks that
you proposed here:

   https://lists.gnu.org/archive/html/qemu-block/2020-04/msg01155.html

In other words, we have this bitmap:

   --0-NN-0_NNNNNNNN_NNNNNNNN_NNNNNNNN

If we write to subcluster 8 (which was already allocated), the resulting
bitmap is this one:

   --0-NNNN_NNNNNNNN_NNNNNNNN_NNNNNNNN

The last block in iotest 271 deals exactly with this kind of scenarios.

>>       /* Get the L2 entry of the last cluster */
>> -    l2_entry = get_l2_entry(s, l2_slice, l2_index + nb_clusters - 1);
>> -    type = qcow2_get_cluster_type(bs, l2_entry);
>> +    l2_index += nb_clusters - 1;
>> +    l2_entry = get_l2_entry(s, l2_slice, l2_index);
>> +    l2_bitmap = get_l2_bitmap(s, l2_slice, l2_index);
>> +    sc_index = offset_to_sc_index(s, guest_offset + bytes - 1);
>> +    type = qcow2_get_subcluster_type(bs, l2_entry, l2_bitmap, sc_index);
>
> [1] but here, we are skipping any intermediate clusters, and worrying
> only about the state of the final cluster.  Is that always going to do
> the correct thing, or will there be cases where we need to update the
> L2 entries of intermediate clusters?

       Cluster 1             Cluster 2             Cluster 3
|---------------------|---------------------|---------------------|
   <---cow_start--><-------write request--------><--cow_end--->


All L2 entries from the beginning of cow_start until the end of cow_end
are always updated. That's again what the loop that I optimized using
the _RANGE masks (and that I liked above) was doing.

The code in calculate_l2_meta() is only concerned with determining the
actual start and end points. Everything between them will be written to
and marked as allocated. It's only the subclusters outside that range
that keep the previous values (unallocated, or zero).

Berto

