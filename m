Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B63C2BA83
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 19:02:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F02D206CC
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 19:02:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OpuEFdaX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F02D206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2gE4-0003hZ-KP
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 14:02:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41523)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j2gDI-00037o-Gu
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 14:01:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j2gDG-0007IE-AV
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 14:01:20 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:21255
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j2gDG-0007GK-5J
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 14:01:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581706877;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fr73XHxyEK9gXCXv2Q+aSskBPipvMly9H2fmqkPRIzU=;
 b=OpuEFdaXU3/SLim5QAYK83Ae1wxkseuIeme2phZIgc6Laxab3T91Oo+jkHqkxOkU/Npd/b
 WaAbctkV9tpuFoAvx+tXlrjMzFTRzd8bMEjaZ6oJyf5zZX7q1lIAvcDf6D+dTZ3s+2HRNb
 yUm10Q8EZ3RnpX26dBYYSqxUk2IQ0uY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-24-ZuOU0_AdOQi3CLRcW9tHNA-1; Fri, 14 Feb 2020 14:01:15 -0500
Received: by mail-wr1-f72.google.com with SMTP id o9so4553958wrw.14
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 11:01:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XHyeZH2hzaxFyAZEYzgfnUPQHmCGxTKM8bRh2CmvS3s=;
 b=FMuO6gx/mtFEa8JUBErbrHLO+AQMW/z1hBkjmgf/1yaLFt8+DIi+qzXAHSnumaDGlH
 EX0broJmDLUXkDfFZaaWd1lxRxZxoEuvDdFaBUfrTLRaGmI1CCo1UTpcghLP5qJHtHvq
 FSQKyvPBUoCMUpufwZ1+pLVDGjMID7MD+VIXiLKGqn0p8bN2ivC125GGSy6AS5dlqdfD
 oXoUi8Wmzu1CqDOaHsUIjAJUYcyeFWWH1kUL1y9xdOeBkR93nGdNVFyFNWM/MDPdExIS
 yxKGRryO9GF2Q+uhL0yAAJ8FeIWrFUjEL9SncabI+tazvSJjJGdEplA30yiCpyfYl/6z
 yJ4Q==
X-Gm-Message-State: APjAAAXDscEreKu4cihcwsMpliqqci2whwefhoW0VCeORnBPWbif862b
 tZINNaa7TO1mtAaH1W8cap34md/DhwDfon7InOOqE26TZBUaTcrU6+nf1fqa9bgtwfdFSZY3eWi
 kDLEjFWvn1RJA830=
X-Received: by 2002:a5d:5708:: with SMTP id a8mr5332458wrv.79.1581706874232;
 Fri, 14 Feb 2020 11:01:14 -0800 (PST)
X-Google-Smtp-Source: APXvYqysehnvNf7RQFKL6IFN2/wOFf0nAKIycOMBMAVWI8HKnH1NoFZR2ZmUu+G+koTOjmJdUoJgAw==
X-Received: by 2002:a5d:5708:: with SMTP id a8mr5332422wrv.79.1581706873721;
 Fri, 14 Feb 2020 11:01:13 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id r5sm8080510wrt.43.2020.02.14.11.01.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Feb 2020 11:01:13 -0800 (PST)
Subject: Re: [RFC v2 2/6] tpm: Use TPMState as a common struct
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 stefanb@linux.ibm.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org
References: <20200214183704.14389-1-eric.auger@redhat.com>
 <20200214183704.14389-3-eric.auger@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <7534bf2b-b7d0-35de-f3b9-143bcde0c1c8@redhat.com>
Date: Fri, 14 Feb 2020 20:01:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200214183704.14389-3-eric.auger@redhat.com>
Content-Language: en-US
X-MC-Unique: ZuOU0_AdOQi3CLRcW9tHNA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: marcandre.lureau@redhat.com, lersek@redhat.com, ardb@kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/14/20 7:37 PM, Eric Auger wrote:
> As we plan to introdce a SysBus TPM TIS device, let's

typo "introduce"

> make the TPMState a common struct usable by both the
> ISADevice and the SysBusDevice. TPMStateISA embeds the
> struct and inherits from the ISADevice.
>=20
> The prototype of functions bound to be used by both
> the ISA and SysBus devices is changed to take TPMState
> handle.
>=20
> A bunch of structs also are renamed to be specialized
> for the ISA device. Besides those transformations, no
> functional change is expected.
>=20
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>   hw/tpm/tpm_tis.c | 146 +++++++++++++++++++++++++++++------------------
>   1 file changed, 91 insertions(+), 55 deletions(-)
>=20
> diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
> index c609737272..fc6d7ca579 100644
> --- a/hw/tpm/tpm_tis.c
> +++ b/hw/tpm/tpm_tis.c
> @@ -65,7 +65,6 @@ typedef struct TPMLocality {
>   } TPMLocality;
>  =20
>   typedef struct TPMState {
> -    ISADevice busdev;
>       MemoryRegion mmio;
>  =20
>       unsigned char buffer[TPM_TIS_BUFFER_MAX];
> @@ -91,7 +90,15 @@ typedef struct TPMState {
>       TPMPPI ppi;
>   } TPMState;
>  =20
> -#define TPM(obj) OBJECT_CHECK(TPMState, (obj), TYPE_TPM_TIS_ISA)
> +typedef struct TPMStateISA {
> +    /*< private >*/
> +    ISADevice parent_obj;
> +
> +    /*< public >*/
> +    TPMState state; /* not a QOM object */

Maybe rename 'state' -> 'tpm'?

Anyway:
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> +} TPMStateISA;
> +
> +#define TPM_TIS_ISA(obj) OBJECT_CHECK(TPMStateISA, (obj), TYPE_TPM_TIS_I=
SA)
>  =20
>   #define DEBUG_TIS 0
>  =20
> @@ -281,9 +288,8 @@ static void tpm_tis_prep_abort(TPMState *s, uint8_t l=
octy, uint8_t newlocty)
>   /*
>    * Callback from the TPM to indicate that the response was received.
>    */
> -static void tpm_tis_request_completed(TPMIf *ti, int ret)
> +static void tpm_tis_request_completed(TPMState *s, int ret)
>   {
> -    TPMState *s =3D TPM(ti);
>       uint8_t locty =3D s->cmd.locty;
>       uint8_t l;
>  =20
> @@ -338,7 +344,7 @@ static uint32_t tpm_tis_data_read(TPMState *s, uint8_=
t locty)
>   }
>  =20
>   #ifdef DEBUG_TIS
> -static void tpm_tis_dump_state(void *opaque, hwaddr addr)
> +static void tpm_tis_dump_state(TPMState *s, hwaddr addr)
>   {
>       static const unsigned regs[] =3D {
>           TPM_TIS_REG_ACCESS,
> @@ -353,7 +359,6 @@ static void tpm_tis_dump_state(void *opaque, hwaddr a=
ddr)
>       int idx;
>       uint8_t locty =3D tpm_tis_locality_from_addr(addr);
>       hwaddr base =3D addr & ~0xfff;
> -    TPMState *s =3D opaque;
>  =20
>       printf("tpm_tis: active locality      : %d\n"
>              "tpm_tis: state of locality %d : %d\n"
> @@ -363,7 +368,7 @@ static void tpm_tis_dump_state(void *opaque, hwaddr a=
ddr)
>  =20
>       for (idx =3D 0; regs[idx] !=3D 0xfff; idx++) {
>           printf("tpm_tis: 0x%04x : 0x%08x\n", regs[idx],
> -               (int)tpm_tis_mmio_read(opaque, base + regs[idx], 4));
> +               (int)tpm_tis_mmio_read(s, base + regs[idx], 4));
>       }
>  =20
>       printf("tpm_tis: r/w offset    : %d\n"
> @@ -488,7 +493,7 @@ static uint64_t tpm_tis_mmio_read(void *opaque, hwadd=
r addr,
>           break;
>   #ifdef DEBUG_TIS
>       case TPM_TIS_REG_DEBUG:
> -        tpm_tis_dump_state(opaque, addr);
> +        tpm_tis_dump_state(s, addr);
>           break;
>   #endif
>       }
> @@ -835,10 +840,8 @@ static const MemoryRegionOps tpm_tis_memory_ops =3D =
{
>   /*
>    * Get the TPMVersion of the backend device being used
>    */
> -static enum TPMVersion tpm_tis_get_tpm_version(TPMIf *ti)
> +static enum TPMVersion tpm_tis_get_tpm_version(TPMState *s)
>   {
> -    TPMState *s =3D TPM(ti);
> -
>       if (tpm_backend_had_startup_error(s->be_driver)) {
>           return TPM_VERSION_UNSPEC;
>       }
> @@ -850,9 +853,8 @@ static enum TPMVersion tpm_tis_get_tpm_version(TPMIf =
*ti)
>    * This function is called when the machine starts, resets or due to
>    * S3 resume.
>    */
> -static void tpm_tis_reset(DeviceState *dev)
> +static void tpm_tis_reset(TPMState *s)
>   {
> -    TPMState *s =3D TPM(dev);
>       int c;
>  =20
>       s->be_tpm_version =3D tpm_backend_get_tpm_version(s->be_driver);
> @@ -896,15 +898,14 @@ static void tpm_tis_reset(DeviceState *dev)
>  =20
>   /* persistent state handling */
>  =20
> -static int tpm_tis_pre_save(void *opaque)
> +static int tpm_tis_pre_save(TPMState *s)
>   {
> -    TPMState *s =3D opaque;
>       uint8_t locty =3D s->active_locty;
>  =20
>       trace_tpm_tis_pre_save(locty, s->rw_offset);
>  =20
>       if (DEBUG_TIS) {
> -        tpm_tis_dump_state(opaque, 0);
> +        tpm_tis_dump_state(s, 0);
>       }
>  =20
>       /*
> @@ -929,34 +930,78 @@ static const VMStateDescription vmstate_locty =3D {
>       }
>   };
>  =20
> -static const VMStateDescription vmstate_tpm_tis =3D {
> +/* ISA */
> +
> +static int tpm_tis_pre_save_isa(void *opaque)
> +{
> +    TPMStateISA *isadev =3D opaque;
> +
> +    return tpm_tis_pre_save(&isadev->state);
> +}
> +
> +static const VMStateDescription vmstate_tpm_tis_isa =3D {
>       .name =3D "tpm-tis",
>       .version_id =3D 0,
> -    .pre_save  =3D tpm_tis_pre_save,
> +    .pre_save  =3D tpm_tis_pre_save_isa,
>       .fields =3D (VMStateField[]) {
> -        VMSTATE_BUFFER(buffer, TPMState),
> -        VMSTATE_UINT16(rw_offset, TPMState),
> -        VMSTATE_UINT8(active_locty, TPMState),
> -        VMSTATE_UINT8(aborting_locty, TPMState),
> -        VMSTATE_UINT8(next_locty, TPMState),
> +        VMSTATE_BUFFER(state.buffer, TPMStateISA),
> +        VMSTATE_UINT16(state.rw_offset, TPMStateISA),
> +        VMSTATE_UINT8(state.active_locty, TPMStateISA),
> +        VMSTATE_UINT8(state.aborting_locty, TPMStateISA),
> +        VMSTATE_UINT8(state.next_locty, TPMStateISA),
>  =20
> -        VMSTATE_STRUCT_ARRAY(loc, TPMState, TPM_TIS_NUM_LOCALITIES, 0,
> +        VMSTATE_STRUCT_ARRAY(state.loc, TPMStateISA, TPM_TIS_NUM_LOCALIT=
IES, 0,
>                                vmstate_locty, TPMLocality),
>  =20
>           VMSTATE_END_OF_LIST()
>       }
>   };
>  =20
> -static Property tpm_tis_properties[] =3D {
> -    DEFINE_PROP_UINT32("irq", TPMState, irq_num, TPM_TIS_IRQ),
> -    DEFINE_PROP_TPMBE("tpmdev", TPMState, be_driver),
> -    DEFINE_PROP_BOOL("ppi", TPMState, ppi_enabled, true),
> +static void tpm_tis_isa_request_completed(TPMIf *ti, int ret)
> +{
> +    TPMStateISA *isadev =3D TPM_TIS_ISA(ti);
> +    TPMState *s =3D &isadev->state;
> +
> +    tpm_tis_request_completed(s, ret);
> +}
> +
> +static enum TPMVersion tpm_tis_isa_get_tpm_version(TPMIf *ti)
> +{
> +    TPMStateISA *isadev =3D TPM_TIS_ISA(ti);
> +    TPMState *s =3D &isadev->state;
> +
> +    return tpm_tis_get_tpm_version(s);
> +}
> +
> +static void tpm_tis_isa_reset(DeviceState *dev)
> +{
> +    TPMStateISA *isadev =3D TPM_TIS_ISA(dev);
> +    TPMState *s =3D &isadev->state;
> +
> +    return tpm_tis_reset(s);
> +}
> +
> +static Property tpm_tis_isa_properties[] =3D {
> +    DEFINE_PROP_UINT32("irq", TPMStateISA, state.irq_num, TPM_TIS_IRQ),
> +    DEFINE_PROP_TPMBE("tpmdev", TPMStateISA, state.be_driver),
> +    DEFINE_PROP_BOOL("ppi", TPMStateISA, state.ppi_enabled, true),
>       DEFINE_PROP_END_OF_LIST(),
>   };
>  =20
> -static void tpm_tis_realizefn(DeviceState *dev, Error **errp)
> +static void tpm_tis_isa_initfn(Object *obj)
>   {
> -    TPMState *s =3D TPM(dev);
> +    TPMStateISA *isadev =3D TPM_TIS_ISA(obj);
> +    TPMState *s =3D &isadev->state;
> +
> +    memory_region_init_io(&s->mmio, obj, &tpm_tis_memory_ops,
> +                          s, "tpm-tis-mmio",
> +                          TPM_TIS_NUM_LOCALITIES << TPM_TIS_LOCALITY_SHI=
FT);
> +}
> +
> +static void tpm_tis_isa_realizefn(DeviceState *dev, Error **errp)
> +{
> +    TPMStateISA *isadev =3D TPM_TIS_ISA(dev);
> +    TPMState *s =3D &isadev->state;
>  =20
>       if (!tpm_find()) {
>           error_setg(errp, "at most one TPM device is permitted");
> @@ -973,55 +1018,46 @@ static void tpm_tis_realizefn(DeviceState *dev, Er=
ror **errp)
>           return;
>       }
>  =20
> -    isa_init_irq(&s->busdev, &s->irq, s->irq_num);
> +    isa_init_irq(ISA_DEVICE(dev), &s->irq, s->irq_num);
>  =20
>       memory_region_add_subregion(isa_address_space(ISA_DEVICE(dev)),
>                                   TPM_TIS_ADDR_BASE, &s->mmio);
>  =20
>       if (s->ppi_enabled) {
>           tpm_ppi_init(&s->ppi, isa_address_space(ISA_DEVICE(dev)),
> -                     TPM_PPI_ADDR_BASE, OBJECT(s));
> +                     TPM_PPI_ADDR_BASE, OBJECT(dev));
>       }
>   }
>  =20
> -static void tpm_tis_initfn(Object *obj)
> -{
> -    TPMState *s =3D TPM(obj);
> -
> -    memory_region_init_io(&s->mmio, OBJECT(s), &tpm_tis_memory_ops,
> -                          s, "tpm-tis-mmio",
> -                          TPM_TIS_NUM_LOCALITIES << TPM_TIS_LOCALITY_SHI=
FT);
> -}
> -
> -static void tpm_tis_class_init(ObjectClass *klass, void *data)
> +static void tpm_tis_isa_class_init(ObjectClass *klass, void *data)
>   {
>       DeviceClass *dc =3D DEVICE_CLASS(klass);
>       TPMIfClass *tc =3D TPM_IF_CLASS(klass);
>  =20
> -    dc->realize =3D tpm_tis_realizefn;
> -    device_class_set_props(dc, tpm_tis_properties);
> -    dc->reset =3D tpm_tis_reset;
> -    dc->vmsd  =3D &vmstate_tpm_tis;
> +    device_class_set_props(dc, tpm_tis_isa_properties);
> +    dc->vmsd  =3D &vmstate_tpm_tis_isa;
>       tc->model =3D TPM_MODEL_TPM_TIS;
> -    tc->get_version =3D tpm_tis_get_tpm_version;
> -    tc->request_completed =3D tpm_tis_request_completed;
> +    dc->realize =3D tpm_tis_isa_realizefn;
> +    dc->reset =3D tpm_tis_isa_reset;
> +    tc->request_completed =3D tpm_tis_isa_request_completed;
> +    tc->get_version =3D tpm_tis_isa_get_tpm_version;
>   }
>  =20
> -static const TypeInfo tpm_tis_info =3D {
> +static const TypeInfo tpm_tis_isa_info =3D {
>       .name =3D TYPE_TPM_TIS_ISA,
>       .parent =3D TYPE_ISA_DEVICE,
> -    .instance_size =3D sizeof(TPMState),
> -    .instance_init =3D tpm_tis_initfn,
> -    .class_init  =3D tpm_tis_class_init,
> +    .instance_size =3D sizeof(TPMStateISA),
> +    .instance_init =3D tpm_tis_isa_initfn,
> +    .class_init  =3D tpm_tis_isa_class_init,
>       .interfaces =3D (InterfaceInfo[]) {
>           { TYPE_TPM_IF },
>           { }
>       }
>   };
>  =20
> -static void tpm_tis_register(void)
> +static void tpm_tis_isa_register(void)
>   {
> -    type_register_static(&tpm_tis_info);
> +    type_register_static(&tpm_tis_isa_info);
>   }
>  =20
> -type_init(tpm_tis_register)
> +type_init(tpm_tis_isa_register)
>=20


