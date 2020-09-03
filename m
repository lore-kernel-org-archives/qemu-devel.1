Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC11FC433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 14:26:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B190206EB
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 14:26:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="FnN1hdzG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B190206EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDqC7-0005xE-Li
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 10:26:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60536)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kDqBR-0005W8-HZ
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 10:25:49 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:35590)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kDqBP-0007gD-Gc
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 10:25:49 -0400
Received: by mail-wr1-x441.google.com with SMTP id e16so3483133wrm.2
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 07:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=uQC/h5c8nPJIiHCg5hp2Cnwu5owxcDFEA1bFa7JJ/Qo=;
 b=FnN1hdzGncdNQOw49FCPgnmGeuURTr5goXQMjJNPyPiff3+pgZSVDZkfk46Dny/D3Q
 GRYR1KnZUOcEtmgkoMolbw6XDfK+gAhvVC2vrWiiGrxx4sb2tuiffwKMdWmWCOB+JE2I
 hsUKg1FsV1XHIRLcXX6VsM9ZZUthIY4/H+7NsziWnX5bAl3HgM9ooJKxppBW0zy+0FhO
 kOdmQJOvQCoSyYGgzUfJx5XhpP28AVQGqljkDSyFvnYqqRl7WrOjWfVu8P2og+8rNroY
 V6l7qKB9cbJqobhnW5lycVf6xvgQMEqaszg0IYHElAauDrhbf5KBA2vnMN87dukI3EdN
 /B2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uQC/h5c8nPJIiHCg5hp2Cnwu5owxcDFEA1bFa7JJ/Qo=;
 b=KUNDhsIvKzFjzQTGeR5FUXdI9d2wX5SkmNRfUvVNLfcdoYfN0fUp+RvmNj4G/N/myb
 VcNIxoYHYKPiMqrJ8CWzHmWRWcMje/FV69HHyAEGXumLyWH84JrALbp6xDwIngm+5NQc
 BLOKqX6XwyQFqpoHMpqbMNULx8byUKDNHYf7kGXRYG8uBmgHLZWGo1S17TwqsE2mIBtD
 4EajWHZSr3/e51fmNrnVMvLIWTj4C/+pdAsTS0EhmrP8io24y8jtRue00ksbw+lP6zL3
 WSjTOVrkYs58XXUdQRbkEW95PbqeV3EsIvwMdfE97kFkPkIIWV6+PCFdM4fhh3/pHIK6
 3DrA==
X-Gm-Message-State: AOAM530BUfyXV2HzGBtvvPCt3iRHl1NcvuPCkTZi+nSBRBhhi41zyYY3
 8ljjNGhj5Xxoh2l0zHrZ7ROQCmWSj7yULS6xpNuW0k1a0VvkkQ==
X-Google-Smtp-Source: ABdhPJy4vklVsZ+XsT8k/uOGmDsehMlzTB4hnXSaIky06UxCpSGmRQJkQEfd87HPvrCXkYCl9uW5HHpEUqEfhj84iMY=
X-Received: by 2002:a5d:518b:: with SMTP id k11mr2662265wrv.369.1599143145561; 
 Thu, 03 Sep 2020 07:25:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200903102530.16846-1-ani@anisinha.ca>
In-Reply-To: <20200903102530.16846-1-ani@anisinha.ca>
From: Ani Sinha <ani@anisinha.ca>
Date: Thu, 3 Sep 2020 19:55:32 +0530
Message-ID: <CAARzgwyEV+qxzMLHk+LoWBbHv_kZzdgEqUz5kVOA7KMycC+fmQ@mail.gmail.com>
Subject: Re: [PATCH v2] Fix a gap where acpi_pcihp_find_hotplug_bus() returns
 a non-hotpluggable bus
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: none client-ip=2a00:1450:4864:20::441;
 envelope-from=ani@anisinha.ca; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Igor Mammedov <imammedo@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Please do not pull this patch. This patch has a bug and it will crash here:

Thread 1 "qemu-system-x86" received signal SIGSEGV, Segmentation fault.
0x000055c2805339e9 in acpi_pcihp_find_hotplug_bus (bsel=bsel@entry=1,
s=<optimized out>)
    at /home/ani/workspace/qemu/hw/acpi/pcihp.c:162
162        if (!qbus_is_hotpluggable(BUS(find.bus))) {
(gdb) p find.bus
$1 = (PCIBus *) 0x0

I will submit a rework soon.

On Thu, Sep 3, 2020 at 3:55 PM Ani Sinha <ani@anisinha.ca> wrote:
>
> When ACPI hotplug for the root bus is disabled, the bsel property for that
> bus is not set. Please see the following commit:
>
> 3d7e78aa7777f ("Introduce a new flag for i440fx to disable PCI hotplug on the root bus").
>
> As a result, when acpi_pcihp_find_hotplug_bus() is called
> with bsel set to 0, it may return the root bus. This can cause devices attached to
> the root bus to get hot-unplugged if the user issues the following set of commmands:
>
> outl 0xae10 0
> outl 0xae08 your_slot
>
> Thanks to Julia for pointing this out here:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg734548.html
>
> In this patch, we fix the issue in this function by checking if the bus which is
> returned by the function is actually hotpluggable. If not, we simply return NULL.
> This avoids the scenario where we were returning a non-hotpluggable bus.
>
> Signed-off-by: Ani Sinha <ani@anisinha.ca>
> ---
>  hw/acpi/pcihp.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
> index 39b1f74442..f148e73c89 100644
> --- a/hw/acpi/pcihp.c
> +++ b/hw/acpi/pcihp.c
> @@ -147,6 +147,21 @@ static PCIBus *acpi_pcihp_find_hotplug_bus(AcpiPciHpState *s, int bsel)
>      if (!bsel && !find.bus) {
>          find.bus = s->root;
>      }
> +
> +    /*
> +     * Check if find.bus is actually hotpluggable. If bsel is set to
> +     * NULL for example on the root bus in order to make it
> +     * non-hotpluggable, find.bus will match the root bus when bsel
> +     * is 0. See acpi_pcihp_test_hotplug_bus() above. Since the
> +     * bus is not hotpluggable however, we should not select the bus.
> +     * Instead, we should set find.bus to NULL in that case. In the check
> +     * below, we generalize this case for all buses, not just the root bus.
> +     * The callers of this function check for a null return value and
> +     * handle them appropriately.
> +     */
> +    if (!qbus_is_hotpluggable(BUS(find.bus))) {
> +        find.bus = NULL;
> +    }
>      return find.bus;
>  }
>
> --
> 2.17.1
>

