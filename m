Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45861C47254
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 21:10:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AE50206FA
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 21:10:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FpfqwZVT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AE50206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jW4pR-0002Zi-5a
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 17:10:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52994)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jW4oQ-0001mV-RN
 for qemu-devel@nongnu.org; Tue, 05 May 2020 17:09:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20251
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jW4oO-0007Pw-K3
 for qemu-devel@nongnu.org; Tue, 05 May 2020 17:09:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588712946;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Kb+m9HgzUTwfbq3SW9L26vjNpZFZ70IrFzsZN/2JrtM=;
 b=FpfqwZVT+IgR5mL5LMxvZWBBQWubyyZ/AE2NNajjebLZjZWZmC3ONZ/eURRrAbu5g2S1Pl
 sza9N//ZAAuQcAKnOSDqUgzd4giu/wFEd0cjms1ZCPtaj6plFGf3KKN9wnRqGuzNj21f46
 MMadIOqqqDVwcqd4P6INVYxT8sQqLfY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-56-rPCqgm_4Pc24XZyylGAwAg-1; Tue, 05 May 2020 17:09:02 -0400
X-MC-Unique: rPCqgm_4Pc24XZyylGAwAg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DC53E1800D4A;
 Tue,  5 May 2020 21:08:59 +0000 (UTC)
Received: from [10.3.114.73] (ovpn-114-73.phx2.redhat.com [10.3.114.73])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 247D65D9C5;
 Tue,  5 May 2020 21:08:57 +0000 (UTC)
Subject: Re: [PATCH v5 14/31] qcow2: Add QCow2SubclusterType and
 qcow2_get_subcluster_type()
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1588699789.git.berto@igalia.com>
 <5b744e9c0f3d348ea675c7a52aabaeeab6fe7b64.1588699789.git.berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <e6a65feb-e7f9-b006-8171-014e41f62395@redhat.com>
Date: Tue, 5 May 2020 16:08:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <5b744e9c0f3d348ea675c7a52aabaeeab6fe7b64.1588699789.git.berto@igalia.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 15:42:13
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
> This patch adds QCow2SubclusterType, which is the subcluster-level
> version of QCow2ClusterType. All QCOW2_SUBCLUSTER_* values have the
> the same meaning as their QCOW2_CLUSTER_* equivalents (when they
> exist). See below for details and caveats.
> 
> In images without extended L2 entries clusters are treated as having
> exactly one subcluster so it is possible to replace one data type with
> the other while keeping the exact same semantics.
> 
> With extended L2 entries there are new possible values, and every
> subcluster in the same cluster can obviously have a different
> QCow2SubclusterType so functions need to be adapted to work on the
> subcluster level.
> 
> There are several things that have to be taken into account:
> 
>    a) QCOW2_SUBCLUSTER_COMPRESSED means that the whole cluster is
>       compressed. We do not support compression at the subcluster
>       level.
> 
>    b) There are two different values for unallocated subclusters:
>       QCOW2_SUBCLUSTER_UNALLOCATED_PLAIN which means that the whole
>       cluster is unallocated, and QCOW2_SUBCLUSTER_UNALLOCATED_ALLOC
>       which means that the cluster is allocated but the subcluster is
>       not. The latter can only happen in images with extended L2
>       entries.

Or put differently, extents of the qcow2 file are always allocated a 
contiguous cluster at a time (so using larger clusters reduces 
fragmentation), but because we can now defer to the backing image a 
sub-cluster at a time, we have less I/O to perform the first time the 
guest touches a subcluster.  The two different return values thus tell 
us when we need to do a cluster allocation vs. just an in-place 
overwrite or a sub-cluster COW.

> 
>    c) QCOW2_SUBCLUSTER_INVALID is used to detect the cases where an L2
>       entry has a value that violates the specification. The caller is
>       responsible for handling these situations.
> 
>       To prevent compatibility problems with images that have invalid
>       values but are currently being read by QEMU without causing side
>       effects, QCOW2_SUBCLUSTER_INVALID is only returned for images
>       with extended L2 entries.
> 
> qcow2_cluster_to_subcluster_type() is added as a separate function
> from qcow2_get_subcluster_type(), but this is only temporary and both
> will be merged in a subsequent patch.
> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>   block/qcow2.h | 127 +++++++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 126 insertions(+), 1 deletion(-)
> 
> diff --git a/block/qcow2.h b/block/qcow2.h
> index 4ad93772b9..be7816a3b8 100644
> --- a/block/qcow2.h
> +++ b/block/qcow2.h
> @@ -80,6 +80,21 @@
>   
>   #define QCOW_EXTL2_SUBCLUSTERS_PER_CLUSTER 32
>   
> +/* The subcluster X [0..31] is allocated */
> +#define QCOW_OFLAG_SUB_ALLOC(X)   (1ULL << (X))
> +/* The subcluster X [0..31] reads as zeroes */
> +#define QCOW_OFLAG_SUB_ZERO(X)    (QCOW_OFLAG_SUB_ALLOC(X) << 32)
> +/* Subclusters X to Y (both included) are allocated */
> +#define QCOW_OFLAG_SUB_ALLOC_RANGE(X, Y) \
> +    (QCOW_OFLAG_SUB_ALLOC((Y) + 1) - QCOW_OFLAG_SUB_ALLOC(X))

Nicer than my initial thoughts on getting rid of the bit-wise loop.  And 
uses 64-bit math to produce a 32-bit answer, so there are no edge cases 
where overflow could misbehave even though the intermediate steps may 
require 33 bits.  Works as long as X <= Y (should that be mentioned in 
the contract?)

> +/* Subclusters X to Y (both included) read as zeroes */
> +#define QCOW_OFLAG_SUB_ZERO_RANGE(X, Y) \
> +    (QCOW_OFLAG_SUB_ALLOC_RANGE(X, Y) << 32)

Also works (you do the math in the low 33 bits before shifting), again 
if X <= Y.

> +/* L2 entry bitmap with all allocation bits set */
> +#define QCOW_L2_BITMAP_ALL_ALLOC  (QCOW_OFLAG_SUB_ALLOC_RANGE(0, 31))
> +/* L2 entry bitmap with all "read as zeroes" bits set */
> +#define QCOW_L2_BITMAP_ALL_ZEROES (QCOW_OFLAG_SUB_ZERO_RANGE(0, 31))

More complicated than merely writing 0xffffffffULL and 
(0xffffffffULL<<32), but the compiler will constant-fold it to the same 
value, and it elegantly expresses the intent.  I like it.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


