Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5281CC43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 13:50:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1ABD72077B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 13:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L35dLW/w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ABD72077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieftv-0006mP-7M
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 08:50:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44482)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1ieftA-00065V-9b
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 08:49:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1ieft8-0007jc-HZ
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 08:49:19 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:49660
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1ieft8-0007jB-ER
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 08:49:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575985757;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I64k/0k0WqHLXmozMKl6bFkRveg8+eAnwsRxOZOuy1o=;
 b=L35dLW/wFoshKygftk0jLhW8iEVTurqKxOKFB9fU5RzxaglW/mhJcrJEnUz/qCnzBL16MX
 2bzuniVjLXhcKsOhRMBRzLWwXc3vJuPqcrd4e5z2vnJz1ttjxQc56g95bC6KGpK2lTYr8K
 1bcwc2WAWjC0mtmOTYB5NqyrE8LJXwo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-mc-EPHbLP0i3DQouD872lQ-1; Tue, 10 Dec 2019 08:49:14 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 95FB112D658B;
 Tue, 10 Dec 2019 13:49:12 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3ADD710016E8;
 Tue, 10 Dec 2019 13:49:08 +0000 (UTC)
Date: Tue, 10 Dec 2019 14:49:06 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v6 0/2] arm/acpi: simplify aml code and enable SHPC
Message-ID: <20191210144906.14e41c7a@redhat.com>
In-Reply-To: <CAFEAcA_cP1pW=WC=0M7S37TRi_4uwaA_kQRTJ_xRkqbq48eLTg@mail.gmail.com>
References: <20191209063719.23086-1-guoheyi@huawei.com>
 <CAFEAcA_cP1pW=WC=0M7S37TRi_4uwaA_kQRTJ_xRkqbq48eLTg@mail.gmail.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: mc-EPHbLP0i3DQouD872lQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Heyi Guo <guoheyi@huawei.com>, wanghaibin.wang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 9 Dec 2019 17:51:10 +0000
Peter Maydell <peter.maydell@linaro.org> wrote:

> On Mon, 9 Dec 2019 at 06:38, Heyi Guo <guoheyi@huawei.com> wrote:
> >
> > After the introduction of generic PCIe root port and PCIe-PCI bridge, we will
> > also have SHPC controller on ARM, and we don't support ACPI hot plug, so just
> > enable SHPC native hot plug.
> >
> > Igor also spotted the store operation outside of bit and/or is not necessary, so
> > simply the code at first.
> >
> > v6:
> > - Fix "make check" errors by updating tests/data/acpi/virt/DSDT*.
> >
> > v5:
> > - Refine commit message of patch 1/2
> >
> > v4:
> > - Improve the code indention.
> >
> > Cc: Shannon Zhao <shannon.zhaosl@gmail.com>
> > Cc: Peter Maydell <peter.maydell@linaro.org>
> > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > Cc: Igor Mammedov <imammedo@redhat.com>  
> 
> Thanks, applied to target-arm.next. (it's a bit awkward that acpi
> table updates require also updating a bunch of binary test files,
> but I suppose trying to make the golden-reference be some textual
> format would be not very feasible.)

Michael tried document it (commit 30c63d4fbd69)
so that binary blobs would not be required (trusted).

Problem is usually in blobs being un-review-able and
unresolvable merge conflicts, that's why Michael
updates tables manually for all changes in pull req.

But in this case it touches only ARM tables and it's
the first change to go in, so it could just work out.


> 
> thanks
> -- PMM
> 


