Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FAD7C47247
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 22:00:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46C202075E
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 22:00:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xs/pR+1J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46C202075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jW5by-0000Lb-BI
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 18:00:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35456)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jW5b6-0008Ky-Lz
 for qemu-devel@nongnu.org; Tue, 05 May 2020 17:59:28 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:26377
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jW5b4-0002uA-TQ
 for qemu-devel@nongnu.org; Tue, 05 May 2020 17:59:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588715965;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ea1rileO8TACkSFXABN3qcLBrlyq57QbvoUeRN8aKzE=;
 b=Xs/pR+1Jpk8wrYGEaYODRJ4ior8Zh8pOL4cyVjHgI1GasargGJEeO5QkWmDurv9aGL6d8W
 G4moTGGv1lauoF1xgfxWptZxpeNvHNeq86zGRiQEVA9nXhT/KRNwqDU+PfzguG5SCl7lEv
 3R+rlJA62xvSe4z+vds++zTlO+OxnwY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-491-IkJYnzNmPlWJcAfLVAqrKA-1; Tue, 05 May 2020 17:59:20 -0400
X-MC-Unique: IkJYnzNmPlWJcAfLVAqrKA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9C72480183C;
 Tue,  5 May 2020 21:59:19 +0000 (UTC)
Received: from [10.3.114.73] (ovpn-114-73.phx2.redhat.com [10.3.114.73])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C39175D9C5;
 Tue,  5 May 2020 21:59:18 +0000 (UTC)
Subject: Re: [PATCH v5 19/31] qcow2: Add subcluster support to
 calculate_l2_meta()
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1588699789.git.berto@igalia.com>
 <907ab6846b93b441a27eb6853ff3058f1c821bf9.1588699789.git.berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <12569151-2f16-f136-6928-2a915b25120b@redhat.com>
Date: Tue, 5 May 2020 16:59:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <907ab6846b93b441a27eb6853ff3058f1c821bf9.1588699789.git.berto@igalia.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 15:23:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
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

On 5/5/20 12:38 PM, Alberto Garcia wrote:
> If an image has subclusters then there are more copy-on-write
> scenarios that we need to consider. Let's say we have a write request
> from the middle of subcluster #3 until the end of the cluster:
> 
> 1) If we are writing to a newly allocated cluster then we need
>     copy-on-write. The previous contents of subclusters #0 to #3 must
>     be copied to the new cluster. We can optimize this process by
>     skipping all leading unallocated or zero subclusters (the status of
>     those skipped subclusters will be reflected in the new L2 bitmap).
> 
> 2) If we are overwriting an existing cluster:
> 
>     2.1) If subcluster #3 is unallocated or has the all-zeroes bit set
>          then we need copy-on-write (on subcluster #3 only).
> 
>     2.2) If subcluster #3 was already allocated then there is no need
>          for any copy-on-write. However we still need to update the L2
>          bitmap to reflect possible changes in the allocation status of
>          subclusters #4 to #31. Because of this, this function checks
>          if all the overwritten subclusters are already allocated and
>          in this case it returns without creating a new QCowL2Meta
>          structure.
> 
> After all these changes l2meta_cow_start() and l2meta_cow_end()
> are not necessarily cluster-aligned anymore. We need to update the
> calculation of old_start and old_end in handle_dependencies() to
> guarantee that no two requests try to write on the same cluster.
> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>   block/qcow2-cluster.c | 174 +++++++++++++++++++++++++++++++++++-------
>   1 file changed, 146 insertions(+), 28 deletions(-)
> 

> -    /* Return if there's no COW (all clusters are normal and we keep them) */
> +    /* Return if there's no COW (all subclusters are normal and we are
> +     * keeping the clusters) */
>       if (keep_old) {
> +        unsigned first_sc = cow_start_to / s->subcluster_size;
> +        unsigned last_sc = (cow_end_from - 1) / s->subcluster_size;
>           int i;
> -        for (i = 0; i < nb_clusters; i++) {
> -            l2_entry = get_l2_entry(s, l2_slice, l2_index + i);
> -            if (qcow2_get_cluster_type(bs, l2_entry) != QCOW2_CLUSTER_NORMAL) {
> +        for (i = first_sc; i <= last_sc; i++) {
> +            unsigned c = i / s->subclusters_per_cluster;
> +            unsigned sc = i % s->subclusters_per_cluster;
> +            l2_entry = get_l2_entry(s, l2_slice, l2_index + c);
> +            l2_bitmap = get_l2_bitmap(s, l2_slice, l2_index + c);
> +            type = qcow2_get_subcluster_type(bs, l2_entry, l2_bitmap, sc);
> +            if (type == QCOW2_SUBCLUSTER_INVALID) {
> +                l2_index += c; /* Point to the invalid entry */
> +                goto fail;
> +            }
> +            if (type != QCOW2_SUBCLUSTER_NORMAL) {
>                   break;
>               }
>           }

This loop is now 32 times slower (for extended L2 entries).  Do you 
really need to check for an invalid subcluster here, or can we just 
blindly check that all 32 subclusters are NORMAL, and leave handling of 
invalid clusters for the rest of the function after we failed the 
exit-early test?  For that matter, for all but the first and last 
cluster, checking if 32 clusters are NORMAL is a simple 64-bit 
comparison rather than 32 iterations of a loop; and even for the first 
and last cluster, the _RANGE macros in 14/31 work well to mask out which 
bits must be set/cleared.  My guess is that optimizing this loop is 
worthwhile, since overwriting existing data is probably more common than 
allocating new data.

> -        if (i == nb_clusters) {
> -            return;
> +        if (i == last_sc + 1) {
> +            return 0;
>           }
>       }

If we get here, then i is now the address of the first subcluster that 
was not NORMAL, even if it is much smaller than the final subcluster 
learned by nb_clusters for the overall request.  [1]

>   
>       /* Get the L2 entry of the first cluster */
>       l2_entry = get_l2_entry(s, l2_slice, l2_index);
> -    type = qcow2_get_cluster_type(bs, l2_entry);
> +    l2_bitmap = get_l2_bitmap(s, l2_slice, l2_index);
> +    sc_index = offset_to_sc_index(s, guest_offset);
> +    type = qcow2_get_subcluster_type(bs, l2_entry, l2_bitmap, sc_index);
>   
> -    if (type == QCOW2_CLUSTER_NORMAL && keep_old) {
> -        cow_start_from = cow_start_to;
> +    if (type == QCOW2_SUBCLUSTER_INVALID) {
> +        goto fail;
> +    }
> +
> +    if (!keep_old) {
> +        switch (type) {
> +        case QCOW2_SUBCLUSTER_COMPRESSED:
> +            cow_start_from = 0;
> +            break;
> +        case QCOW2_SUBCLUSTER_NORMAL:
> +        case QCOW2_SUBCLUSTER_ZERO_ALLOC:
> +        case QCOW2_SUBCLUSTER_UNALLOCATED_ALLOC: {
> +            int i;
> +            /* Skip all leading zero and unallocated subclusters */
> +            for (i = 0; i < sc_index; i++) {
> +                QCow2SubclusterType t;
> +                t = qcow2_get_subcluster_type(bs, l2_entry, l2_bitmap, i);
> +                if (t == QCOW2_SUBCLUSTER_INVALID) {
> +                    goto fail;
> +                } else if (t == QCOW2_SUBCLUSTER_NORMAL) {
> +                    break;
> +                }
> +            }
> +            cow_start_from = i << s->subcluster_bits;
> +            break;

Note that you are only skipping until the first normal subcluster, even 
if other zero/unallocated clusters occur between the first normal 
cluster and the start of the action.  Or visually, suppose we have:

--0-NN-0_NNNNNNNN_NNNNNNNN_NNNNNNNN

as our 32 subclusters, with sc_index of 8.  You will end up skipping 
subclusters 0-3, but NOT 6 and 7.  Still, even though we spend time 
copying the allocated contents of those two subclusters, we also copy 
the subcluster status, and the guest still ends up reading the same data 
as before.  I don't know if it is worth trying to further minimize I/O 
to non-contiguous zero/unalloc subclusters in the head.

> +        }
> +        case QCOW2_SUBCLUSTER_ZERO_PLAIN:
> +        case QCOW2_SUBCLUSTER_UNALLOCATED_PLAIN:
> +            cow_start_from = sc_index << s->subcluster_bits;
> +            break;
> +        default:
> +            g_assert_not_reached();
> +        }
>       } else {
> -        cow_start_from = 0;
> +        switch (type) {
> +        case QCOW2_SUBCLUSTER_NORMAL:
> +            cow_start_from = cow_start_to;
> +            break;
> +        case QCOW2_SUBCLUSTER_ZERO_ALLOC:
> +        case QCOW2_SUBCLUSTER_UNALLOCATED_ALLOC:
> +            cow_start_from = sc_index << s->subcluster_bits;
> +            break;
> +        default:
> +            g_assert_not_reached();
> +        }
>       }
>   
>       /* Get the L2 entry of the last cluster */
> -    l2_entry = get_l2_entry(s, l2_slice, l2_index + nb_clusters - 1);
> -    type = qcow2_get_cluster_type(bs, l2_entry);
> +    l2_index += nb_clusters - 1;
> +    l2_entry = get_l2_entry(s, l2_slice, l2_index);
> +    l2_bitmap = get_l2_bitmap(s, l2_slice, l2_index);
> +    sc_index = offset_to_sc_index(s, guest_offset + bytes - 1);
> +    type = qcow2_get_subcluster_type(bs, l2_entry, l2_bitmap, sc_index);

[1] but here, we are skipping any intermediate clusters, and worrying 
only about the state of the final cluster.  Is that always going to do 
the correct thing, or will there be cases where we need to update the L2 
entries of intermediate clusters?  If we don't check specifically for 
INVALID in the initial subcluster, but instead break the loop as soon as 
we find non-NORMAL, then it seems like the rest of the function should 
fragment the overall request to deal with just the clusters up to the 
point where we found a non-NORMAL, and leave the remaining portion of 
the original request for another round.

Thus, I'm not convinced that this patch is quite right.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


