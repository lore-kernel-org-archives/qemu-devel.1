Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC897C28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 17:56:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6FC9206D5
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 17:56:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HTGDk/mx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6FC9206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWOHN-0002Mm-Sz
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 13:56:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51458)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jWOGf-0001mD-HH
 for qemu-devel@nongnu.org; Wed, 06 May 2020 13:55:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46223
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jWOGd-0000Dj-7X
 for qemu-devel@nongnu.org; Wed, 06 May 2020 13:55:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588787733;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QJym9cqPyhLgHuUfTLnjVzA5YWlAntunR8RF7CtLg5o=;
 b=HTGDk/mxDf3/MjxSXt1S62azdRzW6X0a90q0TgNiElIgEZMa2m6xplMlCxFnYpN+jsSz2D
 +wnMtMOPAQNbonBFKCNIBJpH0/uZk/aghtfN+P1Vs1D4ugsUbmqvl3x3MYVI6VYM7pHAgB
 VG6/Ap9BEiKzi3nBmmA5HyHOGyg+u3E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-266-eU779DrlO9-TM3I7WtvCtQ-1; Wed, 06 May 2020 13:55:32 -0400
X-MC-Unique: eU779DrlO9-TM3I7WtvCtQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BE9131899520;
 Wed,  6 May 2020 17:55:30 +0000 (UTC)
Received: from [10.3.114.73] (ovpn-114-73.phx2.redhat.com [10.3.114.73])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ED19B1917A;
 Wed,  6 May 2020 17:55:29 +0000 (UTC)
Subject: Re: [PATCH v5 20/31] qcow2: Add subcluster support to
 qcow2_get_host_offset()
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1588699789.git.berto@igalia.com>
 <d4b41accb4c52f31dc7faa3b58084062ac4407f4.1588699789.git.berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <80306243-b500-6977-3fcd-82853c905105@redhat.com>
Date: Wed, 6 May 2020 12:55:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <d4b41accb4c52f31dc7faa3b58084062ac4407f4.1588699789.git.berto@igalia.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/06 04:02:22
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
> The logic of this function remains pretty much the same, except that
> it uses count_contiguous_subclusters(), which combines the logic of
> count_contiguous_clusters() / count_contiguous_clusters_unallocated()
> and checks individual subclusters.
> 

Maybe mention that qcow2_cluster_to_subcluster_type() is now inlined 
into its lone remaining caller.

> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>   block/qcow2.h         |  38 +++++-------
>   block/qcow2-cluster.c | 141 ++++++++++++++++++++----------------------
>   2 files changed, 82 insertions(+), 97 deletions(-)
> 

> +++ b/block/qcow2-cluster.c
> @@ -376,66 +376,58 @@ fail:

> +static int count_contiguous_subclusters(BlockDriverState *bs, int nb_clusters,
> +                                        unsigned sc_index, uint64_t *l2_slice,
> +                                        int l2_index)
>   {

> +
> +    assert(type != QCOW2_SUBCLUSTER_INVALID); /* The caller should check this */
> +    assert(l2_index + nb_clusters <= s->l2_size);
> +
> +    if (type == QCOW2_SUBCLUSTER_COMPRESSED) {
> +        /* Compressed clusters are always processed one by one */
> +        return s->subclusters_per_cluster - sc_index;

Should this assert(sc_index == 0)?

>       for (i = 0; i < nb_clusters; i++) {
> -        uint64_t entry = get_l2_entry(s, l2_slice, l2_index + i);
> -        QCow2ClusterType type = qcow2_get_cluster_type(bs, entry);
> -
> -        if (type != wanted_type) {
> -            break;
> +        l2_entry = get_l2_entry(s, l2_slice, l2_index + i);
> +        l2_bitmap = get_l2_bitmap(s, l2_slice, l2_index + i);
> +        if (check_offset && expected_offset != (l2_entry & L2E_OFFSET_MASK)) {
> +            return count;
> +        }
> +        for (j = (i == 0) ? sc_index : 0; j < s->subclusters_per_cluster; j++) {
> +            if (qcow2_get_subcluster_type(bs, l2_entry, l2_bitmap, j) != type) {
> +                return count;
> +            }

This really is checking that sub-clusters have the exact same type.

> @@ -604,24 +604,17 @@ int qcow2_get_host_offset(BlockDriverState *bs, uint64_t offset,
>               ret = -EIO;
>               goto fail;
>           }
> -        /* Compressed clusters can only be processed one by one */
> -        c = 1;
>           *host_offset = l2_entry & L2E_COMPRESSED_OFFSET_SIZE_MASK;
>           break;
> -    case QCOW2_CLUSTER_ZERO_PLAIN:
> -    case QCOW2_CLUSTER_UNALLOCATED:
> -        /* how many empty clusters ? */
> -        c = count_contiguous_clusters_unallocated(bs, nb_clusters,
> -                                                  l2_slice, l2_index, type);

The old code was counting how many contiguous clusters has similar 
types, coalescing ranges of two different cluster types into one 
nb_clusters result.

> +    case QCOW2_SUBCLUSTER_ZERO_PLAIN:
> +    case QCOW2_SUBCLUSTER_UNALLOCATED_PLAIN:
>           *host_offset = 0;
>           break;
> -    case QCOW2_CLUSTER_ZERO_ALLOC:
> -    case QCOW2_CLUSTER_NORMAL: {
> +    case QCOW2_SUBCLUSTER_ZERO_ALLOC:
> +    case QCOW2_SUBCLUSTER_NORMAL:
> +    case QCOW2_SUBCLUSTER_UNALLOCATED_ALLOC: {
>           uint64_t host_cluster_offset = l2_entry & L2E_OFFSET_MASK;
>           *host_offset = host_cluster_offset + offset_in_cluster;
> -        /* how many allocated clusters ? */
> -        c = count_contiguous_clusters(bs, nb_clusters, s->cluster_size,
> -                                      l2_slice, l2_index, QCOW_OFLAG_ZERO);

and here coalescing three different cluster types into one nb_clusters 
result.

>           if (offset_into_cluster(s, host_cluster_offset)) {
>               qcow2_signal_corruption(bs, true, -1, -1,
>                                       "Cluster allocation offset %#"
> @@ -647,9 +640,11 @@ int qcow2_get_host_offset(BlockDriverState *bs, uint64_t offset,
>           abort();
>       }
>   
> +    sc = count_contiguous_subclusters(bs, nb_clusters, sc_index,
> +                                      l2_slice, l2_index);

But the new code is stopping at the first different subcluster type, 
rather than trying to coalesce as many compatible types into one larger 
nb_clusters.  When coupled with patch 19, that factors into my concern 
over whether patch 19 needed to check for INVALID clusters in the 
middle, or whether its fail: label was unreachable.  But it also means 
that you are potentially fragmenting the write in more places (every 
time a subcluster status changes) rather than coalescing similar status, 
the way the old code used to operate.

I don't think the extra fragmentation causes any correctness issues, but 
it may cause performance issues.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


