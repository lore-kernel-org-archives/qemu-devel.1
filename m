Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9663CC2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 18:04:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6681421734
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 18:04:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DFP0BYN9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6681421734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixaeb-0000b3-He
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 13:04:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50097)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1ixadr-00007M-6A
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 13:03:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1ixadq-0001pP-0L
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 13:03:43 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35814
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ixadp-0001n7-TM
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 13:03:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580493821;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hCx6pGTCstYQgOlSAP4AOb5OGlbVvjBGyGUsXaizsdA=;
 b=DFP0BYN9X5w6LvcrijHnUCtGjy3BIQ8fZ/9XdFKRPb5bi3lAa0TRDeKoAiKev790Qp7ui7
 jX7FczA6iYn8ZlOuZ9pby4fcV3GGxXNnTuqq/Lfg8HsIY1ygiGag4EcUsSpkoJkxSVTuj3
 LSwIrv8ule8NY7vyHuzpf5vTTKVhFqU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-91-mwuL78SZOUaWbS5k783wqA-1; Fri, 31 Jan 2020 13:03:35 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4CD81A899E6;
 Fri, 31 Jan 2020 18:03:34 +0000 (UTC)
Received: from [10.3.116.181] (ovpn-116-181.phx2.redhat.com [10.3.116.181])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C5A2A5E260;
 Fri, 31 Jan 2020 18:03:32 +0000 (UTC)
Subject: Re: [PATCH 10/17] block: Add new BDRV_ZERO_OPEN flag
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
References: <20200131174436.2961874-1-eblake@redhat.com>
 <20200131174436.2961874-11-eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <cfefd70e-5cfe-7f32-8740-0be6337ee558@redhat.com>
Date: Fri, 31 Jan 2020 12:03:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200131174436.2961874-11-eblake@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: mwuL78SZOUaWbS5k783wqA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: david.edmondson@oracle.com, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/31/20 11:44 AM, Eric Blake wrote:
> Knowing that a file reads as all zeroes when created is useful, but
> limited in scope to drivers that can create images.  However, there
> are also situations where pre-existing images can quickly be
> determined to read as all zeroes, even when the image was not just
> created by the same process.  The optimization used in qemu-img
> convert to avoid a pre-zeroing pass on the destination is just as
> useful in such a scenario.  As such, it is worth the block layer
> adding another bit to bdrv_known_zeroes().
> 
> Note that while BDRV_ZERO_CREATE cannot chase through backing layers
> (because it only applies at creation time, but the backing layer was
> not created at the same time as the active layer being created), it IS
> okay for BDRV_ZERO_OPEN to chase through layers (as long as all layers
> currently read as zero, the image reads as zero).
> 
> Upcoming patches will update the qcow2, file-posix, and nbd drivers to
> advertise the new bit when appropriate.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---

[Is it bad when I review my own patches?]

> +++ b/block.c
> @@ -5078,7 +5078,7 @@ int bdrv_known_zeroes_truncate(BlockDriverState *bs)
> 
>   int bdrv_known_zeroes(BlockDriverState *bs)
>   {
> -    int mask = BDRV_ZERO_CREATE | BDRV_ZERO_TRUNCATE;
> +    int mask = BDRV_ZERO_CREATE | BDRV_ZERO_TRUNCATE | BDRV_ZERO_OPEN;
> 
>       if (!bs->drv) {
>           return 0;
> @@ -5100,17 +5100,17 @@ int bdrv_known_zeroes(BlockDriverState *bs)
>        * ZERO_CREATE is not viable.  If the current layer is smaller
>        * than the backing layer, truncation may expose backing data,
>        * restricting ZERO_TRUNCATE; treat failure to query size in the
> -     * same manner.  Otherwise, we can trust the driver.
> +     * same manner.  For ZERO_OPEN, we insist that both backing and
> +     * current layer report the bit.
>        */
> -
>       if (bs->backing) {

Spurious line deletion caused by rebasing.


> +++ b/include/block/block.h
> @@ -105,6 +105,16 @@ typedef enum {
>        * for drivers that set .bdrv_co_truncate.
>        */
>       BDRV_ZERO_TRUNCATE      = 0x2,
> +
> +    /*
> +     * bdrv_known_zeroes() should include this bit if an image is
> +     * known to read as all zeroes when first opened; this bit should
> +     * not be relied on after any writes to the image.  This can be
> +     * set even if BDRV_ZERO_INIT is clear, but should only be set if

Rebasing snafu - I renamed that bit BDRV_ZERO_CREATE in patch 9.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


