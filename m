Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E61C4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 15:29:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE61E20854
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 15:29:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AVScJlp6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE61E20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK2Hi-0001AY-Uk
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 11:29:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49652)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pdurrant@gmail.com>) id 1iK1MH-000411-Nz
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 10:30:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pdurrant@gmail.com>) id 1iK1MF-00022W-L4
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 10:30:00 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:41439)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pdurrant@gmail.com>)
 id 1iK1MD-00021s-OX; Mon, 14 Oct 2019 10:29:58 -0400
Received: by mail-pg1-x544.google.com with SMTP id t3so10222541pga.8;
 Mon, 14 Oct 2019 07:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=pVgNsLZmusn/0VPc8jRmCgjq0/uu3i1yih1wwqVCCws=;
 b=AVScJlp6hVP2I3fwaZhc4jyhmHHHVdeVScozqrfXAvuwx5AM+B51wzkN359hcnsPP5
 aRkRwDTo1BX78uFAHS02JixP00kLLombIRsldeqfZH7uh5WKDuUsRe6hCTJHRsROvx0a
 BbWHyN+/wDCdlRvdjzN/uEHlgZoGphrQV4o64Vg/wvCQxUnA/7Qb0thHB34/X8iodmsR
 hgdDD2TOAL9kDqcZcxycJh+1OikNANeDERaz2zgcov7WR68TjWrzY9wTU5LCCB1wMRsf
 2AUHjJvfK8EJqno6i6tFTS/WfPweWyFDhDE1z2IyOvd65FoVYeFE+t0aXDw/pPVB13j1
 XBqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=pVgNsLZmusn/0VPc8jRmCgjq0/uu3i1yih1wwqVCCws=;
 b=EatfEGxq1oairFJs+jg2CdDlL/Km11MSauYA/dosPPz/WNo194v+RIs4PA1lCmnLHO
 kX5AFkZSB3plzU+YTZ9Oqj9WMxGLAySUwoHf0Kn6HiWr4rOQcCQUmoMFjI4b7HBe3nmo
 a4lFTZx7lBcXOo7iq4xn0c68ot7sB93qwMIDK4owxm+3t8A5OBAGHyd0SbuqkUkdMdLh
 QnRjQqD7gpLJvfJlmSipTQPtVauMZTsrbRidPDTMq41r4nCYYmfKPl5U7TlRQ+G+/vIE
 Qvz79nFdw7UT4YYZm7ZsFiTNiYy9MBpl9CoB8v7NVKyp7tz3M4n0U+M0P8sUtkXIf37v
 Hq0w==
X-Gm-Message-State: APjAAAWQ9QoQBpGXWg0j1bx4LVbiOdO4uucjaKHy/Bqmx8a+8EKoFwBY
 zkyhPr8vL7bldEC9bclnR1YuRIahP1g8uoekC/M=
X-Google-Smtp-Source: APXvYqzlAsd8AavS54vG3LLcvFWdOJorkwhqLYrGGsuHW/7m/fDdfLR1oVhgW/XRyxvB0xa2GW8OX02i0CVqNWN9JaI=
X-Received: by 2002:a63:82:: with SMTP id 124mr34900738pga.112.1571063393200; 
 Mon, 14 Oct 2019 07:29:53 -0700 (PDT)
MIME-Version: 1.0
References: <20191014142246.4538-1-philmd@redhat.com>
 <20191014142246.4538-9-philmd@redhat.com>
In-Reply-To: <20191014142246.4538-9-philmd@redhat.com>
From: Paul Durrant <pdurrant@gmail.com>
Date: Mon, 14 Oct 2019 15:29:42 +0100
Message-ID: <CACCGGhCaC5-K+q+fJpTt5aZQ=-XurNAWwNDvKunBLaFHvu7yow@mail.gmail.com>
Subject: Re: [PATCH 08/20] hw/xen/xen_pt_load_rom: Remove unused includes
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
X-Mailman-Approved-At: Mon, 14 Oct 2019 11:28:43 -0400
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Paul Durrant <paul@xen.org>,
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>, qemu-block@nongnu.org,
 Helge Deller <deller@gmx.de>, David Hildenbrand <david@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 xen-devel <xen-devel@lists.xenproject.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Xie Changlong <xiechanglong.d@gmail.com>, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>, Cornelia Huck <cohuck@redhat.com>,
 Max Reitz <mreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 14 Oct 2019 at 15:27, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> xen_pt_load_rom.c does not use any of these includes, remove them.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Paul Durrant <paul@xen.org>

> ---
>  hw/xen/xen_pt_load_rom.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/hw/xen/xen_pt_load_rom.c b/hw/xen/xen_pt_load_rom.c
> index 307a5c93e2..a50a80837e 100644
> --- a/hw/xen/xen_pt_load_rom.c
> +++ b/hw/xen/xen_pt_load_rom.c
> @@ -3,12 +3,8 @@
>   */
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
> -#include "hw/i386/pc.h"
>  #include "qemu/error-report.h"
> -#include "ui/console.h"
>  #include "hw/loader.h"
> -#include "monitor/monitor.h"
> -#include "qemu/range.h"
>  #include "hw/pci/pci.h"
>  #include "xen_pt.h"
>
> --
> 2.21.0
>

