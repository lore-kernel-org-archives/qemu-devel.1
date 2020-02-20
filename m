Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C24C11D05
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 15:29:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E57B0207FD
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 15:29:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XVtOIJ6F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E57B0207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4nl9-00057E-4f
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 10:29:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48881)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1j4nkO-000463-R1
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 10:28:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1j4nkN-00042I-1A
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 10:28:16 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:32610
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1j4nkM-00041y-Oy
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 10:28:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582212493;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QySCA38R4eP275XcG0P4XQCJV36007T4U1Id3UHAA1o=;
 b=XVtOIJ6FeS9baiLI7bFr4J1AS07gQoBNnNTkEaVewsn3Mjs20r423DCmggoEAfItWsPu3k
 RHraF2tqVyeGMLkD6hmYEAE6RUxHWW1iej0CJZQnAsx/krsd71mEivuc+YH0Fk0skeZWYZ
 nSgE4d1LxMFsS1OFaqXcm+CFc8DcFfI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-w2hILhPVNEimOAnx2zHyhA-1; Thu, 20 Feb 2020 10:28:09 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 96BB38010F5;
 Thu, 20 Feb 2020 15:28:08 +0000 (UTC)
Received: from [10.3.116.180] (ovpn-116-180.phx2.redhat.com [10.3.116.180])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AC12D1001B30;
 Thu, 20 Feb 2020 15:28:07 +0000 (UTC)
Subject: Re: [RFC PATCH v3 07/27] qcow2: Add subcluster-related fields to
 BDRVQcow2State
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1577014346.git.berto@igalia.com>
 <b04e7e26cea16892a7f209b37d931c489ef17bd9.1577014346.git.berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <bc469fab-244c-6b26-c5b4-55cc42a7d8cc@redhat.com>
Date: Thu, 20 Feb 2020 09:28:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <b04e7e26cea16892a7f209b37d931c489ef17bd9.1577014346.git.berto@igalia.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: w2hILhPVNEimOAnx2zHyhA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
> This patch adds the following new fields to BDRVQcow2State:
> 
> - subclusters_per_cluster: Number of subclusters in a cluster
> - subcluster_size: The size of each subcluster, in bytes
> - subcluster_bits: No. of bits so 1 << subcluster_bits = subcluster_size
> 
> Images without subclusters are treated as if they had exactly one,
> with subcluster_size = cluster_size.

The qcow2 spec changes earlier in the series made it sound like your 
choices are exactly 1 or 32,

> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>   block/qcow2.c | 5 +++++
>   block/qcow2.h | 5 +++++
>   2 files changed, 10 insertions(+)
> 
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 3866b47946..cbd857e9c7 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -1378,6 +1378,11 @@ static int coroutine_fn qcow2_do_open(BlockDriverState *bs, QDict *options,
>           }
>       }
>   
> +    s->subclusters_per_cluster =
> +        has_subclusters(s) ? QCOW_MAX_SUBCLUSTERS_PER_CLUSTER : 1;

which matches your code here (other than the name of the constant)...

> +    s->subcluster_size = s->cluster_size / s->subclusters_per_cluster;
> +    s->subcluster_bits = ctz32(s->subcluster_size);
> +
>       /* Check support for various header values */
>       if (header.refcount_order > 6) {
>           error_setg(errp, "Reference count entry width too large; may not "
> diff --git a/block/qcow2.h b/block/qcow2.h
> index 1db3fc5dbc..941330cfc9 100644
> --- a/block/qcow2.h
> +++ b/block/qcow2.h
> @@ -78,6 +78,8 @@
>   /* The cluster reads as all zeros */
>   #define QCOW_OFLAG_ZERO (1ULL << 0)
>   
> +#define QCOW_MAX_SUBCLUSTERS_PER_CLUSTER 32
> +

...but this name sounds like other values (2, 4, 8, 16) might be 
possible?  Is this just leftovers from earlier spins of the series 
before we decided to mandate that clusters must be at least 16k if 
subclusters are enabled (so that subclusters are at least 512 bytes)?

Once we get the right name for the constant, the rest of the patch makes 
sense.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


