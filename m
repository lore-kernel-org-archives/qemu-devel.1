Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6A8EC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 09:13:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E4E32078D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 09:13:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mf3M4Aci"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E4E32078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjJHN-0005EX-Ke
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 05:13:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53384)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jjJGX-0004X4-Hp
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 05:12:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49209
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jjJGW-0000d0-K9
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 05:12:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591866771;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZsoscfCvdkg8s4wsIjTzcBYYqaWpJ6lnl4W+krrDGBA=;
 b=Mf3M4AciRBemjslQfIQG1NSPNLOyBu4O5oHN1VJusb2cdB+zR4g2mSImgp9EMZoXcPGghP
 B3hcFWBduP0DsWXHqyaWpG0ipXQskMCtZwiKut5dCQKSmM63+691mZi8xjgP+rxJM/eXSJ
 j5U/GymVTxGsG80UyCPPe4jEwh+96dU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-v7CbhLuzOWyPfkRqkmUeJA-1; Thu, 11 Jun 2020 05:12:49 -0400
X-MC-Unique: v7CbhLuzOWyPfkRqkmUeJA-1
Received: by mail-wm1-f72.google.com with SMTP id h25so2715411wmb.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2020 02:12:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=0HWAYZ639OEhv2hrl5gPyW8DRUe15/VfBg7adjTrSWQ=;
 b=nY6I+mnW8zCnHFDdXUK5J1Mkga5KWBUt/AeqTrqlIz37nZZsNS1Ktg8PuZulmKKpai
 mMx/Fa9SRpj6o5K/EFw8MxpzRPqSMQhwFt6eNJ7VkCYMQe0TSvU4AFc7Pgr7AbUS+X6s
 0FIbvsfFFH1cIGg2KGT+GojZ3NS9lyL4ouKpKFy7EN97Vm52fnnVWh9qXh6nTU3ryzqR
 Cz8nNQPBeQ6jAQcn1N1pPYtZ/Ga8KHC0JTuphOd/ML+u8X73cMMXB2jK6xxS5eIb0ws9
 oG5pbeAV4o5J9W513+RubXqXAIauQUNjyLmvyjoeGXbED1jzLcwmGpZVvYyEJt4o5yjM
 EiIg==
X-Gm-Message-State: AOAM531jAyxVDIH8VTAReHPBLUG/TItrlrYPA1aQqc/I4CCwQEeWSn00
 8THhTtCb1P6S3POHDoMXPRDxXiZRtlZTRMByQsaT729WRUdRWEkqfyOgrGWjrRDVcqyI1Ovnwuk
 hwLSViPYElZoFaJA=
X-Received: by 2002:a1c:32c4:: with SMTP id y187mr7288842wmy.79.1591866768411; 
 Thu, 11 Jun 2020 02:12:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz5J8g/Z3HIn9zuZRsYdbzDrrGMOfm8K1AyJLYfsW2R/DE2vYbA+/z/VGsOIRXGyX6pL2en+g==
X-Received: by 2002:a1c:32c4:: with SMTP id y187mr7288799wmy.79.1591866767976; 
 Thu, 11 Jun 2020 02:12:47 -0700 (PDT)
Received: from redhat.com (bzq-79-181-55-232.red.bezeqint.net. [79.181.55.232])
 by smtp.gmail.com with ESMTPSA id m129sm3595627wmf.2.2020.06.11.02.12.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2020 02:12:47 -0700 (PDT)
Date: Thu, 11 Jun 2020 05:12:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH v8 10/10] acpi: q35: drop _SB.PCI0.ISA.LPCD opregion.
Message-ID: <20200611051228-mutt-send-email-mst@kernel.org>
References: <20200611072919.16638-1-kraxel@redhat.com>
 <20200611072919.16638-11-kraxel@redhat.com>
 <49164120-0186-5ae2-0690-98e27a82c5ab@redhat.com>
 <0d74324f-47a1-203a-9623-1cacb948a6d5@redhat.com>
MIME-Version: 1.0
In-Reply-To: <0d74324f-47a1-203a-9623-1cacb948a6d5@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 03:29:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 11, 2020 at 10:31:01AM +0200, Philippe Mathieu-Daudé wrote:
> On 6/11/20 10:27 AM, Philippe Mathieu-Daudé wrote:
> > Hi Gerd,
> > 
> > On 6/11/20 9:29 AM, Gerd Hoffmann wrote:
> >> Seems to be unused.
> >>
> >> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> >> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> >> ---
> >>  hw/i386/acpi-build.c | 11 -----------
> >>  1 file changed, 11 deletions(-)
> >>
> >> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> >> index 02cf4199c2e9..d93ea40c58b9 100644
> >> --- a/hw/i386/acpi-build.c
> >> +++ b/hw/i386/acpi-build.c
> >> @@ -1296,7 +1296,6 @@ static void build_q35_isa_bridge(Aml *table)
> >>  {
> >>      Aml *dev;
> >>      Aml *scope;
> >> -    Aml *field;
> >>  
> >>      scope =  aml_scope("_SB.PCI0");
> >>      dev = aml_device("ISA");
> >> @@ -1306,16 +1305,6 @@ static void build_q35_isa_bridge(Aml *table)
> >>      aml_append(dev, aml_operation_region("PIRQ", AML_PCI_CONFIG,
> >>                                           aml_int(0x60), 0x0C));
> >>  
> >> -    aml_append(dev, aml_operation_region("LPCD", AML_PCI_CONFIG,
> >> -                                         aml_int(0x80), 0x02));
> >> -    field = aml_field("LPCD", AML_ANY_ACC, AML_NOLOCK, AML_PRESERVE);
> >> -    aml_append(field, aml_named_field("COMA", 3));
> >> -    aml_append(field, aml_reserved_field(1));
> >> -    aml_append(field, aml_named_field("COMB", 3));
> >> -    aml_append(field, aml_reserved_field(1));
> >> -    aml_append(field, aml_named_field("LPTD", 2));
> >> -    aml_append(dev, field);
> >> -
> >>      aml_append(scope, dev);
> >>      aml_append(table, scope);
> >>  }
> >>
> > 
> > I'm a bit confused, isn't it use to describe these
> > devices?
> > 
> > (qemu) info qtree
> > bus: main-system-bus
> >   type System
> >   dev: q35-pcihost, id ""
> >     bus: pcie.0
> >       type PCIE
> >       dev: ICH9-LPC, id ""
> >         gpio-out "gsi" 24
> >         class ISA bridge, addr 00:1f.0, pci id 8086:2918 (sub 1af4:1100)
> >         bus: isa.0
> >           type ISA
> >           dev: port92, id ""
> >             gpio-out "a20" 1
> >           dev: vmmouse, id ""
> >           dev: vmport, id ""
> >           dev: isa-parallel, id ""
> >             index = 0 (0x0)
> >             iobase = 888 (0x378)
> >             irq = 7 (0x7)
> >             chardev = "parallel0"
> >             isa irq 7
> >           dev: isa-serial, id ""
> >             index = 1 (0x1)
> >             iobase = 760 (0x2f8)
> >             irq = 3 (0x3)
> >             chardev = "serial1"
> >             wakeup = 0 (0x0)
> >             isa irq 3
> >           dev: isa-serial, id ""
> >             index = 0 (0x0)
> >             iobase = 1016 (0x3f8)
> >             irq = 4 (0x4)
> >             chardev = "serial0"
> >             wakeup = 0 (0x0)
> >             isa irq 4
> > 
> 
> Ah, this patch complements the previous "acpi: drop serial/parallel
> enable bits from dsdt", right? Maybe better to include this change
> with the build_q35_isa_bridge() part. Like in a single patch:
> "acpi: q35: drop lpc/serial/parallel enable bits from dsdt"
> 
> Then keep the PIIX part of the patches.

Don't see why really.

-- 
MST


