Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B381ECE588
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 15:10:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E25FC20650
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 15:10:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NYclxQmT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E25FC20650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKOTF-0000Pg-Oq
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 11:10:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44462)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iKORA-0006yY-Qf
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 11:08:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iKOR7-0005xs-ET
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 11:08:35 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:42679)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iKOR7-0005xe-7n
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 11:08:33 -0400
Received: by mail-ot1-x344.google.com with SMTP id c10so17222417otd.9
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2019 08:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=MzYo/CIcGV3aU6Kf1OQCSICiwmWdTBweMCA+KcylprU=;
 b=NYclxQmTl1IyDoZqqXfMdmVihjwEkpPVJw+gY/ha8app0F850AxAqAFEFB2Q0HkAoT
 4xdsNeoHL8NToAr3OUHXENRbXmvmuTKozC1dRXHLI3galc1LeXmavfHM6YqUoXqj1VGy
 F08vnxs2vfLOzJQuea82ynGOCSJfrK0OXQ8Ywd0omOSy0kie6f2lvE20hFC0WuRR7wyI
 1bghDEh2897zChqA5MH81TvbFsa2eW6bvJJt83MUS3ebjYx1HOg3ShOkvqOLEPo2YNrl
 CDgNlh01JXX5CnwgHG0OL6ngGEL/sco+pfH4xvAB7DdzOXfG+2i/myJD/wKTDgV0d88C
 YH/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MzYo/CIcGV3aU6Kf1OQCSICiwmWdTBweMCA+KcylprU=;
 b=DYE1DSwSS9n6GNTez0ZPwimEnfKY0VaahxXIviHMQdB8OMxbCtrrf8sE9f+JU+icLm
 JSbOKr6euUQJ6U31wv2CIWPKfSLvQtWIw91zE+dOOGbUL3yLknai4lnN1zBlwjXDDWnT
 88he1jz4NWiGIRK6LmAIZkkkfc21TbhY/I6WxmKjLUnHMDNH4vEFm3ixQ6WOGnEcSGpA
 ZuGxUag96yFOuXF00CNv1CwF2SJYz5zJBvUIRjRTJ8xFyfJFzs4a82u8Sm/4iZaFc0sA
 5Ff15aFnfi0oNiHWYAF4i0RZpLjLG+BHm6aijs/Qbl7Jl7bRyCFIT6u29AYDg2RUwfnH
 CaIg==
X-Gm-Message-State: APjAAAU46s1UBOhPwoV4VYz838J+tqr+UB5R0sjuluXp/vY5SFvKhdLe
 9A2pFQFOl0gcOOncL4sHL7jLUz91oM/3/mvljdndKQ==
X-Google-Smtp-Source: APXvYqwMw8LqqyVcS5Jthlks2YJacOieatWyOomMlayWCEnto6yDAIpFp6+NmpvSMUs8yHlDHhYG8Cxp/2/m2OnKFto=
X-Received: by 2002:a05:6830:ca:: with SMTP id
 x10mr2434112oto.221.1571152112080; 
 Tue, 15 Oct 2019 08:08:32 -0700 (PDT)
MIME-Version: 1.0
References: <20191015140140.34748-1-zhengxiang9@huawei.com>
 <20191015140140.34748-3-zhengxiang9@huawei.com>
In-Reply-To: <20191015140140.34748-3-zhengxiang9@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 15 Oct 2019 16:08:20 +0100
Message-ID: <CAFEAcA85gZUXnL+Qy=Wdg-MVbb1PqiKWCi72XvRnX8pZsgVr_A@mail.gmail.com>
Subject: Re: [PATCH v19 2/5] docs: APEI GHES generation and CPER record
 description
To: Xiang Zheng <zhengxiang9@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, kvm-devel <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, wanghaibin.wang@huawei.com,
 Marcelo Tosatti <mtosatti@redhat.com>, Linuxarm <linuxarm@huawei.com>,
 QEMU Developers <qemu-devel@nongnu.org>, gengdongjiu <gengdongjiu@huawei.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 James Morse <james.morse@arm.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "xuwei \(O\)" <xuwei5@huawei.com>, Laszlo Ersek <lersek@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 15 Oct 2019 at 15:02, Xiang Zheng <zhengxiang9@huawei.com> wrote:
>
> From: Dongjiu Geng <gengdongjiu@huawei.com>
>
> Add APEI/GHES detailed design document
>
> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
> Signed-off-by: Xiang Zheng <zhengxiang9@huawei.com>
> ---
>  docs/specs/acpi_hest_ghes.rst | 94 +++++++++++++++++++++++++++++++++++++++++++
>  docs/specs/index.rst          |  1 +
>  2 files changed, 95 insertions(+)
>  create mode 100644 docs/specs/acpi_hest_ghes.rst
>
> diff --git a/docs/specs/acpi_hest_ghes.rst b/docs/specs/acpi_hest_ghes.rst
> new file mode 100644
> index 0000000..905b6d1
> --- /dev/null
> +++ b/docs/specs/acpi_hest_ghes.rst
> @@ -0,0 +1,94 @@
> +APEI tables generating and CPER record
> +======================================
> +
> +Copyright (c) 2019 HUAWEI TECHNOLOGIES CO., LTD.
> +
> +This work is licensed under the terms of the GNU GPL, version 2 or later.
> +See the COPYING file in the top-level directory.

This puts the copyright/license statement into the HTML rendered
docs seen by the user. We generally put them into an RST comment,
so they're in the source .rst but not the rendered views, like this:

diff --git a/docs/specs/acpi_hest_ghes.rst b/docs/specs/acpi_hest_ghes.rst
index 5b43e4b0da2..348825f9d3e 100644
--- a/docs/specs/acpi_hest_ghes.rst
+++ b/docs/specs/acpi_hest_ghes.rst
@@ -1,10 +1,11 @@
 APEI tables generating and CPER record
 ======================================

-Copyright (c) 2019 HUAWEI TECHNOLOGIES CO., LTD.
+..
+   Copyright (c) 2019 HUAWEI TECHNOLOGIES CO., LTD.

-This work is licensed under the terms of the GNU GPL, version 2 or later.
-See the COPYING file in the top-level directory.
+   This work is licensed under the terms of the GNU GPL, version 2 or later.
+   See the COPYING file in the top-level directory.


> +(9) When QEMU gets a SIGBUS from the kernel, QEMU formats the CPER right into
> +    guest memory, and then injects platform specific interrupt (in case of
> +    arm/virt machine it's Synchronous External Abort) as a notification which
> +    is necessary for notifying the guest.
> +
> +(10) This notification (in virtual hardware) will be handled by the guest
> +    kernel, guest APEI driver will read the CPER which is recorded by QEMU and
> +    do the recovery.

Sphinx thinks the indentation here is not syntactically valid:

  SPHINX  docs/specs

Warning, treated as error:
/home/petmay01/linaro/qemu-from-laptop/qemu/docs/specs/acpi_hest_ghes.rst:93:Enumerated
list ends without a blank line; unexpected unindent.
Makefile:997: recipe for target 'docs/specs/index.html' failed

That's because for an enumerated list all the lines in the paragraph need to
start at the same column. Moving in the two following lines in the (10) item
fixes this:

--- a/docs/specs/acpi_hest_ghes.rst
+++ b/docs/specs/acpi_hest_ghes.rst
@@ -90,5 +90,5 @@ Design Details
     is necessary for notifying the guest.

 (10) This notification (in virtual hardware) will be handled by the guest
-    kernel, guest APEI driver will read the CPER which is recorded by QEMU and
-    do the recovery.
+     kernel, guest APEI driver will read the CPER which is recorded by QEMU and
+     do the recovery.

thanks
-- PMM

