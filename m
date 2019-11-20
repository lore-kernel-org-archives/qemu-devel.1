Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD000C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 23:38:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98341206D8
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 23:38:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="gSSc8IVk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98341206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXZYa-0006jG-L8
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 18:38:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53551)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <qemu_oss@crudebyte.com>) id 1iXZXc-0005jb-4X
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 18:37:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <qemu_oss@crudebyte.com>) id 1iXZXa-0001jQ-Fl
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 18:37:43 -0500
Received: from kylie.crudebyte.com ([5.189.157.229]:49207)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <qemu_oss@crudebyte.com>)
 id 1iXZXa-0001iJ-0y
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 18:37:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=8sRAjE71jdO3+H8MKljs+oh3jJO+1nhDN+XUmbC6fvU=; b=gSSc8IVklFBlZ8p4Gj5OEv5UFV
 V9mgcwiVAZyz7vt+uXt6RInOhxQsB+YQb8pGhw3HuaLoISFSFZ6rE1Ix6T6y6YMs0jkp7E1ms+YtL
 Ewbq1JwaC725/2vS7XORcQEu0Xjyu7vxjSjfSftGHco2xp0GJPuGjf27lp7uvaRK19wGC6KFu18l1
 lOT9XZy2lDXHuE+p1VAdAZyqfcFsNVy4SGTGMpYy8uK9ScQZtO4Hul/ebJIQ72NnCZ4ZOeyIFZwFT
 CkLtvBOA5/mYGi9ntOFtu+IGH+atWPZ514NG9WhVmm4VLhGqp4vklJbbVgivES9RTZ99A0R22qHpm
 8jrjbbVXaiylL4+YAmXw1LNDY9jGXUpciNSVtqUSBLBwc6e7KInw0UyX8IIfiH9hMvvwpOWVN7Kk4
 oJ0yuddZJ3hssjxwbl7MshJQT6mmTk+5d+vF4g70wjBtGF3ZkwdMJ/JK51T1ZMHbjeH+cOKS4SWL3
 Z1qgXi/5NFHmS1L//u4J6TXe4j/sruJPXkb03PrZme51X7ZN5DEt163AuKkLFFK2troGutxXgmCqi
 3SiAT1HfayiJFO0UlzUCVFlPoBOt3m+UwkJPpuo7vBCzo4VKmcu+DLpCkusPzkoFVCHZddaiicP0m
 JKyIMIapXgBEQU/tyi5Fw1+N3YM3pynDrL2HWMThc=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: 9p: requests efficiency
Date: Thu, 21 Nov 2019 00:37:36 +0100
Message-ID: <2782774.O0duVuAc2B@silver>
In-Reply-To: <20191115142656.4f2c0f4b@bahia.lan>
References: <1686691.fQlv7Ls6oC@silver> <20191115142656.4f2c0f4b@bahia.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 5.189.157.229
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Freitag, 15. November 2019 14:26:56 CET Greg Kurz wrote:
> > However when there are a large number of (i.e. small) 9p requests, no
> > matter what the actual request type is, then I am encountering severe
> > performance issues with 9pfs and I try to understand whether this could
> > be improved with reasonable effort.
> 
> Thanks for doing that. This is typically the kind of effort I never
> dared starting on my own.

If you don't mind I still ask some more questions though, just in case you can 
gather them from the back of your head.

> > If I understand it correctly, each incoming request (T message) is
> > dispatched to its own qemu coroutine queue. So individual requests should
> > already be processed in parallel, right?
> 
> Sort of but not exactly. The real parallelization, ie. doing parallel
> processing with concurrent threads, doesn't take place on a per-request
> basis. 

Ok I see, I was just reading that each request causes this call sequence:

	handle_9p_output() -> pdu_submit() -> qemu_co_queue_init(&pdu->complete)

and I was misinterpreting specifically that latter call to be an implied 
thread creation. Because that's what happens with other somewhat similar 
collaborative thread synchronization frameworks like "Grand Central Dispatch" 
or std::async.

But now I realize the entire QEMU coroutine framework is really just managing 
memory stacks, not actually anything about threads per se. The QEMU docs often 
use the term "threads" which is IMO misleading for what it really does.

> A typical request is broken down into several calls to the backend
> which may block because the backend itself calls a syscall that may block
> in the kernel. Each backend call is thus handled by its own thread from the
> mainloop thread pool (see hw/9pfs/coth.[ch] for details). The rest of the
> 9p code, basically everything in 9p.c, is serialized in the mainloop thread.

So the precise parallelism fork points in 9pfs (where tasks are dispatched to 
other threads) are the *_co_*() functions, and there precisely at where they 
are using v9fs_co_run_in_worker( X ) respectively, correct? Or are there more 
fork points than those?

If so, I haven't understood how precisely v9fs_co_run_in_worker() works. I 
mean I understand now how QEMU coroutines are working, and the idea of 
v9fs_co_run_in_worker() is dispatching the passed code block to the worker 
thread, but immediately returning back to main thread and continueing there on 
main thread with other coroutines while the worker thread's dispatched 
coroutine finished. But how that happens there precisely in 
v9fs_co_run_in_worker() is not yet clear to me.

Also where are the worker threads spawned actually?

Best regards,
Christian Schoenebeck



