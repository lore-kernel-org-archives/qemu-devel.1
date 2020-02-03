Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07769C33C9E
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 06:44:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C807120658
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 06:44:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lon24gff"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C807120658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyVT1-0004bv-2Q
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 01:44:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37090)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iyVS7-00042l-4f
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 01:43:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iyVS6-0002DV-42
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 01:43:23 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:60064
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iyVS5-0002Bd-W4
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 01:43:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580712198;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Mxht/KLWEDwGIXr9MQR6xjOTEWdbCtU1Uk3cSWbKMHk=;
 b=Lon24gffcMUBu615uQzsxIaox0ejLhdR3YbhdFhes9Sav9Q6F9KmtGIix5tXiLe9689ILG
 HqH+VKJo6AISzLycseh9iu46T6OfIROusmZ5GhS3vthFRzaZtCknkR29Fzqjm6HVKrs/Xh
 49KRNHPHGv9RZyLHVJ4c151FZ5MzRUM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-jgmXc6vsNhCQlBCVdLkG2g-1; Mon, 03 Feb 2020 01:43:17 -0500
Received: by mail-wm1-f72.google.com with SMTP id 7so4392271wmf.9
 for <qemu-devel@nongnu.org>; Sun, 02 Feb 2020 22:43:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=11YEzOH4JqxoCO8A8NB9nQ9MAE9iM+etG54GJmx13Jc=;
 b=oSMabjYvfIAO59xs+we5eyvHv7S/+zRUWmvW19URJc0U3LjPsaNWeZlTKewzSjBMhr
 hDJoSO4A8GUy7umsQ30uDF0ILX7H/M+BvqtpNYet7KhQiOVF5+C5So/eURIeJYV5b8PF
 PmqLamfinuTaL2NxkqGX5hzveXkItkEQdGyEJCmTG5paaozrHgPst8UcAkMct/OdO55n
 UKp59XYJ+h9A1AEmooJ0d2DfrWrC+XsB34V+VwApYDrTlaWtueuK8yfqk5R6BPUWfeLx
 gBbgRDj0Gm0OLlQsmVIrTpA42CSVeiOZO/JOzG4DS8hLyCXnApIMEpoGonAyx3Imo3cq
 s6Cw==
X-Gm-Message-State: APjAAAX/NGR/IsgM+yQzP0ZdejMwYTwXMOypMlGkQnAUaQifSjwohizQ
 thxbmzpomc47lUg1AkqVhMprBwWvZQ+LgyaD6dyPV6MIT6KmlrcmMocxEN65goYt6Jc7T5O+P9A
 U+3izVdioIHuPR3U=
X-Received: by 2002:adf:f1d0:: with SMTP id z16mr12940377wro.209.1580712196178; 
 Sun, 02 Feb 2020 22:43:16 -0800 (PST)
X-Google-Smtp-Source: APXvYqwuAerm/y9bG5+lcwWQUeZy04z9nAY8TLx5BVcJCimVz2/BZt8N0b8D3VT2s94DFGaEtkgb2g==
X-Received: by 2002:adf:f1d0:: with SMTP id z16mr12940351wro.209.1580712195914; 
 Sun, 02 Feb 2020 22:43:15 -0800 (PST)
Received: from redhat.com (ip-82-36-244-173.west.us.northamericancoax.com.
 [173.244.36.82])
 by smtp.gmail.com with ESMTPSA id r14sm21083307wrj.26.2020.02.02.22.43.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Feb 2020 22:43:15 -0800 (PST)
Date: Mon, 3 Feb 2020 01:43:07 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Heyi Guo <guoheyi@huawei.com>
Subject: Re: [PATCH v2 0/7] Some cleanup in arm/virt/acpi
Message-ID: <20200203014246-mutt-send-email-mst@kernel.org>
References: <20200203001505.52573-1-guoheyi@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20200203001505.52573-1-guoheyi@huawei.com>
X-MC-Unique: jgmXc6vsNhCQlBCVdLkG2g-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, wanghaibin.wang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Feb 03, 2020 at 08:14:58AM +0800, Heyi Guo wrote:
> Remove conflict _ADR objects, and fix and refine PCI device definition in
> ACPI/DSDT.
>=20
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: Shannon Zhao <shannon.zhaosl@gmail.com>
> Cc: qemu-arm@nongnu.org
> Cc: qemu-devel@nongnu.org


Series

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

merge through ARM tree pls.

> v1 -> v2:
> - flow the work flow in tests/qtest/bios-table-test.c to post ACPI relate=
d
>   patches.
> - update commit messages for removing "RP0" and "_ADR".
> - add 3 more cleanup patches.
>=20
> Heyi Guo (7):
>   bios-tables-test: prepare to change ARM virt ACPI DSDT
>   arm/virt/acpi: remove meaningless sub device "PR0" from PCI0
>   arm/virt/acpi: remove _ADR from devices identified by _HID
>   arm/acpi: fix PCI _PRT definition
>   arm/acpi: fix duplicated _UID of PCI interrupt link devices
>   arm/acpi: simplify the description of PCI _CRS
>   virt/acpi: update golden masters for DSDT update
>=20
>  hw/arm/virt-acpi-build.c          |  25 ++++++-------------------
>  tests/data/acpi/virt/DSDT         | Bin 18462 -> 5307 bytes
>  tests/data/acpi/virt/DSDT.memhp   | Bin 19799 -> 6644 bytes
>  tests/data/acpi/virt/DSDT.numamem | Bin 18462 -> 5307 bytes
>  4 files changed, 6 insertions(+), 19 deletions(-)
>=20
> --=20
> 2.19.1


