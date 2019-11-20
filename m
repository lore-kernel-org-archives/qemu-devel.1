Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D267C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 16:33:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2883520872
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 16:33:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aiV4QNQ4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2883520872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXSvL-0007eT-BJ
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 11:33:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45780)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iXSub-00075b-Ng
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 11:33:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iXSuZ-00061W-LO
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 11:33:01 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23797
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iXSuZ-000613-HD
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 11:32:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574267578;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vPWSZ6MkuplrFcVi3N1432/QzNItWkxUZNJGz0jtp1c=;
 b=aiV4QNQ4+tmGiP6UW6w8fdawY3gqyUmJ902EHOmYVnFXX4GU/Xnq3TFG+NJGPyHaSX9Bb1
 NQqn+J4MAqHiUGMCayOPuyPKQiGFmAf4saEP0RBlFme4I7LZTHS6b7UDq3D1PdK9RpRtui
 AWsIVW2UpugpDAMQbfDkvGgqaKbEUsM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-52-0LCW-HQYPdSd3adA-sSNBw-1; Wed, 20 Nov 2019 11:32:48 -0500
Received: by mail-wr1-f70.google.com with SMTP id c16so21579321wro.1
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 08:32:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=aDexTzQTTASOy/+WOP46APNyDEqZk4flfeRmRRLrn8w=;
 b=BBWBkKRfEUg7mZX+YP/2wkPt3zaJ1qQ7+M6D1OD+OssICZ9O3j/IiusSvbK1oAfECN
 pun19NgnhafHb9FHcZD+xP7scf0M2Q0XCRSJgc9WiWyYl3N3I5UFlJkhQmmVTEyujUfq
 FDu3zExPA0AFXc+4681eEYzCgnkvXicpKbeZA86wJs+y8aDY+UxQEWRR8GwBtKkHZU6G
 Y7tdwQQusHhVd1o1p9sTvK7rQKIktssay5cqdjTqdvAmnH2AH4p1sp0imYKGQvyHFrcm
 r3Hrc3RWpssHNFvY0PEHShllwo9pgceULBKUffCq1TPq8f9wzjHy3sqKj7tsA3w+B55E
 CJ2w==
X-Gm-Message-State: APjAAAXlZ7K42C+InscjvUnLRj3+3IniASpaeezx/KHU/FFE6p2osyvN
 6GyCoM5Kf1C/XF4d+yJAXM0Lwt7dcnTen6q+5Z57mI7GvKxcl5yYWBvVqP8sHNbN0xaShGwwsV+
 tcTEyLyV+789JTK8=
X-Received: by 2002:a5d:6b4d:: with SMTP id x13mr4339614wrw.96.1574267567391; 
 Wed, 20 Nov 2019 08:32:47 -0800 (PST)
X-Google-Smtp-Source: APXvYqzdXwazhOUzvYJMhLNR1CStiIOr4plsZ7VisBbTFofOA60TA7v5Y+4963iRu7ivPE+7491gwg==
X-Received: by 2002:a5d:6b4d:: with SMTP id x13mr4339590wrw.96.1574267567139; 
 Wed, 20 Nov 2019 08:32:47 -0800 (PST)
Received: from [192.168.1.35] (131.red-88-21-102.staticip.rima-tde.net.
 [88.21.102.131])
 by smtp.gmail.com with ESMTPSA id f19sm34911739wrf.23.2019.11.20.08.32.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Nov 2019 08:32:46 -0800 (PST)
Subject: Re: [PATCH v4 30/37] cris: improve passing PIC interrupt vector to
 the CPU
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20191120152442.26657-1-marcandre.lureau@redhat.com>
 <20191120152442.26657-31-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c6c2703c-438f-df1c-7b5b-c4c119c5fe11@redhat.com>
Date: Wed, 20 Nov 2019 17:32:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191120152442.26657-31-marcandre.lureau@redhat.com>
Content-Language: en-US
X-MC-Unique: 0LCW-HQYPdSd3adA-sSNBw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: peter.maydell@linaro.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/20/19 4:24 PM, Marc-Andr=C3=A9 Lureau wrote:
> Instead of accessing cpu interrupt vector directly from PIC, send the
> vector value over the qemu_irq.
>=20
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/cris/axis_dev88.c  |  4 ----
>   hw/intc/etraxfs_pic.c | 26 +-------------------------
>   target/cris/cpu.c     |  8 ++++++++
>   target/cris/cpu.h     |  1 +
>   4 files changed, 10 insertions(+), 29 deletions(-)
>=20
> diff --git a/hw/cris/axis_dev88.c b/hw/cris/axis_dev88.c
> index 940c7dd122..be7760476a 100644
> --- a/hw/cris/axis_dev88.c
> +++ b/hw/cris/axis_dev88.c
> @@ -253,7 +253,6 @@ void axisdev88_init(MachineState *machine)
>       const char *kernel_filename =3D machine->kernel_filename;
>       const char *kernel_cmdline =3D machine->kernel_cmdline;
>       CRISCPU *cpu;
> -    CPUCRISState *env;
>       DeviceState *dev;
>       SysBusDevice *s;
>       DriveInfo *nand;
> @@ -267,7 +266,6 @@ void axisdev88_init(MachineState *machine)
>  =20
>       /* init CPUs */
>       cpu =3D CRIS_CPU(cpu_create(machine->cpu_type));
> -    env =3D &cpu->env;
>  =20
>       /* allocate RAM */
>       memory_region_allocate_system_memory(phys_ram, NULL, "axisdev88.ram=
",
> @@ -297,8 +295,6 @@ void axisdev88_init(MachineState *machine)
>  =20
>  =20
>       dev =3D qdev_create(NULL, "etraxfs,pic");
> -    /* FIXME: Is there a proper way to signal vectors to the CPU core?  =
*/
> -    qdev_prop_set_ptr(dev, "interrupt_vector", &env->interrupt_vector);
>       qdev_init_nofail(dev);
>       s =3D SYS_BUS_DEVICE(dev);
>       sysbus_mmio_map(s, 0, 0x3001c000);
> diff --git a/hw/intc/etraxfs_pic.c b/hw/intc/etraxfs_pic.c
> index 77f652acec..12988c7aa9 100644
> --- a/hw/intc/etraxfs_pic.c
> +++ b/hw/intc/etraxfs_pic.c
> @@ -27,8 +27,6 @@
>   #include "qemu/module.h"
>   #include "hw/irq.h"
>   #include "hw/qdev-properties.h"
> -//#include "pc.h"
> -//#include "etraxfs.h"
>  =20
>   #define D(x)
>  =20
> @@ -48,7 +46,6 @@ struct etrax_pic
>       SysBusDevice parent_obj;
>  =20
>       MemoryRegion mmio;
> -    void *interrupt_vector;
>       qemu_irq parent_irq;
>       qemu_irq parent_nmi;
>       uint32_t regs[R_MAX];
> @@ -79,11 +76,7 @@ static void pic_update(struct etrax_pic *fs)
>           }
>       }
>  =20
> -    if (fs->interrupt_vector) {
> -        /* hack alert: ptr property */
> -        *(uint32_t*)(fs->interrupt_vector) =3D vector;
> -    }
> -    qemu_set_irq(fs->parent_irq, !!vector);
> +    qemu_set_irq(fs->parent_irq, vector);
>   }
>  =20
>   static uint64_t
> @@ -163,28 +156,11 @@ static void etraxfs_pic_init(Object *obj)
>       sysbus_init_mmio(sbd, &s->mmio);
>   }
>  =20
> -static Property etraxfs_pic_properties[] =3D {
> -    DEFINE_PROP_PTR("interrupt_vector", struct etrax_pic, interrupt_vect=
or),
> -    DEFINE_PROP_END_OF_LIST(),
> -};
> -
> -static void etraxfs_pic_class_init(ObjectClass *klass, void *data)
> -{
> -    DeviceClass *dc =3D DEVICE_CLASS(klass);
> -
> -    dc->props =3D etraxfs_pic_properties;
> -    /*
> -     * Note: pointer property "interrupt_vector" may remain null, thus
> -     * no need for dc->user_creatable =3D false;
> -     */
> -}
> -
>   static const TypeInfo etraxfs_pic_info =3D {
>       .name          =3D TYPE_ETRAX_FS_PIC,
>       .parent        =3D TYPE_SYS_BUS_DEVICE,
>       .instance_size =3D sizeof(struct etrax_pic),
>       .instance_init =3D etraxfs_pic_init,
> -    .class_init    =3D etraxfs_pic_class_init,
>   };
>  =20
>   static void etraxfs_pic_register_types(void)
> diff --git a/target/cris/cpu.c b/target/cris/cpu.c
> index 7adfd6caf4..6a857f548d 100644
> --- a/target/cris/cpu.c
> +++ b/target/cris/cpu.c
> @@ -147,6 +147,14 @@ static void cris_cpu_set_irq(void *opaque, int irq, =
int level)
>       CPUState *cs =3D CPU(cpu);
>       int type =3D irq =3D=3D CRIS_CPU_IRQ ? CPU_INTERRUPT_HARD : CPU_INT=
ERRUPT_NMI;
>  =20
> +    if (irq =3D=3D CRIS_CPU_IRQ) {
> +        /*
> +         * The PIC passes us the vector for the IRQ as the value it send=
s
> +         * over the qemu_irq line
> +         */
> +        cpu->env.interrupt_vector =3D level;

I worked on a series that change level to a boolean, but having a way to=20
pass a vectored IRQ via the IRQ API seems useful.

Maybe we should clarify the qemu_irq_handler prototype documentation.=20
Unfortunately it is declared in "qemu/typedefs.h", and the documentation=20
is expected in "hw/irq.h".

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> +    }
> +
>       if (level) {
>           cpu_interrupt(cs, type);
>       } else {
> diff --git a/target/cris/cpu.h b/target/cris/cpu.h
> index aba0a66474..a7c2a8e15b 100644
> --- a/target/cris/cpu.h
> +++ b/target/cris/cpu.h
> @@ -34,6 +34,7 @@
>   #define CPU_INTERRUPT_NMI       CPU_INTERRUPT_TGT_EXT_3
>  =20
>   /* CRUS CPU device objects interrupt lines.  */
> +/* PIC passes the vector for the IRQ as the value of it sends over qemu_=
irq */
>   #define CRIS_CPU_IRQ 0
>   #define CRIS_CPU_NMI 1
>  =20
>=20


