Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED2EEC49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 15:04:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE76720CC7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 15:04:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="JCTd25jr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE76720CC7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8n7E-0001rE-S7
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 11:04:04 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49039)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <anthony.perard@citrix.com>) id 1i8n62-0000tT-NU
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 11:02:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <anthony.perard@citrix.com>) id 1i8n5v-0006S9-QC
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 11:02:48 -0400
Received: from esa1.hc3370-68.iphmx.com ([216.71.145.142]:11106)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <anthony.perard@citrix.com>)
 id 1i8n5v-0006Lg-FS
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 11:02:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1568386964;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=D7NHSI1IPTU8qAwQOP90BTdp0BYdzaeJmlcOE5HcqAA=;
 b=JCTd25jrXwJLaZ0JNjM3VSqs6FP8mve5XrL13BRE156iw1z5u8xaRh7r
 x8oFF6gs+O8dGgJbgv3zdmH/Rtz+Whqm0YNEL/EsjbrHQrbqlzgCoWj3q
 4bnJPDOv763YAltV+0+5lFxHbHvhx1EZPQiF7iDT1woPRNYeP1GUOz58w k=;
Authentication-Results: esa1.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none;
 spf=None smtp.pra=anthony.perard@citrix.com;
 spf=Pass smtp.mailfrom=anthony.perard@citrix.com;
 spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa1.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 anthony.perard@citrix.com) identity=pra;
 client-ip=162.221.158.21; receiver=esa1.hc3370-68.iphmx.com;
 envelope-from="anthony.perard@citrix.com";
 x-sender="anthony.perard@citrix.com";
 x-conformance=sidf_compatible
Received-SPF: Pass (esa1.hc3370-68.iphmx.com: domain of
 anthony.perard@citrix.com designates 162.221.158.21 as
 permitted sender) identity=mailfrom;
 client-ip=162.221.158.21; receiver=esa1.hc3370-68.iphmx.com;
 envelope-from="anthony.perard@citrix.com";
 x-sender="anthony.perard@citrix.com";
 x-conformance=sidf_compatible; x-record-type="v=spf1";
 x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
 ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
 ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
 ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83 ~all"
Received-SPF: None (esa1.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 postmaster@mail.citrix.com) identity=helo;
 client-ip=162.221.158.21; receiver=esa1.hc3370-68.iphmx.com;
 envelope-from="anthony.perard@citrix.com";
 x-sender="postmaster@mail.citrix.com";
 x-conformance=sidf_compatible
IronPort-SDR: Ga6+09I/Q8OAwGKPoVEKbLZSjBv/ZPfc22eHZKt4vaH7rswCc9RdT3QwZNCTfE3V1Qq0bjodkR
 SCGtN0mehYFi5J3CCu6iWRxfOgSE9jk/Yt14yG+1vnAXsKrj9Bgo82eXHQbevYvIVnJB/XRC4o
 uvGjym3/9trJcOGoOvr8uTDkWwcO4QgzOmR81NrlnetXRNKn+1zBPTg3qBPv6rBUaVwh7cis9l
 1Fzs7OhKSM4Qi36n4OJ89NSQS3GwnM6Kg5xY0B/3Zx+TD3wh4nKMnmjaQw3JMSIprYSAYcwSbG
 dwA=
X-SBRS: 2.7
X-MesageID: 5596001
X-Ironport-Server: esa1.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.64,501,1559534400"; 
   d="scan'208";a="5596001"
Date: Fri, 13 Sep 2019 16:02:36 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
To: Paul Durrant <paul.durrant@citrix.com>, Paul Durrant <paul@xen.org>
Message-ID: <20190913150236.GE1308@perard.uk.xensource.com>
References: <20190913122418.848-1-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190913122418.848-1-paul.durrant@citrix.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.145.142
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: update my email address
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
Cc: Stefano Stabellini <sstabellini@kernel.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 13, 2019 at 01:24:18PM +0100, Paul Durrant wrote:
> My Citrix email address will expire shortly.
> 
> Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
> ---
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 50eaf005f4..3cabb9e449 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -406,7 +406,7 @@ Guest CPU Cores (Xen)
>  X86 Xen CPUs
>  M: Stefano Stabellini <sstabellini@kernel.org>
>  M: Anthony Perard <anthony.perard@citrix.com>
> -M: Paul Durrant <paul.durrant@citrix.com>
> +M: Paul Durrant <paul@xen.org>

Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>

-- 
Anthony PERARD

