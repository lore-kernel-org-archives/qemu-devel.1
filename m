Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F60C7618F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 16:55:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 015E5205ED
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 16:55:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 015E5205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnQjV-0001mC-So
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 12:55:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59673)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hnQjL-0001JQ-9M
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 12:55:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hnQjK-0001AS-E9
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 12:55:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50916)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hnQjI-00018a-Ff; Tue, 16 Jul 2019 12:55:04 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E70813082B6D;
 Tue, 16 Jul 2019 16:55:02 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-24.ams2.redhat.com [10.36.117.24])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 82E735D72E;
 Tue, 16 Jul 2019 16:55:01 +0000 (UTC)
Date: Tue, 16 Jul 2019 18:54:59 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Message-ID: <20190716165459.GI7297@linux.fritz.box>
References: <20190715104508.7568-1-mreitz@redhat.com>
 <20190715104508.7568-2-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190715104508.7568-2-mreitz@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Tue, 16 Jul 2019 16:55:03 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH for-4.1? 1/4] qcow2: Fix
 .bdrv_has_zero_init()
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
Cc: Jeff Cody <codyprime@gmail.com>, Stefan Weil <sw@weilnetz.de>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 15.07.2019 um 12:45 hat Max Reitz geschrieben:
> If a qcow2 file is preallocated, it can no longer guarantee that it
> initially appears as filled with zeroes.
> 
> So implement .bdrv_has_zero_init() by checking whether the file is
> preallocated; if so, forward the call to the underlying storage node,
> except for when it is encrypted: Encrypted preallocated images always
> return effectively random data, so .bdrv_has_zero_init() must always
> return 0 for them.
> 
> Reported-by: Stefano Garzarella <sgarzare@redhat.com>
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Hm... This patch only really works directly after image creation (which
is indeed where .bdrv_has_zero_init is used). Why do we have to have a
full qcow2_is_zero() that loops over the whole image just to find out
whether it's preallocated? Wouldn't looking at a single data cluster be
enough?

Kevin

