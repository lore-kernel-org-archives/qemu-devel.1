Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C04C3A59C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 13:07:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4804A20644
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 13:07:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4804A20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hybx4-0006Iw-Fa
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 09:07:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32933)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1hybpN-0007ss-DY
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 08:59:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hybpM-0001Fy-Bo
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 08:59:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46454)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hybpI-0001CI-1e; Fri, 16 Aug 2019 08:59:28 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E396C89AC9;
 Fri, 16 Aug 2019 12:59:25 +0000 (UTC)
Received: from localhost.localdomain (dhcp-200-226.str.redhat.com
 [10.33.200.226])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CC5361901A;
 Fri, 16 Aug 2019 12:59:22 +0000 (UTC)
Date: Fri, 16 Aug 2019 14:59:21 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Alberto Garcia <berto@igalia.com>
Message-ID: <20190816125921.GC5014@localhost.localdomain>
References: <20190816121742.29607-1-berto@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190816121742.29607-1-berto@igalia.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Fri, 16 Aug 2019 12:59:26 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] qcow2: Fix the calculation of the maximum
 L2 cache size
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
Cc: Leonid Bloch <lbloch@janustech.com>, Max Reitz <mreitz@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 16.08.2019 um 14:17 hat Alberto Garcia geschrieben:
> The size of the qcow2 L2 cache defaults to 32 MB, which can be easily
> larger than the maximum amount of L2 metadata that the image can have.
> For example: with 64 KB clusters the user would need a qcow2 image
> with a virtual size of 256 GB in order to have 32 MB of L2 metadata.
> 
> Because of that, since commit b749562d9822d14ef69c9eaa5f85903010b86c30
> we forbid the L2 cache to become larger than the maximum amount of L2
> metadata for the image, calculated using this formula:
> 
>     uint64_t max_l2_cache = virtual_disk_size / (s->cluster_size / 8);
> 
> The problem with this formula is that the result should be rounded up
> to the cluster size because an L2 table on disk always takes one full
> cluster.
> 
> For example, a 1280 MB qcow2 image with 64 KB clusters needs exactly
> 160 KB of L2 metadata, but we need 192 KB on disk (3 clusters) even if
> the last 32 KB of those are not going to be used.
> 
> However QEMU rounds the numbers down and only creates 2 cache tables
> (128 KB), which is not enough for the image.
> 
> A quick test doing 4KB random writes on a 1280 MB image gives me
> around 500 IOPS, while with the correct cache size I get 16K IOPS.
> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>

Hm, this is bad. :-(

The requirement so that this bug doesn't affect the user seems to be
that the image size is a multiple of 64k * 8k = 512 MB. Which means that
users are probably often lucky enough in practice.

I'll Cc: qemu-stable anyway.

Thanks, applied to the block branch.

Kevin

