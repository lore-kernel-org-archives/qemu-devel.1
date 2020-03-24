Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1411CC2BAEE
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 15:58:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D84C5208CA
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 15:58:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MdmYonjU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D84C5208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGlxA-0005r7-W0
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 11:58:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43661)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jGlwX-0005Ke-Lt
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 11:58:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jGlwW-0003mR-E2
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 11:58:17 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:54066)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jGlwW-0003m5-B8
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 11:58:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585065496;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vtk9t42jBIiHh/rZG0tZmRWfFMMiUmLJpoQVV1w0g2E=;
 b=MdmYonjUjurpjBf/yL/642vBB7jyVJu+SnaXPYMSes1ZZWWUvlBcX4UzJPsQJc+/u0m692
 pOVdqTgcbg3o3mHfmJQ/2cxegcSc6/GkUnAczR2MISszijhCbH878Ms8LrwK+Avh5z/dcg
 YQ9s86UK1EieScUkqFw1qrcwdnI7sns=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-381-1s6zPYVNNw2iQXXiFHqXQw-1; Tue, 24 Mar 2020 11:58:10 -0400
X-MC-Unique: 1s6zPYVNNw2iQXXiFHqXQw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8F292189D6C0;
 Tue, 24 Mar 2020 15:58:08 +0000 (UTC)
Received: from [10.3.113.103] (ovpn-113-103.phx2.redhat.com [10.3.113.103])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8863F60CD1;
 Tue, 24 Mar 2020 15:57:59 +0000 (UTC)
Subject: Re: [PATCH 2/6] block/mirror: fix use after free of local_err
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20200324153630.11882-1-vsementsov@virtuozzo.com>
 <20200324153630.11882-3-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <36deb99f-e8a9-c0c0-3e99-f031016cfcc0@redhat.com>
Date: Tue, 24 Mar 2020 10:57:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200324153630.11882-3-vsementsov@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
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
Cc: kwolf@redhat.com, zhang.zhanghailiang@huawei.com, qemu-block@nongnu.org,
 quintela@redhat.com, armbru@redhat.com, dgilbert@redhat.com,
 marcandre.lureau@redhat.com, den@openvz.org, mreitz@redhat.com,
 mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/24/20 10:36 AM, Vladimir Sementsov-Ogievskiy wrote:
> local_err is used again in mirror_exit_common() after
> bdrv_set_backing_hd(), so we must zero it. Otherwise try to set
> non-NULL local_err will crash.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   block/mirror.c | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Eric Blake <eblake@redhat.com>

> 
> diff --git a/block/mirror.c b/block/mirror.c
> index 447051dbc6..6203e5946e 100644
> --- a/block/mirror.c
> +++ b/block/mirror.c
> @@ -678,6 +678,7 @@ static int mirror_exit_common(Job *job)
>               bdrv_set_backing_hd(target_bs, backing, &local_err);
>               if (local_err) {
>                   error_report_err(local_err);
> +                local_err = NULL;
>                   ret = -EPERM;
>               }
>           }
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


