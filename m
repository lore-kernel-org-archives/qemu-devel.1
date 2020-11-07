Return-Path: <SRS0=ex3l=EN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76529C388F7
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Nov 2020 14:33:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5298207C3
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Nov 2020 14:33:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fcm/5Rce"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5298207C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbPHx-0006Vm-TB
	for qemu-devel@archiver.kernel.org; Sat, 07 Nov 2020 09:33:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39502)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kbPGu-00061h-Et
 for qemu-devel@nongnu.org; Sat, 07 Nov 2020 09:32:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46364)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kbPGs-0005EC-JI
 for qemu-devel@nongnu.org; Sat, 07 Nov 2020 09:32:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604759568;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EcUVtki8sIU2xFBIxNA5ILiarcP9HygasBHQgu4oKus=;
 b=Fcm/5Rceglk72OXlWMza3fPM2tQjugtB71c/cqaTGnQ9Zy27kaALl7UswjjUCmeloJTCOi
 9GFeUk8hroX2Z5C/G+CrGwtW0nTInvWpigurKwMPB207W3iOONd2YbhQkuSkdK6OjQhy80
 0/9bISayth5YxfhAIr2p5zzZ/HJVt6I=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-543-74KDcw4wPnOE5FDW-dI-0w-1; Sat, 07 Nov 2020 09:32:46 -0500
X-MC-Unique: 74KDcw4wPnOE5FDW-dI-0w-1
Received: by mail-wr1-f69.google.com with SMTP id q15so1781446wrw.8
 for <qemu-devel@nongnu.org>; Sat, 07 Nov 2020 06:32:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=7/SFI+s6Z5NMdqcBmjkM1HMmGPIg6ydQ+GsmMN+ptGc=;
 b=kxkpaWw3wVvVXdvTp8pLyhFt1PyZutr4DrG41bWqzio8pHSEB5VKIM6pq36FghTiJ/
 P/fUsSOvNnqviFaG4MPBvMOm2mq/gUfZcuE128qYCjK0DeMwre6aj14g6zcKPvVPJFRl
 xLKBxrA6KCtJhZRcektANDzWAUccEDM3AanPnLL/bHiS6yscuwlhHt6pVu7Kye+EpdP2
 neKDlo/VjmhNJ7CEpMp5pYggGqUUqRNnJoiq82CDsl2P+DdtFmhdT53A+AtcO9VIRXVd
 dpGBRI7ONzhEZTcEAWoFRGfEFkgijDIKemPTiM3BJ3sFfXHCb7eXUWcTBO6it2CYN301
 PEyQ==
X-Gm-Message-State: AOAM5310Gzlzuak3dZHfplfg9qLCsioVmu0lsTO/jzS4TjUNroU/8Q2w
 vDvlrmoWUdf0VDJea/ZS/rznOopN0YZ1QGRuWyA9sQk0/Vm0vIF6tPtBue4V8h2+aLskd67ivVw
 B6ZzIr7CxzOGGUqY=
X-Received: by 2002:a7b:c2f7:: with SMTP id e23mr5112287wmk.100.1604759565444; 
 Sat, 07 Nov 2020 06:32:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz9OYyA1sN6JjHKTDtKUFuQbptNzppyUoKs6l6YCvM0E3CQfNZO9j5O4Duz+mk/j7ULy29qBg==
X-Received: by 2002:a7b:c2f7:: with SMTP id e23mr5112270wmk.100.1604759565190; 
 Sat, 07 Nov 2020 06:32:45 -0800 (PST)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id b14sm2194380wrs.46.2020.11.07.06.32.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2020 06:32:44 -0800 (PST)
Date: Sat, 7 Nov 2020 09:32:41 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [RFC PATCH-for-5.2] hw/i386/acpi-build: Fix maybe-uninitialized
 error when ACPI hotplug off
Message-ID: <20201107092914-mutt-send-email-mst@kernel.org>
References: <20201107102940.239877-1-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201107102940.239877-1-philmd@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/07 03:59:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <ani@anisinha.ca>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Nov 07, 2020 at 11:29:40AM +0100, Philippe Mathieu-Daudé wrote:
> 'method' can be left uninitialized. Restrict some code to be used
> only in the "if (bsel || pcihp_bridge_en)" block statement.
> 
> This fixes (gcc 9.3.0 on Ubuntu):
> 
>   ../hw/i386/acpi-build.c: In function 'build_append_pci_bus_devices':
>   ../hw/i386/acpi-build.c:496:9: error: 'method' may be used uninitialized
>   in this function [-Werror=maybe-uninitialized]
>     496 |         aml_append(parent_scope, method);
>         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   cc1: all warnings being treated as errors

This code is already in the "if (bsel || pcihp_bridge_en)" block statement.
the compiler just isn't smart enough to figure it out.
I do like the change though, I think repeating the condition
is fragile, it is better to have it in a single place.
Pls repost with method can be left -> gcc 9 thinks that method can be left,
no RFC tag, and I will apply.

> Fixes: df4008c9c59 ("piix4: don't reserve hw resources when hotplug is off globally")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
> RFC because I have no clue about this code
> ---
>  hw/i386/acpi-build.c | 45 +++++++++++++++++++++-----------------------
>  1 file changed, 21 insertions(+), 24 deletions(-)
> 
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 4f66642d887..1f5c2112452 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -465,34 +465,31 @@ static void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus,
>       */
>      if (bsel || pcihp_bridge_en) {
>          method = aml_method("PCNT", 0, AML_NOTSERIALIZED);
> -    }
> -    /* If bus supports hotplug select it and notify about local events */
> -    if (bsel) {
> -        uint64_t bsel_val = qnum_get_uint(qobject_to(QNum, bsel));
>  
> -        aml_append(method, aml_store(aml_int(bsel_val), aml_name("BNUM")));
> -        aml_append(method,
> -            aml_call2("DVNT", aml_name("PCIU"), aml_int(1) /* Device Check */)
> -        );
> -        aml_append(method,
> -            aml_call2("DVNT", aml_name("PCID"), aml_int(3)/* Eject Request */)
> -        );
> -    }
> +        /* If bus supports hotplug select it and notify about local events */
> +        if (bsel) {
> +            uint64_t bsel_val = qnum_get_uint(qobject_to(QNum, bsel));
>  
> -    /* Notify about child bus events in any case */
> -    if (pcihp_bridge_en) {
> -        QLIST_FOREACH(sec, &bus->child, sibling) {
> -            int32_t devfn = sec->parent_dev->devfn;
> -
> -            if (pci_bus_is_root(sec) || pci_bus_is_express(sec)) {
> -                continue;
> -            }
> -
> -            aml_append(method, aml_name("^S%.02X.PCNT", devfn));
> +            aml_append(method, aml_store(aml_int(bsel_val), aml_name("BNUM")));
> +            aml_append(method, aml_call2("DVNT", aml_name("PCIU"),
> +                                         aml_int(1))); /* Device Check */
> +            aml_append(method, aml_call2("DVNT", aml_name("PCID"),
> +                                         aml_int(3))); /* Eject Request */
> +        }
> +
> +        /* Notify about child bus events in any case */
> +        if (pcihp_bridge_en) {
> +            QLIST_FOREACH(sec, &bus->child, sibling) {
> +                int32_t devfn = sec->parent_dev->devfn;
> +
> +                if (pci_bus_is_root(sec) || pci_bus_is_express(sec)) {
> +                    continue;
> +                }
> +
> +                aml_append(method, aml_name("^S%.02X.PCNT", devfn));
> +            }
>          }
> -    }
>  
> -    if (bsel || pcihp_bridge_en) {
>          aml_append(parent_scope, method);
>      }
>      qobject_unref(bsel);
> -- 
> 2.26.2


