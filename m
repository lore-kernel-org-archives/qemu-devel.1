Return-Path: <SRS0=gZkW=SM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E22E5C10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 11:38:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEBC32083E
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 11:38:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEBC32083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57853 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEBYx-0008UO-Pd
	for qemu-devel@archiver.kernel.org; Wed, 10 Apr 2019 07:38:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36699)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=9966e4c82=anthony.perard@citrix.com>)
	id 1hEBYE-00088a-0c
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 07:37:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=9966e4c82=anthony.perard@citrix.com>)
	id 1hEBYC-0003pe-Ux
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 07:37:57 -0400
Received: from smtp03.citrix.com ([162.221.156.55]:44540)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <prvs=9966e4c82=anthony.perard@citrix.com>)
	id 1hEBY7-0003cw-UT; Wed, 10 Apr 2019 07:37:52 -0400
X-IronPort-AV: E=Sophos;i="5.60,332,1549929600"; d="scan'208";a="83207791"
Date: Wed, 10 Apr 2019 12:37:42 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
To: Paul Durrant <paul.durrant@citrix.com>
Message-ID: <20190410113742.GD1435@perard.uk.xensource.com>
References: <20190408151617.13025-1-paul.durrant@citrix.com>
	<20190408151617.13025-2-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190408151617.13025-2-paul.durrant@citrix.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 162.221.156.55
Subject: Re: [Qemu-devel] [PATCH 1/3] xen-bus: use a separate fd for each
 event channel
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
Cc: xen-devel@lists.xenproject.org, Stefano Stabellini <sstabellini@kernel.org>,
	qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190410113742.4_QfOJv9ExZZvnX62o1nwD1L8U06cUKKKRhCSvkMR8I@z>

On Mon, Apr 08, 2019 at 04:16:15PM +0100, Paul Durrant wrote:
> To better support use of IOThread-s it will be necessary to be able to set
> the AioContext for each XenEventChannel and hence it is necessary to open a
> separate handle to libxenevtchan for each channel.
> 
> This patch stops using NotifierList for event channel callbacks, replacing
> that construct by a list of complete XenEventChannel structures. Each of
> these now has a xenevtchn_handle pointer in place of the single pointer
> previously held in the XenDevice structure. The individual handles are
> opened/closed in xen_device_bind/unbind_event_channel(), replacing the
> single open/close in xen_device_realize/unrealize().
> 
> NOTE: This patch does not add an AioContext parameter to
>       xen_device_bind_event_channel(). That will be done in a subsequent
>       patch.
> 
> Signed-off-by: Paul Durrant <paul.durrant@citrix.com>

Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>

There are a few places were I would have like to add an assert, but they
can't be compiled-out in QEMU :-(.

Thanks,

-- 
Anthony PERARD

