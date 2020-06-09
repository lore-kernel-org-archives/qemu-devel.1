Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 351A2C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 14:21:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7B7B2078D
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 14:21:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cM3WfZU2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7B7B2078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jif7g-00075a-6V
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 10:21:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55294)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jif69-0005Tp-LE
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 10:19:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28081
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jif68-00008J-Cc
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 10:19:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591712367;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lnSAfuKnJmXdY0VpCSldzjzzHRt5dNWkRuY7Yw1eVAo=;
 b=cM3WfZU25hXPfZttqFaTvx+n8X4sK+NKf8jdrnGid2txhGc9ajYn7B1LwjdM/odBQIw/a7
 BXqQIY9VHP2jmkv4XGmQRHRjwjnr45GNbxTs4LM8iwd+zb09MfP+Mgsg/8b9cHmPgJS+ro
 shSDHtSWdzRBiDyqNkBjw3sUXXxeX8E=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-0ecUgO3pOoG3Bvw4tLAglA-1; Tue, 09 Jun 2020 10:19:19 -0400
X-MC-Unique: 0ecUgO3pOoG3Bvw4tLAglA-1
Received: by mail-wm1-f72.google.com with SMTP id c4so761414wmd.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 07:19:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=lnSAfuKnJmXdY0VpCSldzjzzHRt5dNWkRuY7Yw1eVAo=;
 b=DSwV2XsSrfhitkFnsrfxyzNctl2ykMLxnkAex9zHXiy5BhhyHzAzSSbiPUN/Hv6JDa
 9vdxOt6XJihZE9RJHiRBd1W+z7uXzAHlZ4MfOhD8uKPqpdZ7S2l3MWo4+X/Gd52PvIkb
 VVAd/ctOh1UHS+20hoVtK7oE/IhxJX8wGs8I0GJfIvjD9ag8MgY0nEEPAXuhdxXqvxq1
 O/TAunZzn2QzZCClovGse68KZ5P4lxQ6EmZvsnJ8w6VoYBbGRVVw4R7zI2qJoUuy5ktk
 fq5ELL3DGWXaO2AvG5COtDKi2pWSkNy+rs4z322X/Vhw/Xc/g6+LNPVOjjkFTofTNjjj
 DkWw==
X-Gm-Message-State: AOAM530DUMLQz5P5TCVfRW+si7Rxr57+Jp8RrKX4bec1EE3k/g2F5EBV
 XTgFKywiAfDoj0/Dedh1DyoQOyvQKSc6N9Cdn7MfveqSpaStVqWRESLT5yHvcdoWiTeakxVSxnP
 niATfOd2AwjKXgnM=
X-Received: by 2002:a5d:4c87:: with SMTP id z7mr4717835wrs.100.1591712358420; 
 Tue, 09 Jun 2020 07:19:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyeo86hKCUp0mtgXR98iiQ38LowH4pLLLTKhCxH99KW7pLOSf8fABOkUkEOy5Ctj0nZ0Ccz3Q==
X-Received: by 2002:a5d:4c87:: with SMTP id z7mr4717801wrs.100.1591712358156; 
 Tue, 09 Jun 2020 07:19:18 -0700 (PDT)
Received: from redhat.com (bzq-79-181-55-232.red.bezeqint.net. [79.181.55.232])
 by smtp.gmail.com with ESMTPSA id d16sm3046995wmd.42.2020.06.09.07.19.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 07:19:17 -0700 (PDT)
Date: Tue, 9 Jun 2020 10:19:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH v5 3/3] tests/acpi: update expected SRAT files
Message-ID: <20200609101341-mutt-send-email-mst@kernel.org>
References: <20200606000911.9896-1-vishal.l.verma@intel.com>
 <20200606000911.9896-4-vishal.l.verma@intel.com>
MIME-Version: 1.0
In-Reply-To: <20200606000911.9896-4-vishal.l.verma@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 01:38:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>, jingqi.liu@intel.com,
 Dave Hansen <dave.hansen@linux.intel.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Dan Williams <dan.j.williams@intel.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jun 05, 2020 at 06:09:11PM -0600, Vishal Verma wrote:
> Update expected SRAT files for the change to account for NVDIMM NUMA
> nodes in the SRAT.
> 
> AML diffs:
> 
> tests/data/acpi/pc/SRAT.dimmpxm:
> --- /tmp/asl-3P2IL0.dsl	2020-05-28 15:11:02.326439263 -0600
> +++ /tmp/asl-1N4IL0.dsl	2020-05-28 15:11:02.325439280 -0600
> @@ -3,7 +3,7 @@
>   * AML/ASL+ Disassembler version 20190509 (64-bit version)
>   * Copyright (c) 2000 - 2019 Intel Corporation
>   *
> - * Disassembly of tests/data/acpi/pc/SRAT.dimmpxm, Thu May 28 15:11:02 2020
> + * Disassembly of /tmp/aml-4D4IL0, Thu May 28 15:11:02 2020
>   *
>   * ACPI Data Table [SRAT]
>   *
> @@ -13,7 +13,7 @@
>  [000h 0000   4]                    Signature : "SRAT"    [System Resource Affinity Table]
>  [004h 0004   4]                 Table Length : 00000188
>  [008h 0008   1]                     Revision : 01
> -[009h 0009   1]                     Checksum : 80
> +[009h 0009   1]                     Checksum : 68
>  [00Ah 0010   6]                       Oem ID : "BOCHS "
>  [010h 0016   8]                 Oem Table ID : "BXPCSRAT"
>  [018h 0024   4]                 Oem Revision : 00000001
> @@ -140,15 +140,15 @@
>  [138h 0312   1]                Subtable Type : 01 [Memory Affinity]
>  [139h 0313   1]                       Length : 28
> 
> -[13Ah 0314   4]             Proximity Domain : 00000000
> +[13Ah 0314   4]             Proximity Domain : 00000002
>  [13Eh 0318   2]                    Reserved1 : 0000
> -[140h 0320   8]                 Base Address : 0000000000000000
> -[148h 0328   8]               Address Length : 0000000000000000
> +[140h 0320   8]                 Base Address : 0000000108000000
> +[148h 0328   8]               Address Length : 0000000008000000
>  [150h 0336   4]                    Reserved2 : 00000000
> -[154h 0340   4]        Flags (decoded below) : 00000000
> -                                     Enabled : 0
> +[154h 0340   4]        Flags (decoded below) : 00000005
> +                                     Enabled : 1
>                                 Hot Pluggable : 0
> -                                Non-Volatile : 0
> +                                Non-Volatile : 1
>  [158h 0344   8]                    Reserved3 : 0000000000000000
> 
>  [160h 0352   1]                Subtable Type : 01 [Memory Affinity]
> 
> tests/data/acpi/q35/SRAT.dimmpxm:
> --- /tmp/asl-HW2LL0.dsl	2020-05-28 15:11:05.446384514 -0600
> +++ /tmp/asl-8MYLL0.dsl	2020-05-28 15:11:05.445384532 -0600
> @@ -3,7 +3,7 @@
>   * AML/ASL+ Disassembler version 20190509 (64-bit version)
>   * Copyright (c) 2000 - 2019 Intel Corporation
>   *
> - * Disassembly of tests/data/acpi/q35/SRAT.dimmpxm, Thu May 28 15:11:05 2020
> + * Disassembly of /tmp/aml-2CYLL0, Thu May 28 15:11:05 2020
>   *
>   * ACPI Data Table [SRAT]
>   *
> @@ -13,7 +13,7 @@
>  [000h 0000   4]                    Signature : "SRAT"    [System Resource Affinity Table]
>  [004h 0004   4]                 Table Length : 00000188
>  [008h 0008   1]                     Revision : 01
> -[009h 0009   1]                     Checksum : 80
> +[009h 0009   1]                     Checksum : 68
>  [00Ah 0010   6]                       Oem ID : "BOCHS "
>  [010h 0016   8]                 Oem Table ID : "BXPCSRAT"
>  [018h 0024   4]                 Oem Revision : 00000001
> @@ -140,15 +140,15 @@
>  [138h 0312   1]                Subtable Type : 01 [Memory Affinity]
>  [139h 0313   1]                       Length : 28
> 
> -[13Ah 0314   4]             Proximity Domain : 00000000
> +[13Ah 0314   4]             Proximity Domain : 00000002
>  [13Eh 0318   2]                    Reserved1 : 0000
> -[140h 0320   8]                 Base Address : 0000000000000000
> -[148h 0328   8]               Address Length : 0000000000000000
> +[140h 0320   8]                 Base Address : 0000000108000000
> +[148h 0328   8]               Address Length : 0000000008000000
>  [150h 0336   4]                    Reserved2 : 00000000
> -[154h 0340   4]        Flags (decoded below) : 00000000
> -                                     Enabled : 0
> +[154h 0340   4]        Flags (decoded below) : 00000005
> +                                     Enabled : 1
>                                 Hot Pluggable : 0
> -                                Non-Volatile : 0
> +                                Non-Volatile : 1
>  [158h 0344   8]                    Reserved3 : 0000000000000000
> 
>  [160h 0352   1]                Subtable Type : 01 [Memory Affinity]
> 
> tests/data/acpi/virt/SRAT.memhp:
> --- /tmp/asl-E32WL0.dsl	2020-05-28 15:19:56.976095582 -0600
> +++ /tmp/asl-Y69WL0.dsl	2020-05-28 15:19:56.974095617 -0600
> @@ -3,7 +3,7 @@
>   * AML/ASL+ Disassembler version 20190509 (64-bit version)
>   * Copyright (c) 2000 - 2019 Intel Corporation
>   *
> - * Disassembly of tests/data/acpi/virt/SRAT.memhp, Thu May 28 15:19:56 2020
> + * Disassembly of /tmp/aml-2CCXL0, Thu May 28 15:19:56 2020
>   *
>   * ACPI Data Table [SRAT]
>   *
> @@ -11,9 +11,9 @@
>   */
> 
>  [000h 0000   4]                    Signature : "SRAT"    [System Resource Affinity Table]
> -[004h 0004   4]                 Table Length : 000000BA
> +[004h 0004   4]                 Table Length : 000000E2
>  [008h 0008   1]                     Revision : 03
> -[009h 0009   1]                     Checksum : 43
> +[009h 0009   1]                     Checksum : 5C
>  [00Ah 0010   6]                       Oem ID : "BOCHS "
>  [010h 0016   8]                 Oem Table ID : "BXPCSRAT"
>  [018h 0024   4]                 Oem Revision : 00000001
> @@ -65,18 +65,32 @@
> 
>  [094h 0148   4]             Proximity Domain : 00000001
>  [098h 0152   2]                    Reserved1 : 0000
> -[09Ah 0154   8]                 Base Address : 0000000080000000
> -[0A2h 0162   8]               Address Length : 00000000F0000000
> +[09Ah 0154   8]                 Base Address : 0000000088000000
> +[0A2h 0162   8]               Address Length : 0000000008000000
>  [0AAh 0170   4]                    Reserved2 : 00000000
> -[0AEh 0174   4]        Flags (decoded below) : 00000003
> +[0AEh 0174   4]        Flags (decoded below) : 00000005
> +                                     Enabled : 1
> +                               Hot Pluggable : 0
> +                                Non-Volatile : 1
> +[0B2h 0178   8]                    Reserved3 : 0000000000000000
> +
> +[0BAh 0186   1]                Subtable Type : 01 [Memory Affinity]
> +[0BBh 0187   1]                       Length : 28
> +
> +[0BCh 0188   4]             Proximity Domain : 00000001
> +[0C0h 0192   2]                    Reserved1 : 0000
> +[0C2h 0194   8]                 Base Address : 0000000080000000
> +[0CAh 0202   8]               Address Length : 00000000F0000000
> +[0D2h 0210   4]                    Reserved2 : 00000000
> +[0D6h 0214   4]        Flags (decoded below) : 00000003
>                                       Enabled : 1
>                                 Hot Pluggable : 1
>                                  Non-Volatile : 0
> -[0B2h 0178   8]                    Reserved3 : 0000000000000000
> +[0DAh 0218   8]                    Reserved3 : 0000000000000000
> 
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>

So I went to apply this and notices that virt tests
did not seem to run. Igor did you notice this too?
Anyway, not this patch's fault.


> ---
>  tests/data/acpi/pc/SRAT.dimmpxm             | Bin 392 -> 392 bytes
>  tests/data/acpi/q35/SRAT.dimmpxm            | Bin 392 -> 392 bytes
>  tests/data/acpi/virt/SRAT.memhp             | Bin 186 -> 226 bytes
>  tests/qtest/bios-tables-test-allowed-diff.h |   3 ---
>  4 files changed, 3 deletions(-)
> 
> diff --git a/tests/data/acpi/pc/SRAT.dimmpxm b/tests/data/acpi/pc/SRAT.dimmpxm
> index f5c0267ea24bb404b6b4e687390140378fbdc3f1..5a13c61b9041c6045c29643bf93a111fb1c0c76a 100644
> GIT binary patch
> delta 51
> scmeBR?qKE$4ss0XU}Rum%-G0fz$nec00kUCF%aN@Pz(&LlS3Je0lmQmhyVZp
> 
> delta 51
> icmeBR?qKE$4ss0XU}RumY}m+Uz$ndt8%z#mGzI{_tp$hx
> 
> diff --git a/tests/data/acpi/q35/SRAT.dimmpxm b/tests/data/acpi/q35/SRAT.dimmpxm
> index f5c0267ea24bb404b6b4e687390140378fbdc3f1..5a13c61b9041c6045c29643bf93a111fb1c0c76a 100644
> GIT binary patch
> delta 51
> scmeBR?qKE$4ss0XU}Rum%-G0fz$nec00kUCF%aN@Pz(&LlS3Je0lmQmhyVZp
> 
> delta 51
> icmeBR?qKE$4ss0XU}RumY}m+Uz$ndt8%z#mGzI{_tp$hx
> 
> diff --git a/tests/data/acpi/virt/SRAT.memhp b/tests/data/acpi/virt/SRAT.memhp
> index 1b57db2072e7f7e2085c4a427aa31c7383851b71..9a35adb40c6f7cd822e5af37abba8aad033617cb 100644
> GIT binary patch
> delta 43
> rcmdnR_=u4!ILI;N5d#AQbIe4p$wD1K76@=aC<X@BiSc3+=gI;A(y0ha
> 
> delta 21
> dcmaFFxQmf1ILI+%7Xt$Wv-3o*$rF#t0suzv27~|r
> 
> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
> index e8f2766a63..dfb8523c8b 100644
> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> @@ -1,4 +1 @@
>  /* List of comma-separated changed AML files to ignore */
> -"tests/data/acpi/pc/SRAT.dimmpxm",
> -"tests/data/acpi/q35/SRAT.dimmpxm",
> -"tests/data/acpi/virt/SRAT.memhp",
> -- 
> 2.26.2


