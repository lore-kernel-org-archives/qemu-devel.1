Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D11C432C3
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 11:42:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C256820730
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 11:42:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bqSviA1k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C256820730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32799 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWfQd-00022D-Vy
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 06:42:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52230)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iWfOh-0000Pl-KM
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 06:40:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iWfOf-0007uC-Qt
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 06:40:47 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24449
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iWfOf-0007tX-NA
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 06:40:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574077243;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=5/Pz2s2NjloelA4gj2RwH9djukmqvbWbnX+zM0Xtsfc=;
 b=bqSviA1kdcNoAiO5nlS+pVzu1GaQvTMa23+y6b0/SwWpjUQkZgQwjYI2+6mwgsd8KzVgko
 bRG5ACIWfgF+kofNdEhQAdML6ufxQcQZYczhc6RWAJ65vRvRls36LoSCfCeQaDlKotRfPW
 04NY0G+C3C+tbsCdY4toNzpmerpASTs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-314--bA5IeXHMIGESnErvqDXaw-1; Mon, 18 Nov 2019 06:40:40 -0500
Received: by mail-wm1-f71.google.com with SMTP id i23so11184893wmb.3
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2019 03:40:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SAqDK0WNXnQx3h8Vxay6QYUGveU68donBYj6mEr51l0=;
 b=H3CmRoRc0aCCHnJ8wmWrz5cxyI3bc3IuTydjU/QqUBugSf/U+9uKbDkB2H1PQ25YRq
 i4YkUq84qbFwgrTBMTfqz5MesMpLScB0tk3rIaQhdJeQiOZkWmjLSTdBb38m/qIIOWE1
 7PtD0qrweZm8TPQ3TX8QnTQpSwrSsL15CvP7ZBVJpKx4Dg+CDyU8jhGNE4l4JfJVRj7l
 1IEdWase2XzLrHGyOwsgXbRDexg+N97Npq5FH2LKjuoPSRDfVbfaqTl10Xk7KAEEui1Z
 FDHEqi4mrb2rajplNoYMIpjmq3W8vOGDcsDJWmaFEujOTxa7SWYCopa2mvYsQvoDub5e
 3NIQ==
X-Gm-Message-State: APjAAAXYoT7aGhMQs10LWzM/UxHdSxpMuQ2bmzA1ZS3nSPe3pT3IBX53
 Sp9ytFTNTNRdVAEUBRQFP4RerC1nqkXJ9zqxL/Lf9ZAYmy1fB9iO87q9W1T6nUOuWibHwzmHHgt
 bedq+SMo2QbWeUcU=
X-Received: by 2002:a05:600c:2383:: with SMTP id
 m3mr27586937wma.166.1574077238969; 
 Mon, 18 Nov 2019 03:40:38 -0800 (PST)
X-Google-Smtp-Source: APXvYqx8jtG4+ktnRj2MxMsdCeeybj09Flz4bS6SqD4GA9SzTzku8Os5OmW5IdBwftb8XxA5h2dMJg==
X-Received: by 2002:a05:600c:2383:: with SMTP id
 m3mr27586917wma.166.1574077238632; 
 Mon, 18 Nov 2019 03:40:38 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:a15b:f753:1ac4:56dc?
 ([2001:b07:6468:f312:a15b:f753:1ac4:56dc])
 by smtp.gmail.com with ESMTPSA id y8sm19085655wmi.9.2019.11.18.03.40.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Nov 2019 03:40:38 -0800 (PST)
Subject: Re: [PATCH v2] hw/i386: Move save_tsc_khz from PCMachineClass to
 X86MachineClass
To: Liam Merwick <liam.merwick@oracle.com>, slp@redhat.com, rth@twiddle.net,
 ehabkost@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com
References: <1574075605-25215-1-git-send-email-liam.merwick@oracle.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <c80b1ed0-c291-4025-54f9-ea357107420b@redhat.com>
Date: Mon, 18 Nov 2019 12:40:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1574075605-25215-1-git-send-email-liam.merwick@oracle.com>
Content-Language: en-US
X-MC-Unique: -bA5IeXHMIGESnErvqDXaw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: darren.kenny@oracle.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 18/11/19 12:13, Liam Merwick wrote:
> Attempting to migrate a VM using the microvm machine class results in the=
 source
> QEMU aborting with the following message/backtrace:
>=20
> target/i386/machine.c:955:tsc_khz_needed: Object 0x555556608fa0 is not an
> instance of type generic-pc-machine
>=20
> abort()
> object_class_dynamic_cast_assert()
> vmstate_save_state_v()
> vmstate_save_state()
> vmstate_save()
> qemu_savevm_state_complete_precopy()
> migration_thread()
> migration_thread()
> migration_thread()
> qemu_thread_start()
> start_thread()
> clone()
>=20
> The access to the machine class returned by MACHINE_GET_CLASS() in
> tsc_khz_needed() is crashing as it is trying to dereference a different
> type of machine class object (TYPE_PC_MACHINE) to that of this microVM.
>=20
> This can be resolved by extending the changes in the following commit
> f0bb276bf8d5 ("hw/i386: split PCMachineState deriving X86MachineState fro=
m it")
> and moving the save_tsc_khz field in PCMachineClass to X86MachineClass.
>=20
> Fixes: f0bb276bf8d5 ("hw/i386: split PCMachineState deriving X86MachineSt=
ate from it")
> Signed-off-by: Liam Merwick <liam.merwick@oracle.com>
> Reviewed-by: Darren Kenny <darren.kenny@oracle.com>

Queued, thanks.

Paolo

>=20
> v1 -> v2 - fix SHA1 of patch being referenced.
>=20
>  hw/i386/pc.c          | 1 -
>  hw/i386/pc_piix.c     | 4 ++--
>  hw/i386/pc_q35.c      | 4 ++--
>  hw/i386/x86.c         | 1 +
>  include/hw/i386/pc.h  | 2 --
>  include/hw/i386/x86.h | 2 ++
>  target/i386/machine.c | 4 ++--
>  7 files changed, 9 insertions(+), 9 deletions(-)
>=20
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 96715f8a3f99..ac08e6360437 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -2195,7 +2195,6 @@ static void pc_machine_class_init(ObjectClass *oc, =
void *data)
>      /* BIOS ACPI tables: 128K. Other BIOS datastructures: less than 4K r=
eported
>       * to be used at the moment, 32K should be enough for a while.  */
>      pcmc->acpi_data_size =3D 0x20000 + 0x8000;
> -    pcmc->save_tsc_khz =3D true;
>      pcmc->linuxboot_dma_enabled =3D true;
>      pcmc->pvh_enabled =3D true;
>      assert(!mc->get_hotplug_handler);
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 2aefa3b8dfe3..0548c259dc74 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -567,10 +567,10 @@ DEFINE_I440FX_MACHINE(v2_6, "pc-i440fx-2.6", NULL,
> =20
>  static void pc_i440fx_2_5_machine_options(MachineClass *m)
>  {
> -    PCMachineClass *pcmc =3D PC_MACHINE_CLASS(m);
> +    X86MachineClass *x86mc =3D X86_MACHINE_CLASS(m);
> =20
>      pc_i440fx_2_6_machine_options(m);
> -    pcmc->save_tsc_khz =3D false;
> +    x86mc->save_tsc_khz =3D false;
>      m->legacy_fw_cfg_order =3D 1;
>      compat_props_add(m->compat_props, hw_compat_2_5, hw_compat_2_5_len);
>      compat_props_add(m->compat_props, pc_compat_2_5, pc_compat_2_5_len);
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index d51f5247276d..385e5cffb167 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -508,10 +508,10 @@ DEFINE_Q35_MACHINE(v2_6, "pc-q35-2.6", NULL,
> =20
>  static void pc_q35_2_5_machine_options(MachineClass *m)
>  {
> -    PCMachineClass *pcmc =3D PC_MACHINE_CLASS(m);
> +    X86MachineClass *x86mc =3D X86_MACHINE_CLASS(m);
> =20
>      pc_q35_2_6_machine_options(m);
> -    pcmc->save_tsc_khz =3D false;
> +    x86mc->save_tsc_khz =3D false;
>      m->legacy_fw_cfg_order =3D 1;
>      compat_props_add(m->compat_props, hw_compat_2_5, hw_compat_2_5_len);
>      compat_props_add(m->compat_props, pc_compat_2_5, pc_compat_2_5_len);
> diff --git a/hw/i386/x86.c b/hw/i386/x86.c
> index fd84b23124e6..394edc2f7209 100644
> --- a/hw/i386/x86.c
> +++ b/hw/i386/x86.c
> @@ -763,6 +763,7 @@ static void x86_machine_class_init(ObjectClass *oc, v=
oid *data)
>      mc->get_default_cpu_node_id =3D x86_get_default_cpu_node_id;
>      mc->possible_cpu_arch_ids =3D x86_possible_cpu_arch_ids;
>      x86mc->compat_apic_id_mode =3D false;
> +    x86mc->save_tsc_khz =3D true;
>      nc->nmi_monitor_handler =3D x86_nmi;
> =20
>      object_class_property_add(oc, X86_MACHINE_MAX_RAM_BELOW_4G, "size",
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index e6fa8418ca61..1f86eba3f998 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -116,8 +116,6 @@ typedef struct PCMachineClass {
>      bool enforce_aligned_dimm;
>      bool broken_reserved_end;
> =20
> -    /* TSC rate migration: */
> -    bool save_tsc_khz;
>      /* generate legacy CPU hotplug AML */
>      bool legacy_cpu_hotplug;
> =20
> diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
> index 82d09fd7d099..4b8491788526 100644
> --- a/include/hw/i386/x86.h
> +++ b/include/hw/i386/x86.h
> @@ -30,6 +30,8 @@ typedef struct {
> =20
>      /*< public >*/
> =20
> +    /* TSC rate migration: */
> +    bool save_tsc_khz;
>      /* Enables contiguous-apic-ID mode */
>      bool compat_apic_id_mode;
>  } X86MachineClass;
> diff --git a/target/i386/machine.c b/target/i386/machine.c
> index 6481f846f6e9..7bdeb7815755 100644
> --- a/target/i386/machine.c
> +++ b/target/i386/machine.c
> @@ -988,8 +988,8 @@ static bool tsc_khz_needed(void *opaque)
>      X86CPU *cpu =3D opaque;
>      CPUX86State *env =3D &cpu->env;
>      MachineClass *mc =3D MACHINE_GET_CLASS(qdev_get_machine());
> -    PCMachineClass *pcmc =3D PC_MACHINE_CLASS(mc);
> -    return env->tsc_khz && pcmc->save_tsc_khz;
> +    X86MachineClass *x86mc =3D X86_MACHINE_CLASS(mc);
> +    return env->tsc_khz && x86mc->save_tsc_khz;
>  }
> =20
>  static const VMStateDescription vmstate_tsc_khz =3D {
>=20


