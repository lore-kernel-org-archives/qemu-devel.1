Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F68CC432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 13:27:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78EAB206D3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 13:27:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78EAB206D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVbdY-0006NI-IZ
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 08:27:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51373)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iVbcu-0005y9-Fz
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 08:27:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iVbct-0002mz-7c
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 08:27:04 -0500
Received: from 11.mo7.mail-out.ovh.net ([87.98.173.157]:55811)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iVbct-0002kH-1Q
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 08:27:03 -0500
Received: from player692.ha.ovh.net (unknown [10.108.57.139])
 by mo7.mail-out.ovh.net (Postfix) with ESMTP id 50E0113EADC
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2019 14:27:00 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player692.ha.ovh.net (Postfix) with ESMTPSA id ABE81C087E50;
 Fri, 15 Nov 2019 13:26:57 +0000 (UTC)
Date: Fri, 15 Nov 2019 14:26:56 +0100
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: 9p: requests efficiency
Message-ID: <20191115142656.4f2c0f4b@bahia.lan>
In-Reply-To: <1686691.fQlv7Ls6oC@silver>
References: <1686691.fQlv7Ls6oC@silver>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 12079498627421870400
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudefhedgheefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdqfffguegfifdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpeffhffvuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrheiledvrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 87.98.173.157
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

On Fri, 15 Nov 2019 02:10:50 +0100
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> I'm currently reading up on how client requests (T messages) are currently 
> dispatched in general by 9pfs, to understand where potential inefficiencies 
> are that I am encountering.
> 
> I mean 9pfs is pretty fast on raw I/O (read/write requests), provided that the 
> message payload on guest side was chosen large enough (e.g. 
> trans=virtio,version=9p2000.L,msize=4194304,...), where I already come close 
> to my test disk's therotical maximum performance on read/write tests. But 
> obviously these are huge 9p requests.
> 
> However when there are a large number of (i.e. small) 9p requests, no matter 
> what the actual request type is, then I am encountering severe performance 
> issues with 9pfs and I try to understand whether this could be improved with 
> reasonable effort.
> 

Thanks for doing that. This is typically the kind of effort I never
dared starting on my own.

> If I understand it correctly, each incoming request (T message) is dispatched 
> to its own qemu coroutine queue. So individual requests should already be 
> processed in parallel, right?
> 

Sort of but not exactly. The real parallelization, ie. doing parallel
processing with concurrent threads, doesn't take place on a per-request
basis. A typical request is broken down into several calls to the backend
which may block because the backend itself calls a syscall that may block
in the kernel. Each backend call is thus handled by its own thread from the
mainloop thread pool (see hw/9pfs/coth.[ch] for details). The rest of the
9p code, basically everything in 9p.c, is serialized in the mainloop thread.

Cheers,

--
Greg

> Best regards,
> Christian Schoenebeck
> 
> 


