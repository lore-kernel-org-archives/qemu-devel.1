Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4607CC432C3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 03:45:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC8E7206DF
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 03:45:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="WSMNmcSy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC8E7206DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47993 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibz87-0007fr-Vb
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 22:45:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34467)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aik@ozlabs.ru>) id 1ibz6k-00079J-TD
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 22:44:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aik@ozlabs.ru>) id 1ibz6i-0003n2-Jk
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 22:44:13 -0500
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:36907)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1ibz6i-0003l0-7z
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 22:44:12 -0500
Received: by mail-pj1-x1043.google.com with SMTP id ep17so936210pjb.4
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2019 19:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=XgsSwNGyYeGI+9ifGwpoODdgd8uanvVx6JO4BRg3lwU=;
 b=WSMNmcSyA1VCEBdXNCqIxW86xQsvfONrA56+iEmT747fJBykAQvYNnhd1TfzW0XTNx
 30edigzFnArT2GY9r1TDYsmlGQJjzLhNPUEZQcQsstxB0X+x5DXZw9TWvPJnUyFqdITY
 SykBNmaiSvSpGERG8VnK1ZlBwHfXk3iBT8XpDz6SnsLeq1SjT9aYMzyKHlEtj2Wg8KCw
 +raBfORoXV2JPMDTAK3aoLqxqjI77vMrB4YGPrivaFze3dT2ejRmPc8/a86fnTELgAD6
 dLCI5nn1MRlnMLqgVqZxI6sqvJqcmTZHo4+h4OXhfhua8Fv+c9S8s3uzWaCeiVJPs5Se
 i2Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=XgsSwNGyYeGI+9ifGwpoODdgd8uanvVx6JO4BRg3lwU=;
 b=annY3h0KI7rbebII1iSg7EoZJSt7KONB9d9tw1DBWETmtDBojnehLnR9if86IY4nsk
 MsKDXZ/nTmG3K1hemogZ1EjV8t1QFA5eNSdywRgBhazsK21lWf6Ejpq2DI0NltHwxSW8
 UmaYET56oMq/tQabYKmqT2orGpzDRykW8Lu78prNIOlolHqps+AmKtmwAH4xpaW4pDJm
 2V/KAkIRMygEs9zQNPsH8IOnO4WlWUpZR/i9wfM6vXiMA0tmWcxBoN4BR1ORjIv3oP1G
 CzZx7vw7a2ENFJq3oPCrQnUAKa9PVixsJ1YyezCQP2vo8ly9mpEAR4fxzrEN3yKgrqI7
 vsbQ==
X-Gm-Message-State: APjAAAXvTu7wA+BI1yIbJIdb6HTyoHgyplgLzWolnQoGCChcjdj2AwLg
 DZvYCc+zRH36z6QTW7ujK7URmRhRGSw=
X-Google-Smtp-Source: APXvYqyFd9VWxRD+i0ZjHrOMzHUuxBQHe0xk6aevSHXu1Fw6w3k/8VxJ04jpzRBySxd+AW5jdpgo9Q==
X-Received: by 2002:a17:902:ff15:: with SMTP id
 f21mr2835495plj.163.1575344650882; 
 Mon, 02 Dec 2019 19:44:10 -0800 (PST)
Received: from [10.61.2.175] ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id o7sm1078827pfg.138.2019.12.02.19.44.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2019 19:44:10 -0800 (PST)
Subject: Re: [for-5.0 3/4] spapr: Clean up RMA size calculation
To: David Gibson <david@gibson.dropbear.id.au>, groug@kaod.org, clg@kaod.org
References: <20191129013504.145455-1-david@gibson.dropbear.id.au>
 <20191129013504.145455-4-david@gibson.dropbear.id.au>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Autocrypt: addr=aik@ozlabs.ru; keydata=
 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
Message-ID: <26f70f7b-d2e3-689a-693e-66ced0f6d4f8@ozlabs.ru>
Date: Tue, 3 Dec 2019 14:44:06 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191129013504.145455-4-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1043
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
Cc: lvivier@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 29/11/2019 12:35, David Gibson wrote:
> Move the calculation of the Real Mode Area (RMA) size into a helper
> function.  While we're there clean it up and correct it in a few ways:
>   * Add comments making it clearer where the various constraints come from
>   * Remove a pointless check that the RMA fits within Node 0 (we've just
>     clamped it so that it does)
>   * The 16GiB limit we apply is only correct for POWER8, but there is also
>     a 1TiB limit that applies on POWER9.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  hw/ppc/spapr.c | 57 +++++++++++++++++++++++++++++++-------------------
>  1 file changed, 35 insertions(+), 22 deletions(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 52c39daa99..7efd4f2b85 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2664,6 +2664,40 @@ static PCIHostState *spapr_create_default_phb(void)
>      return PCI_HOST_BRIDGE(dev);
>  }
>  
> +static hwaddr spapr_rma_size(SpaprMachineState *spapr, Error **errp)
> +{
> +    MachineState *machine = MACHINE(spapr);
> +    hwaddr rma_size = machine->ram_size;
> +    hwaddr node0_size = spapr_node0_size(machine);
> +
> +    /* RMA has to fit in the first NUMA node */
> +    rma_size = MIN(rma_size, node0_size);
> +
> +    /*
> +     * VRMA access is via a special 1TiB SLB mapping, so the RMA can
> +     * never exceed that
> +     */
> +    rma_size = MIN(rma_size, TiB);
> +
> +    /*
> +     * RMA size is controlled in hardware by LPCR[RMLS].  On POWER8


RMA is controlled by LPCR on P8 but the RMLS bits on P9 are reserved
(also reserved in PowerISA 3.0).


> +     * the largest RMA that can be specified there is 16GiB


The P8 user manual says:
===
The following RMO sizes are available for the POWER8 processor.
The RMLS[34:37] field in the LPCR defines the RMO sizes, as described below.
1000 - 32 MB
0011 - 64 MB
0111 - 128 MB
0100 - 256 MB
0010 - 1 GB
0001 - 16 GB
0000 - 256 GB
===

The maximum seems to be 256GiB.


> +     */
> +    if (!ppc_type_check_compat(machine->cpu_type, CPU_POWERPC_LOGICAL_3_00,
> +                               0, spapr->max_compat_pvr)) {
> +        rma_size = MIN(rma_size, 16 * GiB);
> +    }
> +
> +    if (rma_size < (MIN_RMA_SLOF * MiB)) {


nit: it is time to redefine MIN_RMA_SLOF to use MiBs imho :)


> +        error_setg(errp,
> +"pSeries SLOF firmware requires >= %ldMiB guest RMA (Real Mode Area)",
> +                   MIN_RMA_SLOF);

Something went wrong with formatting here.

Otherwise looks good. Thanks,



> +        return -1;
> +    }
> +
> +    return rma_size;
> +}
> +
>  /* pSeries LPAR / sPAPR hardware init */
>  static void spapr_machine_init(MachineState *machine)
>  {
> @@ -2675,7 +2709,6 @@ static void spapr_machine_init(MachineState *machine)
>      int i;
>      MemoryRegion *sysmem = get_system_memory();
>      MemoryRegion *ram = g_new(MemoryRegion, 1);
> -    hwaddr node0_size = spapr_node0_size(machine);
>      long load_limit, fw_size;
>      char *filename;
>      Error *resize_hpt_err = NULL;
> @@ -2715,20 +2748,7 @@ static void spapr_machine_init(MachineState *machine)
>          exit(1);
>      }
>  
> -    spapr->rma_size = node0_size;
> -
> -    /* Actually we don't support unbounded RMA anymore since we added
> -     * proper emulation of HV mode. The max we can get is 16G which
> -     * also happens to be what we configure for PAPR mode so make sure
> -     * we don't do anything bigger than that
> -     */
> -    spapr->rma_size = MIN(spapr->rma_size, 0x400000000ull);
> -
> -    if (spapr->rma_size > node0_size) {
> -        error_report("Numa node 0 has to span the RMA (%#08"HWADDR_PRIx")",
> -                     spapr->rma_size);
> -        exit(1);
> -    }
> +    spapr->rma_size = spapr_rma_size(spapr, &error_fatal);
>  
>      /* Setup a load limit for the ramdisk leaving room for SLOF and FDT */
>      load_limit = MIN(spapr->rma_size, RTAS_MAX_ADDR) - FW_OVERHEAD;
> @@ -2956,13 +2976,6 @@ static void spapr_machine_init(MachineState *machine)
>          }
>      }
>  
> -    if (spapr->rma_size < (MIN_RMA_SLOF * MiB)) {
> -        error_report(
> -            "pSeries SLOF firmware requires >= %ldM guest RMA (Real Mode Area memory)",
> -            MIN_RMA_SLOF);
> -        exit(1);
> -    }
> -
>      if (kernel_filename) {
>          uint64_t lowaddr = 0;
>  
> 

-- 
Alexey

