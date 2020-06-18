Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 210D1C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 20:09:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF9DC208C3
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 20:08:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a+BBgN0A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF9DC208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jm0qJ-0005AE-5Q
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 16:08:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51344)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jm0pZ-0003mN-Q8
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 16:08:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35478
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jm0pX-0000fO-O5
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 16:08:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592510891;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E2T9glCN9ZT+LzhJ0kj9tITBKG4HCCUKql83sh6kgVE=;
 b=a+BBgN0AkBx7n3RXeyUZn6n5bCABWFdAjZBh0R7S8g+q22ZAUVwHhnoot92scUnpMxn04I
 elb4zZz+f9Wq7xHA9U/ovsw/LAjeZ6/Pl5a1DRoQmOMB+XOKcldk6tAok+kKKs+LL3X0iu
 FNS73l0ukBZWw+RDBSygpdwT+dBlIQ8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-462-DuS4fyzVOz6kItscwnY1uQ-1; Thu, 18 Jun 2020 16:08:08 -0400
X-MC-Unique: DuS4fyzVOz6kItscwnY1uQ-1
Received: by mail-wr1-f69.google.com with SMTP id a4so3220655wrp.5
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2020 13:08:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=E2T9glCN9ZT+LzhJ0kj9tITBKG4HCCUKql83sh6kgVE=;
 b=NV1ixwlUDWa/VsbODZx6YAtiXpbxcAgEFLSufsPzHQaVYJ2iJ0pz2HjihxxC+dzdGA
 Xwhem2A94mzFSAVlRaS5oS52WkMsWkBfMjYy4QzZYyveDn+q64M68YPP7k3vXkPfafIf
 zbpKgn8JqeSwa/vP0NB5YKdcSxMWQYr2rwHWTbFvUFLtauP0lXEthXCbE5aTLfN0wVUn
 i5CMC1NB+gX12jGAR2LNWAkR7ero2SRvrKPBL0RzX9GRriQ15+FwVzJJYKhHtQkejP2E
 wc6fKo3/uVyRd26zAUCBhLG8VHsgLtbPLdDxsfBjTqMU9tokQ9dV9ypnKwxpq82KyvJn
 34AQ==
X-Gm-Message-State: AOAM53385ZH7LzGN/yWceFmjbTQzqWhQoh0EOZmLU4y6HEqqO8Gkb703
 tvxgGBaBHXfVmPkgnWVd8m9anPPXrl/RtEohdYy3IN7ye4OI5xyTXhdfRdSEZu5NvUp59SXuNQS
 OJ8iEcNmmPxd7y+k=
X-Received: by 2002:a1c:7e94:: with SMTP id z142mr39716wmc.124.1592510885728; 
 Thu, 18 Jun 2020 13:08:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwZAxUjh12/e5mAsuphFWPcxErPYVK0iuT1UQPM2JVrfEZVfTLgXbbcOtnQEtS+lGkEG8BNGA==
X-Received: by 2002:a1c:7e94:: with SMTP id z142mr39674wmc.124.1592510885347; 
 Thu, 18 Jun 2020 13:08:05 -0700 (PDT)
Received: from redhat.com (bzq-79-178-18-124.red.bezeqint.net. [79.178.18.124])
 by smtp.gmail.com with ESMTPSA id x18sm4611575wmi.35.2020.06.18.13.08.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2020 13:08:04 -0700 (PDT)
Date: Thu, 18 Jun 2020 16:08:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v9 08/10] acpi: drop serial/parallel enable bits from dsdt
Message-ID: <20200618160735-mutt-send-email-mst@kernel.org>
References: <20200617071138.11159-1-kraxel@redhat.com>
 <20200617071138.11159-9-kraxel@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200617071138.11159-9-kraxel@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/18 15:52:30
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
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 17, 2020 at 09:11:36AM +0200, Gerd Hoffmann wrote:
> The _STA methods for COM+LPT used to reference them,
> but that isn't the case any more.
> 
> piix4 DSDT changes:
> 
>      Scope (_SB.PCI0)
>      {
>          Device (ISA)
>          {
>              Name (_ADR, 0x00010000)  // _ADR: Address
>              OperationRegion (P40C, PCI_Config, 0x60, 0x04)
> -            Field (^PX13.P13C, AnyAcc, NoLock, Preserve)
> -            {
> -                Offset (0x5F),
> -                    ,   7,
> -                LPEN,   1,
> -                Offset (0x67),
> -                    ,   3,
> -                CAEN,   1,
> -                    ,   3,
> -                CBEN,   1
> -            }
>          }
>      }
> 
> ich9 DSDT changes:
> 
>      Scope (_SB.PCI0)
>      {
>          Device (ISA)
>          {
>              Name (_ADR, 0x001F0000)  // _ADR: Address
>              OperationRegion (PIRQ, PCI_Config, 0x60, 0x0C)
>              OperationRegion (LPCD, PCI_Config, 0x80, 0x02)
>              Field (LPCD, AnyAcc, NoLock, Preserve)
>              {
>                  COMA,   3,
>                      ,   1,
>                  COMB,   3,
>                  Offset (0x01),
>                  LPTD,   2
>              }
> -
> -            OperationRegion (LPCE, PCI_Config, 0x82, 0x02)
> -            Field (LPCE, AnyAcc, NoLock, Preserve)
> -            {
> -                CAEN,   1,
> -                CBEN,   1,
> -                LPEN,   1
> -            }
>          }
>      }
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>

Don't make binary file changes with source changes.
Pls follow process at top of tests/qtest/bios-tables-test.c

> ---
>  hw/i386/acpi-build.c              |  23 -----------------------
>  tests/data/acpi/pc/DSDT           | Bin 5014 -> 4972 bytes
>  tests/data/acpi/pc/DSDT.acpihmat  | Bin 6338 -> 6296 bytes
>  tests/data/acpi/pc/DSDT.bridge    | Bin 6873 -> 6831 bytes
>  tests/data/acpi/pc/DSDT.cphp      | Bin 5477 -> 5435 bytes
>  tests/data/acpi/pc/DSDT.dimmpxm   | Bin 6667 -> 6625 bytes
>  tests/data/acpi/pc/DSDT.ipmikcs   | Bin 5086 -> 5044 bytes
>  tests/data/acpi/pc/DSDT.memhp     | Bin 6373 -> 6331 bytes
>  tests/data/acpi/pc/DSDT.numamem   | Bin 5020 -> 4978 bytes
>  tests/data/acpi/q35/DSDT          | Bin 7752 -> 7718 bytes
>  tests/data/acpi/q35/DSDT.acpihmat | Bin 9076 -> 9042 bytes
>  tests/data/acpi/q35/DSDT.bridge   | Bin 7769 -> 7735 bytes
>  tests/data/acpi/q35/DSDT.cphp     | Bin 8215 -> 8181 bytes
>  tests/data/acpi/q35/DSDT.dimmpxm  | Bin 9405 -> 9371 bytes
>  tests/data/acpi/q35/DSDT.ipmibt   | Bin 7827 -> 7793 bytes
>  tests/data/acpi/q35/DSDT.memhp    | Bin 9111 -> 9077 bytes
>  tests/data/acpi/q35/DSDT.mmio64   | Bin 8882 -> 8848 bytes
>  tests/data/acpi/q35/DSDT.numamem  | Bin 7758 -> 7724 bytes
>  tests/data/acpi/q35/DSDT.tis      | Bin 8357 -> 8323 bytes
>  19 files changed, 23 deletions(-)
> 
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index d27cecc877c4..ffbdbee51aa8 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -1360,15 +1360,6 @@ static void build_q35_isa_bridge(Aml *table)
>      aml_append(field, aml_named_field("LPTD", 2));
>      aml_append(dev, field);
>  
> -    aml_append(dev, aml_operation_region("LPCE", AML_PCI_CONFIG,
> -                                         aml_int(0x82), 0x02));
> -    /* enable bits */
> -    field = aml_field("LPCE", AML_ANY_ACC, AML_NOLOCK, AML_PRESERVE);
> -    aml_append(field, aml_named_field("CAEN", 1));
> -    aml_append(field, aml_named_field("CBEN", 1));
> -    aml_append(field, aml_named_field("LPEN", 1));
> -    aml_append(dev, field);
> -
>      aml_append(scope, dev);
>      aml_append(table, scope);
>  }
> @@ -1392,7 +1383,6 @@ static void build_piix4_isa_bridge(Aml *table)
>  {
>      Aml *dev;
>      Aml *scope;
> -    Aml *field;
>  
>      scope =  aml_scope("_SB.PCI0");
>      dev = aml_device("ISA");
> @@ -1401,19 +1391,6 @@ static void build_piix4_isa_bridge(Aml *table)
>      /* PIIX PCI to ISA irq remapping */
>      aml_append(dev, aml_operation_region("P40C", AML_PCI_CONFIG,
>                                           aml_int(0x60), 0x04));
> -    /* enable bits */
> -    field = aml_field("^PX13.P13C", AML_ANY_ACC, AML_NOLOCK, AML_PRESERVE);
> -    /* Offset(0x5f),, 7, */
> -    aml_append(field, aml_reserved_field(0x2f8));
> -    aml_append(field, aml_reserved_field(7));
> -    aml_append(field, aml_named_field("LPEN", 1));
> -    /* Offset(0x67),, 3, */
> -    aml_append(field, aml_reserved_field(0x38));
> -    aml_append(field, aml_reserved_field(3));
> -    aml_append(field, aml_named_field("CAEN", 1));
> -    aml_append(field, aml_reserved_field(3));
> -    aml_append(field, aml_named_field("CBEN", 1));
> -    aml_append(dev, field);
>  
>      aml_append(scope, dev);
>      aml_append(table, scope);
> diff --git a/tests/data/acpi/pc/DSDT b/tests/data/acpi/pc/DSDT
> index 384a82dbb3cb0e9f47db6f4d08945631c2b72b56..d9074ac8df7ff21f214a5f4a135e3d1ac2c86227 100644
> GIT binary patch
> delta 62
> zcmbQH{zi?<CD<h-N0@<uan(jH8%8xXz4&0K_yA{5gXktH&tS)Rj(A6xAReGRLv%xc
> QiGec{R{|Hy;%SUR007+&8UO$Q
> 
> delta 104
> zcmaE(Hcg$&CD<ionlJ+cW7|e98^!<!R=xOOr}zM8PlM<tXBN+3$9Rr-N0%TTpbCcQ
> zh5!=-XC|%$E|%y<wK%<i2t(rlLt|$K1`mA(cAo%OKSl-%24-hR5QEv-2}mu@VH5%Y
> DFIE>C
> 
> diff --git a/tests/data/acpi/pc/DSDT.acpihmat b/tests/data/acpi/pc/DSDT.acpihmat
> index 47ddfdb027b06dc2daa46be711c3f4640ce68320..8d76c7c01d49087cc5efb9843a2e1d0865145017 100644
> GIT binary patch
> delta 63
> zcmX?PIKz<3CD<ioh6DoxW5q@;8%8xXz4&0K_yA{5gXktH&tS)Rj(A6xAReGRLv%xc
> RiGec{R{|Hy=4p&N;s6aH4@Uq1
> 
> delta 105
> zcmbPXc*u~;CD<k8kOTt*W5`A>8^!<!R=xOOr}zM8PlM<tXBN+3$9Rr-N0%TTpbCcQ
> zh5!=-XC|%$E|%y<wK%<i2t(rlLt|$K1`mA(cAo%OKSl-%24-hR5QEv-2}o_uVbl=^
> E06$b0M*si-
> 
> diff --git a/tests/data/acpi/pc/DSDT.bridge b/tests/data/acpi/pc/DSDT.bridge
> index d1e2fa9fb8c75160fc1fa46deed6a6a9cb515559..6ffae63dd8fcc4f617b9d9d57d79bd46a7253064 100644
> GIT binary patch
> delta 63
> zcmca<y55w_CD<ioy%Ylj<L8ZBHjHX&dhx+d@d3`B2GLDYp23ds9Py4WK|DZthUkU>
> R69Z=^t^_WY&C?j2B>^`q5Gnuw
> 
> delta 105
> zcmZ2)defB4CD<k8rW6AM<N1wTHjDudta|amPVoWGo(9oP&Mcn6j`1AvjxIqwKotzp
> z4FM(w&P-ehTrAOzYH@l25r)PAhQ`he3?BLn>^=dmevAwj49w1sAO^Fu6Oh`R!{{st
> E0E&YcDgXcg
> 
> diff --git a/tests/data/acpi/pc/DSDT.cphp b/tests/data/acpi/pc/DSDT.cphp
> index 54f481faf1e336c0bbf5e774cd67220fe06e951b..b25bbf7dc5bbabea277d3402b90d376beb038043 100644
> GIT binary patch
> delta 63
> zcmaE=wOfnJCD<jzT9ko-QF$Ym4WpWxUVN}qe1Nm3L3ERpXRu>DN4%p;5D!qEA-W;J
> R#K4(}D}jq;^EAfu!T|Sh4`~1Z
> 
> delta 105
> zcmdn3^;C<?CD<h-Rg{5&@&86H8^!<!R=xOOr}zM8PlM<tXBN+3$9Rr-N0%TTpbCcQ
> zh5!=-XC|%$E|%y<wK%<i2t(rlLt|$K1`mA(cAo%OKSl-%24-hR5QEv-2}o_uVLUGk
> E0B|rEX#fBK
> 
> diff --git a/tests/data/acpi/pc/DSDT.dimmpxm b/tests/data/acpi/pc/DSDT.dimmpxm
> index 5d98016ae571cde04ff96d58212e0faf9aaf50e6..7dffca09865f1c5d4f94e67dfe308bf22a45664a 100644
> GIT binary patch
> delta 63
> zcmeA+d1%b#66_N4P?CXxk$WST4WpWxUVN}qe1Nm3L3ERpXRu>DN4%p;5D!qEA-W;J
> R#K4(}D}jq;^EAd%2>=a%4}|~#
> 
> delta 105
> zcmaE8+-<_;66_MfEycjV_-rGW4P$@<t6qGtQ+$B4r$Ka+GmB@iV?0N^qe~DEPz6JD
> zLx72aGZR+=7fW=bTAW@$grRYOp|LXqgNHr?yH9|tA0vYW1GBRuh{5da1f(|SFqTRH
> E06D!Eg#Z8m
> 
> diff --git a/tests/data/acpi/pc/DSDT.ipmikcs b/tests/data/acpi/pc/DSDT.ipmikcs
> index 1c19e2f354d022279d7e1343fa7212396d8c25a0..5a039ac93c42d4b123e21d51c5799ddb42bf12a0 100644
> GIT binary patch
> delta 63
> zcmcbozD1qOCD<ioi!cKNquoX>8%8xXz4&0K_yA{5gXktH&tS)Rj(A6xAReGRLv%xc
> RiGec{R{|Hy=4p%`LI4lt4_^QP
> 
> delta 105
> zcmdm@eovjtCD<k8o-hLgqtr$&8^!<!R=xOOr}zM8PlM<tXBN+3$9Rr-N0%TTpbCcQ
> zh5!=-XC|%$E|%y<wK%<i2t(rlLt|$K1`mA(cAo%OKSl-%24-hR5QEv-2}o_uVe}9J
> E0760+UjP6A
> 
> diff --git a/tests/data/acpi/pc/DSDT.memhp b/tests/data/acpi/pc/DSDT.memhp
> index 8cb90ef14e13be85995c6fe3d3f6d12f4d939504..a5b60b0e9c7d77fdc770687e28502b7dc6246dcd 100644
> GIT binary patch
> delta 63
> zcmaEAxZ9A+CD<iow*&(N<D89LHjHX&dhx+d@d3`B2GLDYp23ds9Py4WK|DZthUkU>
> R69Z=^t^_WY&C?kD#Q`j#5BC57
> 
> delta 105
> zcmdmO_|%ZgCD<k8sRRQ9W5q@;8^!<!R=xOOr}zM8PlM<tXBN+3$9Rr-N0%TTpbCcQ
> zh5!=-XC|%$E|%y<wK%<i2t(rlLt|$K1`mA(cAo%OKSl-%24-hR5QEv-2}o_uVe}UV
> E0Cn~k_W%F@
> 
> diff --git a/tests/data/acpi/pc/DSDT.numamem b/tests/data/acpi/pc/DSDT.numamem
> index f194bc639482eb839a875d493857526f85f1a9e0..b82e13cd12017c7197cc236d9cc161e28dcfc8b1 100644
> GIT binary patch
> delta 63
> zcmbQE{z;9?CD<jTNSJ|vF=Qi`4WpWxUVN}qe1Nm3L3ERpXRu>DN4%p;5D!qEA-W;J
> R#K4(}D}jq;^E5^_ApisS4(tE`
> 
> delta 105
> zcmeyQHb<SyCD<iojxYlQqrpZl8^!<!R=xOOr}zM8PlM<tXBN+3$9Rr-N0%TTpbCcQ
> zh5!=-XC|%$E|%y<wK%<i2t(rlLt|$K1`mA(cAo%OKSl-%24-hR5QEv-2}o_uVPq2m
> E053=u>;M1&
> 
> diff --git a/tests/data/acpi/q35/DSDT b/tests/data/acpi/q35/DSDT
> index 6a5e4dd85a7d9a95f7ad0fb95e6a4fa7a8d91adb..dada9bf69fc23ea9c0931029445257657fde90ce 100644
> GIT binary patch
> delta 44
> zcmX?Mv&@FeCD<iIO^$(q@!v+S`HcL2EPC<5PVoWGo(9oPjx3XRFxqdHWYU)b03uKf
> AasU7T
> 
> delta 79
> zcmZ2xbHawpCD<jzLym!g@ybT7`HcJy?0WIRPVoWGo(9oP&TNx+Fxo3cH~0iNyE1V#
> eaWO?Vih|e-&W^5rjLuF#!Y2SoZ2r!uF9QH_gcWfB
> 
> diff --git a/tests/data/acpi/q35/DSDT.acpihmat b/tests/data/acpi/q35/DSDT.acpihmat
> index c1dd7773f3386a946fcb4a9a3bf9ad3a33ddbbe9..134fcffc3036c250877a50847426b2fe6d4229d7 100644
> GIT binary patch
> delta 44
> zcmez3cFB#)CD<h-NST3w@ytf9`HcL2EPC<5PVoWGo(9oPjx3XRFxqdHWQtY<05y*d
> A4gdfE
> 
> delta 79
> zcmccQ_Qj3MCD<jTM45qsanVMu`HcJy?0WIRPVoWGo(9oP&TNx+Fxo3cH~0iNyE1V#
> eaWO?Vih|e-&W^5rjLuF#!Y2SoZ2ry|tq1^=WEKqo
> 
> diff --git a/tests/data/acpi/q35/DSDT.bridge b/tests/data/acpi/q35/DSDT.bridge
> index 2ef1e894a35b9e85fe07e2678bd2456f5ec40dc6..6be4ccde643b3bba57f827c65490fa3a328ca77e 100644
> GIT binary patch
> delta 44
> zcmca<v)zWvCD<jzT#kW(ao$F*`HcL2EPC<5PVoWGo(9oPjx3XRFxqdHWO9%J03SOH
> ARsaA1
> 
> delta 79
> zcmdmPbJK>)CD<h-QjURvv1B9Hd`5l;cD?vur}zM8PlM<tXST^Z810p!8+-zsU75I=
> exR|0FML}!^XGd2*MrS7=;S&HPHh*VykO2T`NEKB8
> 
> diff --git a/tests/data/acpi/q35/DSDT.cphp b/tests/data/acpi/q35/DSDT.cphp
> index 74e86176e5fec46e660c567acf8fbcf08a14bdfb..d076236552c60b275bd91e59ab03ea8d96ccc9ea 100644
> GIT binary patch
> delta 44
> zcmbR4@YSBnCD<k8t2_e(W5q_U`HcL2EPC<5PVoWGo(9oPjx3XRFxqdHWcnuy05)3<
> Au>b%7
> 
> delta 79
> zcmexrKiz@LCD<iIT!Dds(RU-)d`5l;cD?vur}zM8PlM<tXST^Z810p!8+-zsU75I=
> exR|0FML}!^XGd2*MrS7=;S&HPHh*XQCkp^jz7?<l
> 
> diff --git a/tests/data/acpi/q35/DSDT.dimmpxm b/tests/data/acpi/q35/DSDT.dimmpxm
> index 4bf8e9d64b04f9f805047d6850c2dd0086970445..eeef0a4c15828b3a621aab88eafb3631ff85a960 100644
> GIT binary patch
> delta 44
> zcmdn%Iop%VCD<iowh99SqvJ-d`HcL2EPC<5PVoWGo(9oPjx3XRFxqdHWLlyG03LS?
> AuK)l5
> 
> delta 79
> zcmbR3x!04+CD<iouL=VLqxeRy`HcJy?0WIRPVoWGo(9oP&TNx+Fxo3cH~0iNyE1V#
> eaWO?Vih|e-&W^5rjLuF#!Y2SoZ2r!;L<s<9F%_-=
> 
> diff --git a/tests/data/acpi/q35/DSDT.ipmibt b/tests/data/acpi/q35/DSDT.ipmibt
> index 0173c3668a6cdef80127de7880a19cb5c5ea7dc0..5d89b41a1878bb0c77abda0807bcc833c7538581 100644
> GIT binary patch
> delta 44
> zcmbPi`_YEWCD<jTP>z9t(P$&rd`5mh7QOgjr}zM8PlM<tN0!Mu80|MpGF8a{02rJM
> AQvd(}
> 
> delta 79
> zcmexpGuf8QCD<iovK#{gBgaOr`HcJy?0WIRPVoWGo(9oP&TNx+Fxo3cH~0iNyE1V#
> eaWO?Vih|e-&W^5rjLuF#!Y2SoZ2rzzB?ACkP!&=D
> 
> diff --git a/tests/data/acpi/q35/DSDT.memhp b/tests/data/acpi/q35/DSDT.memhp
> index 98328d1c4197ab19a71de7f3f18e2985f4910f45..ad0608ef4d22de894e0a72596c2b15dead384903 100644
> GIT binary patch
> delta 44
> zcmbR4{?(1kCD<jTRGEQ+@xw;0`HcL2EPC<5PVoWGo(9oPjx3XRFxqdHWU5mH05ro5
> AKL7v#
> 
> delta 79
> zcmezBHr<`eCD<iox-tU;<FSog^BMUa*!ALro#F$WJq@CpoY^MtV6<0?Ztw|kc4gvf
> e;$n(!6a}#voE=^L7@eJfgiipF*!-QbP7wf>fEGRg
> 
> diff --git a/tests/data/acpi/q35/DSDT.mmio64 b/tests/data/acpi/q35/DSDT.mmio64
> index 5916c0e9ce0a9607c6230f9dfebe2c1be70b2495..b6c6946ed9812685dd71b51784900480963b54bd 100644
> GIT binary patch
> delta 44
> zcmdnwI>D98CD<iof)WD*<C=|J^BMX5SoGq9o#F$WJq@Cp99bssV6@*X$uv^|03;#|
> A;s5{u
> 
> delta 79
> zcmbQ>y2+KxCD<iolM(|1W79^i`HcJy?0WIRPVoWGo(9oP&TNx+Fxo3cH~0iNyE1V#
> eaWO?Vih|e-&W^5rjLuF#!Y2SoZ2rzTQvm>UoE6~!
> 
> diff --git a/tests/data/acpi/q35/DSDT.numamem b/tests/data/acpi/q35/DSDT.numamem
> index cf3fde3449bc8e9bbe683b936cf9866590b0ef82..9b5c962434471d63d65f027c84dfc3e6ac20e10b 100644
> GIT binary patch
> delta 44
> zcmX?Sv&M$YCD<iIM~;Dkam7Zi`HcL2EPC<5PVoWGo(9oPjx3XRFxqdHWHOZj02>|*
> AGynhq
> 
> delta 79
> zcmZ2ubIyj#CD<jzPmY0sv2G*Rd`5l;cD?vur}zM8PlM<tXST^Z810p!8+-zsU75I=
> exR|0FML}!^XGd2*MrS7=;S&HPHh*U{l>q=^1{E^^
> 
> diff --git a/tests/data/acpi/q35/DSDT.tis b/tests/data/acpi/q35/DSDT.tis
> index 56b6fb0c3298517d080e38fea05a748b9f1dba54..7cb8d8b154f3de295669a741c9ec3ec8c67e2b2f 100644
> GIT binary patch
> delta 44
> zcmZ4L*zCyV66_MvtiZs)czq++d`5mh7QOgjr}zM8PlM<tN0!Mu80|MpGWEy-03lZl
> A%>V!Z
> 
> delta 79
> zcmZp6T<XZ>66_MPRDpqkaqUK~`HcJy?0WIRPVoWGo(9oP&TNx+Fxo3cH~0iNyE1V#
> eaWO?Vih|e-&W^5rjLuF#!Y2SoZ2r#JBL@I*{}s#t
> 
> -- 
> 2.18.4


