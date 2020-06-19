Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A7F9C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 18:03:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB37A20DD4
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 18:03:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ig780zM2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB37A20DD4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmLMI-0003mT-4m
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 14:03:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43982)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jmLLT-0002cv-8A
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 14:02:31 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:38633
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jmLLR-0005Lq-Lh
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 14:02:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592589748;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AKeIfFNE0HwzUC8DmzElao8LCr+CqzCEqDwuX5vb91E=;
 b=Ig780zM2j/jAB73tvbWKp2tlJopSHQxSpU/LuZXUDJRiuY3vQzEI3a9pLqs4JJEe/WldiI
 t1thbhFJXr7TUohaXIyDkgJfvziRzy0z3E5tDTbGlyMeTqPIIE/60JwiOC/+INCM/CFipY
 ewLvVciSi/Y4uaUVhIuUgidxt1bmfas=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-19L9dxKjNWCHP-BxQWM5Fw-1; Fri, 19 Jun 2020 14:02:24 -0400
X-MC-Unique: 19L9dxKjNWCHP-BxQWM5Fw-1
Received: by mail-ot1-f71.google.com with SMTP id m5so4494602otp.18
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2020 11:02:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=AKeIfFNE0HwzUC8DmzElao8LCr+CqzCEqDwuX5vb91E=;
 b=OKGWpVaiDXH94LPe0Wk+iNZzp9gTzs8PldzsK3ujrDUwcCCeIC9q3ucfgm9zLowFD1
 rD8oTbzhmeddPPoHO+vIozLSEQrTHbvH9e8MwMF+P+eMJvoswxDkAZBw/K/KWjrCtN3J
 ic4poSAfGEP7crpbP52Ci3rxINM5jz4jJ7TH85EdgnEH3NPxUtZguaK6N40pTYRx/jgu
 DgxHPhejdjL31FfqX8wD9gd64xM9vzpIERhwkyRHopZYiLiCceG3IGTJL1Zg82rR8rhm
 In1c47R32yllhguBBdZYuzy2C9Uq/dDFJkYrOKe+p/caLLmyA3HzEbfiCGCzMFumzXa0
 RwtA==
X-Gm-Message-State: AOAM530ZZSm1NTWmuaAoycUSZ/TwbWUNEUvXH7MY1ZsqSE7D54HmQWn9
 5+DZwjqJh4P9MK7YGohRuYajNgtTEmX59CJAsLd19iZq4xa3EzeB5FBQ2Gh3u3PXSulw5bDsSyn
 +PIUhoR06CL0Uj+Ux9D9aWHyT38FyLlA=
X-Received: by 2002:a9d:5e4:: with SMTP id 91mr4388557otd.244.1592589743843;
 Fri, 19 Jun 2020 11:02:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwIIuaeorkkYHDgw0AzVHF2xH7pLvhJnwvz8ip+v+2NoX+UOqyF4pXhMBfmnvh9l7jOSoD+ppjKDClS264amU8=
X-Received: by 2002:a9d:5e4:: with SMTP id 91mr4388519otd.244.1592589743512;
 Fri, 19 Jun 2020 11:02:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200407043606.291546-1-david@gibson.dropbear.id.au>
 <20200407043606.291546-11-david@gibson.dropbear.id.au>
In-Reply-To: <20200407043606.291546-11-david@gibson.dropbear.id.au>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Fri, 19 Jun 2020 20:02:12 +0200
Message-ID: <CAP+75-UdJ9iT7T5ABETzdh38tLfM3ZB3OXtxc-WUu9zr93RYcA@mail.gmail.com>
Subject: Re: [PULL 10/10] ppc/pnv: Create BMC devices only when defaults are
 enabled
To: David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 01:50:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, QEMU Developers <qemu-devel@nongnu.org>,
 Greg Kurz <groug@kaod.org>, "open list:sPAPR" <qemu-ppc@nongnu.org>,
 Nathan Chancellor <natechancellor@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

On Tue, Apr 7, 2020 at 6:42 AM David Gibson <david@gibson.dropbear.id.au> w=
rote:
>
> From: C=C3=A9dric Le Goater <clg@kaod.org>
>
> Commit e2392d4395dd ("ppc/pnv: Create BMC devices at machine init")
> introduced default BMC devices which can be a problem when the same
> devices are defined on the command line with :
>
>   -device ipmi-bmc-sim,id=3Dbmc0 -device isa-ipmi-bt,bmc=3Dbmc0,irq=3D10
>
> QEMU fails with :
>
>   qemu-system-ppc64: error creating device tree: node: FDT_ERR_EXISTS
>
> Use defaults_enabled() when creating the default BMC devices to let
> the user provide its own BMC devices using '-nodefaults'. If no BMC
> device are provided, output a warning but let QEMU run as this is a
> supported configuration. However, when multiple BMC devices are
> defined, stop QEMU with a clear error as the results are unexpected.
>
> Fixes: e2392d4395dd ("ppc/pnv: Create BMC devices at machine init")
> Reported-by: Nathan Chancellor <natechancellor@gmail.com>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> Message-Id: <20200404153655.166834-1-clg@kaod.org>
> Tested-by: Nathan Chancellor <natechancellor@gmail.com>
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---

Not sure if directly related to this patch, but on gitlab-ci we get:

TEST check-qtest-ppc64: tests/qtest/m48t59-test
TEST check-qtest-ppc64: tests/qtest/device-plug-test
TEST check-qtest-ppc64: tests/qtest/pnv-xscom-test
TEST check-qtest-ppc64: tests/qtest/migration-test
TEST check-qtest-ppc64: tests/qtest/rtas-test
TEST check-qtest-ppc64: tests/qtest/usb-hcd-uhci-test
TEST check-qtest-ppc64: tests/qtest/usb-hcd-xhci-test
TEST check-qtest-ppc64: tests/qtest/test-filter-mirror
TEST check-qtest-ppc64: tests/qtest/test-filter-redirector
TEST check-qtest-ppc64: tests/qtest/display-vga-test
TEST check-qtest-ppc64: tests/qtest/numa-test
TEST check-qtest-ppc64: tests/qtest/ivshmem-test
TEST check-qtest-ppc64: tests/qtest/cpu-plug-test
TEST check-qtest-ppc64: tests/qtest/cdrom-test
TEST check-qtest-ppc64: tests/qtest/device-introspect-test
qemu-system-ppc64: warning: machine has no BMC device. Use '-device
ipmi-bmc-sim,id=3Dbmc0 -device isa-ipmi-bt,bmc=3Dbmc0,irq=3D10' to define
one
qemu-system-ppc64: warning: machine has no BMC device. Use '-device
ipmi-bmc-sim,id=3Dbmc0 -device isa-ipmi-bt,bmc=3Dbmc0,irq=3D10' to define
one
qemu-system-ppc64: warning: machine has no BMC device. Use '-device
ipmi-bmc-sim,id=3Dbmc0 -device isa-ipmi-bt,bmc=3Dbmc0,irq=3D10' to define
one

Since this is very confusing, can you adapt the test?

Thanks,

Phil.


