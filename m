Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C17C3B196
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 11:48:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2282A217F4
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 11:48:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RYF/L3+d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2282A217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2ZSM-0002pf-Cc
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 06:48:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55354)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pmathieu@redhat.com>) id 1j2ZRj-00025l-1p
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 06:47:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pmathieu@redhat.com>) id 1j2ZRi-00026L-1h
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 06:47:46 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:52989
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pmathieu@redhat.com>) id 1j2ZRh-00025H-UJ
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 06:47:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581680865;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fLOxRe0I6SCms20R3U9apOHY9n2qwA1dE4HzvsH5SxM=;
 b=RYF/L3+dDC29LG8FHjpY2eKwKndVFcBX6DHFFt2U9Umom3KI+OcPWWR2nWt1Wus8EWwIyC
 BHEN8hl4CchWj1tn12ocdYsUePq8GJve7YGRUa3dGX3tisU5Uc5tBiEq9AcrQvmaSzImNe
 R2VG+ukvYUZMpihN8wWBldQf22hl2m0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-n54UcT-LMKS8DYTpWmurnw-1; Fri, 14 Feb 2020 06:47:43 -0500
Received: by mail-wr1-f69.google.com with SMTP id m15so3841579wrs.22
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 03:47:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DF2Wf7J9ZEvKMseW8iZryRqj56Ob0/0+2kuiAO3pit0=;
 b=fJ/tiuUwoEoPi7kxLtNbhqSb+JN+ILXtjxI0oTZ6yMJa6DwARAHZDqiwDCivbvFP6m
 D6j3VVrJyS2Eg7p2PsQS5Bfq4yGlEY5dBi85K/pafNbUrzlKVJGx+G1S4VkJsUKXftau
 lXAOvr8/IkMhhG88ZoTDmh3Xx9KnAGy06o1wRjwTY6SGu+BO6ZTx+B3UQKVPmdwUHQ+x
 x+ushDH1rBSXmRVvq+rkN6t6IFf6TjUTo+rrJDxU4m4cNLN0YF+0rVoqJPyY5nxDKlpC
 sGSLONCRNg0hMZc+c7aetPkpDXwc5NF3x/EBAVkmvkaVamdGwDtgalx41LbfwzVXR2cL
 rqcw==
X-Gm-Message-State: APjAAAWQZUl3dWbVLjmo3tS1nn+xEsg/pvju3UX5VkZ5b6iPS5je643A
 lqz5OqMaCYr6bLHjscjQ/y8fbH/zhkvpT7MiBqzCiRzRav3IxhaBkE21TrgTo96UW8gbUCsxgEs
 l6afZpd/8MS+r7DIVikdKNqZiDapufNE=
X-Received: by 2002:a1c:541b:: with SMTP id i27mr4567883wmb.137.1581680862169; 
 Fri, 14 Feb 2020 03:47:42 -0800 (PST)
X-Google-Smtp-Source: APXvYqyk/7qk9RSbTMFPAjrXSUJt3rCp0VnXKfdzycO6drzFLKYvTVlAc2jdruJl8mB+qMKlH454PnR6kguPAKmvzHM=
X-Received: by 2002:a1c:541b:: with SMTP id i27mr4567869wmb.137.1581680861910; 
 Fri, 14 Feb 2020 03:47:41 -0800 (PST)
MIME-Version: 1.0
References: <20200214084607.20471-1-mark.cave-ayland@ilande.co.uk>
 <20200214084607.20471-2-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20200214084607.20471-2-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Fri, 14 Feb 2020 12:47:30 +0100
Message-ID: <CAP+75-X1pbKfG8+17Zif-ZsQNbFk34_AzVWy=U_Hr+Rz7=pgOA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dp264: use pci_create() to initialise the cmd646
 device
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
X-MC-Unique: n54UcT-LMKS8DYTpWmurnw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: John Snow <jsnow@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Mark,

On Fri, Feb 14, 2020 at 9:48 AM Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
>
> Remove the call to pci_cmd646_ide_init() since global device init functio=
ns
> are deprecated in preference of using qdev directly.
>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/alpha/dp264.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
> index a8f9a89cc4..e91989bf9a 100644
> --- a/hw/alpha/dp264.c
> +++ b/hw/alpha/dp264.c
> @@ -16,6 +16,7 @@
>  #include "sysemu/sysemu.h"
>  #include "hw/rtc/mc146818rtc.h"
>  #include "hw/ide.h"
> +#include "hw/ide/pci.h"
>  #include "hw/timer/i8254.h"
>  #include "hw/isa/superio.h"
>  #include "hw/dma/i8257.h"
> @@ -100,9 +101,14 @@ static void clipper_init(MachineState *machine)
>      /* IDE disk setup.  */
>      {
>          DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
> +        PCIDevice *pci_dev;
> +
>          ide_drive_get(hd, ARRAY_SIZE(hd));
>
> -        pci_cmd646_ide_init(pci_bus, hd, 0);
> +        pci_dev =3D pci_create(pci_bus, -1, "cmd646-ide");

Not this patch problem, but it would be nice to have a TYPE_CMD646_IDE.

> +        qdev_prop_set_uint32(DEVICE(pci_dev), "secondary", 0);

Secondary_ide disabled is the default in cmd646_ide_properties[], can
we avoid this call?

> +        qdev_init_nofail(DEVICE(pci_dev));
> +        pci_ide_create_devs(pci_dev, hd);
>      }
>
>      /* Load PALcode.  Given that this is not "real" cpu palcode,
> --
> 2.20.1
>
>


