Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2326C43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 16:04:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B7AC2073D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 16:04:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YQtQMwCZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B7AC2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieLW0-0007WU-4D
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 11:04:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58167)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1ieLTx-0005QR-36
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 11:01:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1ieLTv-0004iO-UU
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 11:01:56 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:24755
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1ieLTv-0004gO-Q3
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 11:01:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575907315;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fW5qCeMSAlq7YX+r/nPq9txoJ1Rudxnifo+OKmaAsmw=;
 b=YQtQMwCZFiYhiZNcsW0cA1pjl2WU/Z/WtQMHhHypj5S63hkMKa7LMui0jMN1h5zLwhR2af
 eG221zMYDQug0+7S/U67qyDvXE4nYlbJJ7pSdnaFofAUMnJgE4wv4Z+fqd7Td+RQ12ZZvj
 pZwSoH4Du3A39dYap8UA2pXo2K32PtE=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-351-H5cxlH4UNka1ca7iKUzY8Q-1; Mon, 09 Dec 2019 11:01:53 -0500
Received: by mail-qv1-f69.google.com with SMTP id p3so4893839qvt.9
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2019 08:01:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=XzG4ayg04gC82Dl3A/iNIRpZtWsWjPLgZRqnCw02sY8=;
 b=XGtQ1PAVv14shergkXDpEN6iZfNY4WZqgjo+yFtAq0BbGbkX/TJ0VpMwUYRUPWtRtV
 c2S1qp0BRuVjoPGRwv4pFQVrVyjgIZa8nQ6B+u5r/3OefRQQkQF2KUGyeHLI3qEMpJUA
 bGklEMbj6UjNaiNrPKAIn0Qtyu4lbghlvoQ8HOOFLebOUmBb/kjynqrodm/4xd+We2eh
 YMO51SNcoZqJxGVlG3VOnr/yOafnHJLAkX6agqlKpIQj4oZB4q2hhEl600/bI6AUg/6v
 7dQtTmqdKsgZ4q8VFCmHspMw+s+6Soxvoy3wM8DrtWVb4tOpIv8eFyXSVaMT0w2JYDOn
 VZNA==
X-Gm-Message-State: APjAAAXL262+26jrvDedl4zMXoZvqxdGwQrI/5sGTgAO3QVHjY9hG+l6
 bjkmrO6guItsQdFxSDCnyW5Wov3fkrS0NBr1fqJ/sttKcMUwYUEzT6SlpLwmzFuMaLwhbTDLWIa
 OKArhPQfX8obcacM=
X-Received: by 2002:a37:4943:: with SMTP id w64mr12532440qka.300.1575907313426; 
 Mon, 09 Dec 2019 08:01:53 -0800 (PST)
X-Google-Smtp-Source: APXvYqwfqKr4Vy31WHytO8Y03AsAJaZ1qoRXFEfZA75TD96fhh8t4jHTHbRO6WchvvgfA/rq7NJ+cA==
X-Received: by 2002:a37:4943:: with SMTP id w64mr12532408qka.300.1575907313183; 
 Mon, 09 Dec 2019 08:01:53 -0800 (PST)
Received: from redhat.com (bzq-79-181-48-215.red.bezeqint.net. [79.181.48.215])
 by smtp.gmail.com with ESMTPSA id x68sm9063807qkc.22.2019.12.09.08.01.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2019 08:01:52 -0800 (PST)
Date: Mon, 9 Dec 2019 11:01:48 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 06/18] hw/acpi: Fix legacy CPU plug error API violations
Message-ID: <20191209110134-mutt-send-email-mst@kernel.org>
References: <20191204093625.14836-1-armbru@redhat.com>
 <20191204093625.14836-7-armbru@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191204093625.14836-7-armbru@redhat.com>
X-MC-Unique: H5cxlH4UNka1ca7iKUzY8Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Dec 04, 2019 at 10:36:13AM +0100, Markus Armbruster wrote:
> legacy_acpi_cpu_plug_cb() dereferences @errp when
> acpi_set_cpu_present_bit() fails.  That's wrong; see the big comment
> in error.h.  Introduced in commit cc43364de7 "acpi/cpu-hotplug:
> introduce helper function to keep bit setting in one place".
>=20
> No caller actually passes null, and acpi_set_cpu_present_bit() can't
> actually fail.
>=20
> Fix anyway: drop acpi_set_cpu_present_bit()'s @errp parameter.
>=20
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

Feel free to merge through your tree pls.

> ---
>  hw/acpi/cpu_hotplug.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
>=20
> diff --git a/hw/acpi/cpu_hotplug.c b/hw/acpi/cpu_hotplug.c
> index 3ac2045a95..9c3bcc84de 100644
> --- a/hw/acpi/cpu_hotplug.c
> +++ b/hw/acpi/cpu_hotplug.c
> @@ -55,8 +55,7 @@ static const MemoryRegionOps AcpiCpuHotplug_ops =3D {
>      },
>  };
> =20
> -static void acpi_set_cpu_present_bit(AcpiCpuHotplug *g, CPUState *cpu,
> -                                     Error **errp)
> +static void acpi_set_cpu_present_bit(AcpiCpuHotplug *g, CPUState *cpu)
>  {
>      CPUClass *k =3D CPU_GET_CLASS(cpu);
>      int64_t cpu_id;
> @@ -74,10 +73,7 @@ static void acpi_set_cpu_present_bit(AcpiCpuHotplug *g=
, CPUState *cpu,
>  void legacy_acpi_cpu_plug_cb(HotplugHandler *hotplug_dev,
>                               AcpiCpuHotplug *g, DeviceState *dev, Error =
**errp)
>  {
> -    acpi_set_cpu_present_bit(g, CPU(dev), errp);
> -    if (*errp !=3D NULL) {
> -        return;
> -    }
> +    acpi_set_cpu_present_bit(g, CPU(dev));
>      acpi_send_event(DEVICE(hotplug_dev), ACPI_CPU_HOTPLUG_STATUS);
>  }
> =20
> @@ -92,7 +88,7 @@ void legacy_acpi_cpu_hotplug_init(MemoryRegion *parent,=
 Object *owner,
>      gpe_cpu->device =3D owner;
> =20
>      CPU_FOREACH(cpu) {
> -        acpi_set_cpu_present_bit(gpe_cpu, cpu, &error_abort);
> +        acpi_set_cpu_present_bit(gpe_cpu, cpu);
>      }
>  }
> =20
> --=20
> 2.21.0


