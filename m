Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09BB2C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 15:54:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA5502173E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 15:54:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RXmrpf+4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA5502173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idFwS-0002NS-I4
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 10:54:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60945)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1idEyy-0000NT-BR
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:53:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1idEyw-0005oO-Np
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:53:24 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:20064
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1idEyw-0005nM-Io
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:53:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575644002;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KXP/u4tNIpHtnz0fS1xsh/7VHfe+8dzY46wCiYLnkws=;
 b=RXmrpf+4IuEgmZL981Np9f6DQbNMdmXGrwNQZGajurgQ9MptHKFhZAk99XFyxApAQ6nkWS
 jYegXnHbfSeusP5631ioi7a/Ouudq3/Q2CfB8x82HeOzZMBUKc7U/rzFjPi+vdTpxbn35e
 jCOR4hQthzJpBUiob4N2CMGSEeVJuTE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-FFfIRV0lPOadLtOX4fZW4w-1; Fri, 06 Dec 2019 00:51:54 -0500
Received: by mail-wr1-f72.google.com with SMTP id b13so2646405wrx.22
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2019 21:51:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/565qbkyu6852uU+G93zof4l+bkCu7TfS5fCla+IKVY=;
 b=kxmbmH9qLl+myp4Fml701AEHlR7kT32CwHt6SWHpAdU1hyVRgYb9WpDND/A4ROtMXV
 vv9hrUo97Tenp9s+RGG0LK/TAhxy/mGY9Jb7cTTIgbeNCoc7Gl2EoVK7S8583xaPHT3B
 EdMRxxaHnxf8VnQbW7c2FuY41MLyI0wFdMpXlsAOdg8hpptRP7ORW/w3lq7AaSV47rbg
 Eis31mcW4egwvoOIKMOLiDH1dLnUib8qg96WOXp6Ggf5RkrV+T7ZYv3hf/rFK4gXXvpm
 9HKZnNc8S9Ko0v6Lg882LptCCDoqNwjjAp4VO1ZF5PmIhuhCcmvuGBYj3mhfgH7Q0CAz
 lFtA==
X-Gm-Message-State: APjAAAWbaLPUtLHTNxCrewO93Y3kySArLfxmxm1K0xvKaU6oJledfMul
 jNzWO3L6bYQ7VyV7DosF/8cpj3iU+CDzkGpAABSOmEWfIuw1icmpoo3a/k5NPKGq4D5UIDVkho+
 LwKd7wZoYwFvnLio=
X-Received: by 2002:adf:ffc7:: with SMTP id x7mr13467601wrs.159.1575611513589; 
 Thu, 05 Dec 2019 21:51:53 -0800 (PST)
X-Google-Smtp-Source: APXvYqyeLD6mh88uQv7UH/mo3//YCqVD7C21mPLsBcTNy2iRyEH6VbxFNhztcGLYbUB1VGwAfH8q/A==
X-Received: by 2002:adf:ffc7:: with SMTP id x7mr13467568wrs.159.1575611513217; 
 Thu, 05 Dec 2019 21:51:53 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id s19sm2100880wmj.33.2019.12.05.21.51.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Dec 2019 21:51:52 -0800 (PST)
Subject: Re: [PATCH 1/3] hw/i386: Remove the deprecated machines 0.12 up to
 0.15
To: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20191205160652.23493-1-thuth@redhat.com>
 <20191205160652.23493-2-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <7d1a93eb-4881-e298-828f-c8edc3323bb6@redhat.com>
Date: Fri, 6 Dec 2019 06:51:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191205160652.23493-2-thuth@redhat.com>
Content-Language: en-US
X-MC-Unique: FFfIRV0lPOadLtOX4fZW4w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
Cc: libvir-list@redhat.com, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/5/19 5:06 PM, Thomas Huth wrote:
> They can't be used reliable for live-migration anymore (see
> https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg04516.html

"reliably"?

I'd keep the reference, but also paste Paolo's 7 lines here.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> for details) and have been marked as deprecated since QEMU v4.0,
> so time to remove them now.
>=20
> And while we're at it, mark the remaining pc-1.x machine types
> as deprecated now, too, so that we finally only have "pc-i440fx"
> and "pc-q35" machine types left (apart from the non-versioned
> "isapc" and "microvm") once we removed them in a couple of releases.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   hw/i386/pc_piix.c     | 82 -------------------------------------------
>   qemu-deprecated.texi  |  2 +-
>   tests/cpu-plug-test.c |  6 +---
>   3 files changed, 2 insertions(+), 88 deletions(-)
>=20
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 1bd70d1abb..59ac9d82c9 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -364,12 +364,6 @@ static void pc_compat_1_2(MachineState *machine)
>       x86_cpu_change_kvm_default("kvm-pv-eoi", NULL);
>   }
>  =20
> -/* PC compat function for pc-0.12 and pc-0.13 */
> -static void pc_compat_0_13(MachineState *machine)
> -{
> -    pc_compat_1_2(machine);
> -}
> -
>   static void pc_init_isa(MachineState *machine)
>   {
>       pc_init1(machine, TYPE_I440FX_PCI_HOST_BRIDGE, TYPE_I440FX_PCI_DEVI=
CE);
> @@ -800,82 +794,6 @@ DEFINE_I440FX_MACHINE(v1_0, "pc-1.0", pc_compat_1_2,
>                         pc_i440fx_1_0_machine_options);
>  =20
>  =20
> -static void pc_i440fx_0_15_machine_options(MachineClass *m)
> -{
> -    static GlobalProperty compat[] =3D {
> -        PC_CPU_MODEL_IDS("0.15")
> -    };
> -
> -    pc_i440fx_1_0_machine_options(m);
> -    m->hw_version =3D "0.15";
> -    m->deprecation_reason =3D "use a newer machine type instead";
> -    compat_props_add(m->compat_props, compat, G_N_ELEMENTS(compat));
> -}
> -
> -DEFINE_I440FX_MACHINE(v0_15, "pc-0.15", pc_compat_1_2,
> -                      pc_i440fx_0_15_machine_options);
> -
> -
> -static void pc_i440fx_0_14_machine_options(MachineClass *m)
> -{
> -    static GlobalProperty compat[] =3D {
> -        PC_CPU_MODEL_IDS("0.14")
> -        { "virtio-blk-pci", "event_idx", "off" },
> -        { "virtio-serial-pci", "event_idx", "off" },
> -        { "virtio-net-pci", "event_idx", "off" },
> -        { "virtio-balloon-pci", "event_idx", "off" },
> -        { "qxl", "revision", "2" },
> -        { "qxl-vga", "revision", "2" },
> -    };
> -
> -    pc_i440fx_0_15_machine_options(m);
> -    m->hw_version =3D "0.14";
> -    compat_props_add(m->compat_props, compat, G_N_ELEMENTS(compat));
> -}
> -
> -DEFINE_I440FX_MACHINE(v0_14, "pc-0.14", pc_compat_1_2,
> -                      pc_i440fx_0_14_machine_options);
> -
> -static void pc_i440fx_0_13_machine_options(MachineClass *m)
> -{
> -    PCMachineClass *pcmc =3D PC_MACHINE_CLASS(m);
> -    static GlobalProperty compat[] =3D {
> -        PC_CPU_MODEL_IDS("0.13")
> -        { TYPE_PCI_DEVICE, "command_serr_enable", "off" },
> -        { "AC97", "use_broken_id", "1" },
> -        { "virtio-9p-pci", "vectors", "0" },
> -        { "VGA", "rombar", "0" },
> -        { "vmware-svga", "rombar", "0" },
> -    };
> -
> -    pc_i440fx_0_14_machine_options(m);
> -    m->hw_version =3D "0.13";
> -    compat_props_add(m->compat_props, compat, G_N_ELEMENTS(compat));
> -    pcmc->kvmclock_enabled =3D false;
> -}
> -
> -DEFINE_I440FX_MACHINE(v0_13, "pc-0.13", pc_compat_0_13,
> -                      pc_i440fx_0_13_machine_options);
> -
> -static void pc_i440fx_0_12_machine_options(MachineClass *m)
> -{
> -    static GlobalProperty compat[] =3D {
> -        PC_CPU_MODEL_IDS("0.12")
> -        { "virtio-serial-pci", "max_ports", "1" },
> -        { "virtio-serial-pci", "vectors", "0" },
> -        { "usb-mouse", "serial", "1" },
> -        { "usb-tablet", "serial", "1" },
> -        { "usb-kbd", "serial", "1" },
> -    };
> -
> -    pc_i440fx_0_13_machine_options(m);
> -    m->hw_version =3D "0.12";
> -    compat_props_add(m->compat_props, compat, G_N_ELEMENTS(compat));
> -}
> -
> -DEFINE_I440FX_MACHINE(v0_12, "pc-0.12", pc_compat_0_13,
> -                      pc_i440fx_0_12_machine_options);
> -
>   typedef struct {
>       uint16_t gpu_device_id;
>       uint16_t pch_device_id;
> diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
> index e407cc085e..2850f9a520 100644
> --- a/qemu-deprecated.texi
> +++ b/qemu-deprecated.texi
> @@ -261,7 +261,7 @@ The 'scsi-disk' device is deprecated. Users should us=
e 'scsi-hd' or
>  =20
>   @section System emulator machines
>  =20
> -@subsection pc-0.12, pc-0.13, pc-0.14 and pc-0.15 (since 4.0)
> +@subsection pc-1.0, pc-1.1, pc-1.2 and pc-1.3 (since 5.0)
>  =20
>   These machine types are very old and likely can not be used for live mi=
gration
>   from old QEMU versions anymore. A newer machine type should be used ins=
tead.
> diff --git a/tests/cpu-plug-test.c b/tests/cpu-plug-test.c
> index 30e514bbfb..e8ffbbce4b 100644
> --- a/tests/cpu-plug-test.c
> +++ b/tests/cpu-plug-test.c
> @@ -148,11 +148,7 @@ static void add_pc_test_case(const char *mname)
>           (strcmp(mname, "pc-1.3") =3D=3D 0) ||
>           (strcmp(mname, "pc-1.2") =3D=3D 0) ||
>           (strcmp(mname, "pc-1.1") =3D=3D 0) ||
> -        (strcmp(mname, "pc-1.0") =3D=3D 0) ||
> -        (strcmp(mname, "pc-0.15") =3D=3D 0) ||
> -        (strcmp(mname, "pc-0.14") =3D=3D 0) ||
> -        (strcmp(mname, "pc-0.13") =3D=3D 0) ||
> -        (strcmp(mname, "pc-0.12") =3D=3D 0)) {
> +        (strcmp(mname, "pc-1.0") =3D=3D 0)) {
>           path =3D g_strdup_printf("cpu-plug/%s/init/%ux%ux%u&maxcpus=3D%=
u",
>                                  mname, data->sockets, data->cores,
>                                  data->threads, data->maxcpus);
>=20


