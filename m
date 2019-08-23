Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F10CFC3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 18:15:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C955C21848
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 18:15:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C955C21848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1E6N-0002jz-TO
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 14:15:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36925)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1i1E5F-0002CC-EE
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 14:14:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1i1E5E-0000fQ-49
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 14:14:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44984)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1i1E5D-0000f9-VX
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 14:14:44 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id F396910F23EB
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2019 18:14:42 +0000 (UTC)
Received: from localhost (ovpn-116-73.gru2.redhat.com [10.97.116.73])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 75BB2261A7;
 Fri, 23 Aug 2019 18:14:39 +0000 (UTC)
Date: Fri, 23 Aug 2019 15:14:38 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190823181438.GT7077@habkost.net>
References: <20190823135632.25010-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190823135632.25010-1-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.66]); Fri, 23 Aug 2019 18:14:43 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] hostmem-file: fix pmem file size check
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
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Aug 23, 2019 at 02:56:32PM +0100, Stefan Hajnoczi wrote:
> Commit 314aec4a6e06844937f1677f6cba21981005f389 ("hostmem-file: reject
> invalid pmem file sizes") added a file size check that verifies the
> hostmem object's size parameter against the actual devdax pmem file.
> This is useful because getting the size wrong results in confusing
> errors inside the guest.
> 
> However, the code doesn't work properly for files where struct
> stat::st_size is zero.  Hostmem-file's ->alloc() function returns early
> without setting an Error, causing the following assertion failure:
> 
>   qemu/memory.c:2215: memory_region_get_ram_ptr: Assertion `mr->ram_block' failed.
> 
> This patch handles the case where qemu_get_pmem_size() returns 0 but
> there is no error.
> 
> Fixes: 314aec4a6e06844937f1677f6cba21981005f389
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Queued, thanks.

-- 
Eduardo

