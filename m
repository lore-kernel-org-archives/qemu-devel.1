Return-Path: <SRS0=bgql=3H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B35EEC33CB1
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 06:49:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CAC720730
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 06:49:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d5V+RlaB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CAC720730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ishvI-0003YY-DU
	for qemu-devel@archiver.kernel.org; Sat, 18 Jan 2020 01:49:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59964)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ishuM-0002ep-Vy
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 01:48:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ishuK-00017w-3Y
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 01:48:34 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55658
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ishuJ-00017Y-VW
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 01:48:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579330111;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z5vdVcUhPU/rEGd2/fHFigve9bNVfdKaRfvZX6oBnjY=;
 b=d5V+RlaB2hWEsmbiCXNB3zEaZ1O3HVGcCSkvjg3QXAP15EghZdQFSOo2wjy1GWle9auU8K
 Td4gTYMt/UxoUI9/eHkF0ZoQCGP5vHHqgFErlQbq8//MWKyuX2SWV/SwOJEJAEuN3D2Vnn
 l9T5xMLrRdS/MgGbtKt0caBeZEfjN+w=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-O0OQXJmiP-aLg6hWccqTHw-1; Sat, 18 Jan 2020 01:48:30 -0500
Received: by mail-wr1-f72.google.com with SMTP id d8so11393633wrq.12
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 22:48:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FUAzDUMNSBhZInZqMU7XWG73UKQx84OTQDQPtMta9xI=;
 b=GD7TSxRc9GzHm2piF0zrY8ztcIpKeFFTnZEsQbj55OAJUX6hZM/1Z589wjBqs06eVV
 dhr62/PoTxbJ0b0w7q/O997N+t5viiAw6ONpmn7FAeFaI2UJ7NeINdqQYgQ/MuKxnFA3
 hKwdOiYUB4Q+RN6xiM0REJpyB6/KFAugWZyQrkXZfgbEa2EL8q/6zO/yIPDpqIRnA69R
 SaVsfU676aW1hhB4lb36JtdfRR5zLt5zROFNOUWEBSU1ZWKbil6RIf5nd0+9a3Vp4T2y
 PHDXQ9UEPZJ+fLF30/XJoBVdiZsL7JtTR4DOoNUNi7XMvjZtiZfrSVaAEE8kLHf+nuLr
 rg/g==
X-Gm-Message-State: APjAAAX+datLd3mB1/YGacPP+GshdXJkG/t3GVgyD55Ql2Qq5TtTP85j
 Iel33FWHlHA8J1ATzfQry2P3vLvs7j4q/3wMJ5weShaxOVioL2AOXtNfs/k4N27KiCffxgPO0DP
 U73SkuU81aVKm6T4=
X-Received: by 2002:a05:600c:2383:: with SMTP id
 m3mr8540301wma.32.1579330109006; 
 Fri, 17 Jan 2020 22:48:29 -0800 (PST)
X-Google-Smtp-Source: APXvYqwu5sv+IJrM2JJ3s852Uqb391QnoZ2WbUgjkRV93/AZDaVuy/d3lQR3TtjNkrjsbFFPzoZgKQ==
X-Received: by 2002:a05:600c:2383:: with SMTP id
 m3mr8540268wma.32.1579330108749; 
 Fri, 17 Jan 2020 22:48:28 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id t125sm13427015wmf.17.2020.01.17.22.48.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jan 2020 22:48:28 -0800 (PST)
Subject: Re: [PATCH v7 01/11] add device_legacy_reset function to prepare for
 reset api change
To: Damien Hedde <damien.hedde@greensocs.com>, qemu-devel@nongnu.org
References: <20200115123620.250132-1-damien.hedde@greensocs.com>
 <20200115123620.250132-2-damien.hedde@greensocs.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ac48e5c4-afa2-4142-69c8-95b09f8108fd@redhat.com>
Date: Sat, 18 Jan 2020 07:48:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200115123620.250132-2-damien.hedde@greensocs.com>
Content-Language: en-US
X-MC-Unique: O0OQXJmiP-aLg6hWccqTHw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Fam Zheng <fam@euphon.net>, peter.maydell@linaro.org,
 Collin Walling <walling@linux.ibm.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, david@gibson.dropbear.id.au,
 ehabkost@redhat.com, Richard Henderson <richard.henderson@linaro.org>,
 qemu-s390x@nongnu.org, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>,
 berrange@redhat.com, cohuck@redhat.com, mark.burton@greensocs.com,
 edgari@xilinx.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/15/20 1:36 PM, Damien Hedde wrote:
> Provide a temporary device_legacy_reset function doing what
> device_reset does to prepare for the transition with Resettable
> API.
>=20
> All occurrence of device_reset in the code tree are also replaced
> by device_legacy_reset.
>=20
> The new resettable API has different prototype and semantics
> (resetting child buses as well as the specified device). Subsequent
> commits will make the changeover for each call site individually; once
> that is complete device_legacy_reset() will be removed.
>=20
> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Acked-by: David Gibson <david@gibson.dropbear.id.au>
> Acked-by: Cornelia Huck <cohuck@redhat.com>
> ---
> v7 update: added new occurence due to rebase
>=20
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: "Daniel P. Berrang=C3=A9" <berrange@redhat.com>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Cc: John Snow <jsnow@redhat.com>
> Cc: "C=C3=A9dric Le Goater" <clg@kaod.org>
> Cc: Collin Walling <walling@linux.ibm.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Halil Pasic <pasic@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>
> Cc: Fam Zheng <fam@euphon.net>
> ---
>   include/hw/qdev-core.h   | 4 ++--
>   hw/audio/intel-hda.c     | 2 +-
>   hw/core/qdev.c           | 6 +++---
>   hw/hyperv/hyperv.c       | 2 +-
>   hw/i386/microvm.c        | 2 +-
>   hw/i386/pc.c             | 2 +-
>   hw/ide/microdrive.c      | 8 ++++----
>   hw/intc/spapr_xive.c     | 2 +-
>   hw/ppc/pnv_psi.c         | 4 ++--
>   hw/ppc/spapr_pci.c       | 2 +-
>   hw/ppc/spapr_vio.c       | 2 +-
>   hw/s390x/s390-pci-inst.c | 2 +-
>   hw/scsi/vmw_pvscsi.c     | 2 +-
>   hw/sd/omap_mmc.c         | 2 +-
>   hw/sd/pl181.c            | 2 +-
>   15 files changed, 22 insertions(+), 22 deletions(-)
>=20
> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
> index 1518495b1e..b8341b0fb0 100644
> --- a/include/hw/qdev-core.h
> +++ b/include/hw/qdev-core.h
> @@ -427,11 +427,11 @@ char *qdev_get_own_fw_dev_path_from_handler(BusStat=
e *bus, DeviceState *dev);
>   void qdev_machine_init(void);
>  =20
>   /**
> - * @device_reset
> + * device_legacy_reset:
>    *
>    * Reset a single device (by calling the reset method).
>    */
> -void device_reset(DeviceState *dev);
> +void device_legacy_reset(DeviceState *dev);
>  =20
>   void device_class_set_parent_reset(DeviceClass *dc,
>                                      DeviceReset dev_reset,
> diff --git a/hw/audio/intel-hda.c b/hw/audio/intel-hda.c
> index 6ecd383540..27b71c57cf 100644
> --- a/hw/audio/intel-hda.c
> +++ b/hw/audio/intel-hda.c
> @@ -1087,7 +1087,7 @@ static void intel_hda_reset(DeviceState *dev)
>       QTAILQ_FOREACH(kid, &d->codecs.qbus.children, sibling) {
>           DeviceState *qdev =3D kid->child;
>           cdev =3D HDA_CODEC_DEVICE(qdev);
> -        device_reset(DEVICE(cdev));
> +        device_legacy_reset(DEVICE(cdev));
>           d->state_sts |=3D (1 << cdev->cad);
>       }
>       intel_hda_update_irq(d);
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index 9f1753f5cf..8c0c8284c8 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -298,7 +298,7 @@ HotplugHandler *qdev_get_hotplug_handler(DeviceState =
*dev)
>  =20
>   static int qdev_reset_one(DeviceState *dev, void *opaque)
>   {
> -    device_reset(dev);
> +    device_legacy_reset(dev);
>  =20
>       return 0;
>   }
> @@ -895,7 +895,7 @@ static void device_set_realized(Object *obj, bool val=
ue, Error **errp)
>               }
>           }
>           if (dev->hotplugged) {
> -            device_reset(dev);
> +            device_legacy_reset(dev);
>           }
>           dev->pending_deleted_event =3D false;
>  =20
> @@ -1127,7 +1127,7 @@ void device_class_set_parent_unrealize(DeviceClass =
*dc,
>       dc->unrealize =3D dev_unrealize;
>   }
>  =20
> -void device_reset(DeviceState *dev)
> +void device_legacy_reset(DeviceState *dev)
>   {
>       DeviceClass *klass =3D DEVICE_GET_CLASS(dev);
>  =20
> diff --git a/hw/hyperv/hyperv.c b/hw/hyperv/hyperv.c
> index da8ce82725..8ca3706f5b 100644
> --- a/hw/hyperv/hyperv.c
> +++ b/hw/hyperv/hyperv.c
> @@ -140,7 +140,7 @@ void hyperv_synic_reset(CPUState *cs)
>       SynICState *synic =3D get_synic(cs);
>  =20
>       if (synic) {
> -        device_reset(DEVICE(synic));
> +        device_legacy_reset(DEVICE(synic));
>       }
>   }
>  =20
> diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
> index 827ce29e58..d23485108d 100644
> --- a/hw/i386/microvm.c
> +++ b/hw/i386/microvm.c
> @@ -370,7 +370,7 @@ static void microvm_machine_reset(MachineState *machi=
ne)
>           cpu =3D X86_CPU(cs);
>  =20
>           if (cpu->apic_state) {
> -            device_reset(cpu->apic_state);
> +            device_legacy_reset(cpu->apic_state);
>           }
>       }
>   }
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 8054bc4147..91c7fdaab1 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1877,7 +1877,7 @@ static void pc_machine_reset(MachineState *machine)
>           cpu =3D X86_CPU(cs);
>  =20
>           if (cpu->apic_state) {
> -            device_reset(cpu->apic_state);
> +            device_legacy_reset(cpu->apic_state);
>           }
>       }
>   }
> diff --git a/hw/ide/microdrive.c b/hw/ide/microdrive.c
> index b0272ea14b..6b30e36ed8 100644
> --- a/hw/ide/microdrive.c
> +++ b/hw/ide/microdrive.c
> @@ -173,7 +173,7 @@ static void md_attr_write(PCMCIACardState *card, uint=
32_t at, uint8_t value)
>       case 0x00:=09/* Configuration Option Register */
>           s->opt =3D value & 0xcf;
>           if (value & OPT_SRESET) {
> -            device_reset(DEVICE(s));
> +            device_legacy_reset(DEVICE(s));
>           }
>           md_interrupt_update(s);
>           break;
> @@ -316,7 +316,7 @@ static void md_common_write(PCMCIACardState *card, ui=
nt32_t at, uint16_t value)
>       case 0xe:=09/* Device Control */
>           s->ctrl =3D value;
>           if (value & CTRL_SRST) {
> -            device_reset(DEVICE(s));
> +            device_legacy_reset(DEVICE(s));
>           }
>           md_interrupt_update(s);
>           break;
> @@ -541,7 +541,7 @@ static int dscm1xxxx_attach(PCMCIACardState *card)
>       md->attr_base =3D pcc->cis[0x74] | (pcc->cis[0x76] << 8);
>       md->io_base =3D 0x0;
>  =20
> -    device_reset(DEVICE(md));
> +    device_legacy_reset(DEVICE(md));
>       md_interrupt_update(md);
>  =20
>       return 0;
> @@ -551,7 +551,7 @@ static int dscm1xxxx_detach(PCMCIACardState *card)
>   {
>       MicroDriveState *md =3D MICRODRIVE(card);
>  =20
> -    device_reset(DEVICE(md));
> +    device_legacy_reset(DEVICE(md));
>       return 0;
>   }
>  =20
> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> index 7663123878..52bab29784 100644
> --- a/hw/intc/spapr_xive.c
> +++ b/hw/intc/spapr_xive.c
> @@ -1766,7 +1766,7 @@ static target_ulong h_int_reset(PowerPCCPU *cpu,
>           return H_PARAMETER;
>       }
>  =20
> -    device_reset(DEVICE(xive));
> +    device_legacy_reset(DEVICE(xive));
>  =20
>       if (kvm_irqchip_in_kernel()) {
>           Error *local_err =3D NULL;
> diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
> index 1d8da31738..916e2a9ba7 100644
> --- a/hw/ppc/pnv_psi.c
> +++ b/hw/ppc/pnv_psi.c
> @@ -466,7 +466,7 @@ static void pnv_psi_reset(DeviceState *dev)
>  =20
>   static void pnv_psi_reset_handler(void *dev)
>   {
> -    device_reset(DEVICE(dev));
> +    device_legacy_reset(DEVICE(dev));
>   }
>  =20
>   static void pnv_psi_realize(DeviceState *dev, Error **errp)
> @@ -715,7 +715,7 @@ static void pnv_psi_p9_mmio_write(void *opaque, hwadd=
r addr,
>           break;
>       case PSIHB9_INTERRUPT_CONTROL:
>           if (val & PSIHB9_IRQ_RESET) {
> -            device_reset(DEVICE(&psi9->source));
> +            device_legacy_reset(DEVICE(&psi9->source));
>           }
>           psi->regs[reg] =3D val;
>           break;
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index 723373de73..81b5d1b6f2 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -2014,7 +2014,7 @@ static int spapr_phb_children_reset(Object *child, =
void *opaque)
>       DeviceState *dev =3D (DeviceState *) object_dynamic_cast(child, TYP=
E_DEVICE);
>  =20
>       if (dev) {
> -        device_reset(dev);
> +        device_legacy_reset(dev);
>       }
>  =20
>       return 0;
> diff --git a/hw/ppc/spapr_vio.c b/hw/ppc/spapr_vio.c
> index 554de9930d..f14944e900 100644
> --- a/hw/ppc/spapr_vio.c
> +++ b/hw/ppc/spapr_vio.c
> @@ -304,7 +304,7 @@ int spapr_vio_send_crq(SpaprVioDevice *dev, uint8_t *=
crq)
>   static void spapr_vio_quiesce_one(SpaprVioDevice *dev)
>   {
>       if (dev->tcet) {
> -        device_reset(DEVICE(dev->tcet));
> +        device_legacy_reset(DEVICE(dev->tcet));
>       }
>       free_crq(dev);
>   }
> diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
> index 92c7e45df5..2f7a7d7bd1 100644
> --- a/hw/s390x/s390-pci-inst.c
> +++ b/hw/s390x/s390-pci-inst.c
> @@ -243,7 +243,7 @@ int clp_service_call(S390CPU *cpu, uint8_t r2, uintpt=
r_t ra)
>                   stw_p(&ressetpci->hdr.rsp, CLP_RC_SETPCIFN_FHOP);
>                   goto out;
>               }
> -            device_reset(DEVICE(pbdev));
> +            device_legacy_reset(DEVICE(pbdev));
>               pbdev->fh &=3D ~FH_MASK_ENABLE;
>               pbdev->state =3D ZPCI_FS_DISABLED;
>               stl_p(&ressetpci->fh, pbdev->fh);
> diff --git a/hw/scsi/vmw_pvscsi.c b/hw/scsi/vmw_pvscsi.c
> index 452a3b63b2..7baab1532f 100644
> --- a/hw/scsi/vmw_pvscsi.c
> +++ b/hw/scsi/vmw_pvscsi.c
> @@ -838,7 +838,7 @@ pvscsi_on_cmd_reset_device(PVSCSIState *s)
>  =20
>       if (sdev !=3D NULL) {
>           s->resetting++;
> -        device_reset(&sdev->qdev);
> +        device_legacy_reset(&sdev->qdev);
>           s->resetting--;
>           return PVSCSI_COMMAND_PROCESSING_SUCCEEDED;
>       }
> diff --git a/hw/sd/omap_mmc.c b/hw/sd/omap_mmc.c
> index c6e516b611..4088a8a80b 100644
> --- a/hw/sd/omap_mmc.c
> +++ b/hw/sd/omap_mmc.c
> @@ -318,7 +318,7 @@ void omap_mmc_reset(struct omap_mmc_s *host)
>        * into any bus, and we must reset it manually. When omap_mmc is
>        * QOMified this must move into the QOM reset function.
>        */
> -    device_reset(DEVICE(host->card));
> +    device_legacy_reset(DEVICE(host->card));
>   }
>  =20
>   static uint64_t omap_mmc_read(void *opaque, hwaddr offset,
> diff --git a/hw/sd/pl181.c b/hw/sd/pl181.c
> index 8033fe455d..2b3776a6a0 100644
> --- a/hw/sd/pl181.c
> +++ b/hw/sd/pl181.c
> @@ -482,7 +482,7 @@ static void pl181_reset(DeviceState *d)
>       /* Since we're still using the legacy SD API the card is not plugge=
d
>        * into any bus, and we must reset it manually.
>        */
> -    device_reset(DEVICE(s->card));
> +    device_legacy_reset(DEVICE(s->card));
>   }
>  =20
>   static void pl181_init(Object *obj)
>=20

Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


