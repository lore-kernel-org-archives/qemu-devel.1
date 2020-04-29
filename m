Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30736C83000
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 22:06:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB68920757
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 22:06:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RIaRa9lx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB68920757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTuqA-0001MS-SG
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 18:06:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35866)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jTupM-0000oy-Jy
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 18:05:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jTupK-0006hE-Bj
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 18:05:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33043
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jTupI-0006gi-Dz
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 18:05:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588197905;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+ozdJ0sQXNBQq8H5IQBnTCJ9FSGZrVtPPAyYEdib+Es=;
 b=RIaRa9lxXSfB4oMFarFY7z/An31V7gg+UWqkGXZRziHxt+qfseULfOhxSYSpGzdAXR+Tf9
 UYH0jtD6scmlfOAnx//wD1udmskDa5QRoktgfVMoPTh0fXp3PkZZenos2+Y72JidTJsh7M
 OXLcyj1aBUc7shDfIfc8eQV4kdhMXog=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-474-2PRzq1DZMMGCEUGTXc-lPA-1; Wed, 29 Apr 2020 18:04:59 -0400
X-MC-Unique: 2PRzq1DZMMGCEUGTXc-lPA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 77DAF45F;
 Wed, 29 Apr 2020 22:04:57 +0000 (UTC)
Received: from [10.10.116.80] (ovpn-116-80.rdu2.redhat.com [10.10.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 100BF60E1C;
 Wed, 29 Apr 2020 22:04:47 +0000 (UTC)
Subject: Re: [PATCH v2 06/17] block/io: support int64_t bytes in
 bdrv_aligned_pwritev()
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200427082325.10414-1-vsementsov@virtuozzo.com>
 <20200427082325.10414-7-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <f45f380b-8e7b-1483-d685-4e7d4729562a@redhat.com>
Date: Wed, 29 Apr 2020 17:04:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200427082325.10414-7-vsementsov@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 15:37:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: kwolf@redhat.com, fam@euphon.net, integration@gluster.org, berto@igalia.com,
 pavel.dovgaluk@ispras.ru, qemu-devel@nongnu.org, dillaman@redhat.com,
 pl@kamp.de, ronniesahlberg@gmail.com, mreitz@redhat.com, den@openvz.org,
 sheepdog@lists.wpkg.org, stefanha@redhat.com, namei.unix@gmail.com,
 pbonzini@redhat.com, sw@weilnetz.de, jsnow@redhat.com, ari@tuxera.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/27/20 3:23 AM, Vladimir Sementsov-Ogievskiy wrote:
> We are generally moving to int64_t for both offset and bytes parameters
> on all io paths. Prepare bdrv_aligned_pwritev() now (and convert the
> dependencies: bdrv_co_write_req_prepare() and
> bdrv_co_write_req_finish() to signed type bytes)
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   block/io.c | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/block/io.c b/block/io.c
> index c8c30e3699..fe19e09034 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -1854,7 +1854,7 @@ fail:
>   }
>   
>   static inline int coroutine_fn
> -bdrv_co_write_req_prepare(BdrvChild *child, int64_t offset, uint64_t bytes,
> +bdrv_co_write_req_prepare(BdrvChild *child, int64_t offset, int64_t bytes,
>                             BdrvTrackedRequest *req, int flags)
>   {

No change in size.  First, check usage within function:
     int64_t end_sector = DIV_ROUND_UP(offset + bytes, BDRV_SECTOR_SIZE);
Changes computation from uint64_t to int64_t.  This causes a borderline 
bug on images between INT64_MAX-511 and INT64_MAX (nbdkit can produce 
such images over NBD, although they are atypical on disk), where 
DIV_ROUND_UP() would give the right answer as uint64_t but a negative 
answer with int64_t.  As those images are not sector-aligned, maybe we 
don't need to care?
all other uses appear to be within asserts related to offset+bytes being 
positive, so that's what we should check for.

Callers:
bdrv_aligned_pwritev() - changed in this patch to 'int64_t', analyzed 
below [1]
bdrv_co_pdiscard() - already passes 'int64_t', also checks for 
offset+bytes overflow - safe
bdrv_co_copy_range_internal() - 'uint64_t', but already analyzed for 
3/17 how it was capped < 2M - safe
bdrv_co_truncate() - already passes 'int64_t', passes new_bytes computed 
by subtracting from a positive 'int64_t offset' - safe


[1] except I hit the end of my work day, so my analysis will have to 
continue tomorrow...


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


