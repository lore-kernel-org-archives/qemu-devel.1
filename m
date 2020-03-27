Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CCA0C43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 18:58:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4886D20575
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 18:58:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cLoox9Uh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4886D20575
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHuBU-0005Jp-AD
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 14:58:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48089)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jHuAu-0004r8-5t
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 14:57:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jHuAt-00031o-0f
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 14:57:48 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:56936)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jHuAs-00031O-U6
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 14:57:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585335466;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s+2IKT9yO7Ge/TBYxouV7tTI3Waq7aFHkxURENhIGT8=;
 b=cLoox9UhF36l4xxcbucUsRjt7KnE/WC55vDG3BWP7etQtUU+fVLgCMXYp4Q56gpKQD30Yr
 y8bA08urCKvEMCnkPZNv3D+fSgC6p9xmxxa/C1oYxZtXld3ZlxxorqyZHiETTtQLtZmjrm
 HaeZgaXMEaPJp0MGaMj5fNEDXr6oW1I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415-i7gLQLUaM0ew6sL44uK-tw-1; Fri, 27 Mar 2020 14:57:42 -0400
X-MC-Unique: i7gLQLUaM0ew6sL44uK-tw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B95F2800D53;
 Fri, 27 Mar 2020 18:57:41 +0000 (UTC)
Received: from [10.3.113.103] (ovpn-113-103.phx2.redhat.com [10.3.113.103])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2530257;
 Fri, 27 Mar 2020 18:57:41 +0000 (UTC)
Subject: Re: [PATCH v3] qcow2: Forbid discard in qcow2 v2 images with backing
 files
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <20200327164857.31415-1-berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <1871e816-ef2f-379a-93da-9b1a825fa876@redhat.com>
Date: Fri, 27 Mar 2020 13:57:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200327164857.31415-1-berto@igalia.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/27/20 11:48 AM, Alberto Garcia wrote:
> A discard request deallocates the selected clusters so they read back
> as zeroes. This is done by clearing the cluster offset field and
> setting QCOW_OFLAG_ZERO in the L2 entry.
> 
> This flag is however only supported when qcow_version >= 3. In older
> images the cluster is simply deallocated, exposing any possible stale
> data from the backing file.
> 
> Since discard is an advisory operation it's safer to simply forbid it
> in this scenario.
> 
> Note that we are adding this check to qcow2_co_pdiscard() and not to
> qcow2_cluster_discard() or discard_in_l2_slice() because the last
> two are also used by qcow2_snapshot_create() to discard the clusters
> used by the VM state. In this case there's no risk of exposing stale
> data to the guest and we really want that the clusters are always
> discarded.
> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---

> +++ b/block/qcow2.c
> @@ -3784,6 +3784,12 @@ static coroutine_fn int qcow2_co_pdiscard(BlockDriverState *bs,
>       int ret;
>       BDRVQcow2State *s = bs->opaque;
>   
> +    /* If the image does not support QCOW_OFLAG_ZERO then discarding
> +     * clusters could expose stale data from the backing file. */
> +    if (s->qcow_version < 3 && bs->backing) {
> +        return -ENOTSUP;
> +    }
> +

Hmm. Should we blindly always fail for v2, or can we be a little bit 
smarter and still discard a cluster in the top layer if the backing 
layer does not also have it allocated?  In other words, is it also worth 
checking bdrv_is_allocated(), and avoiding the -ENOTSUP failure in the 
case where the backing chain does not have any allocation of the same 
range (at which point, discarding the cluster in the top layer will read 
as zeroes rather than as stale data)?

But that's a minor optimization for an older file format; it's just as 
easy to tell users that if they want maximum discarding power on their 
active layer, then they should be using v3 images.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


