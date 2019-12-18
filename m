Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD364C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 16:54:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 888D22176D
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 16:54:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NXeJikhP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 888D22176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihcaQ-0004eO-Kb
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 11:54:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41261)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1ihcZT-0003iz-St
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 11:53:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1ihcZS-0003LO-R3
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 11:53:11 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35493
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1ihcZS-0003Fy-Jx
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 11:53:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576687989;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eBMgJbGiLeG2NzCfocZbmaXYN45+4dW60P9wVOLHwak=;
 b=NXeJikhP/nwhaAQCvDO4iUXhXpi/KXVEt9aE/vjEAIawje3wiSVsEqjCJhUhuIcNQ+evsd
 iqVoRQWTeiFKs+O8TdL1q6mzhtnmw/1G8p5ftgUdvdyaihv5+mu2Y/MRU1jDDK3wNURjgK
 XbOKpaMZp+DqRNzABOqdH+/aozh/Ux8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-DAS5dprmOIiNfl7TYQgwOg-1; Wed, 18 Dec 2019 11:53:08 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5C5CE18C35A1;
 Wed, 18 Dec 2019 16:53:07 +0000 (UTC)
Received: from gondolin (ovpn-117-253.ams2.redhat.com [10.36.117.253])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4938960C18;
 Wed, 18 Dec 2019 16:53:06 +0000 (UTC)
Date: Wed, 18 Dec 2019 17:53:03 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] tests/boot-sector: Fix the bad s390x assembler code
Message-ID: <20191218175303.4ba0e378.cohuck@redhat.com>
In-Reply-To: <20191217150642.27946-1-thuth@redhat.com>
References: <20191217150642.27946-1-thuth@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: DAS5dprmOIiNfl7TYQgwOg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
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
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Janosch Frank <frankja@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 17 Dec 2019 16:06:42 +0100
Thomas Huth <thuth@redhat.com> wrote:

> There are currently two bugs in s390x_code[]: First, the initial jump
> uses the wrong offset, so it was jumping to 0x1014 instead of 0x1010.
> Second, LHI only loads the lower 32-bit of the register.
> 
> Everything worked fine as long as the s390-ccw bios code was jumping
> here with r3 containing zeroes in the uppermost 48 bit - which just
> happened to be the case so far by accident. But we can not rely on this
> fact, and indeed one of the recent suggested patches to jump2ipl.c cause
> the newer GCCs to put different values into r3. In that case the code
> from s390x_code[] crashes very ungracefully.
> 
> Thus let's make sure to jump to the right instruction, and use LGHI
> instead of LHI to make sure that we always zero out the upper bits
> of the register.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/boot-sector.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Thanks, applied.


