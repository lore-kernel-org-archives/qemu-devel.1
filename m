Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82020C3524D
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 09:50:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A2062080D
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 09:50:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tdp9xAv1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A2062080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyYMv-0004dW-ES
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 04:50:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58527)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iyYMC-00048J-LD
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 04:49:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iyYMB-0008BR-FQ
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 04:49:28 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:49463
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iyYMB-0008B6-BI
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 04:49:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580723366;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HLqsnz3qIv6ajG3+Dap/Yy0Xs36ih7iMaBv2fXmaxsI=;
 b=Tdp9xAv1iz3RE03UlHP28A/2Y46FpWJbwSjOkDhZVc9p+1qMWTgF+QfBpKGLBcFNbyYdXZ
 SaX9V3XQ2RO3UOj9UzpxvPjUxqAo2Ey2YNJ4Y7DcUQuqOGxb55Ac7u5seCuopoX24Ye0VG
 1dfrSnekGbI29UOxFu38uRQbbeHI22g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-344-OmuyrU7NOE6yoGE5nzQbjQ-1; Mon, 03 Feb 2020 04:49:20 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A848513FB;
 Mon,  3 Feb 2020 09:49:19 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 12C3A8ECE2;
 Mon,  3 Feb 2020 09:49:18 +0000 (UTC)
Date: Mon, 3 Feb 2020 10:49:17 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: no-reply@patchew.org
Subject: Re: [PATCH v4 00/80] refactor main RAM allocation to use hostmem
 backend
Message-ID: <20200203104917.04349f1b@redhat.com>
In-Reply-To: <158048808101.17955.1318252736152351099@a1bbccc8075a>
References: <1580483390-131164-1-git-send-email-imammedo@redhat.com>
 <158048808101.17955.1318252736152351099@a1bbccc8075a>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: OmuyrU7NOE6yoGE5nzQbjQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 31 Jan 2020 08:28:02 -0800 (PST)
no-reply@patchew.org wrote:

> Patchew URL: https://patchew.org/QEMU/1580483390-131164-1-git-send-email-imammedo@redhat.com/
> 
> 
> 
> Hi,
> 
> This series seems to have some coding style problems. See output below for
> more information:
> 
> Subject: [PATCH v4 00/80] refactor main RAM allocation to use hostmem backend
> Message-id: 1580483390-131164-1-git-send-email-imammedo@redhat.com
[...]
> 1/80 Checking commit 60461983c933 (numa: remove deprecated -mem-path fallback to anonymous RAM)
> 2/80 Checking commit 5762ea41ea77 (machine: introduce memory-backend property)
> 3/80 Checking commit bcce25a8e595 (machine: alias -mem-path and -mem-prealloc into memory-foo backend)
> 4/80 Checking commit 700389660de4 (machine: introduce convenience MachineState::ram)
> 5/80 Checking commit 690a30507aa5 (initialize MachineState::ram in NUMA case)
> 6/80 Checking commit 32f83261cd0d (vl.c: move -m parsing after memory backends has been processed)
> 7/80 Checking commit de3c2ca6c609 (vl.c: ensure that ram_size matches size of machine.memory-backend)
> 8/80 Checking commit 8de04fd7210c (alpha/dp264: use memdev for RAM)
> ERROR: spaces required around that '*' (ctx:WxV)
> #30: FILE: hw/alpha/alpha_sys.h:14:
> +PCIBus *typhoon_init(MemoryRegion *, ISABus **, qemu_irq *, AlphaCPU *[4],

false positive
                                                                       ^
> 
> total: 1 errors, 0 warnings, 49 lines checked
> 
> Patch 8/80 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 

[...]

> 64/80 Checking commit c0f1fddf078c (ppc/{ppc440_bamboo, sam460ex}: drop RAM size fixup)
> 65/80 Checking commit c68dc4f3f534 (ppc/{ppc440_bamboo, sam460ex}: use memdev for RAM)
> WARNING: Block comments use a leading /* on a separate line
> #50: FILE: hw/ppc/ppc4xx_devs.c:669:
> +/* Split RAM between SDRAM banks.

will fix it if I have to respin.

> 
> total: 0 errors, 1 warnings, 103 lines checked
> 
> Patch 65/80 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
[...]


