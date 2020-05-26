Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23685C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 20:33:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE1DB2065F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 20:33:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hxmP/0bA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE1DB2065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdgGJ-0008HR-2l
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 16:33:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47310)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jdgFM-00071B-Rx
 for qemu-devel@nongnu.org; Tue, 26 May 2020 16:32:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28533
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jdgFJ-0005D1-Ib
 for qemu-devel@nongnu.org; Tue, 26 May 2020 16:32:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590525139;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kvIZsdDdpup1iAZ/qwfXmgpE+pohPRO/zvPuhyeKpXg=;
 b=hxmP/0bA7O2vQO45dvz1ZrOsxInBtQbuub1MVNUchgKg9Buu+qMY4gTES+aSPbWIbAY5MB
 YiVVCaKYd5BcIwd+kxK75uq6YJs5ioT/9QiXRu1pFjCzFALqh2AnB+/njz2r8NrsOZj+5A
 1Dy9qdbF1L4qxnkdji205o9hZvbhYa0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-72-bVKP8U7XPZ2nQpknovP3Uw-1; Tue, 26 May 2020 16:32:14 -0400
X-MC-Unique: bVKP8U7XPZ2nQpknovP3Uw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 35873464;
 Tue, 26 May 2020 20:32:13 +0000 (UTC)
Received: from [10.3.112.88] (ovpn-112-88.phx2.redhat.com [10.3.112.88])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 659EA10013D5;
 Tue, 26 May 2020 20:32:12 +0000 (UTC)
Subject: Re: [PATCH v7 14/32] qcow2: Add QCow2SubclusterType and
 qcow2_get_subcluster_type()
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1590429901.git.berto@igalia.com>
 <961e6f3e3af13a25c666859b391b7ed147873d8b.1590429901.git.berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <c423bd22-cfd3-48c6-1129-eb784017cb8a@redhat.com>
Date: Tue, 26 May 2020 15:32:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <961e6f3e3af13a25c666859b391b7ed147873d8b.1590429901.git.berto@igalia.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 15:25:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Derek Su <dereksu@qnap.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/25/20 1:08 PM, Alberto Garcia wrote:
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
>   block/qcow2.h | 126 +++++++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 125 insertions(+), 1 deletion(-)
> 
> diff --git a/block/qcow2.h b/block/qcow2.h
> index 5c6bf48c7a..27dbcbc502 100644
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
> +/* Subclusters [X, Y) (0 <= X <= Y <= 32) are allocated */

As you are now using a half-open range, should this be:
  (0 <= X < Y <= 32)

> +#define QCOW_OFLAG_SUB_ALLOC_RANGE(X, Y) \
> +    (QCOW_OFLAG_SUB_ALLOC(Y) - QCOW_OFLAG_SUB_ALLOC(X))

with <= instead of <, then it is impossible to distinguish between 
QCOW_OFLAG_SUB_ALLOC_RANGE(0,0) and QCOW_OFLAG_SUB_ALLOC_RANGE(31,31) 
which both resolve to 0.  I guess it depends on whether the later uses 
of this macro require a non-zero mask ('X < Y') or tolerate the corner 
case of no subclusters selected ('X <= Y').

> +/* Subclusters [X, Y) (0 <= X <= Y <= 32) read as zeroes */
> +#define QCOW_OFLAG_SUB_ZERO_RANGE(X, Y) \
> +    (QCOW_OFLAG_SUB_ALLOC_RANGE(X, Y) << 32)
> +/* L2 entry bitmap with all allocation bits set */
> +#define QCOW_L2_BITMAP_ALL_ALLOC  (QCOW_OFLAG_SUB_ALLOC_RANGE(0, 32))
> +/* L2 entry bitmap with all "read as zeroes" bits set */
> +#define QCOW_L2_BITMAP_ALL_ZEROES (QCOW_OFLAG_SUB_ZERO_RANGE(0, 32))
> +

Fixing the comment (if necessary) does not change the code, and the rest 
of this patch is fine, so:

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


