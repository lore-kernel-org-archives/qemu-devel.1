Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,TVD_SUBJ_WIPE_DEBT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BC83C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 15:07:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DFDC23D4E
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 15:07:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DfoGEm+8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DFDC23D4E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpvNd-0002yu-K5
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 11:07:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56072)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jpvMY-0002En-Gh
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 11:06:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60981
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jpvMW-0006CP-4m
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 11:06:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593443183;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P71wirPiCaM59Ua8QEoG2At1u81AQQAwkL/F+klRUVo=;
 b=DfoGEm+8kLjWz8NdP/rG4tzzPs7H3uXBFyptfOFRMwIO3QjbTx9xyWjDuxBTjc1gwk3nNi
 krpGfskN9v1GmmOETE4XucVE9CKqpXTwFrs5t/vUjaIGFR91d14FhHQvdBAM4ioHB6cNuP
 ZXNAYjyR5XeOikIC+GFwAphzRkfFOzU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-KK6EiFM1M76gcK1jrtzScw-1; Mon, 29 Jun 2020 11:06:21 -0400
X-MC-Unique: KK6EiFM1M76gcK1jrtzScw-1
Received: by mail-wm1-f70.google.com with SMTP id s134so18527107wme.6
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2020 08:06:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=P71wirPiCaM59Ua8QEoG2At1u81AQQAwkL/F+klRUVo=;
 b=fqWXlrnI9VT8srDzlVIasgQRXBu4UJ710ALhYEr5AXeZ0WIAbERnQCAepK7VHLxHbd
 +A0adpJKs0KJKYjrP4d8m09RuRh3D3Gkwlp5S8iY2dMwryyY5mntSQO3cOiS6AdzzjAn
 wxt9fXx4LFHkm24tlM/yqykOz8KHNaTYdXUa/P4UIbaXq/dWGlUC14ek9r1xvWDwE3xu
 RfVuBndXgLeunOralBpoJ0krPw4m/tPNnGT67OKi+pKb+yhd4N8nD3HsXDYQ47OeWn/r
 a13qklX11sQhdD4i7V788ucG/ogfNSSOTRSLAtxHKpE9iY/ZZWUSkR+u/925QNXx0mhK
 SxxA==
X-Gm-Message-State: AOAM532sRR6I5AQTL5N1GsyXX5vkD49gN8+oPlPVEtEnd7FwtM9wQ+1/
 KY3x2hPI3YkppFGDwJyXXxuGGsJsYfu3v3wbUTJYy239Wo0La9UYaF9uihy0hHWZ+O4AlHbQH+t
 PesH2QqnoF37LtDg=
X-Received: by 2002:a5d:4202:: with SMTP id n2mr16899210wrq.171.1593443179915; 
 Mon, 29 Jun 2020 08:06:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwvK6rDr1RmusDMAm1NnBDxeIWOfHqtlaJG8Q0uHx60+RJHAQnk9x26NAcHC/EQzGPHCOR0Og==
X-Received: by 2002:a5d:4202:: with SMTP id n2mr16899184wrq.171.1593443179717; 
 Mon, 29 Jun 2020 08:06:19 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 z25sm65472wmk.28.2020.06.29.08.06.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2020 08:06:19 -0700 (PDT)
Date: Mon, 29 Jun 2020 11:06:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Andrew Jones <drjones@redhat.com>
Subject: Re: [PATCH 1/4] tests/acpi: remove stale allowed tables
Message-ID: <20200629110443-mutt-send-email-mst@kernel.org>
References: <20200629140938.17566-1-drjones@redhat.com>
 <20200629140938.17566-2-drjones@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200629140938.17566-2-drjones@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/29 01:37:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_SUBJ_WIPE_DEBT=1.004 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, eric.auger@redhat.com, philmd@redhat.com,
 qemu-devel@nongnu.org, shannon.zhaosl@gmail.com, qemu-arm@nongnu.org,
 ard.biesheuvel@arm.com, imammedo@redhat.com, lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 29, 2020 at 04:09:35PM +0200, Andrew Jones wrote:
> Fixes: 93dd625f8bf7 ("tests/acpi: update expected data files")
> Signed-off-by: Andrew Jones <drjones@redhat.com>


Ah yes. Thanks for fixing this! I will add something to the pull request
script to catch this in the future.

> ---
>  tests/qtest/bios-tables-test-allowed-diff.h | 18 ------------------
>  1 file changed, 18 deletions(-)
> 
> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
> index 8992f1f12b77..dfb8523c8bf4 100644
> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> @@ -1,19 +1 @@
>  /* List of comma-separated changed AML files to ignore */
> -"tests/data/acpi/pc/DSDT",
> -"tests/data/acpi/pc/DSDT.acpihmat",
> -"tests/data/acpi/pc/DSDT.bridge",
> -"tests/data/acpi/pc/DSDT.cphp",
> -"tests/data/acpi/pc/DSDT.dimmpxm",
> -"tests/data/acpi/pc/DSDT.ipmikcs",
> -"tests/data/acpi/pc/DSDT.memhp",
> -"tests/data/acpi/pc/DSDT.numamem",
> -"tests/data/acpi/q35/DSDT",
> -"tests/data/acpi/q35/DSDT.acpihmat",
> -"tests/data/acpi/q35/DSDT.bridge",
> -"tests/data/acpi/q35/DSDT.cphp",
> -"tests/data/acpi/q35/DSDT.dimmpxm",
> -"tests/data/acpi/q35/DSDT.ipmibt",
> -"tests/data/acpi/q35/DSDT.memhp",
> -"tests/data/acpi/q35/DSDT.mmio64",
> -"tests/data/acpi/q35/DSDT.numamem",
> -"tests/data/acpi/q35/DSDT.tis",
> -- 
> 2.25.4


