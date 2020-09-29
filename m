Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E2AC4346E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 07:13:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5E1E20754
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 07:12:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cr4ORKaL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5E1E20754
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kN9oo-0007Az-R9
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 03:12:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55644)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kN9o4-0006MS-5A
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 03:12:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35916)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kN9o0-0000Hr-Kr
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 03:12:11 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601363525;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IRrCsCtweCEjAlhtYbGEbcm+bMDIhqlayD4LLHnKE6A=;
 b=cr4ORKaL9CKfQKC8YY4kQQaCzqZ3cgiAPtF9T2kON02wY6Ex4Bu0g1rC/hMtTvZI/WIfHM
 RCgNJOBpioboJYpkpAdphAdI6FsCu5wJbVFPjzFFbmFaadGWsM1SOU49pxudAi6TuHFJga
 b3dAyQHjrKQ9KKUvn+isB3CD4m8zYiY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-90-KNMuP-8oN9-PPmd9bTxsqA-1; Tue, 29 Sep 2020 03:12:02 -0400
X-MC-Unique: KNMuP-8oN9-PPmd9bTxsqA-1
Received: by mail-wm1-f72.google.com with SMTP id a7so1452352wmc.2
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 00:12:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=IRrCsCtweCEjAlhtYbGEbcm+bMDIhqlayD4LLHnKE6A=;
 b=WWz3MrzZzMqaTmurhnAeAta2JOBuMWd1Wljrtb1EeTEEzAlapQRjBWb7Ppjq5WWzog
 BQ3eOAyEkfkM+0r6ttuqi7VM5MzYtdtvm/+MVMEC5/fyQAcA5qVHB+3DZ4P9TqaQknun
 fm1y7Hc6VplGrvHh0UXLXafCVdSYYJ0LCcYDSFnpbByHGrO41ixe4Nb9He7XDJ2uYtQ2
 10EGXZehMylySZ8qP/zLhfCy6B6XXIalsQ65OFJkGvod1lk3wjcG1unC3WrgSNU4HK1/
 doPskwxKOVQyvoWPNnFSZU2IocAVGDJDp6JwKd11RPA8sERGUxqPnJJ0TgWlVWWVkMEW
 V1kA==
X-Gm-Message-State: AOAM531zeYZIBnfbdPi30gTbn4Nezyd9EQtR2G9f2vLEYr3m8ssABd+z
 9zmUUTByKU7gI+taHgoTCF6rHQebh26q7brPgfPUdQPncPPDuyQSzPCDUJLdDrviWc4FiGiIAq7
 mkywgZDf1cmcNBSo=
X-Received: by 2002:a05:600c:2f8f:: with SMTP id
 t15mr3013002wmn.41.1601363521481; 
 Tue, 29 Sep 2020 00:12:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz6vUChkxmpUQpRubyFHP4Bz39Zb/eL6LgrDLLtIgs3oobuM/4Tk/G54O5l+374sd1pr+n6bw==
X-Received: by 2002:a05:600c:2f8f:: with SMTP id
 t15mr3012968wmn.41.1601363521102; 
 Tue, 29 Sep 2020 00:12:01 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id l8sm4822960wrx.22.2020.09.29.00.11.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 00:12:00 -0700 (PDT)
Date: Tue, 29 Sep 2020 03:11:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ani Sinha <ani@anisinha.ca>
Subject: Re: [PATCH v10 13/13] tests/acpi: add DSDT.hpbrroot DSDT table blob
 to test global i440fx hotplug
Message-ID: <20200929031032-mutt-send-email-mst@kernel.org>
References: <20200918084111.15339-1-ani@anisinha.ca>
 <20200918084111.15339-14-ani@anisinha.ca>
MIME-Version: 1.0
In-Reply-To: <20200918084111.15339-14-ani@anisinha.ca>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 22:47:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, jusual@redhat.com,
 qemu-devel@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 18, 2020 at 02:11:11PM +0530, Ani Sinha wrote:
> This change adds a new DSDT golden master table blob to test disabling
> hotplug on both pci root bus and pci bridges. Also reverts the change
> in file bios-tables-test-allowed-diff.h to make sure its now empty so that
> future modifications to acpi tables can be caught.
> 
> The following is the disassembled diff between DSDT.hpbridge and DSDT.hpbrroot:
> 
> @@ -1,30 +1,30 @@
>  /*
>   * Intel ACPI Component Architecture
>   * AML/ASL+ Disassembler version 20180105 (64-bit version)
>   * Copyright (c) 2000 - 2018 Intel Corporation
>   *
>   * Disassembling to symbolic ASL+ operators
>   *
> - * Disassembly of tests/data/acpi/pc/DSDT.hpbridge, Wed Sep 16 09:45:56 2020
> + * Disassembly of /tmp/aml-ECV9Q0, Wed Sep 16 09:45:56 2020
>   *
>   * Original Table Header:
>   *     Signature        "DSDT"
> - *     Length           0x0000131F (4895)
> + *     Length           0x00000B89 (2953)
>   *     Revision         0x01 **** 32-bit table (V1), no 64-bit math support
> - *     Checksum         0xF9
> + *     Checksum         0xA2
>   *     OEM ID           "BOCHS "
>   *     OEM Table ID     "BXPCDSDT"
>   *     OEM Revision     0x00000001 (1)
>   *     Compiler ID      "BXPC"
>   *     Compiler Version 0x00000001 (1)
>   */
>  DefinitionBlock ("", "DSDT", 1, "BOCHS ", "BXPCDSDT", 0x00000001)
>  {
>      Scope (\)
>      {
>          OperationRegion (DBG, SystemIO, 0x0402, One)
>          Field (DBG, ByteAcc, NoLock, Preserve)
>          {
>              DBGB,   8
>          }
> 
> @@ -234,64 +234,32 @@
>          {
>              Name (_HID, EisaId ("PNP0B00") /* AT Real-Time Clock */)  // _HID: Hardware ID
>              Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
>              {
>                  IO (Decode16,
>                      0x0070,             // Range Minimum
>                      0x0070,             // Range Maximum
>                      0x01,               // Alignment
>                      0x08,               // Length
>                      )
>                  IRQNoFlags ()
>                      {8}
>              })
>          }
>      }
> 
> -    Scope (_SB.PCI0)
> -    {
> -        OperationRegion (PCST, SystemIO, 0xAE00, 0x08)
> -        Field (PCST, DWordAcc, NoLock, WriteAsZeros)
> -        {
> -            PCIU,   32,
> -            PCID,   32
> -        }
> -
> -        OperationRegion (SEJ, SystemIO, 0xAE08, 0x04)
> -        Field (SEJ, DWordAcc, NoLock, WriteAsZeros)
> -        {
> -            B0EJ,   32
> -        }
> -
> -        OperationRegion (BNMR, SystemIO, 0xAE10, 0x04)
> -        Field (BNMR, DWordAcc, NoLock, WriteAsZeros)
> -        {
> -            BNUM,   32
> -        }
> -
> -        Mutex (BLCK, 0x00)
> -        Method (PCEJ, 2, NotSerialized)
> -        {
> -            Acquire (BLCK, 0xFFFF)
> -            BNUM = Arg0
> -            B0EJ = (One << Arg1)
> -            Release (BLCK)
> -            Return (Zero)
> -        }
> -    }
> -
>      Scope (_SB)
>      {
>          Scope (PCI0)
>          {
>              Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
>              {
>                  Local0 = Package (0x80){}
>                  Local1 = Zero
>                  While ((Local1 < 0x80))
>                  {
>                      Local2 = (Local1 >> 0x02)
>                      Local3 = ((Local1 + Local2) & 0x03)
>                      If ((Local3 == Zero))
>                      {
>                          Local4 = Package (0x04)
>                              {
> @@ -690,38 +658,32 @@
>                  Method (_OST, 3, Serialized)  // _OST: OSPM Status Indication
>                  {
>                      COST (Zero, Arg0, Arg1, Arg2)
>                  }
>              }
>          }
>      }
> 
>      Method (\_GPE._E02, 0, NotSerialized)  // _Exx: Edge-Triggered GPE
>      {
>          \_SB.CPUS.CSCN ()
>      }
> 
>      Scope (_GPE)
>      {
>          Name (_HID, "ACPI0006" /* GPE Block Device */)  // _HID: Hardware ID
> -        Method (_E01, 0, NotSerialized)  // _Exx: Edge-Triggered GPE
> -        {
> -            Acquire (\_SB.PCI0.BLCK, 0xFFFF)
> -            \_SB.PCI0.PCNT ()
> -            Release (\_SB.PCI0.BLCK)
> -        }
>      }
> 
>      Scope (\_SB.PCI0)
>      {
>          Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
>          {
>              WordBusNumber (ResourceProducer, MinFixed, MaxFixed, PosDecode,
>                  0x0000,             // Granularity
>                  0x0000,             // Range Minimum
>                  0x00FF,             // Range Maximum
>                  0x0000,             // Translation Offset
>                  0x0100,             // Length
>                  ,, )
>              IO (Decode16,
>                  0x0CF8,             // Range Minimum
>                  0x0CF8,             // Range Maximum
> @@ -766,48 +728,32 @@
>          })
>          Device (GPE0)
>          {
>              Name (_HID, "PNP0A06" /* Generic Container Device */)  // _HID: Hardware ID
>              Name (_UID, "GPE0 resources")  // _UID: Unique ID
>              Name (_STA, 0x0B)  // _STA: Status
>              Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
>              {
>                  IO (Decode16,
>                      0xAFE0,             // Range Minimum
>                      0xAFE0,             // Range Maximum
>                      0x01,               // Alignment
>                      0x04,               // Length
>                      )
>              })
>          }
> -
> -        Device (PHPR)
> -        {
> -            Name (_HID, "PNP0A06" /* Generic Container Device */)  // _HID: Hardware ID
> -            Name (_UID, "PCI Hotplug resources")  // _UID: Unique ID
> -            Name (_STA, 0x0B)  // _STA: Status
> -            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
> -            {
> -                IO (Decode16,
> -                    0xAE00,             // Range Minimum
> -                    0xAE00,             // Range Maximum
> -                    0x01,               // Alignment
> -                    0x14,               // Length
> -                    )
> -            })
> -        }
>      }
> 
>      Scope (\)
>      {
>          Name (_S3, Package (0x04)  // _S3_: S3 System State
>          {
>              One,
>              One,
>              Zero,
>              Zero
>          })
>          Name (_S4, Package (0x04)  // _S4_: S4 System State
>          {
>              0x02,
>              0x02,
>              Zero,
> @@ -831,479 +777,48 @@
>              Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
>              {
>                  IO (Decode16,
>                      0x0510,             // Range Minimum
>                      0x0510,             // Range Maximum
>                      0x01,               // Alignment
>                      0x0C,               // Length
>                      )
>              })
>          }
>      }
> 
>      Scope (\_SB)
>      {
>          Scope (PCI0)
>          {
> -            Name (BSEL, Zero)
>              Device (S00)
>              {
>                  Name (_ADR, Zero)  // _ADR: Address
>              }
> 
>              Device (S10)
>              {
>                  Name (_ADR, 0x00020000)  // _ADR: Address
>                  Method (_S1D, 0, NotSerialized)  // _S1D: S1 Device State
>                  {
>                      Return (Zero)
>                  }
> 
>                  Method (_S2D, 0, NotSerialized)  // _S2D: S2 Device State
>                  {
>                      Return (Zero)
>                  }
> 
>                  Method (_S3D, 0, NotSerialized)  // _S3D: S3 Device State
>                  {
>                      Return (Zero)
>                  }
>              }
> 
>              Device (S18)
>              {
>                  Name (_ADR, 0x00030000)  // _ADR: Address
>              }
> -
> -            Device (S20)
> -            {
> -                Name (_SUN, 0x04)  // _SUN: Slot User Number
> -                Name (_ADR, 0x00040000)  // _ADR: Address
> -                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
> -                {
> -                    PCEJ (BSEL, _SUN)
> -                }
> -            }
> -
> -            Device (S28)
> -            {
> -                Name (_SUN, 0x05)  // _SUN: Slot User Number
> -                Name (_ADR, 0x00050000)  // _ADR: Address
> -                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
> -                {
> -                    PCEJ (BSEL, _SUN)
> -                }
> -            }
> -
> -            Device (S30)
> -            {
> -                Name (_SUN, 0x06)  // _SUN: Slot User Number
> -                Name (_ADR, 0x00060000)  // _ADR: Address
> -                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
> -                {
> -                    PCEJ (BSEL, _SUN)
> -                }
> -            }
> -
> -            Device (S38)
> -            {
> -                Name (_SUN, 0x07)  // _SUN: Slot User Number
> -                Name (_ADR, 0x00070000)  // _ADR: Address
> -                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
> -                {
> -                    PCEJ (BSEL, _SUN)
> -                }
> -            }
> -
> -            Device (S40)
> -            {
> -                Name (_SUN, 0x08)  // _SUN: Slot User Number
> -                Name (_ADR, 0x00080000)  // _ADR: Address
> -                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
> -                {
> -                    PCEJ (BSEL, _SUN)
> -                }
> -            }
> -
> -            Device (S48)
> -            {
> -                Name (_SUN, 0x09)  // _SUN: Slot User Number
> -                Name (_ADR, 0x00090000)  // _ADR: Address
> -                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
> -                {
> -                    PCEJ (BSEL, _SUN)
> -                }
> -            }
> -
> -            Device (S50)
> -            {
> -                Name (_SUN, 0x0A)  // _SUN: Slot User Number
> -                Name (_ADR, 0x000A0000)  // _ADR: Address
> -                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
> -                {
> -                    PCEJ (BSEL, _SUN)
> -                }
> -            }
> -
> -            Device (S58)
> -            {
> -                Name (_SUN, 0x0B)  // _SUN: Slot User Number
> -                Name (_ADR, 0x000B0000)  // _ADR: Address
> -                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
> -                {
> -                    PCEJ (BSEL, _SUN)
> -                }
> -            }
> -
> -            Device (S60)
> -            {
> -                Name (_SUN, 0x0C)  // _SUN: Slot User Number
> -                Name (_ADR, 0x000C0000)  // _ADR: Address
> -                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
> -                {
> -                    PCEJ (BSEL, _SUN)
> -                }
> -            }
> -
> -            Device (S68)
> -            {
> -                Name (_SUN, 0x0D)  // _SUN: Slot User Number
> -                Name (_ADR, 0x000D0000)  // _ADR: Address
> -                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
> -                {
> -                    PCEJ (BSEL, _SUN)
> -                }
> -            }
> -
> -            Device (S70)
> -            {
> -                Name (_SUN, 0x0E)  // _SUN: Slot User Number
> -                Name (_ADR, 0x000E0000)  // _ADR: Address
> -                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
> -                {
> -                    PCEJ (BSEL, _SUN)
> -                }
> -            }
> -
> -            Device (S78)
> -            {
> -                Name (_SUN, 0x0F)  // _SUN: Slot User Number
> -                Name (_ADR, 0x000F0000)  // _ADR: Address
> -                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
> -                {
> -                    PCEJ (BSEL, _SUN)
> -                }
> -            }
> -
> -            Device (S80)
> -            {
> -                Name (_SUN, 0x10)  // _SUN: Slot User Number
> -                Name (_ADR, 0x00100000)  // _ADR: Address
> -                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
> -                {
> -                    PCEJ (BSEL, _SUN)
> -                }
> -            }
> -
> -            Device (S88)
> -            {
> -                Name (_SUN, 0x11)  // _SUN: Slot User Number
> -                Name (_ADR, 0x00110000)  // _ADR: Address
> -                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
> -                {
> -                    PCEJ (BSEL, _SUN)
> -                }
> -            }
> -
> -            Device (S90)
> -            {
> -                Name (_SUN, 0x12)  // _SUN: Slot User Number
> -                Name (_ADR, 0x00120000)  // _ADR: Address
> -                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
> -                {
> -                    PCEJ (BSEL, _SUN)
> -                }
> -            }
> -
> -            Device (S98)
> -            {
> -                Name (_SUN, 0x13)  // _SUN: Slot User Number
> -                Name (_ADR, 0x00130000)  // _ADR: Address
> -                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
> -                {
> -                    PCEJ (BSEL, _SUN)
> -                }
> -            }
> -
> -            Device (SA0)
> -            {
> -                Name (_SUN, 0x14)  // _SUN: Slot User Number
> -                Name (_ADR, 0x00140000)  // _ADR: Address
> -                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
> -                {
> -                    PCEJ (BSEL, _SUN)
> -                }
> -            }
> -
> -            Device (SA8)
> -            {
> -                Name (_SUN, 0x15)  // _SUN: Slot User Number
> -                Name (_ADR, 0x00150000)  // _ADR: Address
> -                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
> -                {
> -                    PCEJ (BSEL, _SUN)
> -                }
> -            }
> -
> -            Device (SB0)
> -            {
> -                Name (_SUN, 0x16)  // _SUN: Slot User Number
> -                Name (_ADR, 0x00160000)  // _ADR: Address
> -                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
> -                {
> -                    PCEJ (BSEL, _SUN)
> -                }
> -            }
> -
> -            Device (SB8)
> -            {
> -                Name (_SUN, 0x17)  // _SUN: Slot User Number
> -                Name (_ADR, 0x00170000)  // _ADR: Address
> -                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
> -                {
> -                    PCEJ (BSEL, _SUN)
> -                }
> -            }
> -
> -            Device (SC0)
> -            {
> -                Name (_SUN, 0x18)  // _SUN: Slot User Number
> -                Name (_ADR, 0x00180000)  // _ADR: Address
> -                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
> -                {
> -                    PCEJ (BSEL, _SUN)
> -                }
> -            }
> -
> -            Device (SC8)
> -            {
> -                Name (_SUN, 0x19)  // _SUN: Slot User Number
> -                Name (_ADR, 0x00190000)  // _ADR: Address
> -                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
> -                {
> -                    PCEJ (BSEL, _SUN)
> -                }
> -            }
> -
> -            Device (SD0)
> -            {
> -                Name (_SUN, 0x1A)  // _SUN: Slot User Number
> -                Name (_ADR, 0x001A0000)  // _ADR: Address
> -                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
> -                {
> -                    PCEJ (BSEL, _SUN)
> -                }
> -            }
> -
> -            Device (SD8)
> -            {
> -                Name (_SUN, 0x1B)  // _SUN: Slot User Number
> -                Name (_ADR, 0x001B0000)  // _ADR: Address
> -                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
> -                {
> -                    PCEJ (BSEL, _SUN)
> -                }
> -            }
> -
> -            Device (SE0)
> -            {
> -                Name (_SUN, 0x1C)  // _SUN: Slot User Number
> -                Name (_ADR, 0x001C0000)  // _ADR: Address
> -                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
> -                {
> -                    PCEJ (BSEL, _SUN)
> -                }
> -            }
> -
> -            Device (SE8)
> -            {
> -                Name (_SUN, 0x1D)  // _SUN: Slot User Number
> -                Name (_ADR, 0x001D0000)  // _ADR: Address
> -                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
> -                {
> -                    PCEJ (BSEL, _SUN)
> -                }
> -            }
> -
> -            Device (SF0)
> -            {
> -                Name (_SUN, 0x1E)  // _SUN: Slot User Number
> -                Name (_ADR, 0x001E0000)  // _ADR: Address
> -                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
> -                {
> -                    PCEJ (BSEL, _SUN)
> -                }
> -            }
> -
> -            Device (SF8)
> -            {
> -                Name (_SUN, 0x1F)  // _SUN: Slot User Number
> -                Name (_ADR, 0x001F0000)  // _ADR: Address
> -                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
> -                {
> -                    PCEJ (BSEL, _SUN)
> -                }
> -            }
> -
> -            Method (DVNT, 2, NotSerialized)
> -            {
> -                If ((Arg0 & 0x10))
> -                {
> -                    Notify (S20, Arg1)
> -                }
> -
> -                If ((Arg0 & 0x20))
> -                {
> -                    Notify (S28, Arg1)
> -                }
> -
> -                If ((Arg0 & 0x40))
> -                {
> -                    Notify (S30, Arg1)
> -                }
> -
> -                If ((Arg0 & 0x80))
> -                {
> -                    Notify (S38, Arg1)
> -                }
> -
> -                If ((Arg0 & 0x0100))
> -                {
> -                    Notify (S40, Arg1)
> -                }
> -
> -                If ((Arg0 & 0x0200))
> -                {
> -                    Notify (S48, Arg1)
> -                }
> -
> -                If ((Arg0 & 0x0400))
> -                {
> -                    Notify (S50, Arg1)
> -                }
> -
> -                If ((Arg0 & 0x0800))
> -                {
> -                    Notify (S58, Arg1)
> -                }
> -
> -                If ((Arg0 & 0x1000))
> -                {
> -                    Notify (S60, Arg1)
> -                }
> -
> -                If ((Arg0 & 0x2000))
> -                {
> -                    Notify (S68, Arg1)
> -                }
> -
> -                If ((Arg0 & 0x4000))
> -                {
> -                    Notify (S70, Arg1)
> -                }
> -
> -                If ((Arg0 & 0x8000))
> -                {
> -                    Notify (S78, Arg1)
> -                }
> -
> -                If ((Arg0 & 0x00010000))
> -                {
> -                    Notify (S80, Arg1)
> -                }
> -
> -                If ((Arg0 & 0x00020000))
> -                {
> -                    Notify (S88, Arg1)
> -                }
> -
> -                If ((Arg0 & 0x00040000))
> -                {
> -                    Notify (S90, Arg1)
> -                }
> -
> -                If ((Arg0 & 0x00080000))
> -                {
> -                    Notify (S98, Arg1)
> -                }
> -
> -                If ((Arg0 & 0x00100000))
> -                {
> -                    Notify (SA0, Arg1)
> -                }
> -
> -                If ((Arg0 & 0x00200000))
> -                {
> -                    Notify (SA8, Arg1)
> -                }
> -
> -                If ((Arg0 & 0x00400000))
> -                {
> -                    Notify (SB0, Arg1)
> -                }
> -
> -                If ((Arg0 & 0x00800000))
> -                {
> -                    Notify (SB8, Arg1)
> -                }
> -
> -                If ((Arg0 & 0x01000000))
> -                {
> -                    Notify (SC0, Arg1)
> -                }
> -
> -                If ((Arg0 & 0x02000000))
> -                {
> -                    Notify (SC8, Arg1)
> -                }
> -
> -                If ((Arg0 & 0x04000000))
> -                {
> -                    Notify (SD0, Arg1)
> -                }
> -
> -                If ((Arg0 & 0x08000000))
> -                {
> -                    Notify (SD8, Arg1)
> -                }
> -
> -                If ((Arg0 & 0x10000000))
> -                {
> -                    Notify (SE0, Arg1)
> -                }
> -
> -                If ((Arg0 & 0x20000000))
> -                {
> -                    Notify (SE8, Arg1)
> -                }
> -
> -                If ((Arg0 & 0x40000000))
> -                {
> -                    Notify (SF0, Arg1)
> -                }
> -
> -                If ((Arg0 & 0x80000000))
> -                {
> -                    Notify (SF8, Arg1)
> -                }
> -            }
> -
> -            Method (PCNT, 0, NotSerialized)
> -            {
> -                BNUM = Zero
> -                DVNT (PCIU, One)
> -                DVNT (PCID, 0x03)
> -            }
>          }
>      }
>  }

This is not the only diff I see if I apply this patchset on
top of master.
Dropped this and the previous patch.
Please check what is going on and repost as appropriate.



> Signed-off-by: Ani Sinha <ani@anisinha.ca>
> Acked-by: Igor Mammedov <imammedo@redhat.com>
> ---


