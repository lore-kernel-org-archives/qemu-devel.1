Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D70EC3A589
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 20:06:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA34D2084D
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 20:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F/QnoYIo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA34D2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyM0X-0005Td-1j
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 16:06:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49262)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vandersonmr2@gmail.com>) id 1hyLzf-0004xp-0i
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 16:05:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vandersonmr2@gmail.com>) id 1hyLzb-0001P8-Qj
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 16:05:06 -0400
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841]:39288)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <vandersonmr2@gmail.com>)
 id 1hyLzb-0001P0-Mm
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 16:05:03 -0400
Received: by mail-qt1-x841.google.com with SMTP id l9so3666322qtu.6
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2019 13:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=rhUsX6I+2rYKzzm+P7s76rxHk+sE7N3nQZzO+1jKyVw=;
 b=F/QnoYIoLvkNRd1pVwOXDZlmI3w2C+p6OA1IgpgRNRILGFmgWFKeA2niEEm+Er1Xb4
 NK+nE/sM5HonxKJ5/0jGXpKw767RPm6uaVAdXkJf/6IkTn4qjBeX9TfPFZU0taw4fllX
 pMxC0qSa/5f80Wo3AlnmTehEKTzGWDThmYZRac7zkQUQ4SJl1yq3f9z85/jnyBkXyXfS
 0DrXtNvaZ7iS5koKOyebfeCl5a7JqKV7H2ugPwobNqEHJkCUvR0demVNGbNL2vdmvH/c
 9BvI6BLIaaWmV2Pznmv2mmnv7iAWgJXNfUDjmp1f59MJb/7jtzF1tMNm001tKGcA8QqZ
 mF5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rhUsX6I+2rYKzzm+P7s76rxHk+sE7N3nQZzO+1jKyVw=;
 b=Dbz4lELUBDbedgGB39Gy4Hyuu5Xdn4f/TMju3IK9x/m+5smkPVj4Rq6y0/JS/GJMUe
 opzxS4x7GyMoKWpJ1dJZzp0SeG91td0knFQPo9K/Yo7FP5dnY4JlEJ2YmX+acA/rh0fJ
 FCyrOUupXCS6XEMbPCBv9Pcf7rzvNXfxUXY/Z1sRfMP2oPNgfVyjD97GGYUOw4uiDXXM
 Qe9JBHlwF+y7AP1oyRsUmKeuVAg7Ug+6rM3tUymJEogBMFQ8Wv12s04nMBaZf1+Zfiso
 5Q/jukzq9+TBySlRnrarRfjG+qZODhAfKvbowqq9zIfOE9SfOatK+qrsevMQe6v4sP3n
 XbCg==
X-Gm-Message-State: APjAAAWnBzndlD4M9YK/MTbt2YWEa4PaHFgcxZslq0Fv4TaNaG0etOFA
 o/LNhhEtSI604AdEOlF29izv9misCsHi/rIhbSA=
X-Google-Smtp-Source: APXvYqz7JBEZvc38S1ivgk84D6Botrj6Lq9mq/heVAYVSifVGb+0nd7q9kptS35p4cPIk/TR86voNvQKPt77iK4Q4rg=
X-Received: by 2002:ac8:60a:: with SMTP id d10mr5354782qth.31.1565899502813;
 Thu, 15 Aug 2019 13:05:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190815183803.13346-1-ehabkost@redhat.com>
 <20190815183803.13346-2-ehabkost@redhat.com>
In-Reply-To: <20190815183803.13346-2-ehabkost@redhat.com>
From: Vanderson Martins do Rosario <vandersonmr2@gmail.com>
Date: Thu, 15 Aug 2019 17:04:51 -0300
Message-ID: <CAMzYVD31qvGGZNCsUXotCLQese1cPOVArva1g9HGpeBwmNTVjw@mail.gmail.com>
To: Eduardo Habkost <ehabkost@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::841
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH 1/3] pc: Fix error message on die-id
 validation
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
Cc: Peter Krempa <pkrempa@redhat.com>, Like Xu <like.xu@linux.intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>

Vanderson M. Rosario


On Thu, Aug 15, 2019 at 3:48 PM Eduardo Habkost <ehabkost@redhat.com> wrote:

> The error message for die-id range validation is incorrect.  Example:
>
>   $ qemu-system-x86_64 -smp 1,sockets=6,maxcpus=6 \
>     -device qemu64-x86_64-cpu,socket-id=1,die-id=1,core-id=0,thread-id=0
>   qemu-system-x86_64: -device
> qemu64-x86_64-cpu,socket-id=1,die-id=1,core-id=0,thread-id=0: \
>     Invalid CPU die-id: 1 must be in range 0:5
>
> The actual range for die-id in this example is 0:0.
>
> Fix the error message to use smp_dies and print the correct range.
>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  hw/i386/pc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 549c437050..24b03bb49c 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -2412,7 +2412,7 @@ static void pc_cpu_pre_plug(HotplugHandler
> *hotplug_dev,
>              return;
>          } else if (cpu->die_id > pcms->smp_dies - 1) {
>              error_setg(errp, "Invalid CPU die-id: %u must be in range
> 0:%u",
> -                       cpu->die_id, max_socket);
> +                       cpu->die_id, pcms->smp_dies - 1);
>              return;
>          }
>          if (cpu->core_id < 0) {
> --
> 2.21.0
>
>
>
