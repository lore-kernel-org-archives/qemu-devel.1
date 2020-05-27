Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E6CC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 15:58:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC5BE20776
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 15:58:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gATX8dO8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC5BE20776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdyS6-0006mI-0t
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 11:58:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54856)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jdyRW-0006EO-75
 for qemu-devel@nongnu.org; Wed, 27 May 2020 11:58:10 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:47641)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jdyRV-0000Fr-GU
 for qemu-devel@nongnu.org; Wed, 27 May 2020 11:58:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590595088;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VwTf5x6DtCC2oFz1CdZBflE9NBhTRM3YaVIXmxvJm6g=;
 b=gATX8dO8rDYuvCSkUMogPifp/4P0YLZAV8u+dnav8qaYI9eTzZFhogFfq3UpEdIcLF9Zti
 ci/nqZE+AO+ys6pwrvenFRJmHiCAUVFt7m6+18oRffpTRNeU1EGucV4gZd3iTEydFgj2wM
 mHryX7J8L7dzMiJWwBcwwNmyOWcxF9I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-9-SYMpMUzbNP2ghphNBEiJGQ-1; Wed, 27 May 2020 11:58:01 -0400
X-MC-Unique: SYMpMUzbNP2ghphNBEiJGQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2853B464;
 Wed, 27 May 2020 15:58:00 +0000 (UTC)
Received: from [10.3.112.88] (ovpn-112-88.phx2.redhat.com [10.3.112.88])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7F26960C47;
 Wed, 27 May 2020 15:57:58 +0000 (UTC)
Subject: Re: [PATCH v7 20/32] qcow2: Add subcluster support to
 calculate_l2_meta()
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1590429901.git.berto@igalia.com>
 <d52a76b21a6bf7078096d117fc19148304dd77f0.1590429901.git.berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <26daf4ff-98b0-9484-c002-53656f3e2f08@redhat.com>
Date: Wed, 27 May 2020 10:57:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <d52a76b21a6bf7078096d117fc19148304dd77f0.1590429901.git.berto@igalia.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 00:45:05
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

Quite the mouthful!  But the description looks correct, and the code 
appears to match it.

> 
> After all these changes l2meta_cow_start() and l2meta_cow_end()
> are not necessarily cluster-aligned anymore. We need to update the
> calculation of old_start and old_end in handle_dependencies() to
> guarantee that no two requests try to write on the same cluster.
> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>   block/qcow2-cluster.c | 163 +++++++++++++++++++++++++++++++++---------
>   1 file changed, 131 insertions(+), 32 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


