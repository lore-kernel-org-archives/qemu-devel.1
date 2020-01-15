Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D15F5C32771
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 17:11:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9ED13214AF
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 17:11:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mj2eI5DD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ED13214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irmCT-0004Ph-NP
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 12:11:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42643)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1irmBP-0002iZ-1O
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 12:10:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1irmBN-0004Zd-RG
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 12:10:18 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59617
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1irmBN-0004ZA-NE
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 12:10:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579108217;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u5s77NR2Yt5fuk2lggB00ZbfbDbrnVZ0kMO8O5zOXGM=;
 b=Mj2eI5DDXLjJxfwbc8dVwW9dvKEPzBIvzf6J+nCDVUs/GWVgYBi/WAy9uTIZnAtMFQ2Xjp
 LMrd4oj5lDHjuDKb3VLRHq7OCJ8L6QFAqxqolOy4W1w0TEk7G9FK/NJPHMYk5nSqEEHSrD
 d51UJj01G5eWUtPHKyjdHuiBCwrdmcE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-SSZJ4QLKOJe5s7hceirOzA-1; Wed, 15 Jan 2020 12:10:00 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A3F3B8045ED;
 Wed, 15 Jan 2020 17:09:59 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 025B919756;
 Wed, 15 Jan 2020 17:09:58 +0000 (UTC)
Date: Wed, 15 Jan 2020 18:09:57 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: no-reply@patchew.org
Subject: Re: [PATCH v2 00/86] refactor main RAM allocation to use hostmem
 backend
Message-ID: <20200115180957.74ccc5f4@redhat.com>
In-Reply-To: <157910661287.7467.969397900495856191@37313f22b938>
References: <1579100861-73692-1-git-send-email-imammedo@redhat.com>
 <157910661287.7467.969397900495856191@37313f22b938>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: SSZJ4QLKOJe5s7hceirOzA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 15 Jan 2020 08:43:33 -0800 (PST)
no-reply@patchew.org wrote:

> Patchew URL: https://patchew.org/QEMU/1579100861-73692-1-git-send-email-imammedo@redhat.com/
> 
> 
> 
> Hi,
> 
> This series seems to have some coding style problems. See output below for
> more information:
[...]

> 6/86 Checking commit b9b1823833a3 (alpha:dp264: use memdev for RAM)
> ERROR: spaces required around that '*' (ctx:WxV)
> #30: FILE: hw/alpha/alpha_sys.h:14:
> +PCIBus *typhoon_init(MemoryRegion *, ISABus **, qemu_irq *, AlphaCPU *[4],

patch keeps the same style that was used in original code
I can rewrite it on the next respin to mach current codestyle 

[...]


