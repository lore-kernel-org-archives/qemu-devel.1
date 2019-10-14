Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DCA7ECE587
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 14:23:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E88252067B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 14:23:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E88252067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK1Fh-0004wz-6B
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 10:23:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48067)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iK1EC-00045K-2U
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 10:21:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iK1EB-0007ur-39
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 10:21:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33426)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1iK1E6-0007sj-TI; Mon, 14 Oct 2019 10:21:35 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B1B58C056808;
 Mon, 14 Oct 2019 14:21:33 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.36.118.40])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 114D71001DD7;
 Mon, 14 Oct 2019 14:21:28 +0000 (UTC)
Date: Mon, 14 Oct 2019 16:21:27 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Alberto Garcia <berto@igalia.com>
Subject: Re: [PATCH v2] block: Reject misaligned write requests with
 BDRV_REQ_NO_FALLBACK
Message-ID: <20191014142127.GH7173@localhost.localdomain>
References: <20191014081545.29694-1-berto@igalia.com>
 <20191014092601.GA7173@localhost.localdomain>
 <w5136fvtvug.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <w5136fvtvug.fsf@maestria.local.igalia.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Mon, 14 Oct 2019 14:21:33 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Nir Soffer <nsoffer@redhat.com>,
 Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 14.10.2019 um 13:22 hat Alberto Garcia geschrieben:
> On Mon 14 Oct 2019 11:26:01 AM CEST, Kevin Wolf wrote:
> >> Signed-off-by: Alberto Garcia <berto@igalia.com>
> >
> > Thanks, applied to the block branch.
> 
> I'm a bit late now, but a possible trivial optimization is to flip the
> conditions, because checking the flag should be faster than checking the
> alignment and it's going to be false in almost all cases:
> 
>     if ((flags & BDRV_REQ_NO_FALLBACK) &&
>         !QEMU_IS_ALIGNED(offset | bytes, align)) {
>         return -ENOTSUP;
>     }
> 
> Feel free to edit the commit if you want.

Ok, I'll update it.

Kevin

