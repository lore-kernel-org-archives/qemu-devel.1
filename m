Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC3D1C3A59C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 14:10:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A26922086C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 14:10:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A26922086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hycwE-0005cp-Kq
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 10:10:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43214)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1hycu2-0002xi-3t
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 10:08:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hycu0-0002KY-Q3
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 10:08:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40330)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hycty-0002IT-FB; Fri, 16 Aug 2019 10:08:22 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C3A6725CCB;
 Fri, 16 Aug 2019 14:08:21 +0000 (UTC)
Received: from localhost.localdomain (dhcp-200-226.str.redhat.com
 [10.33.200.226])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8E1418F6DB;
 Fri, 16 Aug 2019 14:08:20 +0000 (UTC)
Date: Fri, 16 Aug 2019 16:08:19 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Alberto Garcia <berto@igalia.com>
Message-ID: <20190816140819.GD5014@localhost.localdomain>
References: <20190816121742.29607-1-berto@igalia.com>
 <20190816125921.GC5014@localhost.localdomain>
 <w51lfvti6fs.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <w51lfvti6fs.fsf@maestria.local.igalia.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Fri, 16 Aug 2019 14:08:21 +0000 (UTC)
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

Am 16.08.2019 um 15:30 hat Alberto Garcia geschrieben:
> On Fri 16 Aug 2019 02:59:21 PM CEST, Kevin Wolf wrote:
> > The requirement so that this bug doesn't affect the user seems to be
> > that the image size is a multiple of 64k * 8k = 512 MB. Which means
> > that users are probably often lucky enough in practice.
> 
> Or rather: cluster_size^2 / 8, which, if my numbers are right:
> 
> |--------------+-------------|
> | Cluster size | Multiple of |
> |--------------+-------------|
> |         4 KB |        2 MB |
> |         8 KB |        8 MB |
> |        16 KB |       32 MB |
> |        32 KB |      128 MB |
> |        64 KB |      512 MB |
> |       128 KB |        2 GB |
> |       256 KB |        8 GB |
> |       512 KB |       32 GB |
> |      1024 KB |      128 GB |
> |      2048 KB |      512 GB |
> |--------------+-------------|
> 
> It get trickier with larger clusters, but if you have a larger cluster
> size you probably have a very large image anyway, so yes I also think
> that users are probably lucky enough in practice.

Yes, I assumed 64k clusters.

The other somewhat popular cluster size is probably 2 MB, where I think
images sizes that are not a multiple of 512 GB are rather likely...

> (also, the number of cache tables is always >= 2, so if the image size
> is less than twice those numbers then it's also safe)

Right. I already corrected my statement to include > 1024 MB in the Red
Hat Bugzilla (but still didn't consider other cluster sizes).

> And yes, the odd value on the 512KB row on that we discussed last month
> is due to this same bug:
> 
> https://lists.gnu.org/archive/html/qemu-block/2019-07/msg00496.html

Hm... And suddently it makes sense. :-)

So I assume all of 512k/1024k/2048k actually perform better? Or is the
effect neglegible for 1024k/2048k?

Kevin

