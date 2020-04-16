Return-Path: <SRS0=3HrQ=6A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E7C8C2BA2B
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 21:48:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 311A1206A2
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 21:48:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="giZyjeMm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 311A1206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPCNV-0006o2-53
	for qemu-devel@archiver.kernel.org; Thu, 16 Apr 2020 17:48:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41598)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jPCMY-0006E4-Ru
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 17:48:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jPCMW-0003aX-U9
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 17:47:58 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:52563
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jPCMW-0003Zz-Ln
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 17:47:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587073675;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=29iFkI2JR5HRRnoBcwiVit6vdq08XD9Or221Gg5DAac=;
 b=giZyjeMm0xGG/HwX1bJnzNjkVuWNwXUtQi+jQW6JOpMkpstFt81GV1fR5sc51QZxyKbBrR
 /QFuWwGM7tBrvm4Zm3Zu/YV8lWeEEE+R9VZFMLFbyBBuehiUSS7J+9fwJuWA9On9KT06P6
 iYehjntCwugAFDxQhnDslBY3bTs15dg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-468-zSLTiOhaPs6rT59XEXr7KQ-1; Thu, 16 Apr 2020 17:47:50 -0400
X-MC-Unique: zSLTiOhaPs6rT59XEXr7KQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D34BDDB88;
 Thu, 16 Apr 2020 21:47:49 +0000 (UTC)
Received: from [10.3.115.59] (ovpn-115-59.phx2.redhat.com [10.3.115.59])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F34771000325;
 Thu, 16 Apr 2020 21:47:48 +0000 (UTC)
Subject: Re: [PATCH] qcow2: Expose bitmaps' size during measure
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
References: <20200416212349.731404-1-eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <df0c78ec-19f6-9fa6-1ca6-896f80026614@redhat.com>
Date: Thu, 16 Apr 2020 16:47:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200416212349.731404-1-eblake@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 nsoffer@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/16/20 4:23 PM, Eric Blake wrote:
> It's useful to know how much space can be occupied by qcow2 persistent
> bitmaps, even though such metadata is unrelated to the guest-visible
> data.  Report this value as an additional field.
> 
> Reported-by: Nir Soffer <nsoffer@redhat.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
> 

Per https://bugzilla.redhat.com/show_bug.cgi?id=1779904#c0, I didn't 
quite round up in enough places:

> @@ -4739,6 +4742,26 @@ static BlockMeasureInfo *qcow2_measure(QemuOpts *opts, BlockDriverState *in_bs,
>               goto err;
>           }
> 
> +        FOR_EACH_DIRTY_BITMAP(in_bs, bm) {
> +            if (bdrv_dirty_bitmap_get_persistence(bm)) {
> +                uint64_t bmsize = bdrv_dirty_bitmap_size(bm);
> +                uint32_t granularity = bdrv_dirty_bitmap_granularity(bm);
> +                const char *name = bdrv_dirty_bitmap_name(bm);
> +                uint64_t bmclusters = DIV_ROUND_UP(bmsize / granularity
> +                                                   / CHAR_BIT, cluster_size);

All of these divisions need to round up.  For example, in an image with 
512-byte clusters and granularity, and a bitmap covering 512*512*8+512 
bytes (2097664), we need 2 clusters, not 1, for the bitmap itself. 
Fortunately, it is an edge case, and we usually have enough slop in the 
final round up to cluster size that most users won't trip on this.

> +
> +                /* Assume the entire bitmap is allocated */
> +                bitmaps_size += bmclusters * cluster_size;
> +                /* Also reserve space for the bitmap table entries */
> +                bitmaps_size += ROUND_UP(bmclusters * sizeof(uint64_t),
> +                                         cluster_size);
> +                /* Guess at contribution to bitmap directory size */
> +                bitmap_overhead += ROUND_UP(strlen(name) + 24,

And I don't like this magic number, but sizeof(Qcow2BitmapDirEntry) from 
qcow2-bitmap.c is a private struct not accessible here.

> +                                            sizeof(uint64_t));
> +            }
> +        }
> +        bitmaps_size += ROUND_UP(bitmap_overhead, cluster_size);
> +
-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


