Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6042C35247
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 16:48:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1F5B2082E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 16:48:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="czHkafhV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1F5B2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iz1Mz-000093-Mi
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 11:48:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37639)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kbusch@kernel.org>) id 1iz1M8-0007sJ-1t
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 11:47:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kbusch@kernel.org>) id 1iz1M7-0005zI-3S
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 11:47:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:46918)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kbusch@kernel.org>)
 id 1iz1M5-0005vt-6t; Tue, 04 Feb 2020 11:47:17 -0500
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 53EDE2082E;
 Tue,  4 Feb 2020 16:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1580834836;
 bh=AO0XGtp+ikbBRrq9ANZpKyH9WiNuMdPRu5lSCWSF6bg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=czHkafhVrhvH/ODbR/+P9RJgUiVL/p8A/X5MH8DBZ4SGjP+qbaRb11kfJvJ18UDLh
 l+s7Mw/AAgSRG1zTkP9zUfflJh0kRiRZwBiFzi5qFFgdFXIBHckTFw5wkhkM4Q9DIe
 aLChxHQjzbb4nVPp3csMyS2ZHabFeXDyXhD5V5hY=
Date: Wed, 5 Feb 2020 01:47:10 +0900
From: Keith Busch <kbusch@kernel.org>
To: Klaus Jensen <k.jensen@samsung.com>
Subject: Re: [PATCH v5 00/26] nvme: support NVMe v1.3d, SGLs and multiple
 namespaces
Message-ID: <20200204164710.GD6823@redsun51.ssa.fujisawa.hgst.com>
References: <CGME20200204095215eucas1p1bb0d5a3c183f7531d8b0e5e081f1ae6b@eucas1p1.samsung.com>
 <20200204095208.269131-1-k.jensen@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200204095208.269131-1-k.jensen@samsung.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 198.145.29.99
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
Cc: Kevin Wolf <kwolf@redhat.com>, Beata Michalska <beata.michalska@linaro.org>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>, Javier Gonzalez <javier.gonz@samsung.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Feb 04, 2020 at 10:51:42AM +0100, Klaus Jensen wrote:
> Hi,
> 
> 
> Changes since v4
>  - Changed vendor and device id to use a Red Hat allocated one. For
>    backwards compatibility add the 'x-use-intel-id' nvme device
>    parameter. This is off by default but is added as a machine compat
>    property to be true for machine types <= 4.2.
> 
>  - SGL mapping code has been refactored.

Looking pretty good to me. For the series beyond the individually
reviewed patches:

Acked-by: Keith Busch <kbusch@kernel.org>

If you need to send a v5, you may add my tag to the patches that are not
substaintially modified if you like.

