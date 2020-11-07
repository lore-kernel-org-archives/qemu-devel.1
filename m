Return-Path: <SRS0=ex3l=EN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18251C388F9
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Nov 2020 16:27:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 770DA20888
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Nov 2020 16:27:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A9Tc0DW7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 770DA20888
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbR3l-0001tz-Ks
	for qemu-devel@archiver.kernel.org; Sat, 07 Nov 2020 11:27:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57376)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kbR2q-0001SM-Ke
 for qemu-devel@nongnu.org; Sat, 07 Nov 2020 11:26:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36926)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kbR2o-0003GU-Bk
 for qemu-devel@nongnu.org; Sat, 07 Nov 2020 11:26:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604766384;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ufsvo98XWeEy/yGxtQQncH+sT0NhqgG21ItevtmJxXk=;
 b=A9Tc0DW7pf5cTBAU6r5iZM6DdUjTVSizZcW4Kecc2ZzvHlJulRcaeAsbxV44zXuW5a3daN
 sBRDuKjlanuQ1N0h5GHp/sRvD7EfE5UC3nkbfQneoOMnR+kXG5ZFceTYTI2OrwnKbI9REZ
 6Smmnw1bN01rS9SEdqaTUjWqyRDWBMU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-234-0B4g6SHnOI-Db2WeebvRLw-1; Sat, 07 Nov 2020 11:26:22 -0500
X-MC-Unique: 0B4g6SHnOI-Db2WeebvRLw-1
Received: by mail-wr1-f71.google.com with SMTP id m20so1887737wrb.21
 for <qemu-devel@nongnu.org>; Sat, 07 Nov 2020 08:26:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=uci1kw+4ogbyUvzlEeySe+VC6YjbIEGSKC9ijqAwH7E=;
 b=cLLA9AflYl38k5cHFbpBOHZXMIIGJYvBnCLje86gDgMEIne40yE7uJ7gGGdLYPFjav
 vguOKBDdS5XBMMelZJJvpGMmfx8ikkvVxZZESaqEqcsfCyCfpoCmf60iPLjJLkVVh+e8
 jFAHWuedq2qtIStPG8W2ZAQznE8ov69bqMO4Vt+8v0RNyB/xhRKTOCFlEKjk/nR2VnsD
 DjbeJjIRnJZqo5zqpJkVya7HFRDgfiZWuHEyosuq6Ys8var0Ol0il5Ty7W95vmsHnGiu
 oobH9qgY91nZ+UTGDX+f4ZpjpqaPFLdfYJmkB5S0LGx9IDHoot20hqmneB5v/CSV2IAr
 HxwQ==
X-Gm-Message-State: AOAM531i9v3jdbg8EGJFA7J+YX1pHWoRP3bUrScaOonSK7iAY4Go2C3S
 jOxZ+Y8U7en3+6CtATB66+jRaYM6beTqTa09348YZ5kIn6F0A4Zl9VxkdwAkwpP7NEmfrWOScwe
 zaYogCu/Esc1m25I=
X-Received: by 2002:a1c:1f08:: with SMTP id f8mr5529375wmf.30.1604766381007;
 Sat, 07 Nov 2020 08:26:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxf9sKu+OvuPssZnR9fZvUUfBl/w6pz0FVLze7jPLSi5ANbKzzYd5QTTekIu8/mYr4/+ZlXaA==
X-Received: by 2002:a1c:1f08:: with SMTP id f8mr5529355wmf.30.1604766380792;
 Sat, 07 Nov 2020 08:26:20 -0800 (PST)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id b14sm7119321wrq.47.2020.11.07.08.26.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2020 08:26:20 -0800 (PST)
Date: Sat, 7 Nov 2020 11:26:16 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ani Sinha <ani@anisinha.ca>
Subject: Re: [PATCH-for-5.2] acpi-build: Fix maybe-uninitialized warning when
 ACPI hotplug is off
Message-ID: <20201107112417-mutt-send-email-mst@kernel.org>
References: <20201107150851.87008-1-ani@anisinha.ca>
MIME-Version: 1.0
In-Reply-To: <20201107150851.87008-1-ani@anisinha.ca>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/07 11:26:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 philmd@redhat.com, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Nov 07, 2020 at 08:38:51PM +0530, Ani Sinha wrote:
>  This fixes the following warning (gcc 9.3.0 on Ubuntu):
> 
>   ../hw/i386/acpi-build.c: In function 'build_append_pci_bus_devices':
>   ../hw/i386/acpi-build.c:496:9: error: 'method' may be used uninitialized
>   in this function [-Werror=maybe-uninitialized]
>     496 |         aml_append(parent_scope, method);
>         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   cc1: all warnings being treated as errors
> 
> Fixes: df4008c9c59 ("piix4: don't reserve hw resources when hotplug is off globally")
> Reported-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Signed-off-by: Ani Sinha <ani@anisinha.ca>
> ---
>  hw/i386/acpi-build.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 4f66642d88..79b86d4a36 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -349,7 +349,7 @@ static void build_append_pcihp_notify_entry(Aml *method, int slot)
>  static void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus,
>                                           bool pcihp_bridge_en)
>  {
> -    Aml *dev, *notify_method = NULL, *method;
> +    Aml *dev, *notify_method = NULL, *method = NULL;
>      QObject *bsel;
>      PCIBus *sec;
>      int i;
> @@ -492,7 +492,7 @@ static void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus,
>          }
>      }
>  
> -    if (bsel || pcihp_bridge_en) {
> +    if (method) {
>          aml_append(parent_scope, method);
>      }
>      qobject_unref(bsel);

I prefer Philippe's fix I think - gcc does not warn about it but
using method when it's NULL would lead to a crash.

> -- 
> 2.25.1


