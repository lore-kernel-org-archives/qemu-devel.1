Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E904CC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 14:38:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2DAF206A1
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 14:38:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OzDVVEzy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2DAF206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtuAf-0002Kf-Vx
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 10:38:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44530)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jtu9p-0001q3-OQ
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 10:37:45 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:56956
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jtu9n-00068x-D6
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 10:37:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594391860;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IiQTrskeSfR7zFlizWEDaWByWOajOwfqPdwt65Zcibc=;
 b=OzDVVEzy3OPFEPUTpNASqP+oB75Sd6Uk1xwNgB/F69NkZ+6AvJHgD0JHvCAi7PU/qT2eaz
 Uvy+uC5sz0LWvGQET7oxtM3LwPadc0jCCHb3ylFUIgdJlcVTJiFnJsMQxFq6dA561mpXsg
 HVmay99g/gpowDdmAWpHjmVv6a/CEwU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-334-dS1Xi16yMuOTAAwksHq-Pw-1; Fri, 10 Jul 2020 10:37:36 -0400
X-MC-Unique: dS1Xi16yMuOTAAwksHq-Pw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6D4F31932488;
 Fri, 10 Jul 2020 14:37:35 +0000 (UTC)
Received: from [10.3.112.178] (ovpn-112-178.phx2.redhat.com [10.3.112.178])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DAA6D70100;
 Fri, 10 Jul 2020 14:37:34 +0000 (UTC)
Subject: Re: [PATCH for-5.1 1/2] block: Require aligned image size to avoid
 assertion failure
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20200710142149.40962-1-kwolf@redhat.com>
 <20200710142149.40962-2-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <c9555a24-f4db-58a3-1e0c-97fd66e99ba5@redhat.com>
Date: Fri, 10 Jul 2020 09:37:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200710142149.40962-2-kwolf@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 22:08:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/10/20 9:21 AM, Kevin Wolf wrote:
> Unaligned requests will automatically be aligned to bl.request_alignment
> and we don't want to extend requests to access space beyond the end of
> the image, so it's required that the image size is aligned.

Yep, that's what I've already done on nbd images.

nbdkit has '--filter=truncate' which rounds an image size up to 
alignment by reading the absent tail as zeros, and permitting writes 
that rewrite zero but failing with EIO any write that would attempt to 
change the tail.  We may eventually want that complexity in qemu's block 
layer for ALL drivers (as part of switching the block layer to 
byte-accurate sizing everywhere), but that's a LOT more effort.  The 
short term of just mandating alignment is much easier and still defensible.

> 
> With write requests, this could cause assertion failures like this if
> RESIZE permissions weren't requested:
> 
> qemu-img: block/io.c:1910: bdrv_co_write_req_prepare: Assertion `end_sector <= bs->total_sectors || child->perm & BLK_PERM_RESIZE' failed.
> 
> This was e.g. triggered by qemu-img converting to a target image with 4k
> request alignment when the image was only aligned to 512 bytes, but not
> to 4k.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   block.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)

Reviewed-by: Eric Blake <eblake@redhat.com>

> 
> diff --git a/block.c b/block.c
> index cc377d7ef3..c635777911 100644
> --- a/block.c
> +++ b/block.c
> @@ -1489,6 +1489,16 @@ static int bdrv_open_driver(BlockDriverState *bs, BlockDriver *drv,
>           return -EINVAL;
>       }
>   
> +    /*
> +     * Unaligned requests will automatically be aligned to bl.request_alignment
> +     * and we don't want to extend requests to access space beyond the end of
> +     * the image, so it's required that the image size is aligned.
> +     */
> +    if ((bs->total_sectors * BDRV_SECTOR_SIZE) % bs->bl.request_alignment) {
> +        error_setg(errp, "Image size is not a multiple of request alignment");
> +        return -EINVAL;
> +    }
> +

Do we have any iotest coverage of this new message?  (If none of our 
existing tests broke, then you should add one...)


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


