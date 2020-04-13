Return-Path: <SRS0=kd+i=55=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9464CC2BA2B
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 16:05:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D08C2063A
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 16:05:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kchv4Fvb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D08C2063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jO1aa-0002CW-Cz
	for qemu-devel@archiver.kernel.org; Mon, 13 Apr 2020 12:05:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58559)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jO1ZT-0000RQ-Jw
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 12:04:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1jO1ZR-0003cP-6I
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 12:04:27 -0400
Received: from mail-ua1-x943.google.com ([2607:f8b0:4864:20::943]:46729)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1jO1ZR-0003bW-0G; Mon, 13 Apr 2020 12:04:25 -0400
Received: by mail-ua1-x943.google.com with SMTP id o14so3271042uat.13;
 Mon, 13 Apr 2020 09:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=SkY93g081tYc+r8vljnrAhCCxfM1oSj3fDtrxu7uJew=;
 b=Kchv4FvbO0ZAE6azSSCfzB0iRfuv1+2ruRiyIo2HextCFljIPm4uqjhBeullz1SmwJ
 YC/c9R96lW7jvoSfDW1uSVnK/wT8nwbETEZnsngq65dh2226uanZyYMaJSgjLgs1c6hS
 Kht8XzfFTMNMi9Z+eq6I+dQH+Z6kxTiqxr8nYMcIvrVF3Qt8et1QFWajO8xqZ9NSqvNo
 AcXSLP5l5z3Y9xidxZqNS5JRCyQX2PaKV9STio6j9JqCbYn2iuQI4HyVvNc70RrbOSRb
 gQtT1RJRucuVu0upg5eOgLgex+Vxlp5qg1dl8NwcjxhGpnKm7SMWFi5qhdyLy3ipkd0H
 hisw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=SkY93g081tYc+r8vljnrAhCCxfM1oSj3fDtrxu7uJew=;
 b=lqUxORHhJ/iUE59PkpxTqnzi503bEcdd93nnt1JJw+vfi5H5/Eo6Mnfh9BNJtm84DB
 5wacABfgXSG4jlBL6F/YVHfvdZ8MnnkzG2weU1eZkuSn/YvTNoivvoG6LGX/jD1SOmRJ
 cGEUbDqYXcWXtVXTFfOSAJkh6KKnfYIwpw+/tlput+tQe5IACFoii6RqqtftWwblstyn
 aMdlIsS5TsPSgPcxsuMigoYjDX8HYQeSkNF66VEZPfpZhwQOsD2DxdGqj4Vjbrvr/KFV
 IgHg1VYxZXZlksONW7NvnQ4Ylfx4aBsgc9g+aMaqvh2Di2GBHAZgyxOhEBqYC5ZQUzvQ
 FooA==
X-Gm-Message-State: AGi0Puam3Zd/gGgPqCNo9H3fOKJinLP4BdIi2ck2m/p5nhoeoaMf9Ud+
 E5aUCMlFJZfrY9kPOVzO1aXAZ/r5nZ3V1Ol1pxA=
X-Google-Smtp-Source: APiQypKfNMX0KGg5e3OlMFOMYOcwE/UkaQVLRx7ApZtIWvxhQErK45z8mRrLnv92BWDc7hjG6nRgTzBWQx03AQc4WLQ=
X-Received: by 2002:a9f:2964:: with SMTP id t91mr11281050uat.21.1586793862356; 
 Mon, 13 Apr 2020 09:04:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200412223619.11284-1-f4bug@amsat.org>
 <20200412223619.11284-2-f4bug@amsat.org>
In-Reply-To: <20200412223619.11284-2-f4bug@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 13 Apr 2020 08:56:06 -0700
Message-ID: <CAKmqyKPjYurgma0TqtXfg-RfkjHBKiw=KqvbO_ZMMqDqwoaB9w@mail.gmail.com>
Subject: Re: [PATCH-for-5.1 v3 01/24] various: Remove suspicious '\' character
 outside of #define in C code
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::943
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jeff Cody <codyprime@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Max Reitz <mreitz@redhat.com>,
 Qemu-block <qemu-block@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Xie Changlong <xiechanglong.d@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Beniamino Galvani <b.galvani@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Peter Chubb <peter.chubb@nicta.com.au>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 "open list:New World" <qemu-ppc@nongnu.org>,
 Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>, Andrew Jeffery <andrew@aj.id.au>,
 Wen Congyang <wencongyang2@huawei.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Apr 12, 2020 at 3:38 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
> Fixes the following coccinelle warnings:
>
>   $ spatch --sp-file --verbose-parsing  ... \
>       scripts/coccinelle/remove_local_err.cocci
>   ...
>   SUSPICIOUS: a \ character appears outside of a #define at ./target/ppc/=
translate_init.inc.c:5213
>   SUSPICIOUS: a \ character appears outside of a #define at ./target/ppc/=
translate_init.inc.c:5261
>   SUSPICIOUS: a \ character appears outside of a #define at ./target/micr=
oblaze/cpu.c:166
>   SUSPICIOUS: a \ character appears outside of a #define at ./target/micr=
oblaze/cpu.c:167
>   SUSPICIOUS: a \ character appears outside of a #define at ./target/micr=
oblaze/cpu.c:169
>   SUSPICIOUS: a \ character appears outside of a #define at ./target/micr=
oblaze/cpu.c:170
>   SUSPICIOUS: a \ character appears outside of a #define at ./target/micr=
oblaze/cpu.c:171
>   SUSPICIOUS: a \ character appears outside of a #define at ./target/micr=
oblaze/cpu.c:172
>   SUSPICIOUS: a \ character appears outside of a #define at ./target/micr=
oblaze/cpu.c:173
>   SUSPICIOUS: a \ character appears outside of a #define at ./target/i386=
/cpu.c:5787
>   SUSPICIOUS: a \ character appears outside of a #define at ./target/i386=
/cpu.c:5789
>   SUSPICIOUS: a \ character appears outside of a #define at ./target/i386=
/cpu.c:5800
>   SUSPICIOUS: a \ character appears outside of a #define at ./target/i386=
/cpu.c:5801
>   SUSPICIOUS: a \ character appears outside of a #define at ./target/i386=
/cpu.c:5802
>   SUSPICIOUS: a \ character appears outside of a #define at ./target/i386=
/cpu.c:5804
>   SUSPICIOUS: a \ character appears outside of a #define at ./target/i386=
/cpu.c:5805
>   SUSPICIOUS: a \ character appears outside of a #define at ./target/i386=
/cpu.c:5806
>   SUSPICIOUS: a \ character appears outside of a #define at ./target/i386=
/cpu.c:6329
>   SUSPICIOUS: a \ character appears outside of a #define at ./hw/sd/sdhci=
.c:1133
>   SUSPICIOUS: a \ character appears outside of a #define at ./hw/scsi/scs=
i-disk.c:3081
>   SUSPICIOUS: a \ character appears outside of a #define at ./hw/net/virt=
io-net.c:1529
>   SUSPICIOUS: a \ character appears outside of a #define at ./hw/riscv/si=
five_u.c:468
>   SUSPICIOUS: a \ character appears outside of a #define at ./dump/dump.c=
:1895
>   SUSPICIOUS: a \ character appears outside of a #define at ./block/vhdx.=
c:2209
>   SUSPICIOUS: a \ character appears outside of a #define at ./block/vhdx.=
c:2215
>   SUSPICIOUS: a \ character appears outside of a #define at ./block/vhdx.=
c:2221
>   SUSPICIOUS: a \ character appears outside of a #define at ./block/vhdx.=
c:2222
>   SUSPICIOUS: a \ character appears outside of a #define at ./block/repli=
cation.c:172
>   SUSPICIOUS: a \ character appears outside of a #define at ./block/repli=
cation.c:173
>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  block/replication.c             |  4 ++--
>  block/vhdx.c                    |  8 ++++----
>  dump/dump.c                     |  2 +-
>  hw/net/virtio-net.c             |  2 +-
>  hw/riscv/sifive_u.c             |  2 +-
>  hw/scsi/scsi-disk.c             |  2 +-
>  hw/sd/sdhci.c                   |  2 +-
>  target/i386/cpu.c               | 18 +++++++++---------
>  target/microblaze/cpu.c         | 14 +++++++-------
>  target/ppc/translate_init.inc.c |  4 ++--
>  10 files changed, 29 insertions(+), 29 deletions(-)
>
> diff --git a/block/replication.c b/block/replication.c
> index da013c2041..971f0fe266 100644
> --- a/block/replication.c
> +++ b/block/replication.c
> @@ -172,8 +172,8 @@ static void replication_child_perm(BlockDriverState *=
bs, BdrvChild *c,
>      if ((bs->open_flags & (BDRV_O_INACTIVE | BDRV_O_RDWR)) =3D=3D BDRV_O=
_RDWR) {
>          *nperm |=3D BLK_PERM_WRITE;
>      }
> -    *nshared =3D BLK_PERM_CONSISTENT_READ \
> -               | BLK_PERM_WRITE \
> +    *nshared =3D BLK_PERM_CONSISTENT_READ
> +               | BLK_PERM_WRITE
>                 | BLK_PERM_WRITE_UNCHANGED;
>      return;
>  }
> diff --git a/block/vhdx.c b/block/vhdx.c
> index 33e57cd656..e16fdc2f2d 100644
> --- a/block/vhdx.c
> +++ b/block/vhdx.c
> @@ -2206,20 +2206,20 @@ static QemuOptsList vhdx_create_opts =3D {
>             .name =3D VHDX_BLOCK_OPT_BLOCK_SIZE,
>             .type =3D QEMU_OPT_SIZE,
>             .def_value_str =3D stringify(0),
> -           .help =3D "Block Size; min 1MB, max 256MB. " \
> +           .help =3D "Block Size; min 1MB, max 256MB. "
>                     "0 means auto-calculate based on image size."
>         },
>         {
>             .name =3D BLOCK_OPT_SUBFMT,
>             .type =3D QEMU_OPT_STRING,
> -           .help =3D "VHDX format type, can be either 'dynamic' or 'fixe=
d'. "\
> +           .help =3D "VHDX format type, can be either 'dynamic' or 'fixe=
d'. "
>                     "Default is 'dynamic'."
>         },
>         {
>             .name =3D VHDX_BLOCK_OPT_ZERO,
>             .type =3D QEMU_OPT_BOOL,
> -           .help =3D "Force use of payload blocks of type 'ZERO'. "\
> -                   "Non-standard, but default.  Do not set to 'off' when=
 "\
> +           .help =3D "Force use of payload blocks of type 'ZERO'. "
> +                   "Non-standard, but default.  Do not set to 'off' when=
 "
>                     "using 'qemu-img convert' with subformat=3Ddynamic."
>         },
>         { NULL }
> diff --git a/dump/dump.c b/dump/dump.c
> index 22ed1d3b0d..248ea06370 100644
> --- a/dump/dump.c
> +++ b/dump/dump.c
> @@ -1892,7 +1892,7 @@ static void dump_process(DumpState *s, Error **errp=
)
>      result =3D qmp_query_dump(NULL);
>      /* should never fail */
>      assert(result);
> -    qapi_event_send_dump_completed(result, !!local_err, (local_err ? \
> +    qapi_event_send_dump_completed(result, !!local_err, (local_err ?
>                                     error_get_pretty(local_err) : NULL));
>      qapi_free_DumpQueryResult(result);
>
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index a46e3b37a7..eddfa7f923 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -1526,7 +1526,7 @@ static void virtio_net_rsc_extract_unit6(VirtioNetR=
scChain *chain,
>                                   + sizeof(struct eth_header));
>      unit->ip =3D ip6;
>      unit->ip_plen =3D &(ip6->ip6_ctlun.ip6_un1.ip6_un1_plen);
> -    unit->tcp =3D (struct tcp_header *)(((uint8_t *)unit->ip)\
> +    unit->tcp =3D (struct tcp_header *)(((uint8_t *)unit->ip)
>                                          + sizeof(struct ip6_header));
>      unit->tcp_hdrlen =3D (htons(unit->tcp->th_offset_flags) & 0xF000) >>=
 10;
>
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index 56351c4faa..998666c91f 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -465,7 +465,7 @@ static void riscv_sifive_u_machine_instance_init(Obje=
ct *obj)
>      object_property_add_bool(obj, "start-in-flash", sifive_u_get_start_i=
n_flash,
>                               sifive_u_set_start_in_flash, NULL);
>      object_property_set_description(obj, "start-in-flash",
> -                                    "Set on to tell QEMU's ROM to jump t=
o " \
> +                                    "Set on to tell QEMU's ROM to jump t=
o "
>                                      "flash. Otherwise QEMU will jump to =
DRAM",
>                                      NULL);
>  }
> diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
> index 1c0cb63a6f..e5bcd0baf8 100644
> --- a/hw/scsi/scsi-disk.c
> +++ b/hw/scsi/scsi-disk.c
> @@ -3078,7 +3078,7 @@ static const TypeInfo scsi_cd_info =3D {
>
>  #ifdef __linux__
>  static Property scsi_block_properties[] =3D {
> -    DEFINE_BLOCK_ERROR_PROPERTIES(SCSIDiskState, qdev.conf),         \
> +    DEFINE_BLOCK_ERROR_PROPERTIES(SCSIDiskState, qdev.conf),
>      DEFINE_PROP_DRIVE("drive", SCSIDiskState, qdev.conf.blk),
>      DEFINE_PROP_BOOL("share-rw", SCSIDiskState, qdev.conf.share_rw, fals=
e),
>      DEFINE_PROP_UINT16("rotation_rate", SCSIDiskState, rotation_rate, 0)=
,
> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> index de63ffb037..70531ad360 100644
> --- a/hw/sd/sdhci.c
> +++ b/hw/sd/sdhci.c
> @@ -1130,7 +1130,7 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t v=
al, unsigned size)
>
>          /* Limit block size to the maximum buffer size */
>          if (extract32(s->blksize, 0, 12) > s->buf_maxsz) {
> -            qemu_log_mask(LOG_GUEST_ERROR, "%s: Size 0x%x is larger than=
 " \
> +            qemu_log_mask(LOG_GUEST_ERROR, "%s: Size 0x%x is larger than=
 "
>                            "the maximum buffer 0x%x", __func__, s->blksiz=
e,
>                            s->buf_maxsz);
>
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 90ffc5f3b1..9c256ab159 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -5784,9 +5784,9 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index=
, uint32_t count,
>              host_cpuid(index, 0, eax, ebx, ecx, edx);
>              break;
>          }
> -        *eax =3D (L1_DTLB_2M_ASSOC << 24) | (L1_DTLB_2M_ENTRIES << 16) |=
 \
> +        *eax =3D (L1_DTLB_2M_ASSOC << 24) | (L1_DTLB_2M_ENTRIES << 16) |
>                 (L1_ITLB_2M_ASSOC <<  8) | (L1_ITLB_2M_ENTRIES);
> -        *ebx =3D (L1_DTLB_4K_ASSOC << 24) | (L1_DTLB_4K_ENTRIES << 16) |=
 \
> +        *ebx =3D (L1_DTLB_4K_ASSOC << 24) | (L1_DTLB_4K_ENTRIES << 16) |
>                 (L1_ITLB_4K_ASSOC <<  8) | (L1_ITLB_4K_ENTRIES);
>          *ecx =3D encode_cache_cpuid80000005(env->cache_info_amd.l1d_cach=
e);
>          *edx =3D encode_cache_cpuid80000005(env->cache_info_amd.l1i_cach=
e);
> @@ -5797,13 +5797,13 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t ind=
ex, uint32_t count,
>              host_cpuid(index, 0, eax, ebx, ecx, edx);
>              break;
>          }
> -        *eax =3D (AMD_ENC_ASSOC(L2_DTLB_2M_ASSOC) << 28) | \
> -               (L2_DTLB_2M_ENTRIES << 16) | \
> -               (AMD_ENC_ASSOC(L2_ITLB_2M_ASSOC) << 12) | \
> +        *eax =3D (AMD_ENC_ASSOC(L2_DTLB_2M_ASSOC) << 28) |
> +               (L2_DTLB_2M_ENTRIES << 16) |
> +               (AMD_ENC_ASSOC(L2_ITLB_2M_ASSOC) << 12) |
>                 (L2_ITLB_2M_ENTRIES);
> -        *ebx =3D (AMD_ENC_ASSOC(L2_DTLB_4K_ASSOC) << 28) | \
> -               (L2_DTLB_4K_ENTRIES << 16) | \
> -               (AMD_ENC_ASSOC(L2_ITLB_4K_ASSOC) << 12) | \
> +        *ebx =3D (AMD_ENC_ASSOC(L2_DTLB_4K_ASSOC) << 28) |
> +               (L2_DTLB_4K_ENTRIES << 16) |
> +               (AMD_ENC_ASSOC(L2_ITLB_4K_ASSOC) << 12) |
>                 (L2_ITLB_4K_ENTRIES);
>          encode_cache_cpuid80000006(env->cache_info_amd.l2_cache,
>                                     cpu->enable_l3_cache ?
> @@ -6326,7 +6326,7 @@ static void x86_cpu_expand_features(X86CPU *cpu, Er=
ror **errp)
>               */
>              env->features[w] |=3D
>                  x86_cpu_get_supported_feature_word(w, cpu->migratable) &
> -                ~env->user_features[w] & \
> +                ~env->user_features[w] &
>                  ~feature_word_info[w].no_autoenable_flags;
>          }
>      }
> diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
> index a2c2f271df..c9cf2364ca 100644
> --- a/target/microblaze/cpu.c
> +++ b/target/microblaze/cpu.c
> @@ -163,14 +163,14 @@ static void mb_cpu_realizefn(DeviceState *dev, Erro=
r **errp)
>
>      qemu_init_vcpu(cs);
>
> -    env->pvr.regs[0] =3D PVR0_USE_EXC_MASK \
> -                       | PVR0_USE_ICACHE_MASK \
> +    env->pvr.regs[0] =3D PVR0_USE_EXC_MASK
> +                       | PVR0_USE_ICACHE_MASK
>                         | PVR0_USE_DCACHE_MASK;
> -    env->pvr.regs[2] =3D PVR2_D_OPB_MASK \
> -                        | PVR2_D_LMB_MASK \
> -                        | PVR2_I_OPB_MASK \
> -                        | PVR2_I_LMB_MASK \
> -                        | PVR2_FPU_EXC_MASK \
> +    env->pvr.regs[2] =3D PVR2_D_OPB_MASK
> +                        | PVR2_D_LMB_MASK
> +                        | PVR2_I_OPB_MASK
> +                        | PVR2_I_LMB_MASK
> +                        | PVR2_FPU_EXC_MASK
>                          | 0;
>
>      version =3D cpu->cfg.version ? cpu->cfg.version : DEFAULT_CPU_VERSIO=
N;
> diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.=
inc.c
> index e853164a86..fd763e588e 100644
> --- a/target/ppc/translate_init.inc.c
> +++ b/target/ppc/translate_init.inc.c
> @@ -5210,7 +5210,7 @@ POWERPC_FAMILY(e5500)(ObjectClass *oc, void *data)
>                         PPC_FLOAT_STFIWX | PPC_WAIT |
>                         PPC_MEM_TLBSYNC | PPC_TLBIVAX | PPC_MEM_SYNC |
>                         PPC_64B | PPC_POPCNTB | PPC_POPCNTWD;
> -    pcc->insns_flags2 =3D PPC2_BOOKE206 | PPC2_PRCNTL | PPC2_PERM_ISA206=
 | \
> +    pcc->insns_flags2 =3D PPC2_BOOKE206 | PPC2_PRCNTL | PPC2_PERM_ISA206=
 |
>                          PPC2_FP_CVT_S64;
>      pcc->msr_mask =3D (1ull << MSR_CM) |
>                      (1ull << MSR_GS) |
> @@ -5258,7 +5258,7 @@ POWERPC_FAMILY(e6500)(ObjectClass *oc, void *data)
>                         PPC_FLOAT_STFIWX | PPC_WAIT |
>                         PPC_MEM_TLBSYNC | PPC_TLBIVAX | PPC_MEM_SYNC |
>                         PPC_64B | PPC_POPCNTB | PPC_POPCNTWD | PPC_ALTIVE=
C;
> -    pcc->insns_flags2 =3D PPC2_BOOKE206 | PPC2_PRCNTL | PPC2_PERM_ISA206=
 | \
> +    pcc->insns_flags2 =3D PPC2_BOOKE206 | PPC2_PRCNTL | PPC2_PERM_ISA206=
 |
>                          PPC2_FP_CVT_S64 | PPC2_ATOMIC_ISA206;
>      pcc->msr_mask =3D (1ull << MSR_CM) |
>                      (1ull << MSR_GS) |
> --
> 2.21.1
>
>

