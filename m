Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC8C2C3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 08:47:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A22402146E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 08:47:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h23Ya+q8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A22402146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9mAG-0004kn-TF
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 03:47:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51433)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j9m8n-0003dF-Ar
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 03:46:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j9m8l-000575-TA
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 03:46:01 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36743
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j9m8l-00056p-PG
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 03:45:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583397959;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZffSG/yzyJFEbPeuCZfP9n7ukxWZ4+qXx1a+O3fqfuQ=;
 b=h23Ya+q8PJGVZf9bgxqr0gmC2JPSxPmOGKRc6Y6I5CXsBUcCViGf3sokjSjzq/Lgkhqoxk
 RpoQit7wCdVg2Acp+7vnQLjt5CWvngkvrXzxk8mQlNleaYXwhC/gx7yCi65OFAIZ+4xwuG
 T7sux7d0qm/eg89zTcdYGZZFTtdO6cI=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-8x86MPQSOeWvfSg5Irrm1w-1; Thu, 05 Mar 2020 03:45:57 -0500
X-MC-Unique: 8x86MPQSOeWvfSg5Irrm1w-1
Received: by mail-ed1-f72.google.com with SMTP id y23so3838379edt.2
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 00:45:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=m416NwVFBBgq0D2ulkVXmujCfhQ+yO+jagwPtvPv0bU=;
 b=pz3gSHuBO7ECwZklW9bTl9W0Vwl7cI6WbJo0SCnrBWjreo+//ewVtszsjE4mTM3dgu
 YlkALrNg/vZRU4Xoc6k5q0U40UnKGU6wU+skexHDngNNO8T91wsj0g1SEHJHPCIuR2Aw
 7jdkGmZgiacRUyvMIsLXx5wnR6yJ8asxx5RO7PVTg9uNSuFuUtjrl/VhrKeyrh4ChrRx
 TO7pRW/nz6UR2UUVIocpGQmxvJg4WHsy9eiKRGJpBsirR+Tou6M4LfLVhE2d/PUeQAvp
 9MqvpoFbfzxtQger/78vQ02vJsLa2TzTiIJqmhcSa8NCbPNGwEbOSMJUbxjeZ6jPWRuN
 j0Jw==
X-Gm-Message-State: ANhLgQ2HJTddzUVfdFDlVUXgg4gVgRyuG4nIDW4nau1xfxO0FTeOoCI2
 MOwWJ/FVmnQb3/YqaGOvmFXZ9GWxNB2TkFuVP/cY5aWVDtY7WIe5+D2XubNszGwHV1RZGXdLUPy
 3nnSEPuzU1KxRYf8=
X-Received: by 2002:a05:6402:1b09:: with SMTP id
 by9mr7268123edb.23.1583397955938; 
 Thu, 05 Mar 2020 00:45:55 -0800 (PST)
X-Google-Smtp-Source: ADFU+vtPWR/OySZjQYGDxRgIDnoyTb2JsctE/Jud8vZklZtmoSQpbo/2WmE5akM2jElf697+Pv5hkg==
X-Received: by 2002:a05:6402:1b09:: with SMTP id
 by9mr7268099edb.23.1583397955714; 
 Thu, 05 Mar 2020 00:45:55 -0800 (PST)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id p7sm197104edy.15.2020.03.05.00.45.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Mar 2020 00:45:55 -0800 (PST)
Subject: Re: [PATCH v7 15/17] spapr: Don't clamp RMA to 16GiB on new machine
 types
To: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 clg@kaod.org, qemu-devel@nongnu.org, groug@kaod.org
References: <20200303034351.333043-1-david@gibson.dropbear.id.au>
 <20200303034351.333043-16-david@gibson.dropbear.id.au>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <233c4ed0-2df6-fa66-ecc7-4320398296c8@redhat.com>
Date: Thu, 5 Mar 2020 09:45:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200303034351.333043-16-david@gibson.dropbear.id.au>
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
> In spapr_machine_init() we clamp the size of the RMA to 16GiB and the
> comment saying why doesn't make a whole lot of sense.  In fact, this was
> done because the real mode handling code elsewhere limited the RMA in TCG
> mode to the maximum value configurable in LPCR[RMLS], 16GiB.
>=20
> But,
>   * Actually LPCR[RMLS] has been able to encode a 256GiB size for a very
>     long time, we just didn't implement it properly in the softmmu
>   * LPCR[RMLS] shouldn't really be relevant anyway, it only was because w=
e
>     used to abuse the RMOR based translation mode in order to handle the
>     fact that we're not modelling the hypervisor parts of the cpu
>=20
> We've now removed those limitations in the modelling so the 16GiB clamp n=
o
> longer serves a function.  However, we can't just remove the limit
> universally: that would break migration to earlier qemu versions, where
> the 16GiB RMLS limit still applies, no matter how bad the reasons for it
> are.
>=20
> So, we replace the 16GiB clamp, with a clamp to a limit defined in the
> machine type class.  We set it to 16 GiB for machine types 4.2 and earlie=
r,
> but set it to 0 meaning unlimited for the new 5.0 machine type.
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>   hw/ppc/spapr.c         | 13 ++++++++-----
>   include/hw/ppc/spapr.h |  1 +
>   2 files changed, 9 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index ef7667455c..95bda4a615 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2701,12 +2701,14 @@ static void spapr_machine_init(MachineState *mach=
ine)
>  =20
>       spapr->rma_size =3D node0_size;
>  =20
> -    /* Actually we don't support unbounded RMA anymore since we added
> -     * proper emulation of HV mode. The max we can get is 16G which
> -     * also happens to be what we configure for PAPR mode so make sure
> -     * we don't do anything bigger than that
> +    /*
> +     * Clamp the RMA size based on machine type.  This is for
> +     * migration compatibility with older qemu versions, which limited
> +     * the RMA size for complicated and mostly bad reasons.
>        */
> -    spapr->rma_size =3D MIN(spapr->rma_size, 0x400000000ull);
> +    if (smc->rma_limit) {
> +        spapr->rma_size =3D MIN(spapr->rma_size, smc->rma_limit);
> +    }
>  =20
>       if (spapr->rma_size > node0_size) {
>           error_report("Numa node 0 has to span the RMA (%#08"HWADDR_PRIx=
")",
> @@ -4598,6 +4600,7 @@ static void spapr_machine_4_2_class_options(Machine=
Class *mc)
>       compat_props_add(mc->compat_props, hw_compat_4_2, hw_compat_4_2_len=
);
>       smc->default_caps.caps[SPAPR_CAP_CCF_ASSIST] =3D SPAPR_CAP_OFF;
>       smc->default_caps.caps[SPAPR_CAP_FWNMI_MCE] =3D SPAPR_CAP_OFF;
> +    smc->rma_limit =3D 16 * GiB;
>       mc->nvdimm_supported =3D false;
>   }
>  =20
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 90dbc55931..2015e37ac5 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -126,6 +126,7 @@ struct SpaprMachineClass {
>       bool pre_4_1_migration; /* don't migrate hpt-max-page-size */
>       bool linux_pci_probe;
>       bool smp_threads_vsmt; /* set VSMT to smp_threads by default */
> +    hwaddr rma_limit;          /* clamp the RMA to this size */
>  =20
>       void (*phb_placement)(SpaprMachineState *spapr, uint32_t index,
>                             uint64_t *buid, hwaddr *pio,
>=20

Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>


