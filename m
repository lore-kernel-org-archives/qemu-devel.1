Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CBB1C35247
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 23:29:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C70182082E
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 23:29:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eE2Jpc+Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C70182082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58447 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izU7E-00073h-UE
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 18:29:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53586)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1izU6S-00068Z-QZ
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 18:29:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1izU6R-0001ZI-T6
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 18:29:04 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37164
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1izU6R-0001XZ-PJ
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 18:29:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580945343;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wHbTq5+cr6EbSs08IW1010a85JKpVcCgsw8GtsNm/Mc=;
 b=eE2Jpc+Yg8v0/50bMBM8pxZ+xvnHTShtJrl+FPrkKGOnkCa5jfApN20XZNoUHmpq4MHe0B
 5r1NDQTdauA1fj2MY8vXggQMESa+RtQtc0WXM0dMuSb9MrLCTSp1goaLeLyTSpozgGXoAj
 YLeBgHGNoeOj2aZaLVS0f1ckU7X8GMg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-PD6KtIgDPXO1skGgJihTfg-1; Wed, 05 Feb 2020 18:28:57 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4CB0418B9FC1;
 Wed,  5 Feb 2020 23:28:56 +0000 (UTC)
Received: from [10.3.116.181] (ovpn-116-181.phx2.redhat.com [10.3.116.181])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 811D35C1B0;
 Wed,  5 Feb 2020 23:28:55 +0000 (UTC)
Subject: Re: [PATCH v2 26/33] block: Use child_of_bds in remaining places
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200204170848.614480-1-mreitz@redhat.com>
 <20200204170848.614480-27-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <81dcb8df-3d89-f62d-6326-58b71524ac50@redhat.com>
Date: Wed, 5 Feb 2020 17:28:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200204170848.614480-27-mreitz@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: PD6KtIgDPXO1skGgJihTfg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/4/20 11:08 AM, Max Reitz wrote:
> Replace child_file by child_of_bds in all remaining places (excluding
> tests).
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---

> +++ b/block/raw-format.c
> @@ -444,6 +444,7 @@ static int raw_open(BlockDriverState *bs, QDict *options, int flags,
>       BDRVRawState *s = bs->opaque;
>       bool has_size;
>       uint64_t offset, size;
> +    BdrvChildRole file_role;
>       int ret;
>   
>       ret = raw_read_options(options, &offset, &has_size, &size, errp);
> @@ -451,8 +452,18 @@ static int raw_open(BlockDriverState *bs, QDict *options, int flags,
>           return ret;
>       }
>   
> -    bs->file = bdrv_open_child(NULL, options, "file", bs, &child_file, 0,
> -                               false, errp);
> +    /*
> +     * Without offset and a size limit, this driver behaves very much
> +     * like a filter.  With any such limit, it does not.
> +     */
> +    if (offset || has_size) {
> +        file_role = BDRV_CHILD_DATA | BDRV_CHILD_PRIMARY;
> +    } else {
> +        file_role = BDRV_CHILD_FILTERED | BDRV_CHILD_PRIMARY;
> +    }

Cool - the new roles gives us the flexibility to be more dynamic!

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


