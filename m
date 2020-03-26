Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7FAEC43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 21:56:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8C3B20719
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 21:56:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Aw1Y3/2d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8C3B20719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHaUe-0005Jk-QS
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 17:56:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58531)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jHaTZ-0004UR-PG
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 17:55:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jHaTY-0005hu-IL
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 17:55:45 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:36979)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jHaTY-0005gm-9s
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 17:55:44 -0400
Received: by mail-oi1-x242.google.com with SMTP id u20so2276987oic.4
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 14:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=/7Dge42VPMQIQ+qAVtWjTSc1/n/GVgSuU4WhzEapY/E=;
 b=Aw1Y3/2dzbHMFpA62MhH9zJsJ8zMqb4GtyaSvfdqziD4nig5f4LXR3VQHxjwWVzXru
 8IYgF/jp+QflPbPr6w7Op4sOLl5UoZ2i6fL0iVQwFdHbHHAWzD/0rE4nwvLNeWa9TQ6e
 NU/z7gYAi4BAz09GvmaJzVd5qp579/Th1VHa45XC059+kUBXZ10obygo1tW+GDkR3eJa
 6ZDWsFturC6K2oSd0oe2hs7raNj1Ht48xyWla/TO61ubtKwnTkJa1KZnN5NxmJC8Y0g5
 hTXZJ8OIBEab+faVD3EZwPlfo3erURNegpJVagQtnA/1O2K+Qa4HoUPIsweELUgdlMcj
 OI6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=/7Dge42VPMQIQ+qAVtWjTSc1/n/GVgSuU4WhzEapY/E=;
 b=LdTlj33nYZTpaakjU5ajYCcE6caJ87GrmTaNgI+tM2oJ0N2wx15MmJyveLRkH3iplg
 F9k+4ObFx6cKa+C4TIPBYYrwpKF54cnDGcRlr6H1rVG6/rKhtd+ilSKAuYLoLLwU49kf
 C2d73u8vVnRtdcqHbRo/h3nSvJSZ3PhEn9cOPQB5K2UJY+Ws+h0LqUXcQUZfNNkFdkW9
 7775c/j/VhfMWO2XnVZ90JrrvSSWjmWE0aRcH4xkB/9Xp3L0U/JLU+sZBKbWh0hHv2z8
 U7hqMrqrWPco9scDQa6dXpkwab3pfSIFBAen42GOWUcHcrokcKuatt0P6l4VHvtT+lJV
 aaeA==
X-Gm-Message-State: ANhLgQ3Cen4Liw1JweZ2Bb2rbi5CSM4gtfiV7C3Q72gykEmoB0WO9WOE
 G6HUMrZ/27l0goag/fmsamQ8IiTlAzVMKE/kaWagH/ubu48=
X-Google-Smtp-Source: ADFU+vu9ZekAHqpHmmO/NFGRrhtGWpGzNywbcUb9rHOgkkBznqwLjbl5BXRWlMBNU4XrAa8b5Hn0O0rNhEQjLFjlVv4=
X-Received: by 2002:aca:c608:: with SMTP id w8mr1963767oif.163.1585259743374; 
 Thu, 26 Mar 2020 14:55:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200325191830.16553-1-f4bug@amsat.org>
 <20200325191830.16553-13-f4bug@amsat.org>
In-Reply-To: <20200325191830.16553-13-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 26 Mar 2020 21:55:32 +0000
Message-ID: <CAFEAcA-26fHbOp5saM+XBCz72fzfz+=+xtiXGRtWnc6CMoiakA@mail.gmail.com>
Subject: Re: [PATCH-for-5.0 12/12] hw/riscv/sifive_u: Add missing
 error-propagation code
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
Cc: Paul Burton <pburton@wavecomp.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm <qemu-arm@nongnu.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-ppc <qemu-ppc@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 25 Mar 2020 at 19:19, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> Running the coccinelle script produced:
>
>   $ spatch \
>     --macro-file scripts/cocci-macro-file.h --include-headers \
>     --sp-file scripts/coccinelle/object_property_missing_error_propagate.=
cocci \
>     --keep-comments --smpl-spacing --dir hw
>
>   [[manual check required: error_propagate() might be missing in object_p=
roperty_set_bool() hw/riscv/sifive_u.c:558:4]]
>   [[manual check required: error_propagate() might be missing in object_p=
roperty_set_bool() hw/riscv/sifive_u.c:561:4]]
>
> Add the missing error_propagate() after manual review.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/riscv/sifive_u.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index 56351c4faa..01e44018cd 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -473,113 +473,121 @@ static void riscv_sifive_u_machine_instance_init(=
Object *obj)
>  static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
>  {
>      MachineState *ms =3D MACHINE(qdev_get_machine());
>      SiFiveUSoCState *s =3D RISCV_U_SOC(dev);
>      const struct MemmapEntry *memmap =3D sifive_u_memmap;
>      MemoryRegion *system_memory =3D get_system_memory();
>      MemoryRegion *mask_rom =3D g_new(MemoryRegion, 1);
>      MemoryRegion *l2lim_mem =3D g_new(MemoryRegion, 1);
>      qemu_irq plic_gpios[SIFIVE_U_PLIC_NUM_SOURCES];
>      char *plic_hart_config;
>      size_t plic_hart_config_len;
>      int i;
>      Error *err =3D NULL;
>      NICInfo *nd =3D &nd_table[0];
>
>      object_property_set_bool(OBJECT(&s->e_cpus), true, "realized",
>                               &error_abort);
>      object_property_set_bool(OBJECT(&s->u_cpus), true, "realized",
>                               &error_abort);
>      /*
>       * The cluster must be realized after the RISC-V hart array containe=
r,
>       * as the container's CPU object is only created on realize, and the
>       * CPU must exist and have been parented into the cluster before the
>       * cluster is realized.
>       */
>      object_property_set_bool(OBJECT(&s->e_cluster), true, "realized",
>                               &error_abort);
>      object_property_set_bool(OBJECT(&s->u_cluster), true, "realized",
>                               &error_abort);

Different bug noticed in passing: these really ought not to be
using error_abort to realize things, as realize is a fairly
likely-to-fail operation on most objects (either now or in
the future if the object implementation changes).

>
>      /* boot rom */
>      memory_region_init_rom(mask_rom, OBJECT(dev), "riscv.sifive.u.mrom",
>                             memmap[SIFIVE_U_MROM].size, &error_fatal);
>      memory_region_add_subregion(system_memory, memmap[SIFIVE_U_MROM].bas=
e,
>                                  mask_rom);

>      object_property_set_bool(OBJECT(&s->prci), true, "realized", &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
>      sysbus_mmio_map(SYS_BUS_DEVICE(&s->prci), 0, memmap[SIFIVE_U_PRCI].b=
ase);
>
>      object_property_set_bool(OBJECT(&s->otp), true, "realized", &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }

The changes made in this patch are fine though:
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

