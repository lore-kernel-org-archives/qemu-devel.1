Return-Path: <SRS0=nDBX=XQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B57DDC49ED7
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Sep 2019 08:52:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B83F205F4
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Sep 2019 08:52:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ieDgSrDV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B83F205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBb7g-0004OU-NP
	for qemu-devel@archiver.kernel.org; Sat, 21 Sep 2019 04:52:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37836)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iBb6g-0003kO-TQ
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 04:51:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iBb6f-0006qY-IW
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 04:51:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24831
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iBb6f-0006pv-3Y
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 04:51:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1569055864;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=2oHym0paq8wP1jirp7Hrewxbwo5cVbOzSMQIUtAA36Y=;
 b=ieDgSrDV1zVg9/M9az0GjjwOvUi6wMHriXBAB8dkZsA4t1MyxFopcFU+P7VXrR44v3yOhs
 6Yp33u3IFv0REZBBKDs8J3mGssorjtcJZvvnGYj0PIv/qhHo8nqWOR7IhaADzV01UA7Psq
 67lrV2abWG6m4BxDfWQEIBVuhrvP9K8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-N0pvUXmKMRmtvgicpA2BHA-1; Sat, 21 Sep 2019 04:51:01 -0400
Received: by mail-wm1-f70.google.com with SMTP id 124so5166551wmz.1
 for <qemu-devel@nongnu.org>; Sat, 21 Sep 2019 01:51:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=skQ7lqTj2M93LArXM51p4hqq79iwLM5vlU0SZmgZKEU=;
 b=N0NDOcbU5TGcwvP6WqBU/Tzn3NKY/rIsSMYQeeA1rUqiHg3JBEywR0TEzHJBMreUZ0
 rbcw6GDTppG/oVNh5OzgmU9L/JVs6GO7IUEQvm6J/u+COBeYHb9KPXIQOcUygqwPnzxy
 YN6NgWZvoaCSmNA1nJPD+8EO/eCaLA/p2W62fHA61N4RQxZiFOpNUtpQkQCmhJfn28kY
 HTLJOWurhNWWUtLavczQXvKnJuG88jsC7jIZ+Wr6F5CO6qBSU0JWFES3tJF6+fJxfMsr
 rpm8c9k+fSR847iInVg+hA2Lq4P4FNxr87giBFH4MHqma+LTyqKc0tYAmWOI5vZUxcTt
 c2UA==
X-Gm-Message-State: APjAAAXhGAa0WH8rdcoxBbVGFtqkeiD9D7yKDWLK3U5Em9unWQGwh0AR
 30G5oCHCcKApD5xpPaBTdoZf0xBMxLq3BUyCAAkAQZf4ejrmSPP8IkQ/3ezPSB5YIxobgAwZA4s
 QtX3/kEVtwq2lxLM=
X-Received: by 2002:a05:600c:141:: with SMTP id
 w1mr6450917wmm.75.1569055860299; 
 Sat, 21 Sep 2019 01:51:00 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx+51KAPnI0N8sCwolj8W9FMCRvhmguBm28fkYY+UGjKZWeabPcy5AqXEnU2SxNEHFSsJ3pqA==
X-Received: by 2002:a05:600c:141:: with SMTP id
 w1mr6450900wmm.75.1569055860074; 
 Sat, 21 Sep 2019 01:51:00 -0700 (PDT)
Received: from [192.168.1.40] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id w12sm6374656wrg.47.2019.09.21.01.50.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Sep 2019 01:50:59 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] riscv: hw: Drop "clock-frequency" property of cpu
 nodes
To: Bin Meng <bmeng.cn@gmail.com>, Alistair Francis
 <Alistair.Francis@wdc.com>, Palmer Dabbelt <palmer@sifive.com>,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <1569044491-7875-1-git-send-email-bmeng.cn@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <fad9668d-14e8-40c1-2c02-9a6197e88397@redhat.com>
Date: Sat, 21 Sep 2019 10:50:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1569044491-7875-1-git-send-email-bmeng.cn@gmail.com>
Content-Language: en-US
X-MC-Unique: N0pvUXmKMRmtvgicpA2BHA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Bin,

On 9/21/19 7:41 AM, Bin Meng wrote:
> The "clock-frequency" property of cpu nodes isn't required. Drop it.
>=20
> This is to keep in sync with Linux kernel commit below:
> https://patchwork.kernel.org/patch/11133031/

What happens if you run a older kernel that doesn't contain the
referenced patch?

> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
>=20
> ---
>=20
> Changes in v2:
> - drop the one in spike and virt machines too
>=20
>  hw/riscv/sifive_u.c         | 2 --
>  hw/riscv/spike.c            | 2 --
>  hw/riscv/virt.c             | 2 --
>  include/hw/riscv/sifive_u.h | 1 -
>  include/hw/riscv/spike.h    | 4 ----
>  include/hw/riscv/virt.h     | 4 ----
>  6 files changed, 15 deletions(-)
>=20
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index 9f8e84b..02dd761 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -151,8 +151,6 @@ static void create_fdt(SiFiveUState *s, const struct =
MemmapEntry *memmap,
>          char *intc =3D g_strdup_printf("/cpus/cpu@%d/interrupt-controlle=
r", cpu);
>          char *isa;
>          qemu_fdt_add_subnode(fdt, nodename);
> -        qemu_fdt_setprop_cell(fdt, nodename, "clock-frequency",
> -                              SIFIVE_U_CLOCK_FREQ);
>          /* cpu 0 is the management hart that does not have mmu */
>          if (cpu !=3D 0) {
>              qemu_fdt_setprop_string(fdt, nodename, "mmu-type", "riscv,sv=
48");
> diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
> index d60415d..8bbffbc 100644
> --- a/hw/riscv/spike.c
> +++ b/hw/riscv/spike.c
> @@ -102,8 +102,6 @@ static void create_fdt(SpikeState *s, const struct Me=
mmapEntry *memmap,
>          char *intc =3D g_strdup_printf("/cpus/cpu@%d/interrupt-controlle=
r", cpu);
>          char *isa =3D riscv_isa_string(&s->soc.harts[cpu]);
>          qemu_fdt_add_subnode(fdt, nodename);
> -        qemu_fdt_setprop_cell(fdt, nodename, "clock-frequency",
> -                              SPIKE_CLOCK_FREQ);
>          qemu_fdt_setprop_string(fdt, nodename, "mmu-type", "riscv,sv48")=
;
>          qemu_fdt_setprop_string(fdt, nodename, "riscv,isa", isa);
>          qemu_fdt_setprop_string(fdt, nodename, "compatible", "riscv");
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index d36f562..1303061 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -161,8 +161,6 @@ static void create_fdt(RISCVVirtState *s, const struc=
t MemmapEntry *memmap,
>          char *intc =3D g_strdup_printf("/cpus/cpu@%d/interrupt-controlle=
r", cpu);
>          char *isa =3D riscv_isa_string(&s->soc.harts[cpu]);
>          qemu_fdt_add_subnode(fdt, nodename);
> -        qemu_fdt_setprop_cell(fdt, nodename, "clock-frequency",
> -                              VIRT_CLOCK_FREQ);
>          qemu_fdt_setprop_string(fdt, nodename, "mmu-type", "riscv,sv48")=
;
>          qemu_fdt_setprop_string(fdt, nodename, "riscv,isa", isa);
>          qemu_fdt_setprop_string(fdt, nodename, "compatible", "riscv");
> diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
> index e4df298..4850805 100644
> --- a/include/hw/riscv/sifive_u.h
> +++ b/include/hw/riscv/sifive_u.h
> @@ -75,7 +75,6 @@ enum {
>  };
> =20
>  enum {
> -    SIFIVE_U_CLOCK_FREQ =3D 1000000000,
>      SIFIVE_U_HFCLK_FREQ =3D 33333333,
>      SIFIVE_U_RTCCLK_FREQ =3D 1000000
>  };
> diff --git a/include/hw/riscv/spike.h b/include/hw/riscv/spike.h
> index 03d8703..dc77042 100644
> --- a/include/hw/riscv/spike.h
> +++ b/include/hw/riscv/spike.h
> @@ -38,10 +38,6 @@ enum {
>      SPIKE_DRAM
>  };
> =20
> -enum {
> -    SPIKE_CLOCK_FREQ =3D 1000000000
> -};
> -
>  #if defined(TARGET_RISCV32)
>  #define SPIKE_V1_09_1_CPU TYPE_RISCV_CPU_RV32GCSU_V1_09_1
>  #define SPIKE_V1_10_0_CPU TYPE_RISCV_CPU_RV32GCSU_V1_10_0
> diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
> index 6e5fbe5..68978a1 100644
> --- a/include/hw/riscv/virt.h
> +++ b/include/hw/riscv/virt.h
> @@ -55,10 +55,6 @@ enum {
>      VIRTIO_NDEV =3D 0x35 /* Arbitrary maximum number of interrupts */
>  };
> =20
> -enum {
> -    VIRT_CLOCK_FREQ =3D 1000000000
> -};
> -
>  #define VIRT_PLIC_HART_CONFIG "MS"
>  #define VIRT_PLIC_NUM_SOURCES 127
>  #define VIRT_PLIC_NUM_PRIORITIES 7
>=20


