Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1FB9C761A0
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 09:22:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD71720726
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 09:22:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KRfGAOGc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD71720726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3cc1-0003z2-Sm
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 04:22:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51167)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j3cbG-00032b-9I
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 04:21:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j3cbE-0007jC-Ie
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 04:21:58 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:39319
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j3cbE-0007i6-FA
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 04:21:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581931315;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lisnPcDB15QHDm3FNXn38p+Xr7+XPlALGYswteOpypg=;
 b=KRfGAOGcGdJYeblPwlSYJbpYQfW96xabLQCNpl3YdvUylY5QsWu/cmv6FxMFIWm6CHYliZ
 vnYSx3X3VoPLPF143EtS9APnm7dNfyiBAHBUL3qLJj3TtJRp51t8xthqCbC3I6u/YFJL8W
 chn+qbNiKYPBj8abjHDxQM5WjNdKk0s=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61-lH3gTYn8NFixNbmUMxfhuA-1; Mon, 17 Feb 2020 04:21:53 -0500
Received: by mail-wm1-f69.google.com with SMTP id p26so5976669wmg.5
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 01:21:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=lisnPcDB15QHDm3FNXn38p+Xr7+XPlALGYswteOpypg=;
 b=bgMt0jojmIten02HDDvfiqCmxHxEkm3DoiufJp/zJ+nCU8hw/jgw/6/80i2i+hHSU6
 sVTxiprLR0+LdSyaI/6ICZHnC3xXPvkgPJDIf1s8YKekXjS6emxfuWrjQ78jxNRNGs/d
 TRdh17Zrve+J+axQPAkBqO1nhlKWYTdk7xBbdEKACFFM1LQI1jzsyaAJ4vr2SHmopLsY
 lmlsrOyWizkmb4H/PxiW92/ncfBrBnckVRy/inrGQEebJlZK++JbStU7uLDtLP8GY7/1
 48Cg6hmdBdNzYoVUtTKD9SkRd1p16pYTwEDBTG1ItQxUJuRDs6y4WAZtJdIUpCIvkCR/
 Z4Og==
X-Gm-Message-State: APjAAAU4hzpRBwRtnobOvHgq1cLMZ1rSEdywvrYZ9TmIcDxB2Nd1Lt8n
 wE3f5RAvh7fjHUbzj2tZuM2TSfoU9XaNPtwihqjeva2AOXYjHibD6gSF+SuKSLjjjJqa/cSKVgR
 VF/qG8CJyqQB7tOQ=
X-Received: by 2002:a1c:9e13:: with SMTP id h19mr21570943wme.21.1581931312652; 
 Mon, 17 Feb 2020 01:21:52 -0800 (PST)
X-Google-Smtp-Source: APXvYqyLzdzxG/Z4/Srxkkk1XEEPndS5/GAW4nlUd4VDT05N6FHtUv65hO+vhkRjtiDE0hxbw0tW+A==
X-Received: by 2002:a1c:9e13:: with SMTP id h19mr21570896wme.21.1581931312217; 
 Mon, 17 Feb 2020 01:21:52 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id v8sm87890wrw.2.2020.02.17.01.21.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2020 01:21:51 -0800 (PST)
Subject: Re: [RFC v2 2/6] tpm: Use TPMState as a common struct
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 stefanb@linux.ibm.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org
References: <20200214183704.14389-1-eric.auger@redhat.com>
 <20200214183704.14389-3-eric.auger@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <bda40279-016a-8cb5-96b0-cedc88e21e60@redhat.com>
Date: Mon, 17 Feb 2020 10:21:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200214183704.14389-3-eric.auger@redhat.com>
Content-Language: en-US
X-MC-Unique: lH3gTYn8NFixNbmUMxfhuA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

Hi Eric,

On 2/14/20 7:37 PM, Eric Auger wrote:
> As we plan to introdce a SysBus TPM TIS device, let's
> make the TPMState a common struct usable by both the
> ISADevice and the SysBusDevice. TPMStateISA embeds the
> struct and inherits from the ISADevice.
> 
> The prototype of functions bound to be used by both
> the ISA and SysBus devices is changed to take TPMState
> handle.
> 
> A bunch of structs also are renamed to be specialized
> for the ISA device. Besides those transformations, no
> functional change is expected.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>   hw/tpm/tpm_tis.c | 146 +++++++++++++++++++++++++++++------------------
>   1 file changed, 91 insertions(+), 55 deletions(-)
> 
> diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
> index c609737272..fc6d7ca579 100644
> --- a/hw/tpm/tpm_tis.c
> +++ b/hw/tpm/tpm_tis.c
> @@ -65,7 +65,6 @@ typedef struct TPMLocality {
>   } TPMLocality;
>   
>   typedef struct TPMState {
> -    ISADevice busdev;
>       MemoryRegion mmio;
>   
>       unsigned char buffer[TPM_TIS_BUFFER_MAX];
> @@ -91,7 +90,15 @@ typedef struct TPMState {
>       TPMPPI ppi;
>   } TPMState;
>   
> -#define TPM(obj) OBJECT_CHECK(TPMState, (obj), TYPE_TPM_TIS_ISA)
> +typedef struct TPMStateISA {
> +    /*< private >*/
> +    ISADevice parent_obj;
> +
> +    /*< public >*/
> +    TPMState state; /* not a QOM object */
> +} TPMStateISA;
> +
> +#define TPM_TIS_ISA(obj) OBJECT_CHECK(TPMStateISA, (obj), TYPE_TPM_TIS_ISA)
>   
>   #define DEBUG_TIS 0
>   
> @@ -281,9 +288,8 @@ static void tpm_tis_prep_abort(TPMState *s, uint8_t locty, uint8_t newlocty)
>   /*
>    * Callback from the TPM to indicate that the response was received.
>    */
> -static void tpm_tis_request_completed(TPMIf *ti, int ret)
> +static void tpm_tis_request_completed(TPMState *s, int ret)
>   {
> -    TPMState *s = TPM(ti);
>       uint8_t locty = s->cmd.locty;
>       uint8_t l;
>   
> @@ -338,7 +344,7 @@ static uint32_t tpm_tis_data_read(TPMState *s, uint8_t locty)
>   }
>   
>   #ifdef DEBUG_TIS
> -static void tpm_tis_dump_state(void *opaque, hwaddr addr)
> +static void tpm_tis_dump_state(TPMState *s, hwaddr addr)
>   {
>       static const unsigned regs[] = {
>           TPM_TIS_REG_ACCESS,
> @@ -353,7 +359,6 @@ static void tpm_tis_dump_state(void *opaque, hwaddr addr)
>       int idx;
>       uint8_t locty = tpm_tis_locality_from_addr(addr);
>       hwaddr base = addr & ~0xfff;
> -    TPMState *s = opaque;
>   
>       printf("tpm_tis: active locality      : %d\n"
>              "tpm_tis: state of locality %d : %d\n"
> @@ -363,7 +368,7 @@ static void tpm_tis_dump_state(void *opaque, hwaddr addr)
>   
>       for (idx = 0; regs[idx] != 0xfff; idx++) {
>           printf("tpm_tis: 0x%04x : 0x%08x\n", regs[idx],
> -               (int)tpm_tis_mmio_read(opaque, base + regs[idx], 4));
> +               (int)tpm_tis_mmio_read(s, base + regs[idx], 4));
>       }
>   
>       printf("tpm_tis: r/w offset    : %d\n"
> @@ -488,7 +493,7 @@ static uint64_t tpm_tis_mmio_read(void *opaque, hwaddr addr,
>           break;
>   #ifdef DEBUG_TIS
>       case TPM_TIS_REG_DEBUG:
> -        tpm_tis_dump_state(opaque, addr);
> +        tpm_tis_dump_state(s, addr);
>           break;
>   #endif
>       }
> @@ -835,10 +840,8 @@ static const MemoryRegionOps tpm_tis_memory_ops = {
>   /*
>    * Get the TPMVersion of the backend device being used
>    */
> -static enum TPMVersion tpm_tis_get_tpm_version(TPMIf *ti)
> +static enum TPMVersion tpm_tis_get_tpm_version(TPMState *s)
>   {
> -    TPMState *s = TPM(ti);
> -
>       if (tpm_backend_had_startup_error(s->be_driver)) {
>           return TPM_VERSION_UNSPEC;
>       }
> @@ -850,9 +853,8 @@ static enum TPMVersion tpm_tis_get_tpm_version(TPMIf *ti)
>    * This function is called when the machine starts, resets or due to
>    * S3 resume.
>    */
> -static void tpm_tis_reset(DeviceState *dev)
> +static void tpm_tis_reset(TPMState *s)
>   {
> -    TPMState *s = TPM(dev);
>       int c;
>   
>       s->be_tpm_version = tpm_backend_get_tpm_version(s->be_driver);
> @@ -896,15 +898,14 @@ static void tpm_tis_reset(DeviceState *dev)
>   
>   /* persistent state handling */
>   
> -static int tpm_tis_pre_save(void *opaque)
> +static int tpm_tis_pre_save(TPMState *s)
>   {
> -    TPMState *s = opaque;
>       uint8_t locty = s->active_locty;
>   
>       trace_tpm_tis_pre_save(locty, s->rw_offset);
>   
>       if (DEBUG_TIS) {
> -        tpm_tis_dump_state(opaque, 0);
> +        tpm_tis_dump_state(s, 0);
>       }
>   
>       /*
> @@ -929,34 +930,78 @@ static const VMStateDescription vmstate_locty = {
>       }
>   };
>   
> -static const VMStateDescription vmstate_tpm_tis = {
> +/* ISA */
> +
> +static int tpm_tis_pre_save_isa(void *opaque)
> +{
> +    TPMStateISA *isadev = opaque;
> +
> +    return tpm_tis_pre_save(&isadev->state);
> +}
> +
> +static const VMStateDescription vmstate_tpm_tis_isa = {
>       .name = "tpm-tis",
>       .version_id = 0,
> -    .pre_save  = tpm_tis_pre_save,
> +    .pre_save  = tpm_tis_pre_save_isa,
>       .fields = (VMStateField[]) {
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

On a second thought these fields seem to belong to a TPMCommonState.
Why not QOM'ify an abstract common parent between ISA and SysBus?

>   
> -        VMSTATE_STRUCT_ARRAY(loc, TPMState, TPM_TIS_NUM_LOCALITIES, 0,
> +        VMSTATE_STRUCT_ARRAY(state.loc, TPMStateISA, TPM_TIS_NUM_LOCALITIES, 0,
>                                vmstate_locty, TPMLocality),
>   
>           VMSTATE_END_OF_LIST()
>       }
>   };
>   
> -static Property tpm_tis_properties[] = {
> -    DEFINE_PROP_UINT32("irq", TPMState, irq_num, TPM_TIS_IRQ),
> -    DEFINE_PROP_TPMBE("tpmdev", TPMState, be_driver),
> -    DEFINE_PROP_BOOL("ppi", TPMState, ppi_enabled, true),
> +static void tpm_tis_isa_request_completed(TPMIf *ti, int ret)
> +{
> +    TPMStateISA *isadev = TPM_TIS_ISA(ti);
> +    TPMState *s = &isadev->state;
> +
> +    tpm_tis_request_completed(s, ret);
> +}
> +
> +static enum TPMVersion tpm_tis_isa_get_tpm_version(TPMIf *ti)
> +{
> +    TPMStateISA *isadev = TPM_TIS_ISA(ti);
> +    TPMState *s = &isadev->state;
> +
> +    return tpm_tis_get_tpm_version(s);
> +}
> +
> +static void tpm_tis_isa_reset(DeviceState *dev)
> +{
> +    TPMStateISA *isadev = TPM_TIS_ISA(dev);
> +    TPMState *s = &isadev->state;
> +
> +    return tpm_tis_reset(s);
> +}
> +
> +static Property tpm_tis_isa_properties[] = {
> +    DEFINE_PROP_UINT32("irq", TPMStateISA, state.irq_num, TPM_TIS_IRQ),
> +    DEFINE_PROP_TPMBE("tpmdev", TPMStateISA, state.be_driver),
> +    DEFINE_PROP_BOOL("ppi", TPMStateISA, state.ppi_enabled, true),
>       DEFINE_PROP_END_OF_LIST(),
>   };
>   
> -static void tpm_tis_realizefn(DeviceState *dev, Error **errp)
> +static void tpm_tis_isa_initfn(Object *obj)
>   {
> -    TPMState *s = TPM(dev);
> +    TPMStateISA *isadev = TPM_TIS_ISA(obj);
> +    TPMState *s = &isadev->state;
> +
> +    memory_region_init_io(&s->mmio, obj, &tpm_tis_memory_ops,
> +                          s, "tpm-tis-mmio",
> +                          TPM_TIS_NUM_LOCALITIES << TPM_TIS_LOCALITY_SHIFT);
> +}
> +
> +static void tpm_tis_isa_realizefn(DeviceState *dev, Error **errp)
> +{
> +    TPMStateISA *isadev = TPM_TIS_ISA(dev);
> +    TPMState *s = &isadev->state;
>   
>       if (!tpm_find()) {
>           error_setg(errp, "at most one TPM device is permitted");
> @@ -973,55 +1018,46 @@ static void tpm_tis_realizefn(DeviceState *dev, Error **errp)
>           return;
>       }
>   
> -    isa_init_irq(&s->busdev, &s->irq, s->irq_num);
> +    isa_init_irq(ISA_DEVICE(dev), &s->irq, s->irq_num);
>   
>       memory_region_add_subregion(isa_address_space(ISA_DEVICE(dev)),
>                                   TPM_TIS_ADDR_BASE, &s->mmio);
>   
>       if (s->ppi_enabled) {
>           tpm_ppi_init(&s->ppi, isa_address_space(ISA_DEVICE(dev)),
> -                     TPM_PPI_ADDR_BASE, OBJECT(s));
> +                     TPM_PPI_ADDR_BASE, OBJECT(dev));
>       }
>   }
>   
> -static void tpm_tis_initfn(Object *obj)
> -{
> -    TPMState *s = TPM(obj);
> -
> -    memory_region_init_io(&s->mmio, OBJECT(s), &tpm_tis_memory_ops,
> -                          s, "tpm-tis-mmio",
> -                          TPM_TIS_NUM_LOCALITIES << TPM_TIS_LOCALITY_SHIFT);
> -}
> -
> -static void tpm_tis_class_init(ObjectClass *klass, void *data)
> +static void tpm_tis_isa_class_init(ObjectClass *klass, void *data)
>   {
>       DeviceClass *dc = DEVICE_CLASS(klass);
>       TPMIfClass *tc = TPM_IF_CLASS(klass);
>   
> -    dc->realize = tpm_tis_realizefn;
> -    device_class_set_props(dc, tpm_tis_properties);
> -    dc->reset = tpm_tis_reset;
> -    dc->vmsd  = &vmstate_tpm_tis;
> +    device_class_set_props(dc, tpm_tis_isa_properties);
> +    dc->vmsd  = &vmstate_tpm_tis_isa;
>       tc->model = TPM_MODEL_TPM_TIS;
> -    tc->get_version = tpm_tis_get_tpm_version;
> -    tc->request_completed = tpm_tis_request_completed;
> +    dc->realize = tpm_tis_isa_realizefn;
> +    dc->reset = tpm_tis_isa_reset;
> +    tc->request_completed = tpm_tis_isa_request_completed;
> +    tc->get_version = tpm_tis_isa_get_tpm_version;
>   }
>   
> -static const TypeInfo tpm_tis_info = {
> +static const TypeInfo tpm_tis_isa_info = {
>       .name = TYPE_TPM_TIS_ISA,
>       .parent = TYPE_ISA_DEVICE,
> -    .instance_size = sizeof(TPMState),
> -    .instance_init = tpm_tis_initfn,
> -    .class_init  = tpm_tis_class_init,
> +    .instance_size = sizeof(TPMStateISA),
> +    .instance_init = tpm_tis_isa_initfn,
> +    .class_init  = tpm_tis_isa_class_init,
>       .interfaces = (InterfaceInfo[]) {
>           { TYPE_TPM_IF },
>           { }
>       }
>   };
>   
> -static void tpm_tis_register(void)
> +static void tpm_tis_isa_register(void)
>   {
> -    type_register_static(&tpm_tis_info);
> +    type_register_static(&tpm_tis_isa_info);
>   }
>   
> -type_init(tpm_tis_register)
> +type_init(tpm_tis_isa_register)
> 


