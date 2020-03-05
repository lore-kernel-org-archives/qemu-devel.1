Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 646B5C3F2CD
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 08:44:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E0612146E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 08:44:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="An9sMZ9q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E0612146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9m7V-0001qu-9U
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 03:44:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49117)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j9m6q-0001EJ-2f
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 03:44:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j9m6o-0003WY-RZ
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 03:43:59 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21124
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j9m6o-0003W4-NL
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 03:43:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583397838;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EoE4L0PqSdojdZZVB7BdvjTFrrvAfFiuCSWFTTilAFs=;
 b=An9sMZ9qcdG+KHdrjBK8jbt77Z2iqWxw+JuxWhxdHXrWxU1OMCzaMcFme5EWphiXY3R/vh
 AF/j2b2d3BGZeHDka9AmIqFwCS9N5pa8ZrLBbeWRvLtfaRibgVWics1s2Nwmv1anEmEn/Q
 P6bKkFvVLBk9Fd0FI+EKKRcfelS20II=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-42-XmyDEkkOPvy3orTcLXPVRA-1; Thu, 05 Mar 2020 03:43:56 -0500
X-MC-Unique: XmyDEkkOPvy3orTcLXPVRA-1
Received: by mail-ed1-f71.google.com with SMTP id x13so3782377eds.19
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 00:43:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=C0AlKd3vtFCQTBGG7AtgaIUZ85Jxtq3F92Q9mCQJ9JU=;
 b=XnhMl/ymiQyVim/ei1jmjZ6qNC+8MIfX6nF1ToR4EAdf/dmU9YcJBxvgqz1DHwzYT9
 2R+lq4tfkoNdk5m6Bt1Dof7/ySdn06Kdw36OUHLTtGDm84iXofoNGtxGhDj/0DNwsjFF
 pFuHDyyn1T5osHZrNpsDb1/XA7h2Tya4cHGDji8hBspHgd9lvzOBCPmp8KWu1Sro17z4
 n1YgxUkxlwey1lhMU+n+laxioHNOICkPBARXFS9SY5RTv4nMpMVdpnYv8l9RkFcsBdkY
 gWnBNQ8bXbN1i+INh3t8BAFP1juzTvoNAm1JNbZ0GXF6k4sDyR9w2U/jGRPZJT39CplI
 VF+A==
X-Gm-Message-State: ANhLgQ01ciOiPaX3vyTm57M8DWbGAu4TUANHCjwOD/Ja0x3wey6Jby8+
 opwy9TC2o8SFC1bJA62PA5klMu+AsQTmGU82OW4njHBXYz6rcaP4sudAHdb236r62Fz09Xw9VLP
 aJjAE+3DVyWFHUfA=
X-Received: by 2002:a17:906:9610:: with SMTP id
 s16mr6287557ejx.364.1583397835466; 
 Thu, 05 Mar 2020 00:43:55 -0800 (PST)
X-Google-Smtp-Source: ADFU+vvu+8jM4Iy2xxmWTX9mUAcJQk0zQNrk7w7qFuOxWDop9WRc5IldUb5E2RdTq/guIx/Quz7nQg==
X-Received: by 2002:a17:906:9610:: with SMTP id
 s16mr6287535ejx.364.1583397835167; 
 Thu, 05 Mar 2020 00:43:55 -0800 (PST)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id f20sm678710edm.38.2020.03.05.00.43.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Mar 2020 00:43:54 -0800 (PST)
Subject: Re: [PATCH v7 16/17] spapr: Clean up RMA size calculation
To: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 clg@kaod.org, qemu-devel@nongnu.org, groug@kaod.org
References: <20200303034351.333043-1-david@gibson.dropbear.id.au>
 <20200303034351.333043-17-david@gibson.dropbear.id.au>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c33d9ffc-72e1-787c-b099-dd08e84e5663@redhat.com>
Date: Thu, 5 Mar 2020 09:43:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200303034351.333043-17-david@gibson.dropbear.id.au>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: lvivier@redhat.com, Thomas Huth <thuth@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, aik@ozlabs.ru, farosas@linux.ibm.com,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Igor Mammedov <imammedo@redhat.com>, paulus@samba.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/3/20 4:43 AM, David Gibson wrote:
> Move the calculation of the Real Mode Area (RMA) size into a helper
> function.  While we're there clean it up and correct it in a few ways:
>    * Add comments making it clearer where the various constraints come fr=
om
>    * Remove a pointless check that the RMA fits within Node 0 (we've just
>      clamped it so that it does)
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>   hw/ppc/spapr.c | 60 ++++++++++++++++++++++++++++++--------------------
>   1 file changed, 36 insertions(+), 24 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 95bda4a615..2eb0d8f70d 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2648,6 +2648,41 @@ static PCIHostState *spapr_create_default_phb(void=
)
>       return PCI_HOST_BRIDGE(dev);
>   }
>  =20
> +static hwaddr spapr_rma_size(SpaprMachineState *spapr, Error **errp)
> +{
> +    MachineState *machine =3D MACHINE(spapr);
> +    SpaprMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
> +    hwaddr rma_size =3D machine->ram_size;
> +    hwaddr node0_size =3D spapr_node0_size(machine);
> +
> +    /* RMA has to fit in the first NUMA node */
> +    rma_size =3D MIN(rma_size, node0_size);
> +
> +    /*
> +     * VRMA access is via a special 1TiB SLB mapping, so the RMA can
> +     * never exceed that
> +     */
> +    rma_size =3D MIN(rma_size, 1 * TiB);
> +
> +    /*
> +     * Clamp the RMA size based on machine type.  This is for
> +     * migration compatibility with older qemu versions, which limited
> +     * the RMA size for complicated and mostly bad reasons.
> +     */
> +    if (smc->rma_limit) {
> +        rma_size =3D MIN(rma_size, smc->rma_limit);
> +    }
> +
> +    if (rma_size < MIN_RMA_SLOF) {
> +        error_setg(errp,
> +"pSeries SLOF firmware requires >=3D %ldMiB guest RMA (Real Mode Area me=
mory)",
> +                   MIN_RMA_SLOF / MiB);
> +        return 0;
> +    }
> +
> +    return rma_size;
> +}
> +
>   /* pSeries LPAR / sPAPR hardware init */
>   static void spapr_machine_init(MachineState *machine)
>   {
> @@ -2659,7 +2694,6 @@ static void spapr_machine_init(MachineState *machin=
e)
>       PCIHostState *phb;
>       int i;
>       MemoryRegion *sysmem =3D get_system_memory();
> -    hwaddr node0_size =3D spapr_node0_size(machine);
>       long load_limit, fw_size;
>       char *filename;
>       Error *resize_hpt_err =3D NULL;
> @@ -2699,22 +2733,7 @@ static void spapr_machine_init(MachineState *machi=
ne)
>           exit(1);
>       }
>  =20
> -    spapr->rma_size =3D node0_size;
> -
> -    /*
> -     * Clamp the RMA size based on machine type.  This is for
> -     * migration compatibility with older qemu versions, which limited
> -     * the RMA size for complicated and mostly bad reasons.
> -     */
> -    if (smc->rma_limit) {
> -        spapr->rma_size =3D MIN(spapr->rma_size, smc->rma_limit);
> -    }
> -
> -    if (spapr->rma_size > node0_size) {
> -        error_report("Numa node 0 has to span the RMA (%#08"HWADDR_PRIx"=
)",
> -                     spapr->rma_size);
> -        exit(1);
> -    }
> +    spapr->rma_size =3D spapr_rma_size(spapr, &error_fatal);
>  =20
>       /* Setup a load limit for the ramdisk leaving room for SLOF and FDT=
 */
>       load_limit =3D MIN(spapr->rma_size, RTAS_MAX_ADDR) - FW_OVERHEAD;
> @@ -2951,13 +2970,6 @@ static void spapr_machine_init(MachineState *machi=
ne)
>           }
>       }
>  =20
> -    if (spapr->rma_size < MIN_RMA_SLOF) {
> -        error_report(
> -            "pSeries SLOF firmware requires >=3D %ldMiB guest RMA (Real =
Mode Area memory)",
> -            MIN_RMA_SLOF / MiB);
> -        exit(1);
> -    }
> -
>       if (kernel_filename) {
>           uint64_t lowaddr =3D 0;
>  =20
>=20

Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>


