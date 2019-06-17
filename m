Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B140C31E57
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 12:38:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46E7C20861
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 12:38:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46E7C20861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46990 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcquM-0001eB-2a
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 08:38:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41141)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hcqlU-0004Th-Jy
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 08:29:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hcqlS-00075w-JD
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 08:29:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43100)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1hcqlQ-00072z-Jf
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 08:29:32 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2C1A73066800;
 Mon, 17 Jun 2019 12:29:29 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-99.ams2.redhat.com [10.36.117.99])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B5E3E1001E61;
 Mon, 17 Jun 2019 12:29:23 +0000 (UTC)
Date: Mon, 17 Jun 2019 14:29:22 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190617122922.GG7397@linux.fritz.box>
References: <20190612120421.20336-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190612120421.20336-1-stefanha@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Mon, 17 Jun 2019 12:29:29 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4] virtio-scsi: restart DMA after iothread
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
Cc: Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 12.06.2019 um 14:04 hat Stefan Hajnoczi geschrieben:
> When the 'cont' command resumes guest execution the vm change state
> handlers are invoked.  Unfortunately there is no explicit ordering
> between vm change state handlers.  When two layers of code both use vm
> change state handlers, we don't control which handler runs first.
> 
> virtio-scsi with iothreads hits a deadlock when a failed SCSI command is
> restarted and completes before the iothread is re-initialized.
> 
> This patch introduces priorities for VM change state handlers so the
> IOThread is guaranteed to be initialized before DMA requests are
> restarted.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> v4:
> Paolo and Michael were interested in a priorities system.  Kevin wasn't
> convinced.  Here is a patch implementing the priorities approach so you
> can decide whether you prefer this or not.

I still prefer the v3 approach that reflects the actual dependencies in
the code. With the priorities approach, we try to represent a tree of
devices (a structure we already have) with an additional flat list of
numbers. While these numbers can actually provide all the information
that we need in practice in this specific case, it still feels a bit
hacky and might not be extensible to future cases.

But in the end, if Paolo feels strongly that for whatever reason
propagating events through the real device tree isn't good, let's get
the bug fixed with whatever hack it takes.

Kevin

