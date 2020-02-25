Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BCF5C35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 10:06:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 257A221556
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 10:06:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i0YVp+Jz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 257A221556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6X6p-0001XG-AR
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 05:06:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58898)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j6X5f-0000Ta-7I
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 05:05:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j6X5d-0004zE-Rs
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 05:05:23 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40094
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j6X5d-0004yn-Oe
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 05:05:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582625121;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZSIX1w871Hq6Mxq5SHmwwfbUgY7lZAD25opJKpMAAYI=;
 b=i0YVp+JzNN1I6/B7eeTGqzaQN7KLMcVZmP+4Xi/wjl6ugjNaILv/wbPGnsyXwKZuPZONKp
 2ZR+0epOLrX9LF97096POMDy9+FEaNndn860YzfGtiJgNecpEZkkygBH9fZX7i42jqxiSk
 GJWAtiDjlzsGXk39Satv0K5WWFrmNy8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-138-nU12Am4SO4qbVBn9WI0etw-1; Tue, 25 Feb 2020 05:05:19 -0500
X-MC-Unique: nU12Am4SO4qbVBn9WI0etw-1
Received: by mail-wr1-f69.google.com with SMTP id n23so7050014wra.20
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 02:05:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=JrMl88kPROecXa+gdgRUv+c9C4/VxCb33UuCKxbI6YM=;
 b=V7uAKASsNJUzstaBVTtayu8Rnpgp3kkBPZmdNk6OWQzfGLPS2ENPt3JWzfjeFIjkE9
 IbumUs4n4PYP5YHLCI59OWJpWmy1+ifmuWlg07pwDZObBod9ntrDDAB3t3hUKQbES6ic
 PDyoRyoLk5QN5c+G1X3Dc9UDKzlN449Tu58cMhZ3jjfewbSY6FFSFlBKtAkZXdq+yqb/
 foM+Jche2YsDxE8eYAfTGErooYwv+i1qwN129cy/DfD9awEW0hjmZSTYquXvFLfemNFm
 xQAvWy3IEwazNCMdxjQt/9lZpQ6DTZy5FvkMXZTd68tHWKQUGPay1LXgbrE5D1W14JEf
 On0Q==
X-Gm-Message-State: APjAAAU8U64aMJyGlr8qX0YSF7ysltZ5lzWcV+I0f9kSGYO4ol1U/XDg
 Gqaatnvrd6qygxdNVNDbhVzaChpdGYdWyl5LdcSIsWrrIEniPxW0umm3j13uTEA0yO9AhEQDoyK
 L14+qt6xKNr6mZdk=
X-Received: by 2002:a05:6000:1147:: with SMTP id
 d7mr10340045wrx.142.1582625118433; 
 Tue, 25 Feb 2020 02:05:18 -0800 (PST)
X-Google-Smtp-Source: APXvYqzYe3l7SDVBJkTUOCevvYRtz1XtiA/cVK6S6Kiv+mhB7y+XmhkOqVf+uCNcqetz/dosbdJByQ==
X-Received: by 2002:a05:6000:1147:: with SMTP id
 d7mr10340005wrx.142.1582625118150; 
 Tue, 25 Feb 2020 02:05:18 -0800 (PST)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id z25sm3507524wmf.14.2020.02.25.02.05.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Feb 2020 02:05:17 -0800 (PST)
Subject: Re: [PATCH RESEND v2 18/32] hw/i386/pc_sysfw: Simplify using
 memory_region_init_alias()
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <20200224205533.23798-1-philmd@redhat.com>
 <20200224205533.23798-19-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <532522f3-fc33-4405-1819-fe89c3ed088e@redhat.com>
Date: Tue, 25 Feb 2020 11:05:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200224205533.23798-19-philmd@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>, qemu-block@nongnu.org,
 Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Alistair Francis <alistair@alistair23.me>,
 Fabien Chouteau <chouteau@adacore.com>, qemu-arm@nongnu.org,
 Peter Chubb <peter.chubb@nicta.com.au>, Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-riscv@nongnu.org, Igor Mitsyanko <i.mitsyanko@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Laurent Vivier <laurent@vivier.eu>, Max Reitz <mreitz@redhat.com>,
 Michael Walle <michael@walle.cc>, qemu-ppc@nongnu.org,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/24/20 9:55 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> The scripts/coccinelle/memory-region-housekeeping.cocci reported:
> * TODO [[view:hw/i386/pc_sysfw.c::face=3Dovl-face1::linb=3D67::colb=3D4::=
cole=3D26][potential use of memory_region_init_rom*() in  hw/i386/pc_sysfw.=
c::67]]
>=20
> pc_isa_bios_init() does a manual copy of a part of the BIOS,
> from a read-only region. We can simplify by directly aliasing
> the same part.
>=20
> Before:
>=20
>    (qemu) info mtree
>    memory-region: system
>      0000000000000000-ffffffffffffffff (prio 0, i/o): system
>        0000000000000000-0000000007ffffff (prio 0, ram): alias ram-below-4=
g @pc.ram 0000000000000000-0000000007ffffff
>        0000000000000000-ffffffffffffffff (prio -1, i/o): pci
>          00000000000a0000-00000000000bffff (prio 1, i/o): vga-lowmem
>          00000000000c0000-00000000000dffff (prio 1, rom): pc.rom
>          00000000000e0000-00000000000fffff (prio 1, rom): isa-bios
>        ...
>        00000000fff00000-00000000ffffffff (prio 0, romd): system.flash0
>=20
> After:
>=20
>    (qemu) info mtree
>    memory-region: system
>      0000000000000000-ffffffffffffffff (prio 0, i/o): system
>        0000000000000000-0000000007ffffff (prio 0, ram): alias ram-below-4=
g @pc.ram 0000000000000000-0000000007ffffff
>        0000000000000000-ffffffffffffffff (prio -1, i/o): pci
>          00000000000a0000-00000000000bffff (prio 1, i/o): vga-lowmem
>          00000000000c0000-00000000000dffff (prio 1, rom): pc.rom
>          00000000000e0000-00000000000fffff (prio 1, romd): alias isa-bios=
 @system.flash0 00000000000e0000-00000000000fffff
>        ...
>        00000000fff00000-00000000ffffffff (prio 0, romd): system.flash0

IIUC migrating old -> new is OK, the previous ROM copy is discarded.

What about new -> old, does it require specific handling? Do we care?

>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>   hw/i386/pc_sysfw.c | 24 ++++++------------------
>   1 file changed, 6 insertions(+), 18 deletions(-)
>=20
> diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
> index f5f3f466b0..e864c09ea8 100644
> --- a/hw/i386/pc_sysfw.c
> +++ b/hw/i386/pc_sysfw.c
> @@ -54,31 +54,19 @@ static void pc_isa_bios_init(MemoryRegion *rom_memory=
,
>                                MemoryRegion *flash_mem,
>                                int ram_size)
>   {
> -    int isa_bios_size;
> -    MemoryRegion *isa_bios;
> -    uint64_t flash_size;
> -    void *flash_ptr, *isa_bios_ptr;
> -
> -    flash_size =3D memory_region_size(flash_mem);
> +    uint64_t isa_bios_size;
> +    MemoryRegion *isa_bios =3D g_new(MemoryRegion, 1);
> +    uint64_t flash_size =3D memory_region_size(flash_mem);
>  =20
>       /* map the last 128KB of the BIOS in ISA space */
>       isa_bios_size =3D MIN(flash_size, 128 * KiB);
> -    isa_bios =3D g_malloc(sizeof(*isa_bios));
> -    memory_region_init_ram(isa_bios, NULL, "isa-bios", isa_bios_size,
> -                           &error_fatal);
> +    memory_region_init_alias(isa_bios, NULL, "isa-bios", flash_mem,
> +                             flash_size - isa_bios_size,
> +                             isa_bios_size);
>       memory_region_add_subregion_overlap(rom_memory,
>                                           0x100000 - isa_bios_size,
>                                           isa_bios,
>                                           1);
> -
> -    /* copy ISA rom image from top of flash memory */
> -    flash_ptr =3D memory_region_get_ram_ptr(flash_mem);
> -    isa_bios_ptr =3D memory_region_get_ram_ptr(isa_bios);
> -    memcpy(isa_bios_ptr,
> -           ((uint8_t*)flash_ptr) + (flash_size - isa_bios_size),
> -           isa_bios_size);
> -
> -    memory_region_set_readonly(isa_bios, true);
>   }
>  =20
>   static PFlashCFI01 *pc_pflash_create(PCMachineState *pcms,
>=20


