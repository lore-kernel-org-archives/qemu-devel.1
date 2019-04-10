Return-Path: <SRS0=gZkW=SM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	URI_NOVOWEL,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B647C10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 15:53:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 089EB20830
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 15:53:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 089EB20830
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33685 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEFXM-00063o-Am
	for qemu-devel@archiver.kernel.org; Wed, 10 Apr 2019 11:53:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37326)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=9966e4c82=anthony.perard@citrix.com>)
	id 1hEFWW-0005ee-L8
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 11:52:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=9966e4c82=anthony.perard@citrix.com>)
	id 1hEFWV-0002mI-Hw
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 11:52:28 -0400
Received: from smtp03.citrix.com ([162.221.156.55]:1482)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <prvs=9966e4c82=anthony.perard@citrix.com>)
	id 1hEFWS-0002hI-HI; Wed, 10 Apr 2019 11:52:24 -0400
X-IronPort-AV: E=Sophos;i="5.60,332,1549929600"; d="scan'208";a="83242875"
Date: Wed, 10 Apr 2019 16:52:17 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
To: Paul Durrant <paul.durrant@citrix.com>
Message-ID: <20190410155217.GH1435@perard.uk.xensource.com>
References: <20190409164038.25484-1-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190409164038.25484-1-paul.durrant@citrix.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 162.221.156.55
Subject: Re: [Qemu-devel] [PATCH] xen-block: support
 feature-large-sector-size
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
Message-ID: <20190410155217.Md5qIruwR6SmRWDQ_6RWh8Bg0_EvXhXmwrq2YrAclWk@z>

On Tue, Apr 09, 2019 at 05:40:38PM +0100, Paul Durrant wrote:
> A recent Xen commit [1] clarified the semantics of sector based quantities
> used in the blkif protocol such that it is now safe to create a xen-block
> device with a logical_block_size != 512, as long as the device only
> connects to a frontend advertizing 'feature-large-block-size'.
> 
> This patch modifies xen-block accordingly. It also uses a stack variable
> for the BlockBackend in xen_block_realize() to avoid repeated dereferencing
> of the BlockConf pointer, and changes the parameters of
> xen_block_dataplane_create() so that the BlockBackend pointer and sector
> size are passed expicitly rather than implicitly via the BlockConf.
> 
> These modifications have been tested against a recent Windows PV XENVBD
> driver [2] using a xen-disk device with a 4kB logical block size.
> 
> [1] http://xenbits.xen.org/gitweb/?p=xen.git;a=commit;h=67e1c050e36b2c9900cca83618e56189effbad98
> [2] https://winpvdrvbuild.xenproject.org:8080/job/XENVBD-master/126
> 
> Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
> ---
> diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
> index ef635be4c2..05e890ad78 100644
> --- a/hw/block/xen-block.c
> +++ b/hw/block/xen-block.c
> @@ -51,11 +51,25 @@ static void xen_block_connect(XenDevice *xendev, Error **errp)
[...]
> +    if (xen_device_frontend_scanf(xendev, "feature-large-sector-size", "%u",
> +                                  &feature_large_sector_size) != 1) {
> +        feature_large_sector_size = 0;
> +    }
> +
> +    if (feature_large_sector_size != 1 &&
> +        conf->logical_block_size != XEN_BLKIF_SECTOR_SIZE) {
> +        error_setg(errp, "logical_block_size != %u not supported",

Maybe add "by frontend" to the error message?

> +                   XEN_BLKIF_SECTOR_SIZE);
> +        return;
> +    }
> +

With the question answered:
Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>

Thanks,

-- 
Anthony PERARD

