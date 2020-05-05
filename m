Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF5EC47247
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 19:25:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1CD6206B9
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 19:25:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DBV3YeBd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1CD6206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jW3Bq-0005yh-Ri
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 15:25:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34234)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jW3Af-0005KI-7r
 for qemu-devel@nongnu.org; Tue, 05 May 2020 15:24:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54705
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jW3Ac-0000EY-Ma
 for qemu-devel@nongnu.org; Tue, 05 May 2020 15:24:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588706636;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k+nYQpD1dw2ZmjIFVdkpWYkDDfZdBkD300DvQoWrER8=;
 b=DBV3YeBdDr46qEkYwpy50WoX9VByOmf+dd56qBR4dUsz+mLuG5/DxPoxvH5O21WGvHnieL
 iAFDlBoWq/PLs+CFh0WudSFvzmWpP6VlRME+CWskBMUH8rwLa78oYGT4MYj6UNqAyOm4Hu
 wPJeilnX/6qfymvFNtKS2DTK+NSPxZY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-id2DFCqtNoyQllr3AvAMXw-1; Tue, 05 May 2020 15:23:52 -0400
X-MC-Unique: id2DFCqtNoyQllr3AvAMXw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 428F6100A8E7;
 Tue,  5 May 2020 19:23:51 +0000 (UTC)
Received: from [10.3.114.73] (ovpn-114-73.phx2.redhat.com [10.3.114.73])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 023101000327;
 Tue,  5 May 2020 19:23:49 +0000 (UTC)
Subject: Re: [PATCH v5 05/31] qcow2: Process QCOW2_CLUSTER_ZERO_ALLOC clusters
 in handle_copied()
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1588699789.git.berto@igalia.com>
 <84fbd11fbfc4a2ee65a4cdca36976d4b18f10ef6.1588699789.git.berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <3579a7ff-0250-cadf-28cf-c840b1d51f9f@redhat.com>
Date: Tue, 5 May 2020 14:23:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <84fbd11fbfc4a2ee65a4cdca36976d4b18f10ef6.1588699789.git.berto@igalia.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 00:37:38
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
> When writing to a qcow2 file there are two functions that take a
> virtual offset and return a host offset, possibly allocating new
> clusters if necessary:
> 
>     - handle_copied() looks for normal data clusters that are already
>       allocated and have a reference count of 1. In those clusters we
>       can simply write the data and there is no need to perform any
>       copy-on-write.
> 
>     - handle_alloc() looks for clusters that do need copy-on-write,
>       either because they haven't been allocated yet, because their
>       reference count is != 1 or because they are ZERO_ALLOC clusters.
> 
> The ZERO_ALLOC case is a bit special because those are clusters that
> are already allocated and they could perfectly be dealt with in
> handle_copied() (as long as copy-on-write is performed when required).
> 
> In fact, there is extra code specifically for them in handle_alloc()
> that tries to reuse the existing allocation if possible and frees them
> otherwise.
> 
> This patch changes the handling of ZERO_ALLOC clusters so the
> semantics of these two functions are now like this:
> 
>     - handle_copied() looks for clusters that are already allocated and
>       which we can overwrite (NORMAL and ZERO_ALLOC clusters with a
>       reference count of 1).
> 
>     - handle_alloc() looks for clusters for which we need a new
>       allocation (all other cases).
> 
> One important difference after this change is that clusters found
> in handle_copied() may now require copy-on-write, but this will be
> necessary anyway once we add support for subclusters.
> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>   block/qcow2-cluster.c | 256 +++++++++++++++++++++++-------------------
>   1 file changed, 141 insertions(+), 115 deletions(-)

> @@ -1053,15 +1058,53 @@ void qcow2_alloc_cluster_abort(BlockDriverState *bs, QCowL2Meta *m)
>   static void calculate_l2_meta(BlockDriverState *bs,
>                                 uint64_t host_cluster_offset,
>                                 uint64_t guest_offset, unsigned bytes,
> -                              QCowL2Meta **m, bool keep_old)
> +                              uint64_t *l2_slice, QCowL2Meta **m, bool keep_old)
>   {

Borderline long line, but it fits ;)

>       BDRVQcow2State *s = bs->opaque;
> -    unsigned cow_start_from = 0;
> +    int l2_index = offset_to_l2_slice_index(s, guest_offset);
> +    uint64_t l2_entry;
> +    unsigned cow_start_from, cow_end_to;
>       unsigned cow_start_to = offset_into_cluster(s, guest_offset);
>       unsigned cow_end_from = cow_start_to + bytes;
> -    unsigned cow_end_to = ROUND_UP(cow_end_from, s->cluster_size);
>       unsigned nb_clusters = size_to_clusters(s, cow_end_from);
>       QCowL2Meta *old_m = *m;
> +    QCow2ClusterType type;
> +
> +    assert(nb_clusters <= s->l2_slice_size - l2_index);
> +
> +    /* Return if there's no COW (all clusters are normal and we keep them) */
> +    if (keep_old) {
> +        int i;
> +        for (i = 0; i < nb_clusters; i++) {
> +            l2_entry = be64_to_cpu(l2_slice[l2_index + i]);
> +            if (qcow2_get_cluster_type(bs, l2_entry) != QCOW2_CLUSTER_NORMAL) {
> +                break;
> +            }
> +        }
> +        if (i == nb_clusters) {
> +            return;
> +        }
> +    }
> +
> +    /* Get the L2 entry of the first cluster */
> +    l2_entry = be64_to_cpu(l2_slice[l2_index]);

This is the second time we're grabbing the first entry in this function. 
But I don't think it's worth trying to micro-optimize.


> +static int count_single_write_clusters(BlockDriverState *bs, int nb_clusters,
> +                                       uint64_t *l2_slice, int l2_index,
> +                                       bool new_alloc)
>   {
> +    BDRVQcow2State *s = bs->opaque;
> +    uint64_t l2_entry = be64_to_cpu(l2_slice[l2_index]);
> +    uint64_t expected_offset = l2_entry & L2E_OFFSET_MASK;
>       int i;
>   
>       for (i = 0; i < nb_clusters; i++) {
> -        uint64_t l2_entry = be64_to_cpu(l2_slice[l2_index + i]);
> -        if (!cluster_needs_cow(bs, l2_entry)) {
> +        l2_entry = be64_to_cpu(l2_slice[l2_index + i]);

And another place where we compute l2_entry for the first cluster twice, 
and again not worth micro-optimizing.

I didn't find anything that needs a change.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


