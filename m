Return-Path: <SRS0=PCRa=3C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C59B7C33CA9
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 20:07:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 898B12084D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 20:07:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G2U4A+Tu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 898B12084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ir608-0001su-Es
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 15:07:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45523)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1ir5zE-0000Xj-7E
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 15:06:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1ir5zD-0002gc-7k
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 15:06:56 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20290
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ir5zD-0002gA-4Y
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 15:06:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578946014;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GPvRzQvIdaqqNb0HVBmmcAVMm4KHhNn/ND3/BBp73uI=;
 b=G2U4A+TuZXpA3Tu1IibQGJpvw0WHq+DK6L2c9Tly9T/GyHC3V9vE7yHCacg4s2dSCvLiSc
 UZ76czx+wk2wq9bOoQlojg91aravcUF2BEsquuH/GE7Ee5xQXKIBpdopkw++2q4Dzd/a8y
 cOSxztUHl6sHXtRsZXf14W/WSMoyyEo=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-183-H36u7esbPrOyuzeIy034uA-1; Mon, 13 Jan 2020 15:06:51 -0500
Received: by mail-qv1-f70.google.com with SMTP id n11so7040752qvp.15
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2020 12:06:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=3zF0XGwwqTYlkck4hqT2NGqc4X5DVV63ye95UnKmVp8=;
 b=krAiMvlOTnaJeIQAuNMiMsjVTVGdWarCKJdDt+/rnNaYS+kN/2VdMBPCYVzQ+V4y6+
 GpNezmEe1PJhwbW6265HEJswAI6oRJJQc1892c8z2vnieed8kgIlMQwA9Cy4MtHtVHHz
 vWEtAC1Yk6BmnrKbvU47hK6SI6PL7Zh0l35Yw78/6klOFTYdQP/KThsFmV3Ap0vLjLPa
 wRwEFJZfKa9TZjH9B++oSi7w0Ht8GiG98fp5Eic+3vJd0/5TiZUyIIf+lvTl7TMLuQTJ
 BmkU5EW4rK1BmdxHE60rCgFMJvGNTbu4Do9FjLp4fHctxfFxDO78qeHItAKWfMByhtG7
 Yqaw==
X-Gm-Message-State: APjAAAUDk+gczdsRkSM/uPppscMz5/YQhfc7jHZuc/OvGusUBFaLq7bk
 QIYQL6S5067cqfPsP5SYGs8b6DMxHMyUQU090ZPGPIsWTNJNJ93AElERCa36ola2EHtRKAh4FWz
 viYrjff4uhjBGrVA=
X-Received: by 2002:ac8:408e:: with SMTP id p14mr333088qtl.66.1578946011160;
 Mon, 13 Jan 2020 12:06:51 -0800 (PST)
X-Google-Smtp-Source: APXvYqyNpluUGviHTFJkl3xrnD6lQIpu6bn4/fdPv7DQIQno6ZGc92wGBLM1Z9LkMzbmIST+5tzXHQ==
X-Received: by 2002:ac8:408e:: with SMTP id p14mr333068qtl.66.1578946010979;
 Mon, 13 Jan 2020 12:06:50 -0800 (PST)
Received: from xz-x1 ([104.156.64.74])
 by smtp.gmail.com with ESMTPSA id m5sm6221343qtq.6.2020.01.13.12.06.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jan 2020 12:06:50 -0800 (PST)
Date: Mon, 13 Jan 2020 15:06:49 -0500
From: Peter Xu <peterx@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v12 04/13] virtio-iommu: Add the iommu regions
Message-ID: <20200113200649.GC201624@xz-x1>
References: <20200109144319.15912-1-eric.auger@redhat.com>
 <20200109144319.15912-5-eric.auger@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200109144319.15912-5-eric.auger@redhat.com>
X-MC-Unique: H36u7esbPrOyuzeIy034uA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: peter.maydell@linaro.org, kevin.tian@intel.com, tnowicki@marvell.com,
 jean-philippe@linaro.org, quintela@redhat.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com, bharatb.linux@gmail.com, qemu-arm@nongnu.org,
 mst@redhat.com, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jan 09, 2020 at 03:43:10PM +0100, Eric Auger wrote:
> +/**
> + * The bus number is used for lookup when SID based operations occur.
> + * In that case we lazily populate the IOMMUPciBus array from the bus ha=
sh
> + * table. At the time the IOMMUPciBus is created (iommu_find_add_as), th=
e bus
> + * numbers may not be always initialized yet.
> + */
> +static IOMMUPciBus *iommu_find_iommu_pcibus(VirtIOIOMMU *s, uint8_t bus_=
num)
> +{
> +    IOMMUPciBus *iommu_pci_bus =3D s->iommu_pcibus_by_bus_num[bus_num];
> +
> +    if (!iommu_pci_bus) {
> +        GHashTableIter iter;
> +
> +        g_hash_table_iter_init(&iter, s->as_by_busptr);
> +        while (g_hash_table_iter_next(&iter, NULL, (void **)&iommu_pci_b=
us)) {
> +            if (pci_bus_num(iommu_pci_bus->bus) =3D=3D bus_num) {
> +                s->iommu_pcibus_by_bus_num[bus_num] =3D iommu_pci_bus;
> +                return iommu_pci_bus;
> +            }
> +        }

Btw, we may need to:

           return NULL;

here.

> +    }
> +    return iommu_pci_bus;
> +}

--=20
Peter Xu


