Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D7BEC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 21:07:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CB5E2145D
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 21:07:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="eex0mklj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CB5E2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSRW0-00039q-Q0
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 17:07:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37118)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1kSRVK-0002f2-T3; Tue, 13 Oct 2020 17:06:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:55752)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1kSRVI-0005M5-NJ; Tue, 13 Oct 2020 17:06:42 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6E406208D5;
 Tue, 13 Oct 2020 21:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1602623198;
 bh=Z+Z9cVVfdGxDk4ptHXbEbE9PNqq1M47LY3xiIONp3MI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=eex0mkljnBcrMtteb6vebIK4AEl3/LiZUmP/bqIBF95+rUyhQ1381J1ZoB83zsrIU
 +EusCwLAo2/NglEPV5VM9zWHL6l+KIQ8CYYqVnJ/gOaP3QZPo6GBr0AID89KmCLdkY
 5ZVnFjt5pIzXpaNXci0v7y16/diVTw2wIAclW9Zk=
Date: Tue, 13 Oct 2020 14:06:36 -0700
From: Keith Busch <kbusch@kernel.org>
To: Klaus Jensen <its@irrelevant.dk>
Subject: Re: [PATCH] hw/block/nvme: add block utilization tracking
Message-ID: <20201013210636.GA1049395@dhcp-10-100-145-180.wdl.wdc.com>
References: <20201013190846.260841-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201013190846.260841-1-its@irrelevant.dk>
Received-SPF: pass client-ip=198.145.29.99; envelope-from=kbusch@kernel.org;
 helo=mail.kernel.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 17:06:39
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>, Klaus Jensen <k.jensen@samsung.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 13, 2020 at 09:08:46PM +0200, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> This adds support for reporting the Deallocated or Unwritten Logical
> Block error (DULBE). This requires tracking the allocated/deallocated
> status of all logical blocks.
> 
> Introduce a bitmap that does this. The bitmap is always intialized to
> all ones (aka, all blocks are allocated) on boot up. Blocks can then be
> specifically deallocated using Write Zeroes. This ensures that we can
> always guarantee zeroes to be returned from deallocated blocks.
> 
> When the device gains support for persistent state, the intention is to
> remove the "allocated by default" behavior.

I think this is a rather odd feature for this device to support. The
implementation is slow can end up allocating quite a bit of memory. If
we were going to support it here, wouldn't it make more sense to tie it
to the filesystem's ability to support fallocate hole punch for the
backing namespace, and check if the range is allocated with SEEK_HOLE?
Then you don't even need to track persistent state, and we're actually
getting the genuine capability.

