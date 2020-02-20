Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B50BC11D05
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 15:23:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBE98207FD
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 15:23:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z5oSS6TL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBE98207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4nfb-0007lL-5G
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 10:23:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48157)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1j4neu-0007BQ-5I
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 10:22:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1j4ner-0000aA-NE
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 10:22:34 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24995
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1j4ner-0000ZY-Ic
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 10:22:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582212152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZFKbSo+S/ReAfOKc50OuXLJGs5EliIP160KN2/KkIy0=;
 b=Z5oSS6TLi8dRbhdvZGKx+4E4VkU0AyH0XOIqTZ9eerol4mMqBclOGTmmkTrtU/eYmofI+H
 a59bT/QeMxZXc5kCokfIl7j0rFYM2rlvxMqN04+on4ZEejoNLdtdtym2nlA2iOTvOPwmLp
 0DqIEk/ttoWNZ83lvKE/nXyrse+n2AI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-253-YqRhbSLYPp2I2f-3nTa5pA-1; Thu, 20 Feb 2020 10:22:26 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5A62513F9;
 Thu, 20 Feb 2020 15:22:25 +0000 (UTC)
Received: from [10.3.116.180] (ovpn-116-180.phx2.redhat.com [10.3.116.180])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A1FB419481;
 Thu, 20 Feb 2020 15:22:24 +0000 (UTC)
Subject: Re: [RFC PATCH v3 04/27] qcow2: Add get_l2_entry() and set_l2_entry()
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1577014346.git.berto@igalia.com>
 <a1be1f4311da643b439cb5e1924b0ddfb052f338.1577014346.git.berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <aca66606-11df-56df-e20a-a966d9c151c3@redhat.com>
Date: Thu, 20 Feb 2020 09:22:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <a1be1f4311da643b439cb5e1924b0ddfb052f338.1577014346.git.berto@igalia.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: YqRhbSLYPp2I2f-3nTa5pA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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

On 12/22/19 5:36 AM, Alberto Garcia wrote:
> The size of an L2 entry is 64 bits, but if we want to have subclusters
> we need extended L2 entries. This means that we have to access L2
> tables and slices differently depending on whether an image has
> extended L2 entries or not.
> 
> This patch replaces all l2_slice[] accesses with calls to
> get_l2_entry() and set_l2_entry().
> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>   block/qcow2-cluster.c  | 65 ++++++++++++++++++++++--------------------
>   block/qcow2-refcount.c | 17 +++++------
>   block/qcow2.h          | 12 ++++++++
>   3 files changed, 55 insertions(+), 39 deletions(-)
> 

> @@ -978,12 +981,12 @@ int qcow2_alloc_cluster_link_l2(BlockDriverState *bs, QCowL2Meta *m)
>            * cluster the second one has to do RMW (which is done above by
>            * perform_cow()), update l2 table with its cluster pointer and free
>            * old cluster. This is what this loop does */
> -        if (l2_slice[l2_index + i] != 0) {
> -            old_cluster[j++] = l2_slice[l2_index + i];
> +        if (get_l2_entry(s, l2_slice, l2_index + i) != 0) {
> +            old_cluster[j++] = get_l2_entry(s, l2_slice, l2_index + i);
>           }
>   
> -        l2_slice[l2_index + i] = cpu_to_be64((cluster_offset +
> -                    (i << s->cluster_bits)) | QCOW_OFLAG_COPIED);
> +        set_l2_entry(s, l2_slice, l2_index + i, QCOW_OFLAG_COPIED |
> +                     (cluster_offset + (i << s->cluster_bits)));

Cute commutative law use for line length reasons.

> +++ b/block/qcow2.h

scripts/git.orderfile can be used to hoist this part of the patch to the 
front of the message (as it is more valuable to review first).

> @@ -495,6 +495,18 @@ typedef enum QCow2MetadataOverlap {
>   
>   #define INV_OFFSET (-1ULL)
>   
> +static inline uint64_t get_l2_entry(BDRVQcow2State *s, uint64_t *l2_slice,
> +                                    int idx)
> +{
> +    return be64_to_cpu(l2_slice[idx]);
> +}
> +
> +static inline void set_l2_entry(BDRVQcow2State *s, uint64_t *l2_slice,
> +                                int idx, uint64_t entry)
> +{
> +    l2_slice[idx] = cpu_to_be64(entry);
> +}
> +

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


