Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF03CC54EEB
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 18:15:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA0912051A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 18:15:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA0912051A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGRbM-0003Ix-Qh
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 14:15:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59564)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dietmar@proxmox.com>) id 1jGRaR-0002YL-Rv
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 14:14:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dietmar@proxmox.com>) id 1jGRaQ-00062n-OP
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 14:14:07 -0400
Received: from proxmox-new.maurer-it.com ([212.186.127.180]:51927)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dietmar@proxmox.com>) id 1jGRaQ-0005xy-HY
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 14:14:06 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 6B84542887;
 Mon, 23 Mar 2020 19:13:54 +0100 (CET)
Date: Mon, 23 Mar 2020 19:13:52 +0100 (CET)
From: Dietmar Maurer <dietmar@proxmox.com>
To: Kevin Wolf <kwolf@redhat.com>
Message-ID: <1825818863.138.1584987232460@webmail.proxmox.com>
In-Reply-To: <20200323170710.GC8049@linux.fritz.box>
References: <1577640273.5.1584605618249@webmail.proxmox.com>
 <20200323170710.GC8049@linux.fritz.box>
Subject: Re: aio-context question
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.2-Rev22
X-Originating-Client: open-xchange-appsuite
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.186.127.180
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
Reply-To: Dietmar Maurer <dietmar@proxmox.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> If it doesn't have any effect because it just does what will be done
> later anyway, it can be removed, but that doesn't buy us much.

I think that code is simply unnecessary (no effect).
But it is quite hard to read and understand, so I think removing
that code helps to simplify things.

> If it results in preventing some case (like the one fixed by 30dd65f3),
> we need to check whether this case is actually safe. If it is safe, we
> can remove the lines and get a new feature from it.
> 
> In both cases, I think a test case should be written together with the
> removal of the code. And if we find out that it's unsafe, we should even
> more write a test case that makes sure that the operation fails.

Yes, a test case would be great. Especially one that test backups with
io-threads. 

I am hunting a bug for more than a week now. Seems bdrv_drain hangs 
sometimes when running a backup job on drives using io-threads ...

But I still haven't found a reliable way to reproduce it.
Sometimes takes me several hours to trigger it again... 

I will try to write a test case if I can really find that bug...


