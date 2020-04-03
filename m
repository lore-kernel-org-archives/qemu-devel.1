Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E2DAC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 14:07:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA37D206E9
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 14:07:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h+XnnZjO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA37D206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKMyh-0005cp-0t
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 10:07:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38824)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jKMxr-0004QO-2K
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 10:06:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jKMxo-0003pf-H9
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 10:06:30 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:39899)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jKMxo-0003pB-6i
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 10:06:28 -0400
Received: by mail-ot1-x344.google.com with SMTP id x11so7343028otp.6
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2020 07:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=bk5wp0lHQALw4uwxKLLIqPkZJ0tw2SNSYsidXYkaNUE=;
 b=h+XnnZjOz/T7t4SP1SYbiEXF5VjFSX0HpcAjidOAFZRMSFDx9NPSRvQEDmelJulzez
 OwBklwSCFpfJUCnYISEs1nLOAGObgxThevJ1UnYCx/T8R7RCoXxDIgXIArLJ7VELul45
 Yvghf4lyMywc2zMzue9ElzfRPFXGsxNjPbFuf0NmG0kIceTuX0P0ybKmaOWFxSic2qeW
 kRixy6vOMokSel36GtYhwqPBq/DBjMhBLSD2xiwj+JenSf2kEHLWO2qkbmhhZB96FdXe
 Jeb1lgKVHnBB0Vp8GTS1IJegDzuT3Lj3JZSnlK9fx6GkPZ8tAgV5VFW9imAzVZtSxUjd
 qFWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bk5wp0lHQALw4uwxKLLIqPkZJ0tw2SNSYsidXYkaNUE=;
 b=FCNrG5LBxUSdKsS8jndzXPBgrEndlj6Ku9C4hg4uQ5Y4QKjohBxvCT2PUkXJLVonV2
 LeuKXl8xei9W/xIXxDgbRCFj+0VmWRnY9yj7flTNijKVuwz4xINNbBsem7ygpJ3bqVdE
 YLXK2flN2NAz9s/5ey+EWlR5JPWj9oucLDp8hKiSsx+ZDdA+8UvNsoKWwwvZq5+lg3W1
 7WwZV0yPM01oxMuoeMY5rKrmPira8ATtSg9imcGGZaHtghM8ujsSo4b5pc9okjc9xiZc
 MOrc9qvqF1tC9MfYuNMfDEnF2W0+JWUFmjtOcIRZm3PN9u6hjg4qlqe9HCLQQkBAVaTw
 gwxg==
X-Gm-Message-State: AGi0PuZl5v272IQvbrhrc9iIN7o6Z/t1FHaiU0viI49GMXAxin+zyvrr
 8DCYEUz+oRXtlcsnl51gRNOazvgf9zcxLeRwwQFtgw==
X-Google-Smtp-Source: APiQypJKEPQnJCs3bUfO44OperDhUW8imUnjcIirM8EUfqXmgQHTBGa62DEYd1NzjPLbKB6jzIvDu7gU+Qgxd12T6Ro=
X-Received: by 2002:a9d:1920:: with SMTP id j32mr6156212ota.221.1585922785949; 
 Fri, 03 Apr 2020 07:06:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200403140018.13531-1-imammedo@redhat.com>
In-Reply-To: <20200403140018.13531-1-imammedo@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Apr 2020 15:06:14 +0100
Message-ID: <CAFEAcA_cyK+1+BjYqVB+nu70jiShx861NM=W0ezp_8g5eV6qcw@mail.gmail.com>
Subject: Re: [PATCH] nvdimm-utils: clean up headers and add license comment
To: Igor Mammedov <imammedo@redhat.com>
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Shivaprasad G Bhat <sbhat@linux.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Greg Kurz <groug@kaod.org>, QEMU Developers <qemu-devel@nongnu.org>,
 qemu-ppc <qemu-ppc@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 3 Apr 2020 at 15:00, Igor Mammedov <imammedo@redhat.com> wrote:
>
> Fixes: 3f350f6bb36233be50fc2bc18dc78b6a948a5dbe
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  include/qemu/nvdimm-utils.h |  2 --
>  util/nvdimm-utils.c         | 29 +++++++++++++++++++++++++++++
>  2 files changed, 29 insertions(+), 2 deletions(-)
>
> diff --git a/include/qemu/nvdimm-utils.h b/include/qemu/nvdimm-utils.h
> index 4b8b198ba7..1f1dae477f 100644
> --- a/include/qemu/nvdimm-utils.h
> +++ b/include/qemu/nvdimm-utils.h
> @@ -1,7 +1,5 @@
>  #ifndef NVDIMM_UTILS_H
>  #define NVDIMM_UTILS_H
>

.h file still missing the copyright-n-license comment ?

> -#include "qemu/osdep.h"
> -
>  GSList *nvdimm_get_device_list(void);
>  #endif
> diff --git a/util/nvdimm-utils.c b/util/nvdimm-utils.c
> index 5cc768ca47..ca41d39af5 100644
> --- a/util/nvdimm-utils.c
> +++ b/util/nvdimm-utils.c
> @@ -1,3 +1,32 @@
> +/*
> + * NVDIMM utilities
> + *
> + * Copyright(C) 2015 Intel Corporation.
> + *
> + * Author:
> + *  Xiao Guangrong <guangrong.xiao@linux.intel.com>
> + *
> + * NFIT is defined in ACPI 6.0: 5.2.25 NVDIMM Firmware Interface Table (NFIT)
> + * and the DSM specification can be found at:
> + *       http://pmem.io/documents/NVDIMM_DSM_Interface_Example.pdf
> + *
> + * Currently, it only supports PMEM Virtualization.
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2 of the License, or (at your option) any later version.

I guess you copied this from somewhere else, but commit b7cbb8741b40b7c
suggests that "Lesser General Public License version 2" is
wrong and it should either be "Library General Public License
version 2" or "Lesser General Public License version 2.1"...we
might as well get it right when we're adding a new file, so
I would suggest you want 2.1 here.

> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, see <http://www.gnu.org/licenses/>
> + */
> +
> +#include "qemu/osdep.h"
>  #include "qemu/nvdimm-utils.h"
>  #include "hw/mem/nvdimm.h"
>
> --
> 2.18.1
>


thanks
-- PMM

