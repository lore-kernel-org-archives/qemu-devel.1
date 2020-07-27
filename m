Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B486C433E5
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 14:05:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 444D92073E
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 14:05:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NEdIeyR1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 444D92073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k03kw-00072w-J2
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 10:05:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43396)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k03kB-0006N7-4R
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 10:04:43 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:29586
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k03k9-0005Wt-DF
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 10:04:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595858679;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zq+6NFALOXmOuaSqQvXYPWBoHbCcCk+cahNZb/Y0w0I=;
 b=NEdIeyR1pPC6K0JyjXbIN/aiy1WiHHpx0iiT8kqdhY3KILxFDyvBBTJThYLzhuQGoSicuY
 EFQn1Q2HpVBqDGColuz88KhO/pT3rDBLpUk1JSfnSVq7uxBSUo+AmpI9/q9LN+yPCwAtMH
 /+NVMndD9hPo3ZVuUc5t/Ggz6OqO5OI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-251-0G9s6fukNceC-ZBbwa73KA-1; Mon, 27 Jul 2020 10:04:18 -0400
X-MC-Unique: 0G9s6fukNceC-ZBbwa73KA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1110D186A820;
 Mon, 27 Jul 2020 14:04:17 +0000 (UTC)
Received: from [10.3.113.26] (ovpn-113-26.phx2.redhat.com [10.3.113.26])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 92AF069327;
 Mon, 27 Jul 2020 14:04:16 +0000 (UTC)
Subject: Re: [PATCH 1/2] block: nbd: Fix convert qcow2 compressed to nbd
To: Nir Soffer <nirsof@gmail.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
References: <20200726152532.256261-1-nsoffer@redhat.com>
 <20200726152532.256261-2-nsoffer@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <1737bdc4-6192-1adb-7027-faf09bdbd92c@redhat.com>
Date: Mon, 27 Jul 2020 09:04:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200726152532.256261-2-nsoffer@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 03:37:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Nir Soffer <nsoffer@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/26/20 10:25 AM, Nir Soffer wrote:
> When converting to qcow2 compressed format, the last step is a special
> zero length compressed write, ending in call to bdrv_co_truncate(). This
> call always fail for the nbd driver since it does not implement

fails

> bdrv_co_truncate().

Arguably, qemu-img should be taught to ignore the failure, since it is 
not unique to the nbd driver. But I can live with your approach here.

> 
> For block devices, which have the same limits, the call succeeds since
> file driver implements bdrv_co_truncate(). If the caller asked to
> truncate to the same or smaller size with exact=false, the truncate
> succeeds. Implement the same logic for nbd.
> 
> Example failing without this change:
> 

> 
> Fixes: https://bugzilla.redhat.com/1860627
> Signed-off-by: Nir Soffer <nsoffer@redhat.com>
> ---
>   block/nbd.c | 27 +++++++++++++++++++++++++++
>   1 file changed, 27 insertions(+)
> 
> diff --git a/block/nbd.c b/block/nbd.c
> index 65a4f56924..2154113af3 100644
> --- a/block/nbd.c
> +++ b/block/nbd.c
> @@ -1966,6 +1966,30 @@ static void nbd_close(BlockDriverState *bs)
>       nbd_clear_bdrvstate(s);
>   }
>   
> +/*
> + * NBD cannot truncate, but if the caller ask to truncate to the same size, or

asks

> + * to a smaller size with extact=false, there is not reason to fail the

exact, no

> + * operation.
> + */
> +static int coroutine_fn nbd_co_truncate(BlockDriverState *bs, int64_t offset,
> +                                        bool exact, PreallocMode prealloc,
> +                                        BdrvRequestFlags flags, Error **errp)
> +{
> +    BDRVNBDState *s = bs->opaque;
> +
> +    if (offset != s->info.size && exact) {
> +        error_setg(errp, "Cannot resize NBD nodes");
> +        return -ENOTSUP;
> +    }
> +
> +    if (offset > s->info.size) {
> +        error_setg(errp, "Cannot grow NBD nodes");
> +        return -EINVAL;
> +    }
> +
> +    return 0;

Looks reasonable.  As Max said, I wonder if we want to reject particular 
preallocation modes (looking at block/file-posix.c:raw_co_truncate), in 
the case where the image was resized down and then back up (since 
s->info.size is constant, but the BDS size is not if inexact resize 
succeeds).

As you have a bugzilla entry, I think this is safe for -rc2; I'll be 
touching up the typos and queuing it through my NBD tree later today.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


