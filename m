Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E961C3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 10:19:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE47F20848
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 10:19:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a7MTf4bK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE47F20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9nbB-0004oL-62
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 05:19:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42632)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j9naP-0004LH-So
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 05:18:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j9naO-0003yi-IF
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 05:18:37 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:32006
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j9naO-0003yD-Dd
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 05:18:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583403516;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1DRr573LmGsMlH229mpT5zyOyOA/DZAYDfwDZEjp1xs=;
 b=a7MTf4bKqN/j0pKCQat/UdHEq20Ke9Pm2pnCC8CuP62dp/6cKD4Z+fk2G3azOq+Iq8xUq1
 X23kRRM8GJcMLcEY3/79mbRaOBJOE8Jl75h6wAa0Vz9iPAMoFeXsvsilakXYnqEkvKV2DT
 i8TznHXUt/31lrZ4tmlPtEX/ZAQ3zeE=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-95--a28WSE2P_KiZpjM9l-RFg-1; Thu, 05 Mar 2020 05:18:34 -0500
X-MC-Unique: -a28WSE2P_KiZpjM9l-RFg-1
Received: by mail-ed1-f72.google.com with SMTP id a11so2600761eds.15
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 02:18:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ryKwavPBrkflicEeHIYZpNaaQVXUIyfZz5vlUFNvIKg=;
 b=LCx7HKJy78gtJcAdO6pXJWQjRp/HDjvYgvSUIsDDEEnzsSW59uoErClU5pF/OvUFlr
 Qm5Anz+OJjj65UQUVqoxfsMiQY2uyNCAjYIfsbug1RDV8y67uv1n9xYoD2w7Hov+UmOv
 pHYz2ugN6W1pdKtaZGT5bTBubW7QONrTBP438dkngd6K90Dqvmiy00S98zKHR4tVhjdY
 O+8W1s/nQiezVm9CSgn/PVMAMO4/Kv/VK9hwivmyLgaISGM5r7LEFBasXYwV8E2cAeZi
 kJczXZOedKNmpLb/MiVF8TBKSryvLKQlYDzOtxdLsharQU/c4XoXvJyJcaj88cKhRm7y
 TNHg==
X-Gm-Message-State: ANhLgQ2pd/8SpJafpngCe0Ky3/fuOS84zxK9PlDUUvV0e9FryANf/yo6
 hWCrL3KYPJwPa9K1Ex2XfkLN9N7pVXTIFGoHthcxjvx+ozmCHhF2G6LmW7edyt8p0O5u/x9KrmF
 FwJnQ4ttjjynSroc=
X-Received: by 2002:a05:6402:12c8:: with SMTP id
 k8mr7543192edx.134.1583403512948; 
 Thu, 05 Mar 2020 02:18:32 -0800 (PST)
X-Google-Smtp-Source: ADFU+vtMjJNfMSADofg8/e/QFSeCqzIzmlKo210dlhBY7kq/c6eB5KpEDPq22UAGvh8uhDwaFUv0bg==
X-Received: by 2002:a05:6402:12c8:: with SMTP id
 k8mr7543168edx.134.1583403512597; 
 Thu, 05 Mar 2020 02:18:32 -0800 (PST)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id q5sm819266edw.34.2020.03.05.02.18.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Mar 2020 02:18:32 -0800 (PST)
Subject: Re: [PATCH v1] mips/mips_malta: Allow more than 2G RAM
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org,
 Paul Burton <pburton@wavecomp.com>
References: <20200228032613.1049955-1-jiaxun.yang@flygoat.com>
 <20200303004137.1099502-1-jiaxun.yang@flygoat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6b4a7564-eac6-7bd3-b1c0-e9c7ac4e0c80@redhat.com>
Date: Thu, 5 Mar 2020 11:18:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200303004137.1099502-1-jiaxun.yang@flygoat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: imammedo@redhat.com, Paul Burton <paul.burton@mips.com>,
 Yunqiang Su <ysu@wavecomp.com>, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Please post new patches as v2, and do not post them as reply to v1.

On 3/3/20 1:41 AM, Jiaxun Yang wrote:
> When malta is coupled with MIPS64 cpu which have 64bit
> address space, it is possible to have more than 2G RAM.
>=20
> So we removed ram_size check and overwrite memory
> layout for these targets.
>=20
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Suggested-by: Yunqiang Su <ysu@wavecomp.com>
> --
> v1: Do not overwrite cmdline when we don't have highmem.
> ---
>   hw/mips/mips_malta.c | 29 +++++++++++++++++++++++------
>   1 file changed, 23 insertions(+), 6 deletions(-)
>=20
> diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
> index 6e7ba9235d..4267958f35 100644
> --- a/hw/mips/mips_malta.c
> +++ b/hw/mips/mips_malta.c
> @@ -98,7 +98,8 @@ typedef struct {
>   } MaltaState;
>  =20
>   static struct _loaderparams {
> -    int ram_size, ram_low_size;
> +    unsigned int ram_low_size;
> +    ram_addr_t ram_size;
>       const char *kernel_filename;
>       const char *kernel_cmdline;
>       const char *initrd_filename;
> @@ -1023,6 +1024,7 @@ static int64_t load_kernel(void)
>   {
>       int64_t kernel_entry, kernel_high, initrd_size;
>       long kernel_size;
> +    char mem_cmdline[128];
>       ram_addr_t initrd_offset;
>       int big_endian;
>       uint32_t *prom_buf;
> @@ -1099,20 +1101,33 @@ static int64_t load_kernel(void)
>       prom_buf =3D g_malloc(prom_size);
>  =20
>       prom_set(prom_buf, prom_index++, "%s", loaderparams.kernel_filename=
);
> +
> +    memset(&mem_cmdline[0], 0, sizeof(mem_cmdline));
> +    if (loaderparams.ram_size > 0x10000000) {

Please use 256 * MiB.

> +        /*
> +         * Always use cmdline to overwrite mem layout
> +         * as kernel may reject large emesize.
> +         */
> +        sprintf(&mem_cmdline[0],
> +                "mem=3D0x10000000@0x00000000 mem=3D0x%" PRIx64 "@0x90000=
000",
> +                loaderparams.ram_size - 0x10000000);

Ditto.

Also please use g_strdup_printf("mem=3D0x%" PRIx64 "@...")/g_free.

> +    }
> +
>       if (initrd_size > 0) {
>           prom_set(prom_buf, prom_index++,
> -                 "rd_start=3D0x%" PRIx64 " rd_size=3D%" PRId64 " %s",
> -                 xlate_to_kseg0(NULL, initrd_offset),
> +                 "%s rd_start=3D0x%" PRIx64 " rd_size=3D%" PRId64 " %s",
> +                 &mem_cmdline[0], xlate_to_kseg0(NULL, initrd_offset),
>                    initrd_size, loaderparams.kernel_cmdline);
>       } else {
> -        prom_set(prom_buf, prom_index++, "%s", loaderparams.kernel_cmdli=
ne);
> +        prom_set(prom_buf, prom_index++, "%s %s", &mem_cmdline[0],
> +                 loaderparams.kernel_cmdline);
>       }
>  =20
>       prom_set(prom_buf, prom_index++, "memsize");
>       prom_set(prom_buf, prom_index++, "%u", loaderparams.ram_low_size);
>  =20
>       prom_set(prom_buf, prom_index++, "ememsize");
> -    prom_set(prom_buf, prom_index++, "%u", loaderparams.ram_size);
> +    prom_set(prom_buf, prom_index++, "%lu", loaderparams.ram_size);
>  =20
>       prom_set(prom_buf, prom_index++, "modetty0");
>       prom_set(prom_buf, prom_index++, "38400n8r");
> @@ -1253,12 +1268,14 @@ void mips_malta_init(MachineState *machine)
>       /* create CPU */
>       mips_create_cpu(machine, s, &cbus_irq, &i8259_irq);
>  =20
> -    /* allocate RAM */
> +#ifdef TARGET_MIPS32
> +    /* MIPS32 won't accept more than 2GiB RAM due to limited address spa=
ce */

Cc'ing Paul Burton due to commit 94c2b6aff43.

>       if (ram_size > 2 * GiB) {
>           error_report("Too much memory for this machine: %" PRId64 "MB,"
>                        " maximum 2048MB", ram_size / MiB);

This is annoying, because the CoreLV/CoreFPGA core cards only have 4=20
DIMM slots for PC-100 SDRAM, and the Memory Controller of the GT=E2=80=9364=
120A=20
north bridge accept at most 256 MiB per SCS for address decoding, so we=20
have a maximum of 1 GiB on 32-bit boards.

In 64-bit emulation we use the a 20Kc core, provided by the Core20K core=20
card which doesn't use the GT=E2=80=9364120A but the Bonito64. So the model=
 is=20
incorrect... The Bonito64 indeed allow more memory.

Maybe it is time to consider that for 64-bit targets, since we are not=20
modelling a Malta core board, we can name it the official 'virt' machine...

>           exit(1);
>       }
> +#endif
>  =20
>       /* register RAM at high address where it is undisturbed by IO */
>       memory_region_add_subregion(system_memory, 0x80000000, machine->ram=
);
>=20


