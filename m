Return-Path: <SRS0=gZkW=SM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F996C10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 15:17:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2CEB2083E
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 15:17:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2CEB2083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33030 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEEyY-0004ER-Qc
	for qemu-devel@archiver.kernel.org; Wed, 10 Apr 2019 11:17:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=9966e4c82=anthony.perard@citrix.com>)
	id 1hEEwB-0002Bn-0d
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 11:14:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=9966e4c82=anthony.perard@citrix.com>)
	id 1hEEqw-0001mu-0p
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 11:09:31 -0400
Received: from smtp03.citrix.com ([162.221.156.55]:61646)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <prvs=9966e4c82=anthony.perard@citrix.com>)
	id 1hEEqr-0001Ys-Qn; Wed, 10 Apr 2019 11:09:28 -0400
X-IronPort-AV: E=Sophos;i="5.60,332,1549929600"; d="scan'208";a="83234990"
Date: Wed, 10 Apr 2019 16:09:18 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
To: Paul Durrant <paul.durrant@citrix.com>
Message-ID: <20190410150918.GF1435@perard.uk.xensource.com>
References: <20190408151617.13025-1-paul.durrant@citrix.com>
	<20190408151617.13025-4-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190408151617.13025-4-paul.durrant@citrix.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 162.221.156.55
Subject: Re: [Qemu-devel] [PATCH 3/3] xen-bus / xen-block: add support for
 event channel polling
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>,
	qemu-block@nongnu.org, qemu-devel@nongnu.org,
	Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
	xen-devel@lists.xenproject.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190410150918.kIOW9YyeHP4BrrJ0ah440bL4yZk1PH9Diz-9ATghjkk@z>

On Mon, Apr 08, 2019 at 04:16:17PM +0100, Paul Durrant wrote:
> This patch introduces a poll callback for event channel fd-s and uses
> this to invoke the channel callback function.
> 
> To properly support polling, it is necessary for the event channel callback
> function to return a boolean saying whether it has done any useful work or
> not. Thus xen_block_dataplane_event() is modified to directly invoke
> xen_block_handle_requests() and the latter only returns true if it actually
> processes any requests. This also means that the call to qemu_bh_schedule()
> is moved into xen_block_complete_aio(), which is more intuitive since the
> only reason for doing a deferred poll of the shared ring should be because
> there were previously insufficient resources to fully complete a previous
> poll.
> 
> Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
> ---

Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>

Thanks,

-- 
Anthony PERARD

