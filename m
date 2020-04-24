Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD1AEC54FCB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 19:40:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8532D21569
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 19:40:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="brMnYuJW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8532D21569
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jS4BT-0002uf-Jv
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 15:40:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57212)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jS4An-0002EY-Gn
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 15:39:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jS4Ai-0008EJ-OC
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 15:39:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32588
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jS4Ai-00082M-7v
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 15:39:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587757174;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g6AQ+DvP0Ry1hyj2KXj08/u5Fuvqf5Fn5tw16bVmQHk=;
 b=brMnYuJWBy1Wvd/fuYgNoWuRsmPaWEjgWaycn9SolS1PMNCX+CtrjDsGyWJKfqiC9qJF5h
 JTuhNmsHyoNWwrKkQwmkaA7eEN7fDkBcdWwNPUfRHl5HqdBKkers+rwjS6NM2NUKCpvwXV
 Rd5O5w6eMDZKrk2oPJKuvzv9D4ejS54=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-495-U7i8sIqAPhKrCb48fwb9SQ-1; Fri, 24 Apr 2020 15:39:29 -0400
X-MC-Unique: U7i8sIqAPhKrCb48fwb9SQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AF78D1005510;
 Fri, 24 Apr 2020 19:39:27 +0000 (UTC)
Received: from [10.10.116.80] (ovpn-116-80.rdu2.redhat.com [10.10.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 47E9E5C1D4;
 Fri, 24 Apr 2020 19:39:26 +0000 (UTC)
Subject: Re: [PATCH v4 23/30] qcow2: Update L2 bitmap in
 qcow2_alloc_cluster_link_l2()
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1584468723.git.berto@igalia.com>
 <6ffd3ee7ca1e53272705ad34d2ea7ac10b50ade0.1584468723.git.berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <15b848ef-3e86-91f4-4ef6-5adde7ac750d@redhat.com>
Date: Fri, 24 Apr 2020 14:39:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <6ffd3ee7ca1e53272705ad34d2ea7ac10b50ade0.1584468723.git.berto@igalia.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/24 13:45:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.120
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

On 3/17/20 1:16 PM, Alberto Garcia wrote:
> The L2 bitmap needs to be updated after each write to indicate what
> new subclusters are now allocated.
> 
> This needs to happen even if the cluster was already allocated and the
> L2 entry was otherwise valid.
> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> ---
>   block/qcow2-cluster.c | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
> 
> diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
> index ceacd91ea3..dfd8b66958 100644
> --- a/block/qcow2-cluster.c
> +++ b/block/qcow2-cluster.c
> @@ -1006,6 +1006,23 @@ int qcow2_alloc_cluster_link_l2(BlockDriverState *bs, QCowL2Meta *m)
>           assert((offset & L2E_OFFSET_MASK) == offset);
>   
>           set_l2_entry(s, l2_slice, l2_index + i, offset | QCOW_OFLAG_COPIED);
> +
> +        /* Update bitmap with the subclusters that were just written */
> +        if (has_subclusters(s)) {
> +            unsigned written_from = m->cow_start.offset;
> +            unsigned written_to = m->cow_end.offset + m->cow_end.nb_bytes ?:
> +                m->nb_clusters << s->cluster_bits;
> +            uint64_t l2_bitmap = get_l2_bitmap(s, l2_slice, l2_index + i);
> +            int sc;
> +            for (sc = 0; sc < s->subclusters_per_cluster; sc++) {
> +                int sc_off = i * s->cluster_size + sc * s->subcluster_size;
> +                if (sc_off >= written_from && sc_off < written_to) {
> +                    l2_bitmap |= QCOW_OFLAG_SUB_ALLOC(sc);
> +                    l2_bitmap &= ~QCOW_OFLAG_SUB_ZERO(sc);
> +                }
> +            }

Are there more efficient ways to set this series of bits than iterating 
one bit at a time, while still remaining legible?  For example, what if 
we had something like:

l2_bitmap = get_l2_bitmap(...);
int sc_from = OFFSET_TO_SC(written_from);
int sc_to = OFFSET_TO_SC(written_to - 1);
l2_bitmap |= QCOW_OFLAG_SUB_ALLOC_RANGE(sc_from, sc_to);
l2_bitmap &= ~QCOW_OFLAG_SUB_ZERO_RANGE(sc_from, sc_to);

which would require macros:

#define OFFSET_TO_SC(offset) (offset >> (s->cluster_bits - 6))
#define QCOW_OFLAG_SUB_ALLOC_RANGE(from, to) \
   deposit64(0, (from), (len) - (from), -1)
#define QCOW_OFLAG_SUB_ZERO_RANGE(from, to) \
   deposit64(0, (from) + 32, (len) - (from) + 32, -1)


> +            set_l2_bitmap(s, l2_slice, l2_index + i, l2_bitmap);

I'm hoping this function doesn't cause redundant I/O if the L2 entry 
didn't actually change.  But that's not the concern for this patch.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


