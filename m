Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD125FA372A
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 15:00:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9896C2168B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 15:00:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PawlpDEu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9896C2168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKkmN-00044q-Sl
	for qemu-devel@archiver.kernel.org; Wed, 16 Oct 2019 10:59:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45365)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iKkli-0003fO-1G
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 10:59:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iKklg-00038G-Ge
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 10:59:17 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:34954)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1iKklg-00037F-9b
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 10:59:16 -0400
Received: by mail-wr1-x443.google.com with SMTP id v8so28472039wrt.2
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2019 07:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=sA+oyHzdAI0p+AuWqDLIRCrsZwVL2WF2HyFQpx/JGHs=;
 b=PawlpDEuNAtzZO61kxQYOjeCcAuQVTy1kg0Bfl3swTGmoAkyNORMlN7ceEMb8dX8D+
 Rl+ROhcBPo6iL52LQ2EfocFCo3U85hl1zh4rH2Ud5Apj7R6wjO2uKTT02+mRTUZBTEJD
 ri6NFNomBtIIv/qiYQXR2lZ62KJzvxduk0Ua0FPQY/rOv84XsEHCyT5A+JNx4xsdkeIO
 SvB3Y8eHfgLEDG5CPt2+GzH7frvJJeblo6Y3hNWCwM13e3HISprwRNamozgYQsUW2yXx
 CN9xmUiUyIFC2nrCe25fkwh2W8N6E9nlhrzyf+/jQE/UwXKgEHRBYAt10fqN8/uJX7mP
 W7Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=sA+oyHzdAI0p+AuWqDLIRCrsZwVL2WF2HyFQpx/JGHs=;
 b=E5ktwpaWzXRdApLUSyc2q5O2xsrbN9e2FUyXmnmio6IQzIlaJ2Weqhd7fVjar+6ec5
 OKgKaWVW0+n9gUPFsoQ7GiZH0KPYF6qEzcf5tIKiynKPA9vwCTDVJz4FUc6eFLCm+pqx
 cNYOS9Jv/H2XXZsYute5GOORpkAn8m3NLcyv2iotfZ6T5GNViJDRSjbssloOVqKTZc0l
 py6Gtl9WOUfUYgJ44SczZ1MZywWUkjQauH1nThFUsRyX8VbWt6z/v8wVrpUQAoklSDP9
 qC7Kh0lixHqXpljiipjoj7sa/r5ly8ieIhyYsGH8QHRxUDJu5foUTgQsCNvNYRhCr/Zg
 NDBQ==
X-Gm-Message-State: APjAAAXg156jXjlL+52RMGVV1BqSZa5AHME0S8HGHY/ySGGH/uIqLF9W
 3h172A4bLniAW+w5deTDIX3+3a5uE+7kdnn/QMI=
X-Google-Smtp-Source: APXvYqw2Xp8ME6Ul3P/4Lf0IqKkpVxFjdJ8dNFiy51DXThg6Nlm4zDypCVfCnu4viXZPINmJxhml4Hh52nW9dF0UeLQ=
X-Received: by 2002:a05:6000:18d:: with SMTP id
 p13mr3065312wrx.396.1571237954086; 
 Wed, 16 Oct 2019 07:59:14 -0700 (PDT)
MIME-Version: 1.0
References: <20191016101241.24405-1-slp@redhat.com>
 <20191016101241.24405-4-slp@redhat.com>
In-Reply-To: <20191016101241.24405-4-slp@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 16 Oct 2019 16:59:01 +0200
Message-ID: <CAJ+F1CJjqrDJMSgyCOQT19nw2hGXTLpareYuSOuZy41xntXVJQ@mail.gmail.com>
Subject: Re: [PATCH v10 03/15] hw/i386/pc: fix code style issues on functions
 that will be moved out
To: Sergio Lopez <slp@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, groug@kaod.org,
 QEMU <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Laszlo Ersek <lersek@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Oct 16, 2019 at 12:13 PM Sergio Lopez <slp@redhat.com> wrote:
>
> Fix code style issues detected by checkpatch.pl on functions that will
> be moved out to x86.c.
>
> Signed-off-by: Sergio Lopez <slp@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  hw/i386/pc.c | 53 ++++++++++++++++++++++++++++------------------------
>  1 file changed, 29 insertions(+), 24 deletions(-)
>
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index fd08c6704b..77e86bfc3d 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -866,7 +866,8 @@ static void handle_a20_line_change(void *opaque, int =
irq, int level)
>      x86_cpu_set_a20(cpu, level);
>  }
>
> -/* Calculates initial APIC ID for a specific CPU index
> +/*
> + * Calculates initial APIC ID for a specific CPU index
>   *
>   * Currently we need to be able to calculate the APIC ID from the CPU in=
dex
>   * alone (without requiring a CPU object), as the QEMU<->Seabios interfa=
ces have
> @@ -1039,7 +1040,7 @@ static void x86_load_linux(PCMachineState *pcms,
>      const char *kernel_cmdline =3D machine->kernel_cmdline;
>
>      /* Align to 16 bytes as a paranoia measure */
> -    cmdline_size =3D (strlen(kernel_cmdline)+16) & ~15;
> +    cmdline_size =3D (strlen(kernel_cmdline) + 16) & ~15;
>
>      /* load the kernel header */
>      f =3D fopen(kernel_filename, "rb");
> @@ -1055,8 +1056,8 @@ static void x86_load_linux(PCMachineState *pcms,
>  #if 0
>      fprintf(stderr, "header magic: %#x\n", ldl_p(header+0x202));
>  #endif
> -    if (ldl_p(header+0x202) =3D=3D 0x53726448) {
> -        protocol =3D lduw_p(header+0x206);
> +    if (ldl_p(header + 0x202) =3D=3D 0x53726448) {
> +        protocol =3D lduw_p(header + 0x206);
>      } else {
>          /*
>           * This could be a multiboot kernel. If it is, let's stop treati=
ng it
> @@ -1158,7 +1159,7 @@ static void x86_load_linux(PCMachineState *pcms,
>
>      /* highest address for loading the initrd */
>      if (protocol >=3D 0x20c &&
> -        lduw_p(header+0x236) & XLF_CAN_BE_LOADED_ABOVE_4G) {
> +        lduw_p(header + 0x236) & XLF_CAN_BE_LOADED_ABOVE_4G) {
>          /*
>           * Linux has supported initrd up to 4 GB for a very long time (2=
007,
>           * long before XLF_CAN_BE_LOADED_ABOVE_4G which was added in 201=
3),
> @@ -1177,7 +1178,7 @@ static void x86_load_linux(PCMachineState *pcms,
>           */
>          initrd_max =3D UINT32_MAX;
>      } else if (protocol >=3D 0x203) {
> -        initrd_max =3D ldl_p(header+0x22c);
> +        initrd_max =3D ldl_p(header + 0x22c);
>      } else {
>          initrd_max =3D 0x37ffffff;
>      }
> @@ -1187,14 +1188,14 @@ static void x86_load_linux(PCMachineState *pcms,
>      }
>
>      fw_cfg_add_i32(fw_cfg, FW_CFG_CMDLINE_ADDR, cmdline_addr);
> -    fw_cfg_add_i32(fw_cfg, FW_CFG_CMDLINE_SIZE, strlen(kernel_cmdline)+1=
);
> +    fw_cfg_add_i32(fw_cfg, FW_CFG_CMDLINE_SIZE, strlen(kernel_cmdline) +=
 1);
>      fw_cfg_add_string(fw_cfg, FW_CFG_CMDLINE_DATA, kernel_cmdline);
>
>      if (protocol >=3D 0x202) {
> -        stl_p(header+0x228, cmdline_addr);
> +        stl_p(header + 0x228, cmdline_addr);
>      } else {
> -        stw_p(header+0x20, 0xA33F);
> -        stw_p(header+0x22, cmdline_addr-real_addr);
> +        stw_p(header + 0x20, 0xA33F);
> +        stw_p(header + 0x22, cmdline_addr - real_addr);
>      }
>
>      /* handle vga=3D parameter */
> @@ -1212,20 +1213,22 @@ static void x86_load_linux(PCMachineState *pcms,
>          } else {
>              video_mode =3D strtol(vmode, NULL, 0);
>          }
> -        stw_p(header+0x1fa, video_mode);
> +        stw_p(header + 0x1fa, video_mode);
>      }
>
>      /* loader type */
> -    /* High nybble =3D B reserved for QEMU; low nybble is revision numbe=
r.
> -       If this code is substantially changed, you may want to consider
> -       incrementing the revision. */
> +    /*
> +     * High nybble =3D B reserved for QEMU; low nybble is revision numbe=
r.
> +     * If this code is substantially changed, you may want to consider
> +     * incrementing the revision.
> +     */
>      if (protocol >=3D 0x200) {
>          header[0x210] =3D 0xB0;
>      }
>      /* heap */
>      if (protocol >=3D 0x201) {
> -        header[0x211] |=3D 0x80; /* CAN_USE_HEAP */
> -        stw_p(header+0x224, cmdline_addr-real_addr-0x200);
> +        header[0x211] |=3D 0x80; /* CAN_USE_HEAP */
> +        stw_p(header + 0x224, cmdline_addr - real_addr - 0x200);
>      }
>
>      /* load initrd */
> @@ -1257,14 +1260,14 @@ static void x86_load_linux(PCMachineState *pcms,
>              exit(1);
>          }
>
> -        initrd_addr =3D (initrd_max-initrd_size) & ~4095;
> +        initrd_addr =3D (initrd_max - initrd_size) & ~4095;
>
>          fw_cfg_add_i32(fw_cfg, FW_CFG_INITRD_ADDR, initrd_addr);
>          fw_cfg_add_i32(fw_cfg, FW_CFG_INITRD_SIZE, initrd_size);
>          fw_cfg_add_bytes(fw_cfg, FW_CFG_INITRD_DATA, initrd_data, initrd=
_size);
>
> -        stl_p(header+0x218, initrd_addr);
> -        stl_p(header+0x21c, initrd_size);
> +        stl_p(header + 0x218, initrd_addr);
> +        stl_p(header + 0x21c, initrd_size);
>      }
>
>      /* load kernel and setup */
> @@ -1272,7 +1275,7 @@ static void x86_load_linux(PCMachineState *pcms,
>      if (setup_size =3D=3D 0) {
>          setup_size =3D 4;
>      }
> -    setup_size =3D (setup_size+1)*512;
> +    setup_size =3D (setup_size + 1) * 512;
>      if (setup_size > kernel_size) {
>          fprintf(stderr, "qemu: invalid kernel header\n");
>          exit(1);
> @@ -1310,7 +1313,7 @@ static void x86_load_linux(PCMachineState *pcms,
>          kernel_size =3D setup_data_offset + sizeof(struct setup_data) + =
dtb_size;
>          kernel =3D g_realloc(kernel, kernel_size);
>
> -        stq_p(header+0x250, prot_addr + setup_data_offset);
> +        stq_p(header + 0x250, prot_addr + setup_data_offset);
>
>          setup_data =3D (struct setup_data *)(kernel + setup_data_offset)=
;
>          setup_data->next =3D 0;
> @@ -1507,7 +1510,8 @@ void x86_cpus_init(PCMachineState *pcms)
>
>      x86_cpu_set_default_version(pcmc->default_cpu_version);
>
> -    /* Calculates the limit to CPU APIC ID values
> +    /*
> +     * Calculates the limit to CPU APIC ID values
>       *
>       * Limit for the APIC ID value, so that all
>       * CPU APIC IDs are < pcms->apic_id_limit.
> @@ -2709,7 +2713,7 @@ static const CPUArchIdList *x86_possible_cpu_arch_i=
ds(MachineState *ms)
>          /*
>           * make sure that max_cpus hasn't changed since the first use, i=
.e.
>           * -smp hasn't been parsed after it
> -        */
> +         */
>          assert(ms->possible_cpus->len =3D=3D max_cpus);
>          return ms->possible_cpus;
>      }
> @@ -2722,7 +2726,8 @@ static const CPUArchIdList *x86_possible_cpu_arch_i=
ds(MachineState *ms)
>
>          ms->possible_cpus->cpus[i].type =3D ms->cpu_type;
>          ms->possible_cpus->cpus[i].vcpus_count =3D 1;
> -        ms->possible_cpus->cpus[i].arch_id =3D x86_cpu_apic_id_from_inde=
x(pcms, i);
> +        ms->possible_cpus->cpus[i].arch_id =3D
> +            x86_cpu_apic_id_from_index(pcms, i);
>          x86_topo_ids_from_apicid(ms->possible_cpus->cpus[i].arch_id,
>                                   pcms->smp_dies, ms->smp.cores,
>                                   ms->smp.threads, &topo);
> --
> 2.21.0
>
>


--
Marc-Andr=C3=A9 Lureau

