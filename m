Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC60C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 15:49:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5674922EBD
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 15:49:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VN9zJpgw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5674922EBD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3i8s-0004rw-7C
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 11:49:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57012)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k3i7K-0003Az-07
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 11:47:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59614
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k3i7F-0006NL-76
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 11:47:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596728855;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QipeNrVWJzDJea/AY5cowmlgrgFOBzE967YBpguCRec=;
 b=VN9zJpgwtOkHIj7wgDILsckvKvu8wW20jX5KlhTPhP+Boz13V09zN5Ahf5OGNnS6v60YlS
 Ea8ej+MhPHYzBKp/euVzPt2XRZfSoprR3T/r0JQ/N2o5MRIgunTK2ZsYOQc4V2DquZzUux
 tiblBVCg1P06t/J8olp/tUujPVtVwYg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-xJxiXtb4O7OuyECW9-krrA-1; Thu, 06 Aug 2020 11:47:28 -0400
X-MC-Unique: xJxiXtb4O7OuyECW9-krrA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 317F780048D;
 Thu,  6 Aug 2020 15:47:26 +0000 (UTC)
Received: from [10.3.115.21] (ovpn-115-21.phx2.redhat.com [10.3.115.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 383438AC08;
 Thu,  6 Aug 2020 15:47:24 +0000 (UTC)
Subject: Re: [PATCH for-5.1?] block/block-copy: always align copied region to
 cluster size
To: Stefan Reiter <s.reiter@proxmox.com>, qemu-block@nongnu.org
References: <20200806135740.24420-1-s.reiter@proxmox.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <987a7881-bc89-72d9-7b9b-2383c2e6aa8e@redhat.com>
Date: Thu, 6 Aug 2020 10:47:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200806135740.24420-1-s.reiter@proxmox.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 00:24:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-devel@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/6/20 8:57 AM, Stefan Reiter wrote:
> Since commit 42ac214406e0 (block/block-copy: refactor task creation)
> block_copy_task_create calculates the area to be copied via
> bdrv_dirty_bitmap_next_dirty_area, but that can return an unaligned byte
> count if the backing image's last cluster end is not aligned to the
> bitmap's granularity.
> 
> Always ALIGN_UP the resulting bytes value to satisfy block_copy_do_copy,
> which requires the 'bytes' parameter to be aligned to cluster size.
> 
> Signed-off-by: Stefan Reiter <s.reiter@proxmox.com>
> ---

As this is an assertion failure in a feature new to 5.1, this might be a 
candidate for inclusion if we have other reasons to go with -rc4.  But 
it's awfully late, I don't think this bug is sufficient on its own to 
delay the release.

> 
> This causes backups with unaligned image sizes to fail on the last block in my
> testing (e.g. a backup job with 4k cluster size fails on a drive with 4097
> bytes).
> 
> Alternatively one could remove the
>    assert(QEMU_IS_ALIGNED(bytes, s->cluster_size));
> from block_copy_do_copy, but I'd wager that's there for a reason?
> 
>   block/block-copy.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/block/block-copy.c b/block/block-copy.c
> index f7428a7c08..023cb03200 100644
> --- a/block/block-copy.c
> +++ b/block/block-copy.c
> @@ -142,6 +142,8 @@ static BlockCopyTask *block_copy_task_create(BlockCopyState *s,
>           return NULL;
>       }
>   
> +    bytes = QEMU_ALIGN_UP(bytes, s->cluster_size);
> +
>       /* region is dirty, so no existent tasks possible in it */
>       assert(!find_conflicting_task(s, offset, bytes));
>   
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


