Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E31A0C83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 14:06:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9E87206C0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 14:06:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ekxTSuPs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9E87206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTQsF-0005U1-OD
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 10:06:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39556)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jTQqd-0000OD-5D
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 10:04:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jTQgC-000436-Rr
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 09:57:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56618
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jTQgC-000413-AU
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 09:53:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588082023;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6IBOWTSfE2+c9pEle/3h+SsKG5DZLt2mJjibil2jVek=;
 b=ekxTSuPssY3jUFQGHZcCeJxIDuwi71T3bFLbYPx0Fpbqwo7F5PHRaMc1dHg/n2c0BbsgsV
 bBDW4KZ1YaMS8soStK8Nvn0RAStN+q2B7WWWc7ld2lbSrXQY32mY35kubI42pSIpWOXAvx
 FlgqKEoANpzgkEFb7/K2MTYvaAuqW9A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-369-wrnewQmwPNCA-jIZvb3uqw-1; Tue, 28 Apr 2020 09:53:41 -0400
X-MC-Unique: wrnewQmwPNCA-jIZvb3uqw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9A1B3800D24;
 Tue, 28 Apr 2020 13:53:40 +0000 (UTC)
Received: from [10.10.116.80] (ovpn-116-80.rdu2.redhat.com [10.10.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DC4E8605CD;
 Tue, 28 Apr 2020 13:53:39 +0000 (UTC)
Subject: Re: [PATCH 1/4] block: Add bdrv_make_empty()
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200428132629.796753-1-mreitz@redhat.com>
 <20200428132629.796753-2-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <bd4bb486-559a-58ff-dafb-f1e63908be4e@redhat.com>
Date: Tue, 28 Apr 2020 08:53:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200428132629.796753-2-mreitz@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 04:15:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/28/20 8:26 AM, Max Reitz wrote:
> Right now, all users of bdrv_make_empty() call the BlockDriver method
> directly.  That is not only bad style, it is also wrong, unless the
> caller has a BdrvChild with a WRITE permission.
> 
> Introduce bdrv_make_empty() that verifies that it does.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   include/block/block.h |  1 +
>   block.c               | 23 +++++++++++++++++++++++
>   2 files changed, 24 insertions(+)
> 
> diff --git a/include/block/block.h b/include/block/block.h
> index b05995fe9c..d947fb4080 100644
> --- a/include/block/block.h
> +++ b/include/block/block.h
> @@ -351,6 +351,7 @@ BlockMeasureInfo *bdrv_measure(BlockDriver *drv, QemuOpts *opts,
>   void bdrv_get_geometry(BlockDriverState *bs, uint64_t *nb_sectors_ptr);
>   void bdrv_refresh_limits(BlockDriverState *bs, Error **errp);
>   int bdrv_commit(BlockDriverState *bs);
> +int bdrv_make_empty(BdrvChild *c, Error **errp);

Can we please fix this to take a flags parameter?  I want to make it 
easier for callers to request BDRV_REQ_NO_FALLBACK for distinguishing 
between callers where the image must be made empty (read as all zeroes) 
regardless of time spent, vs. made empty quickly (including if it is 
already all zero) but where the caller is prepared for the operation to 
fail and will write zeroes itself if fast bulk zeroing was not possible.


> +int bdrv_make_empty(BdrvChild *c, Error **errp)
> +{
> +    BlockDriver *drv = c->bs->drv;
> +    int ret;
> +
> +    assert(c->perm & BLK_PERM_WRITE);
> +
> +    if (!drv->bdrv_make_empty) {
> +        error_setg(errp, "%s does not support emptying nodes",
> +                   drv->format_name);
> +        return -ENOTSUP;
> +    }

And here's where we can add some automatic fallbacks, such as 
recognizing if the image already reads as all zeroes.  But those 
optimizations can come in separate patches; for YOUR patch, just getting 
the proper API in place is fine.

> +
> +    ret = drv->bdrv_make_empty(c->bs);
> +    if (ret < 0) {
> +        error_setg_errno(errp, -ret, "Failed to empty %s",
> +                         c->bs->filename);
> +        return ret;
> +    }
> +
> +    return 0;
> +}
> 

Other than a missing flag parameter, this looks fine.


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


