Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E8E0C55179
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 16:06:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBC4C208C3
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 16:06:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D1aeP7FI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBC4C208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVGdF-0005zJ-Lr
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 12:06:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51220)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kVGZ4-0001FT-VT
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 12:02:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60374)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kVGZ2-00017G-D6
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 12:02:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603296130;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wp9k3BZI+SGGpM3akKwEULLUMnyv4FPkVGvutlzsJXg=;
 b=D1aeP7FIs8pIYpqj45/Z9oh2VtV3YimeedmwpQZxUHsmL0OhsVps5sBiGiKqKpBO1qfWoO
 pmQPI+9palp2qkgcvUjpjDD7da1En7nNHTD8ccuZVR6A36rAktGrrjsehMAEdrOP7pROAE
 9Swz4LdPITJNSvcha6YHe1VkxrZoSlM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-67-k7tDH6NxMiycNK_0C5Y2ug-1; Wed, 21 Oct 2020 12:02:06 -0400
X-MC-Unique: k7tDH6NxMiycNK_0C5Y2ug-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 938F880EF8B;
 Wed, 21 Oct 2020 16:02:05 +0000 (UTC)
Received: from [10.3.114.232] (ovpn-114-232.phx2.redhat.com [10.3.114.232])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D8EA25C1C7;
 Wed, 21 Oct 2020 16:02:01 +0000 (UTC)
Subject: Re: [PATCH] migration/block-dirty-bitmap: fix larger granularity
 bitmaps
To: Stefan Reiter <s.reiter@proxmox.com>, quintela@redhat.com,
 dgilbert@redhat.com
References: <20201021144456.1072-1-s.reiter@proxmox.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <03debf8b-eb33-c1e6-5803-502bd9bedc8c@redhat.com>
Date: Wed, 21 Oct 2020 11:02:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201021144456.1072-1-s.reiter@proxmox.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/21 02:16:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: fam@euphon.net, vsementsov@virtuozzo.com, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, stefanha@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/21/20 9:44 AM, Stefan Reiter wrote:
> sectors_per_chunk is a 64 bit integer, but the calculation is done in 32
> bits, leading to an overflow for coarse bitmap granularities.
> 
> If that results in the value 0, it leads to a hang where no progress is
> made but send_bitmap_bits is constantly called with nr_sectors being 0.
> 
> Signed-off-by: Stefan Reiter <s.reiter@proxmox.com>
> ---
>  migration/block-dirty-bitmap.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
> index 5bef793ac0..5398869e2b 100644
> --- a/migration/block-dirty-bitmap.c
> +++ b/migration/block-dirty-bitmap.c
> @@ -562,8 +562,9 @@ static int add_bitmaps_to_list(DBMSaveState *s, BlockDriverState *bs,
>          dbms->bitmap_alias = g_strdup(bitmap_alias);
>          dbms->bitmap = bitmap;
>          dbms->total_sectors = bdrv_nb_sectors(bs);
> -        dbms->sectors_per_chunk = CHUNK_SIZE * 8 *
> +        dbms->sectors_per_chunk = CHUNK_SIZE * 8lu *

8lu is not necessarily 64-bit; you need llu.  Also, I prefer
capitalizing the type suffix, as in 8LLU.

I can touch that up while queuing through my bitmaps tree, so:

Reviewed-by: Eric Blake <eblake@redhat.com>

>              bdrv_dirty_bitmap_granularity(bitmap) >> BDRV_SECTOR_BITS;
> +        assert(dbms->sectors_per_chunk != 0);
>          if (bdrv_dirty_bitmap_enabled(bitmap)) {
>              dbms->flags |= DIRTY_BITMAP_MIG_START_FLAG_ENABLED;
>          }
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


