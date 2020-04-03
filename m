Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF668C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 12:34:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 897F120721
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 12:34:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bne1DSnc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 897F120721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKLXB-0000jH-Ov
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 08:34:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53960)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jKLWZ-0008S6-Fr
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 08:34:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jKLWY-0001hO-8P
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 08:34:15 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:34845)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jKLWY-0001h4-0D
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 08:34:14 -0400
Received: by mail-oi1-x241.google.com with SMTP id t25so5932435oij.2
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2020 05:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tZ+X2OIcC6KEtw5Q6TOnkoXU3YI4F8I/hN0Gn18aQz4=;
 b=Bne1DSncOmWU35pqDoUT3Nv4pDZVVtJmXO3EDqN4jEya9oSxnxTC1+TZMpFgC9poVY
 Fei0clXPEFP8HXyk0YErmpTQ3bKknrAedZ2y25vhVD33mJEKgbqRBgVA4cPDbSg7pkkK
 hhaNGzxkCGglWPNR3zQ6XykhkQBI+A850eQKzRZYtM6S1vf5uUzwLTVSoC6zrSzOLuus
 xZ5CiE3jLUPN2Me7ebAq0VYJTdX1PavPfPtn/5ENfDZMVB5jyjgTPCGVWsSSarXTqt+V
 Yhz1+AFIuHTFupzevIFNj8lkUX5A8aI7MlToVdAsJq8hIlnuDs4ps+dLHymOrkckgjVW
 AF9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tZ+X2OIcC6KEtw5Q6TOnkoXU3YI4F8I/hN0Gn18aQz4=;
 b=cn66Y/0OhOE/JsnC30Jim61my4QZEB0W63zhTsqoIMal52u9A3vXwKGdoypX6bCdP8
 DIfP+FDV5G65A5oSgiIiRZrzGSUzO+lIVnZgrRLu2W9p5yiCGRRMn2gPYwFyJ3Xyf0ho
 JfQUEPokazfWZueU2TeiBzOcIfRIdMX/wjKCTbY5yoMadXwW+EWyQTHs0PNYpB1V5pK6
 Iq0GKSQC34wuJ/0JgUYtOG8n5emCkcI95NZKmlfkFQE01XkP2szdFbXk9wZpf54y+LH5
 wNckRhdjITtouAzfVuRvrVUol7jv8JHDB5fHI5zgIc5ueMWWKEZslC13Huvwl3jiGngk
 HA7w==
X-Gm-Message-State: AGi0PuYmm6BsrBkFUCwQiRGWDVdhkBzQZ+XyFg57F1VtHMm3TsPTS01D
 UuGPjwHUctJ9T1YU2hr/2txFM/qAp0eZ6LKzpWMQ4w==
X-Google-Smtp-Source: APiQypKpdw38F1KxoKFbpQJLnIjYH8qzn1tJU2SAyWZYJaKkNm9D7/1pGIleMC1tqbVJ4Pf3VbJP13DF3YFMU4wnQO8=
X-Received: by 2002:aca:3049:: with SMTP id w70mr861442oiw.146.1585917252814; 
 Fri, 03 Apr 2020 05:34:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200221033650.444386-1-david@gibson.dropbear.id.au>
 <20200221033650.444386-6-david@gibson.dropbear.id.au>
In-Reply-To: <20200221033650.444386-6-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Apr 2020 13:34:01 +0100
Message-ID: <CAFEAcA_oqU7_NKTnZ+wNa-DAfMhmpgFrPmWx4gdZaiJJiXj23w@mail.gmail.com>
Subject: Re: [PULL 05/20] mem: move nvdimm_device_list to utilities
To: David Gibson <david@gibson.dropbear.id.au>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
 QEMU Developers <qemu-devel@nongnu.org>, Greg Kurz <groug@kaod.org>,
 qemu-ppc <qemu-ppc@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 21 Feb 2020 at 03:37, David Gibson <david@gibson.dropbear.id.au> wrote:
>
> From: Shivaprasad G Bhat <sbhat@linux.ibm.com>
>
> nvdimm_device_list is required for parsing the list for devices
> in subsequent patches. Move it to common utility area.
>
> Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> Message-Id: <158131055857.2897.15658377276504711773.stgit@lep8c.aus.stglabs.ibm.com>
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  hw/acpi/nvdimm.c            | 28 +---------------------------
>  include/qemu/nvdimm-utils.h |  7 +++++++
>  util/Makefile.objs          |  1 +
>  util/nvdimm-utils.c         | 29 +++++++++++++++++++++++++++++
>  4 files changed, 38 insertions(+), 27 deletions(-)
>  create mode 100644 include/qemu/nvdimm-utils.h
>  create mode 100644 util/nvdimm-utils.c

Hi; I just found this commit as a result of running
a clean-includes pass on the tree...

> diff --git a/include/qemu/nvdimm-utils.h b/include/qemu/nvdimm-utils.h
> new file mode 100644
> index 0000000000..4b8b198ba7
> --- /dev/null
> +++ b/include/qemu/nvdimm-utils.h
> @@ -0,0 +1,7 @@
> +#ifndef NVDIMM_UTILS_H
> +#define NVDIMM_UTILS_H
> +
> +#include "qemu/osdep.h"

New files should have a comment block at the top giving
author/copyright/license info.

Header files should never include osdep.h.

> +
> +GSList *nvdimm_get_device_list(void);
> +#endif

> diff --git a/util/nvdimm-utils.c b/util/nvdimm-utils.c
> new file mode 100644
> index 0000000000..5cc768ca47
> --- /dev/null
> +++ b/util/nvdimm-utils.c
> @@ -0,0 +1,29 @@
> +#include "qemu/nvdimm-utils.h"
> +#include "hw/mem/nvdimm.h"

New .c files definitely need a license/copyright
comment block.

All .c files must include "qemu/osdep.h" as the
very first include.

Would somebody like to send a patch fixing this, please?

> +
> +static int nvdimm_device_list(Object *obj, void *opaque)
> +{
> +    GSList **list = opaque;
> +
> +    if (object_dynamic_cast(obj, TYPE_NVDIMM)) {
> +        *list = g_slist_append(*list, DEVICE(obj));
> +    }
> +
> +    object_child_foreach(obj, nvdimm_device_list, opaque);
> +    return 0;
> +}

thanks
-- PMM

