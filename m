Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 533F0C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 12:47:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28CB322314
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 12:47:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28CB322314
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jp.fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itWSk-0005xd-88
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 07:47:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55523)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <misono.tomohiro@fujitsu.com>) id 1itWRn-0005Vx-9N
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 07:46:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <misono.tomohiro@fujitsu.com>) id 1itWRh-00005o-QG
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 07:46:25 -0500
Received: from mgwym02.jp.fujitsu.com ([211.128.242.41]:64010)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <misono.tomohiro@fujitsu.com>)
 id 1itWRh-0008Ry-AU
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 07:46:21 -0500
Received: from yt-mxq.gw.nic.fujitsu.com (unknown [192.168.229.66]) by
 mgwym02.jp.fujitsu.com with smtp
 id 41b0_cfc9_dc7b6898_e6d7_4630_8efe_525e5d0c51d7;
 Mon, 20 Jan 2020 21:46:10 +0900
Received: from g01jpfmpwkw03.exch.g01.fujitsu.local
 (g01jpfmpwkw03.exch.g01.fujitsu.local [10.0.193.57])
 by yt-mxq.gw.nic.fujitsu.com (Postfix) with ESMTP id C6090AC00C4
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 21:46:09 +0900 (JST)
Received: from g01jpexchkw34.g01.fujitsu.local (unknown [10.0.193.4])
 by g01jpfmpwkw03.exch.g01.fujitsu.local (Postfix) with ESMTP id B729BBD6643;
 Mon, 20 Jan 2020 21:46:08 +0900 (JST)
Received: from luna3.soft.fujitsu.com (10.124.196.199) by
 g01jpexchkw34.g01.fujitsu.local (10.0.193.49) with Microsoft SMTP Server id
 14.3.439.0; Mon, 20 Jan 2020 21:46:09 +0900
From: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
To: <dgilbert@redhat.com>
Subject: Re: [PATCH 100/104] virtiofsd: process requests in a thread pool
Date: Mon, 20 Jan 2020 21:54:55 +0900
Message-ID: <20200120125455.13860-1-misono.tomohiro@jp.fujitsu.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20191212163904.159893-101-dgilbert@redhat.com>
References: <20191212163904.159893-101-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-SecurityPolicyCheck-GC: OK by FENCE-Mail
X-TM-AS-GCONF: 00
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 211.128.242.41
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
Cc: misono.tomohiro@jp.fujitsu.com, qemu-devel@nongnu.org, stefanha@redhat.com,
 vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> From: Stefan Hajnoczi <stefanha@redhat.com>
> 
> Introduce a thread pool so that fv_queue_thread() just pops
> VuVirtqElements and hands them to the thread pool.  For the time being
> only one worker thread is allowed since passthrough_ll.c is not
> thread-safe yet.  Future patches will lift this restriction so that
> multiple FUSE requests can be processed in parallel.
> 
> The main new concept is struct FVRequest, which contains both
> VuVirtqElement and struct fuse_chan.  We now have fv_VuDev for a device,
> fv_QueueInfo for a virtqueue, and FVRequest for a request.  Some of
> fv_QueueInfo's fields are moved into FVRequest because they are
> per-request.  The name FVRequest conforms to QEMU coding style and I
> expect the struct fv_* types will be renamed in a future refactoring.
> 
> This patch series is not optimal.  fbuf reuse is dropped so each request
> does malloc(se->bufsize), but there is no clean and cheap way to keep
> this with a thread pool.  The vq_lock mutex is held for longer than
> necessary, especially during the eventfd_write() syscall.  Performance
> can be improved in the future.
> 
> prctl(2) had to be added to the seccomp whitelist because glib invokes
> it.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Looks good to me.
 Reviewed-by: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>

