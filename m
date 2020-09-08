Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE73C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 12:04:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0054321D82
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 12:04:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iyRqLU46"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0054321D82
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFcMo-0005KY-28
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 08:04:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55430)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kFcLJ-0003Vc-S3
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 08:03:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56551
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kFcLI-0004Tx-2q
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 08:03:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599566599;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B62JRL2X8+ZThetqEnGEcM1eNrz74CVKJLHmcLUul2o=;
 b=iyRqLU46iDfEjrYqe/We1UVgEM65bz/QIFQaVp9r6L6E1wcY3kbfzhe70AqO6lNtunxuhz
 Sn6Eunk72yaId/NTrYIanU4zkLoYGDv43AgDxNhXeTR/WrEz0Hf8NmNpkYmzSPD8iBT1rt
 vukUBHidyhyHbl1QuuOSOitl2zh9BdI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-572-2NokKKy1M2W9K91ukxxKYw-1; Tue, 08 Sep 2020 08:03:16 -0400
X-MC-Unique: 2NokKKy1M2W9K91ukxxKYw-1
Received: by mail-wm1-f70.google.com with SMTP id x6so376961wmi.1
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 05:03:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=FRW8GTYCbth4PFoMPsQ7CovdYqkNb1MGHCGC1NELfaE=;
 b=kbFSldr4W9LArJrcG38sHp1uI/VeJsmUyxIY2oewYKajVDFU0g8d2ra7vyZlO7OYPD
 Cjp05oIntC+M8+mJ8Arcx9pJVOlhrjOmbe644sX7FXNhpdnunIVyLek0sQu+lhH/eNNG
 bnizodOsp2P6lzllMW4WKgqiV7DGd+6pmpszTakzjBJVKciYKOEXeyh58WYPj/yi+CbP
 yOZrAY7vbdHuPAJ2jMgxX4qvTOfroqNwqGCKQAEZoysHzwdpRwWKoOxNicBOFMW4Ma4+
 xnGTsnSsfQ660TQrroiwg10+GjMVODLppuATH5Bp0iNVqJJ3mzLAgZikJYXTuTIENOky
 SMaA==
X-Gm-Message-State: AOAM530JkDxyc220IZkMyXnJ+2fc7UZMznjn0ttb8+PXgdxv1f+BUAI1
 lLvNJa8auW4lZDBjLdoTLoNSIfiwn+4KQ2w6wsSheDN/c9A4PDCmOI8jXHt1VUUC401ivNAMZt7
 QXv9ChJZpdV9nKfM=
X-Received: by 2002:a1c:9a48:: with SMTP id c69mr3940894wme.43.1599566595219; 
 Tue, 08 Sep 2020 05:03:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzsJQRzzJuqR06VRWoKfP3BhX8H4BgA70S4D6vHbCipkn2OjEbOrQ9L4Qmg5Sm79AHXj9zVUA==
X-Received: by 2002:a1c:9a48:: with SMTP id c69mr3940869wme.43.1599566594999; 
 Tue, 08 Sep 2020 05:03:14 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-221-30.inter.net.il. [80.230.221.30])
 by smtp.gmail.com with ESMTPSA id k22sm34535076wrd.29.2020.09.08.05.03.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 05:03:14 -0700 (PDT)
Date: Tue, 8 Sep 2020 08:03:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>
Subject: Re: [PATCH 10/10] tests: acpi: update "virt/SSDT.memhp" for
 edk2-stable202008
Message-ID: <20200908080301-mutt-send-email-mst@kernel.org>
References: <20200908072939.30178-1-lersek@redhat.com>
 <20200908072939.30178-11-lersek@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200908072939.30178-11-lersek@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 02:10:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Igor Mammedov <imammedo@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 qemu devel list <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 08, 2020 at 09:29:39AM +0200, Laszlo Ersek wrote:
> The NVDIMM_ACPI_MEM_ADDR dword in "virt/SSDT.memhp" needs an update due to
> the firmware now allocating NVDIMM_DSM_MEM_FILE at a lower address.
> 
> >          }
> >      }
> >
> > -    Name (MEMA, 0x43DD0000)
> > +    Name (MEMA, 0x43D10000)
> >  }
> >
> 
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: Philippe Mathieu-Daudé <philmd@redhat.com>
> Ref: https://bugs.launchpad.net/qemu/+bug/1852196
> Signed-off-by: Laszlo Ersek <lersek@redhat.com>

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  tests/qtest/bios-tables-test-allowed-diff.h |   1 -
>  tests/data/acpi/virt/SSDT.memhp             | Bin 736 -> 736 bytes
>  2 files changed, 1 deletion(-)
> 
> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
> index e569098abddc..dfb8523c8bf4 100644
> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> @@ -1,2 +1 @@
>  /* List of comma-separated changed AML files to ignore */
> -"tests/data/acpi/virt/SSDT.memhp",
> diff --git a/tests/data/acpi/virt/SSDT.memhp b/tests/data/acpi/virt/SSDT.memhp
> index db61d6733284..375d7b6fc85a 100644
> Binary files a/tests/data/acpi/virt/SSDT.memhp and b/tests/data/acpi/virt/SSDT.memhp differ
> -- 
> 2.19.1.3.g30247aa5d201
> 


