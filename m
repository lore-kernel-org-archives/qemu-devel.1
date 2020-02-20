Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EAA8C11D0C
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 14:54:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EBC424656
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 14:54:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PqRqhndj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EBC424656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4nE1-00081w-HB
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 09:54:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44455)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1j4nDL-00075l-NQ
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 09:54:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1j4nDK-00045b-Ee
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 09:54:07 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:26344
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1j4nDK-00045E-9j
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 09:54:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582210445;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b3AjxXqrek9clSfcsqwOdbapi0BxnaMow7M+7/Ud+WQ=;
 b=PqRqhndjN31laB5F2E9OjNpIJ5Bw0/Pna1UUYP0VcpKoiJqhOJdKQfJcERGnM3mCtT6Qdg
 8I8+KHQEKwwpNgeB6ljWJidEMKSwyhVbaX8ecxrb1Xl0szV3jSihxIERRXNKXf6MWxtEyt
 6M361VlX+lBzOr2eSbhJcGI3Uh3uobE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-319-5BxoQ1kOMbmMIymKpB1l6w-1; Thu, 20 Feb 2020 09:53:58 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4AD0F8018AD;
 Thu, 20 Feb 2020 14:53:56 +0000 (UTC)
Received: from [10.3.116.180] (ovpn-116-180.phx2.redhat.com [10.3.116.180])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 53C9819757;
 Thu, 20 Feb 2020 14:53:54 +0000 (UTC)
Subject: Re: [RFC PATCH v3 03/27] qcow2: Process QCOW2_CLUSTER_ZERO_ALLOC
 clusters in handle_copied()
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1577014346.git.berto@igalia.com>
 <e327f4c1ed2f9626ce018c1fd2b9db437721b30c.1577014346.git.berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <df92e101-eec9-06c2-c83f-fa4885e65780@redhat.com>
Date: Thu, 20 Feb 2020 08:53:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <e327f4c1ed2f9626ce018c1fd2b9db437721b30c.1577014346.git.berto@igalia.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 5BxoQ1kOMbmMIymKpB1l6w-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/22/19 5:36 AM, Alberto Garcia wrote:
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
> One importante difference after this change is that clusters found in

important

> handle_copied() may now require copy-on-write, but this will be anyway
> necessary once we add support for subclusters.

necessary anyway

> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>   block/qcow2-cluster.c | 226 +++++++++++++++++++++++-------------------
>   1 file changed, 126 insertions(+), 100 deletions(-)

A bit of an increase in code size, but I think it does reduce the 
overall complexity to treat ZERO_ALLOC like normal.  The patch is big, 
but I don't see any sane way to split it.  Overall, I like it.

> 
> diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
> index e078bddcc2..9387f15866 100644
> --- a/block/qcow2-cluster.c
> +++ b/block/qcow2-cluster.c

> @@ -1069,18 +1112,20 @@ static void calculate_l2_meta(BlockDriverState *bs,
>       QLIST_INSERT_HEAD(&s->cluster_allocs, *m, next_in_flight);
>   }
>   
> -/* Returns true if writing to a cluster requires COW */
> -static bool cluster_needs_cow(BlockDriverState *bs, uint64_t l2_entry)
> +/* Returns true if writing to the cluster pointed to by @l2_entry
> + * requires a new allocation (that is, if the cluster is unallocated
> + * or has refcount > 1 and therefore cannot be written in-place). */

syntax check wants you to wing this comment, now.

> +static bool cluster_needs_new_alloc(BlockDriverState *bs, uint64_t l2_entry)

The rename makes sense.

> @@ -1337,9 +1400,10 @@ static int do_alloc_cluster_offset(BlockDriverState *bs, uint64_t guest_offset,
>   }
>   
>   /*
> - * Allocates new clusters for an area that either is yet unallocated or needs a
> - * copy on write. If *host_offset is not INV_OFFSET, clusters are only
> - * allocated if the new allocation can match the specified host offset.
> + * Allocates new clusters for an area that either is yet unallocated or
> + * cannot be overwritten in-place. If *host_offset is not INV_OFFSET,

s/either is yet/is either still/

> + * clusters are only allocated if the new allocation can match the specified
> + * host offset.
>    *
>    * Note that guest_offset may not be cluster aligned. In this case, the
>    * returned *host_offset points to exact byte referenced by guest_offset and

Findings are minor and you can fix them up when dropping RFC.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


