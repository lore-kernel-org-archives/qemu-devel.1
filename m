Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5740AC34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 13:09:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6D0822B48
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 13:09:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xtc0QHN9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6D0822B48
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j42dO-00072s-Jw
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 08:09:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41530)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j42Qg-0002m7-5b
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 07:56:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j42Qc-0007P4-A1
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 07:56:46 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28733
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j42Qc-0007Ot-42
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 07:56:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582030601;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xo7GhoWSu+0JZhdpTAlcqyTsDXMPEfltgowRkdddayw=;
 b=Xtc0QHN9E5J6KnKpmMSYjHQVSkidadom+W74A735jOm0lrNBJNcp/unc6y244zCZ0EeqDz
 OKjZNPtCdOcdVdW19bFNe3lFuyACAPzo/8SUnKXR/f06EOeecdmFTMtb0xywWfldejydNJ
 Mp7Twd3jAsFn+glW4eR6tzZC5PIA/zQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-426-E6tSpmULMIKtmBo8kLnWNA-1; Tue, 18 Feb 2020 07:56:39 -0500
Received: by mail-wr1-f72.google.com with SMTP id u18so10703470wrn.11
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 04:56:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dDEfDRppkMEtdhxdvB3n+Pqw6zJksUydJ235uk+LzQs=;
 b=j4fpAdhWhv6f1Qs2SdTMRKxoy9kA89luchREwT2Ngl/BdbRBurvWZC3gudrvl5zrpx
 aV3Q4RZVZQYt/3uLfILX+4+m3jmtGvQVkXdbLQ/Q9uJuSG+XL7Yk4ZMvj6eif3lhDU0F
 XMQTf19RqyL7muWEUX6sI4xoLNDUld4pWmLBz0oXI+DhyIWRHMlFKgWtc9ToFXC7Yngf
 iuRPdzkG31SIPzFv0gWRW7DzM8jVCkwj6dgSlXezOnwXTzu8tMlgyMFWPbi+quPj1BJU
 /hLVQpeEGzaoNa12SY+TzGF7UDEiNurREQilsaSWNz3Q6S3zBuUcjmrEbXcGbv8UmdEK
 ZCEw==
X-Gm-Message-State: APjAAAXawuylPnGUnza4AX8bWWmROjtPLaNwUIfOy6MokF3vCN1JJLQx
 QlFp62alKurxScqSWKGCTMCtvs/x1Ts4saoLD3/s28TzhVJ/tvGAoH0a8r7JI+TN3ATDzPQpm1l
 9P2Ay74lHTP/IiM0=
X-Received: by 2002:adf:dfcc:: with SMTP id q12mr28346391wrn.171.1582030597324; 
 Tue, 18 Feb 2020 04:56:37 -0800 (PST)
X-Google-Smtp-Source: APXvYqwmF02XnlrsX14M0LJEAiiDd2JNs1pz0z5yEMKv+K1yyBAgzgTOR2AqwKMGTWI+F6sNZJrEbg==
X-Received: by 2002:adf:dfcc:: with SMTP id q12mr28346347wrn.171.1582030596774; 
 Tue, 18 Feb 2020 04:56:36 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id x6sm6022286wrr.6.2020.02.18.04.56.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Feb 2020 04:56:36 -0800 (PST)
Subject: Re: [PATCH v2] Avoid address_space_rw() with a constant is_write
 argument
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20200218112457.22712-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f87dbeeb-2259-9eb9-45c7-a30819eec2ee@redhat.com>
Date: Tue, 18 Feb 2020 13:56:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200218112457.22712-1-peter.maydell@linaro.org>
Content-Language: en-US
X-MC-Unique: E6tSpmULMIKtmBo8kLnWNA-1
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/18/20 12:24 PM, Peter Maydell wrote:
> The address_space_rw() function allows either reads or writes
> depending on the is_write argument passed to it; this is useful
> when the direction of the access is determined programmatically
> (as for instance when handling the KVM_EXIT_MMIO exit reason).
> Under the hood it just calls either address_space_write() or
> address_space_read_full().
>=20
> We also use it a lot with a constant is_write argument, though,
> which has two issues:
>   * when reading "address_space_rw(..., 1)" this is less
>     immediately clear to the reader as being a write than
>     "address_space_write(...)"
>   * calling address_space_rw() bypasses the optimization
>     in address_space_read() that fast-paths reads of a
>     fixed length
>=20
> This commit was produced with the included Coccinelle script
> scripts/coccinelle/as-rw-const.patch.
>=20
> Two lines in hw/net/dp8393x.c that Coccinelle produced that
> were over 80 characters were re-wrapped by hand.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> I could break this down into separate patches by submaintainer,
> but the patch is not that large and I would argue that it's
> better for the project if we can try to avoid introducing too
> much friction into the process of doing 'safe' tree-wide
> minor refactorings.
>=20
> v1->v2: put the coccinelle script in scripts/coccinelle rather
> than just in the commit message.
> ---
>   accel/kvm/kvm-all.c                  |  6 +--
>   dma-helpers.c                        |  4 +-
>   exec.c                               |  4 +-
>   hw/dma/xlnx-zdma.c                   | 11 ++---
>   hw/net/dp8393x.c                     | 68 ++++++++++++++--------------
>   hw/net/i82596.c                      | 25 +++++-----
>   hw/net/lasi_i82596.c                 |  5 +-
>   hw/ppc/pnv_lpc.c                     |  8 ++--
>   hw/s390x/css.c                       | 12 ++---
>   qtest.c                              | 52 ++++++++++-----------
>   target/i386/hvf/x86_mmu.c            | 12 ++---
>   scripts/coccinelle/as_rw_const.cocci | 30 ++++++++++++
>   12 files changed, 133 insertions(+), 104 deletions(-)
>   create mode 100644 scripts/coccinelle/as_rw_const.cocci
>=20
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index c111312dfdd..0cfe6fd8ded 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -2178,9 +2178,9 @@ void kvm_flush_coalesced_mmio_buffer(void)
>               ent =3D &ring->coalesced_mmio[ring->first];
>  =20
>               if (ent->pio =3D=3D 1) {
> -                address_space_rw(&address_space_io, ent->phys_addr,
> -                                 MEMTXATTRS_UNSPECIFIED, ent->data,
> -                                 ent->len, true);
> +                address_space_write(&address_space_io, ent->phys_addr,
> +                                    MEMTXATTRS_UNSPECIFIED, ent->data,
> +                                    ent->len);
>               } else {
>                   cpu_physical_memory_write(ent->phys_addr, ent->data, en=
t->len);
>               }
> diff --git a/dma-helpers.c b/dma-helpers.c
> index d3871dc61ea..e8a26e81e16 100644
> --- a/dma-helpers.c
> +++ b/dma-helpers.c
> @@ -28,8 +28,8 @@ int dma_memory_set(AddressSpace *as, dma_addr_t addr, u=
int8_t c, dma_addr_t len)
>       memset(fillbuf, c, FILLBUF_SIZE);
>       while (len > 0) {
>           l =3D len < FILLBUF_SIZE ? len : FILLBUF_SIZE;
> -        error |=3D address_space_rw(as, addr, MEMTXATTRS_UNSPECIFIED,
> -                                  fillbuf, l, true);
> +        error |=3D address_space_write(as, addr, MEMTXATTRS_UNSPECIFIED,
> +                                     fillbuf, l);
>           len -=3D l;
>           addr +=3D l;
>       }
> diff --git a/exec.c b/exec.c
> index 8e9cc3b47cf..baefe582393 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -3810,8 +3810,8 @@ int cpu_memory_rw_debug(CPUState *cpu, target_ulong=
 addr,
>               address_space_write_rom(cpu->cpu_ases[asidx].as, phys_addr,
>                                       attrs, buf, l);
>           } else {
> -            address_space_rw(cpu->cpu_ases[asidx].as, phys_addr,
> -                             attrs, buf, l, 0);
> +            address_space_read(cpu->cpu_ases[asidx].as, phys_addr, attrs=
, buf,
> +                               l);
>           }
>           len -=3D l;
>           buf +=3D l;
> diff --git a/hw/dma/xlnx-zdma.c b/hw/dma/xlnx-zdma.c
> index 8fb83f5b078..31936061e21 100644
> --- a/hw/dma/xlnx-zdma.c
> +++ b/hw/dma/xlnx-zdma.c
> @@ -311,8 +311,7 @@ static bool zdma_load_descriptor(XlnxZDMA *s, uint64_=
t addr, void *buf)
>           return false;
>       }
>  =20
> -    address_space_rw(s->dma_as, addr, s->attr,
> -                     buf, sizeof(XlnxZDMADescr), false);
> +    address_space_read(s->dma_as, addr, s->attr, buf, sizeof(XlnxZDMADes=
cr));
>       return true;
>   }
>  =20
> @@ -364,7 +363,7 @@ static uint64_t zdma_update_descr_addr(XlnxZDMA *s, b=
ool type,
>       } else {
>           addr =3D zdma_get_regaddr64(s, basereg);
>           addr +=3D sizeof(s->dsc_dst);
> -        address_space_rw(s->dma_as, addr, s->attr, (void *) &next, 8, fa=
lse);
> +        address_space_read(s->dma_as, addr, s->attr, (void *)&next, 8);
>           zdma_put_regaddr64(s, basereg, next);
>       }
>       return next;
> @@ -416,8 +415,7 @@ static void zdma_write_dst(XlnxZDMA *s, uint8_t *buf,=
 uint32_t len)
>               }
>           }
>  =20
> -        address_space_rw(s->dma_as, s->dsc_dst.addr, s->attr, buf, dlen,
> -                         true);
> +        address_space_write(s->dma_as, s->dsc_dst.addr, s->attr, buf, dl=
en);
>           if (burst_type =3D=3D AXI_BURST_INCR) {
>               s->dsc_dst.addr +=3D dlen;
>           }
> @@ -493,8 +491,7 @@ static void zdma_process_descr(XlnxZDMA *s)
>                   len =3D s->cfg.bus_width / 8;
>               }
>           } else {
> -            address_space_rw(s->dma_as, src_addr, s->attr, s->buf, len,
> -                             false);
> +            address_space_read(s->dma_as, src_addr, s->attr, s->buf, len=
);
>               if (burst_type =3D=3D AXI_BURST_INCR) {
>                   src_addr +=3D len;
>               }
> diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
> index a134d431ae3..f5f1c669e80 100644
> --- a/hw/net/dp8393x.c
> +++ b/hw/net/dp8393x.c
> @@ -275,8 +275,8 @@ static void dp8393x_do_load_cam(dp8393xState *s)
>  =20
>       while (s->regs[SONIC_CDC] & 0x1f) {
>           /* Fill current entry */
> -        address_space_rw(&s->as, dp8393x_cdp(s),
> -            MEMTXATTRS_UNSPECIFIED, (uint8_t *)s->data, size, 0);
> +        address_space_read(&s->as, dp8393x_cdp(s), MEMTXATTRS_UNSPECIFIE=
D,
> +                           (uint8_t *)s->data, size);
>           s->cam[index][0] =3D dp8393x_get(s, width, 1) & 0xff;
>           s->cam[index][1] =3D dp8393x_get(s, width, 1) >> 8;
>           s->cam[index][2] =3D dp8393x_get(s, width, 2) & 0xff;
> @@ -293,8 +293,8 @@ static void dp8393x_do_load_cam(dp8393xState *s)
>       }
>  =20
>       /* Read CAM enable */
> -    address_space_rw(&s->as, dp8393x_cdp(s),
> -        MEMTXATTRS_UNSPECIFIED, (uint8_t *)s->data, size, 0);
> +    address_space_read(&s->as, dp8393x_cdp(s), MEMTXATTRS_UNSPECIFIED,
> +                       (uint8_t *)s->data, size);
>       s->regs[SONIC_CE] =3D dp8393x_get(s, width, 0);
>       DPRINTF("load cam done. cam enable mask 0x%04x\n", s->regs[SONIC_CE=
]);
>  =20
> @@ -311,8 +311,8 @@ static void dp8393x_do_read_rra(dp8393xState *s)
>       /* Read memory */
>       width =3D (s->regs[SONIC_DCR] & SONIC_DCR_DW) ? 2 : 1;
>       size =3D sizeof(uint16_t) * 4 * width;
> -    address_space_rw(&s->as, dp8393x_rrp(s),
> -        MEMTXATTRS_UNSPECIFIED, (uint8_t *)s->data, size, 0);
> +    address_space_read(&s->as, dp8393x_rrp(s), MEMTXATTRS_UNSPECIFIED,
> +                       (uint8_t *)s->data, size);
>  =20
>       /* Update SONIC registers */
>       s->regs[SONIC_CRBA0] =3D dp8393x_get(s, width, 0);
> @@ -426,8 +426,8 @@ static void dp8393x_do_transmit_packets(dp8393xState =
*s)
>           size =3D sizeof(uint16_t) * 6 * width;
>           s->regs[SONIC_TTDA] =3D s->regs[SONIC_CTDA];
>           DPRINTF("Transmit packet at %08x\n", dp8393x_ttda(s));
> -        address_space_rw(&s->as, dp8393x_ttda(s) + sizeof(uint16_t) * wi=
dth,
> -            MEMTXATTRS_UNSPECIFIED, (uint8_t *)s->data, size, 0);
> +        address_space_read(&s->as, dp8393x_ttda(s) + sizeof(uint16_t) * =
width,
> +                           MEMTXATTRS_UNSPECIFIED, (uint8_t *)s->data, s=
ize);
>           tx_len =3D 0;
>  =20
>           /* Update registers */
> @@ -451,17 +451,19 @@ static void dp8393x_do_transmit_packets(dp8393xStat=
e *s)
>               if (tx_len + len > sizeof(s->tx_buffer)) {
>                   len =3D sizeof(s->tx_buffer) - tx_len;
>               }
> -            address_space_rw(&s->as, dp8393x_tsa(s),
> -                MEMTXATTRS_UNSPECIFIED, &s->tx_buffer[tx_len], len, 0);
> +            address_space_read(&s->as, dp8393x_tsa(s), MEMTXATTRS_UNSPEC=
IFIED,
> +                               &s->tx_buffer[tx_len], len);
>               tx_len +=3D len;
>  =20
>               i++;
>               if (i !=3D s->regs[SONIC_TFC]) {
>                   /* Read next fragment details */
>                   size =3D sizeof(uint16_t) * 3 * width;
> -                address_space_rw(&s->as,
> -                    dp8393x_ttda(s) + sizeof(uint16_t) * (4 + 3 * i) * w=
idth,
> -                    MEMTXATTRS_UNSPECIFIED, (uint8_t *)s->data, size, 0)=
;
> +                address_space_read(&s->as,
> +                                   dp8393x_ttda(s)
> +                                   + sizeof(uint16_t) * (4 + 3 * i) * wi=
dth,
> +                                   MEMTXATTRS_UNSPECIFIED, (uint8_t *)s-=
>data,
> +                                   size);
>                   s->regs[SONIC_TSA0] =3D dp8393x_get(s, width, 0);
>                   s->regs[SONIC_TSA1] =3D dp8393x_get(s, width, 1);
>                   s->regs[SONIC_TFS] =3D dp8393x_get(s, width, 2);
> @@ -494,18 +496,18 @@ static void dp8393x_do_transmit_packets(dp8393xStat=
e *s)
>           dp8393x_put(s, width, 0,
>                       s->regs[SONIC_TCR] & 0x0fff); /* status */
>           size =3D sizeof(uint16_t) * width;
> -        address_space_rw(&s->as,
> -            dp8393x_ttda(s),
> -            MEMTXATTRS_UNSPECIFIED, (uint8_t *)s->data, size, 1);
> +        address_space_write(&s->as, dp8393x_ttda(s), MEMTXATTRS_UNSPECIF=
IED,
> +                            (uint8_t *)s->data, size);
>  =20
>           if (!(s->regs[SONIC_CR] & SONIC_CR_HTX)) {
>               /* Read footer of packet */
>               size =3D sizeof(uint16_t) * width;
> -            address_space_rw(&s->as,
> -                dp8393x_ttda(s) +
> -                             sizeof(uint16_t) *
> -                             (4 + 3 * s->regs[SONIC_TFC]) * width,
> -                MEMTXATTRS_UNSPECIFIED, (uint8_t *)s->data, size, 0);
> +            address_space_read(&s->as,
> +                               dp8393x_ttda(s)
> +                               + sizeof(uint16_t) * (4 + 3 * s->regs[SON=
IC_TFC])
> +                               * width,
> +                               MEMTXATTRS_UNSPECIFIED, (uint8_t *)s->dat=
a,
> +                               size);
>               s->regs[SONIC_CTDA] =3D dp8393x_get(s, width, 0) & ~0x1;
>               if (dp8393x_get(s, width, 0) & 0x1) {
>                   /* EOL detected */
> @@ -767,8 +769,8 @@ static ssize_t dp8393x_receive(NetClientState *nc, co=
nst uint8_t * buf,
>           /* Are we still in resource exhaustion? */
>           size =3D sizeof(uint16_t) * 1 * width;
>           address =3D dp8393x_crda(s) + sizeof(uint16_t) * 5 * width;
> -        address_space_rw(&s->as, address, MEMTXATTRS_UNSPECIFIED,
> -                         (uint8_t *)s->data, size, 0);
> +        address_space_read(&s->as, address, MEMTXATTRS_UNSPECIFIED,
> +                           (uint8_t *)s->data, size);
>           if (dp8393x_get(s, width, 0) & 0x1) {
>               /* Still EOL ; stop reception */
>               return -1;
> @@ -787,11 +789,11 @@ static ssize_t dp8393x_receive(NetClientState *nc, =
const uint8_t * buf,
>       /* Put packet into RBA */
>       DPRINTF("Receive packet at %08x\n", dp8393x_crba(s));
>       address =3D dp8393x_crba(s);
> -    address_space_rw(&s->as, address,
> -        MEMTXATTRS_UNSPECIFIED, (uint8_t *)buf, rx_len, 1);
> +    address_space_write(&s->as, address, MEMTXATTRS_UNSPECIFIED,
> +                        (uint8_t *)buf, rx_len);
>       address +=3D rx_len;
> -    address_space_rw(&s->as, address,
> -        MEMTXATTRS_UNSPECIFIED, (uint8_t *)&checksum, 4, 1);
> +    address_space_write(&s->as, address, MEMTXATTRS_UNSPECIFIED,
> +                        (uint8_t *)&checksum, 4);
>       rx_len +=3D 4;
>       s->regs[SONIC_CRBA1] =3D address >> 16;
>       s->regs[SONIC_CRBA0] =3D address & 0xffff;
> @@ -819,13 +821,13 @@ static ssize_t dp8393x_receive(NetClientState *nc, =
const uint8_t * buf,
>       dp8393x_put(s, width, 3, s->regs[SONIC_TRBA1]); /* pkt_ptr1 */
>       dp8393x_put(s, width, 4, s->regs[SONIC_RSC]); /* seq_no */
>       size =3D sizeof(uint16_t) * 5 * width;
> -    address_space_rw(&s->as, dp8393x_crda(s),
> -        MEMTXATTRS_UNSPECIFIED, (uint8_t *)s->data, size, 1);
> +    address_space_write(&s->as, dp8393x_crda(s), MEMTXATTRS_UNSPECIFIED,
> +                        (uint8_t *)s->data, size);
>  =20
>       /* Move to next descriptor */
>       size =3D sizeof(uint16_t) * width;
> -    address_space_rw(&s->as, dp8393x_crda(s) + sizeof(uint16_t) * 5 * wi=
dth,
> -        MEMTXATTRS_UNSPECIFIED, (uint8_t *)s->data, size, 0);
> +    address_space_read(&s->as, dp8393x_crda(s) + sizeof(uint16_t) * 5 * =
width,
> +                       MEMTXATTRS_UNSPECIFIED, (uint8_t *)s->data, size)=
;
>       s->regs[SONIC_LLFA] =3D dp8393x_get(s, width, 0);
>       if (s->regs[SONIC_LLFA] & 0x1) {
>           /* EOL detected */
> @@ -838,8 +840,8 @@ static ssize_t dp8393x_receive(NetClientState *nc, co=
nst uint8_t * buf,
>               offset +=3D sizeof(uint16_t);
>           }
>           s->data[0] =3D 0;
> -        address_space_rw(&s->as, offset, MEMTXATTRS_UNSPECIFIED,
> -                         (uint8_t *)s->data, sizeof(uint16_t), 1);
> +        address_space_write(&s->as, offset, MEMTXATTRS_UNSPECIFIED,
> +                            (uint8_t *)s->data, sizeof(uint16_t));
>           s->regs[SONIC_CRDA] =3D s->regs[SONIC_LLFA];
>           s->regs[SONIC_ISR] |=3D SONIC_ISR_PKTRX;
>           s->regs[SONIC_RSC] =3D (s->regs[SONIC_RSC] & 0xff00) | (((s->re=
gs[SONIC_RSC] & 0x00ff) + 1) & 0x00ff);
> diff --git a/hw/net/i82596.c b/hw/net/i82596.c
> index 3a0e1ec4c05..6a80c24af23 100644
> --- a/hw/net/i82596.c
> +++ b/hw/net/i82596.c
> @@ -148,8 +148,8 @@ static void i82596_transmit(I82596State *s, uint32_t =
addr)
>  =20
>           if (s->nic && len) {
>               assert(len <=3D sizeof(s->tx_buffer));
> -            address_space_rw(&address_space_memory, tba,
> -                MEMTXATTRS_UNSPECIFIED, s->tx_buffer, len, 0);
> +            address_space_read(&address_space_memory, tba,
> +                               MEMTXATTRS_UNSPECIFIED, s->tx_buffer, len=
);
>               DBG(PRINT_PKTHDR("Send", &s->tx_buffer));
>               DBG(printf("Sending %d bytes\n", len));
>               qemu_send_packet(qemu_get_queue(s->nic), s->tx_buffer, len)=
;
> @@ -172,8 +172,8 @@ static void set_individual_address(I82596State *s, ui=
nt32_t addr)
>  =20
>       nc =3D qemu_get_queue(s->nic);
>       m =3D s->conf.macaddr.a;
> -    address_space_rw(&address_space_memory, addr + 8,
> -        MEMTXATTRS_UNSPECIFIED, m, ETH_ALEN, 0);
> +    address_space_read(&address_space_memory, addr + 8,
> +                       MEMTXATTRS_UNSPECIFIED, m, ETH_ALEN);
>       qemu_format_nic_info_str(nc, m);
>       trace_i82596_new_mac(nc->info_str);
>   }
> @@ -190,9 +190,8 @@ static void set_multicast_list(I82596State *s, uint32=
_t addr)
>       }
>       for (i =3D 0; i < mc_count; i++) {
>           uint8_t multicast_addr[ETH_ALEN];
> -        address_space_rw(&address_space_memory,
> -            addr + i * ETH_ALEN, MEMTXATTRS_UNSPECIFIED,
> -            multicast_addr, ETH_ALEN, 0);
> +        address_space_read(&address_space_memory, addr + i * ETH_ALEN,
> +                           MEMTXATTRS_UNSPECIFIED, multicast_addr, ETH_A=
LEN);
>           DBG(printf("Add multicast entry " MAC_FMT "\n",
>                       MAC_ARG(multicast_addr)));
>           unsigned mcast_idx =3D (net_crc32(multicast_addr, ETH_ALEN) &
> @@ -260,8 +259,8 @@ static void command_loop(I82596State *s)
>               byte_cnt =3D MAX(byte_cnt, 4);
>               byte_cnt =3D MIN(byte_cnt, sizeof(s->config));
>               /* copy byte_cnt max. */
> -            address_space_rw(&address_space_memory, s->cmd_p + 8,
> -                MEMTXATTRS_UNSPECIFIED, s->config, byte_cnt, 0);
> +            address_space_read(&address_space_memory, s->cmd_p + 8,
> +                               MEMTXATTRS_UNSPECIFIED, s->config, byte_c=
nt);
>               /* config byte according to page 35ff */
>               s->config[2] &=3D 0x82; /* mask valid bits */
>               s->config[2] |=3D 0x40;
> @@ -640,14 +639,14 @@ ssize_t i82596_receive(NetClientState *nc, const ui=
nt8_t *buf, size_t sz)
>               }
>               rba =3D get_uint32(rbd + 8);
>               /* printf("rba is 0x%x\n", rba); */
> -            address_space_rw(&address_space_memory, rba,
> -                MEMTXATTRS_UNSPECIFIED, (void *)buf, num, 1);
> +            address_space_write(&address_space_memory, rba,
> +                                MEMTXATTRS_UNSPECIFIED, (void *)buf, num=
);
>               rba +=3D num;
>               buf +=3D num;
>               len -=3D num;
>               if (len =3D=3D 0) { /* copy crc */
> -                address_space_rw(&address_space_memory, rba - 4,
> -                    MEMTXATTRS_UNSPECIFIED, crc_ptr, 4, 1);
> +                address_space_write(&address_space_memory, rba - 4,
> +                                    MEMTXATTRS_UNSPECIFIED, crc_ptr, 4);
>               }
>  =20
>               num |=3D 0x4000; /* set F BIT */
> diff --git a/hw/net/lasi_i82596.c b/hw/net/lasi_i82596.c
> index 427b3fbf701..52637a562d8 100644
> --- a/hw/net/lasi_i82596.c
> +++ b/hw/net/lasi_i82596.c
> @@ -55,8 +55,9 @@ static void lasi_82596_mem_write(void *opaque, hwaddr a=
ddr,
>            * Provided for SeaBIOS only. Write MAC of Network card to addr=
 @val.
>            * Needed for the PDC_LAN_STATION_ID_READ PDC call.
>            */
> -        address_space_rw(&address_space_memory, val,
> -            MEMTXATTRS_UNSPECIFIED, d->state.conf.macaddr.a, ETH_ALEN, 1=
);
> +        address_space_write(&address_space_memory, val,
> +                            MEMTXATTRS_UNSPECIFIED, d->state.conf.macadd=
r.a,
> +                            ETH_ALEN);
>           break;
>       }
>   }
> diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
> index 5989d723c50..f150deca340 100644
> --- a/hw/ppc/pnv_lpc.c
> +++ b/hw/ppc/pnv_lpc.c
> @@ -238,16 +238,16 @@ static bool opb_read(PnvLpcController *lpc, uint32_=
t addr, uint8_t *data,
>                        int sz)
>   {
>       /* XXX Handle access size limits and FW read caching here */
> -    return !address_space_rw(&lpc->opb_as, addr, MEMTXATTRS_UNSPECIFIED,
> -                             data, sz, false);
> +    return !address_space_read(&lpc->opb_as, addr, MEMTXATTRS_UNSPECIFIE=
D,
> +                               data, sz);
>   }
>  =20
>   static bool opb_write(PnvLpcController *lpc, uint32_t addr, uint8_t *da=
ta,
>                         int sz)
>   {
>       /* XXX Handle access size limits here */
> -    return !address_space_rw(&lpc->opb_as, addr, MEMTXATTRS_UNSPECIFIED,
> -                             data, sz, true);
> +    return !address_space_write(&lpc->opb_as, addr, MEMTXATTRS_UNSPECIFI=
ED,
> +                                data, sz);
>   }
>  =20
>   #define ECCB_CTL_READ           PPC_BIT(15)
> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
> index 844caab4082..0e0fccd050e 100644
> --- a/hw/s390x/css.c
> +++ b/hw/s390x/css.c
> @@ -874,18 +874,18 @@ static inline int ida_read_next_idaw(CcwDataStream =
*cds)
>           if (idaw_addr & 0x07 || !cds_ccw_addrs_ok(idaw_addr, 0, ccw_fmt=
1)) {
>               return -EINVAL; /* channel program check */
>           }
> -        ret =3D address_space_rw(&address_space_memory, idaw_addr,
> -                               MEMTXATTRS_UNSPECIFIED, (void *) &idaw.fm=
t2,
> -                               sizeof(idaw.fmt2), false);
> +        ret =3D address_space_read(&address_space_memory, idaw_addr,
> +                                 MEMTXATTRS_UNSPECIFIED, (void *)&idaw.f=
mt2,
> +                                 sizeof(idaw.fmt2));
>           cds->cda =3D be64_to_cpu(idaw.fmt2);
>       } else {
>           idaw_addr =3D cds->cda_orig + sizeof(idaw.fmt1) * cds->at_idaw;
>           if (idaw_addr & 0x03 || !cds_ccw_addrs_ok(idaw_addr, 0, ccw_fmt=
1)) {
>               return -EINVAL; /* channel program check */
>           }
> -        ret =3D address_space_rw(&address_space_memory, idaw_addr,
> -                               MEMTXATTRS_UNSPECIFIED, (void *) &idaw.fm=
t1,
> -                               sizeof(idaw.fmt1), false);
> +        ret =3D address_space_read(&address_space_memory, idaw_addr,
> +                                 MEMTXATTRS_UNSPECIFIED, (void *)&idaw.f=
mt1,
> +                                 sizeof(idaw.fmt1));
>           cds->cda =3D be64_to_cpu(idaw.fmt1);
>           if (cds->cda & 0x80000000) {
>               return -EINVAL; /* channel program check */
> diff --git a/qtest.c b/qtest.c
> index 12432f99cf4..328d674bcc8 100644
> --- a/qtest.c
> +++ b/qtest.c
> @@ -429,23 +429,23 @@ static void qtest_process_command(CharBackend *chr,=
 gchar **words)
>  =20
>           if (words[0][5] =3D=3D 'b') {
>               uint8_t data =3D value;
> -            address_space_rw(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED=
,
> -                             &data, 1, true);
> +            address_space_write(first_cpu->as, addr, MEMTXATTRS_UNSPECIF=
IED,
> +                                &data, 1);
>           } else if (words[0][5] =3D=3D 'w') {
>               uint16_t data =3D value;
>               tswap16s(&data);
> -            address_space_rw(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED=
,
> -                             (uint8_t *) &data, 2, true);
> +            address_space_write(first_cpu->as, addr, MEMTXATTRS_UNSPECIF=
IED,
> +                                (uint8_t *)&data, 2);
>           } else if (words[0][5] =3D=3D 'l') {
>               uint32_t data =3D value;
>               tswap32s(&data);
> -            address_space_rw(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED=
,
> -                             (uint8_t *) &data, 4, true);
> +            address_space_write(first_cpu->as, addr, MEMTXATTRS_UNSPECIF=
IED,
> +                                (uint8_t *)&data, 4);
>           } else if (words[0][5] =3D=3D 'q') {
>               uint64_t data =3D value;
>               tswap64s(&data);
> -            address_space_rw(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED=
,
> -                             (uint8_t *) &data, 8, true);
> +            address_space_write(first_cpu->as, addr, MEMTXATTRS_UNSPECIF=
IED,
> +                                (uint8_t *)&data, 8);
>           }
>           qtest_send_prefix(chr);
>           qtest_send(chr, "OK\n");
> @@ -463,22 +463,22 @@ static void qtest_process_command(CharBackend *chr,=
 gchar **words)
>  =20
>           if (words[0][4] =3D=3D 'b') {
>               uint8_t data;
> -            address_space_rw(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED=
,
> -                             &data, 1, false);
> +            address_space_read(first_cpu->as, addr, MEMTXATTRS_UNSPECIFI=
ED,
> +                               &data, 1);
>               value =3D data;
>           } else if (words[0][4] =3D=3D 'w') {
>               uint16_t data;
> -            address_space_rw(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED=
,
> -                             (uint8_t *) &data, 2, false);
> +            address_space_read(first_cpu->as, addr, MEMTXATTRS_UNSPECIFI=
ED,
> +                               (uint8_t *)&data, 2);
>               value =3D tswap16(data);
>           } else if (words[0][4] =3D=3D 'l') {
>               uint32_t data;
> -            address_space_rw(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED=
,
> -                             (uint8_t *) &data, 4, false);
> +            address_space_read(first_cpu->as, addr, MEMTXATTRS_UNSPECIFI=
ED,
> +                               (uint8_t *)&data, 4);
>               value =3D tswap32(data);
>           } else if (words[0][4] =3D=3D 'q') {
> -            address_space_rw(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED=
,
> -                             (uint8_t *) &value, 8, false);
> +            address_space_read(first_cpu->as, addr, MEMTXATTRS_UNSPECIFI=
ED,
> +                               (uint8_t *)&value, 8);
>               tswap64s(&value);
>           }
>           qtest_send_prefix(chr);
> @@ -498,8 +498,8 @@ static void qtest_process_command(CharBackend *chr, g=
char **words)
>           g_assert(len);
>  =20
>           data =3D g_malloc(len);
> -        address_space_rw(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
> -                         data, len, false);
> +        address_space_read(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED, =
data,
> +                           len);
>  =20
>           enc =3D g_malloc(2 * len + 1);
>           for (i =3D 0; i < len; i++) {
> @@ -524,8 +524,8 @@ static void qtest_process_command(CharBackend *chr, g=
char **words)
>           g_assert(ret =3D=3D 0);
>  =20
>           data =3D g_malloc(len);
> -        address_space_rw(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
> -                         data, len, false);
> +        address_space_read(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED, =
data,
> +                           len);
>           b64_data =3D g_base64_encode(data, len);
>           qtest_send_prefix(chr);
>           qtest_sendf(chr, "OK %s\n", b64_data);
> @@ -559,8 +559,8 @@ static void qtest_process_command(CharBackend *chr, g=
char **words)
>                   data[i] =3D 0;
>               }
>           }
> -        address_space_rw(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
> -                         data, len, true);
> +        address_space_write(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,=
 data,
> +                            len);
>           g_free(data);
>  =20
>           qtest_send_prefix(chr);
> @@ -582,8 +582,8 @@ static void qtest_process_command(CharBackend *chr, g=
char **words)
>           if (len) {
>               data =3D g_malloc(len);
>               memset(data, pattern, len);
> -            address_space_rw(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED=
,
> -                             data, len, true);
> +            address_space_write(first_cpu->as, addr, MEMTXATTRS_UNSPECIF=
IED,
> +                                data, len);
>               g_free(data);
>           }
>  =20
> @@ -616,8 +616,8 @@ static void qtest_process_command(CharBackend *chr, g=
char **words)
>               out_len =3D MIN(out_len, len);
>           }
>  =20
> -        address_space_rw(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
> -                         data, len, true);
> +        address_space_write(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,=
 data,
> +                            len);
>  =20
>           qtest_send_prefix(chr);
>           qtest_send(chr, "OK\n");
> diff --git a/target/i386/hvf/x86_mmu.c b/target/i386/hvf/x86_mmu.c
> index d5a0efe7188..ff016fc0145 100644
> --- a/target/i386/hvf/x86_mmu.c
> +++ b/target/i386/hvf/x86_mmu.c
> @@ -88,8 +88,8 @@ static bool get_pt_entry(struct CPUState *cpu, struct g=
pt_translation *pt,
>       }
>  =20
>       index =3D gpt_entry(pt->gva, level, pae);
> -    address_space_rw(&address_space_memory, gpa + index * pte_size(pae),
> -                     MEMTXATTRS_UNSPECIFIED, (uint8_t *)&pte, pte_size(p=
ae), 0);
> +    address_space_read(&address_space_memory, gpa + index * pte_size(pae=
),
> +                       MEMTXATTRS_UNSPECIFIED, (uint8_t *)&pte, pte_size=
(pae));
>  =20
>       pt->pte[level - 1] =3D pte;
>  =20
> @@ -238,8 +238,8 @@ void vmx_write_mem(struct CPUState *cpu, target_ulong=
 gva, void *data, int bytes
>           if (!mmu_gva_to_gpa(cpu, gva, &gpa)) {
>               VM_PANIC_EX("%s: mmu_gva_to_gpa %llx failed\n", __func__, g=
va);
>           } else {
> -            address_space_rw(&address_space_memory, gpa, MEMTXATTRS_UNSP=
ECIFIED,
> -                             data, copy, 1);
> +            address_space_write(&address_space_memory, gpa,
> +                                MEMTXATTRS_UNSPECIFIED, data, copy);
>           }
>  =20
>           bytes -=3D copy;
> @@ -259,8 +259,8 @@ void vmx_read_mem(struct CPUState *cpu, void *data, t=
arget_ulong gva, int bytes)
>           if (!mmu_gva_to_gpa(cpu, gva, &gpa)) {
>               VM_PANIC_EX("%s: mmu_gva_to_gpa %llx failed\n", __func__, g=
va);
>           }
> -        address_space_rw(&address_space_memory, gpa, MEMTXATTRS_UNSPECIF=
IED,
> -                         data, copy, 0);
> +        address_space_read(&address_space_memory, gpa, MEMTXATTRS_UNSPEC=
IFIED,
> +                           data, copy);
>  =20
>           bytes -=3D copy;
>           gva +=3D copy;
> diff --git a/scripts/coccinelle/as_rw_const.cocci b/scripts/coccinelle/as=
_rw_const.cocci
> new file mode 100644
> index 00000000000..30da707701b
> --- /dev/null
> +++ b/scripts/coccinelle/as_rw_const.cocci
> @@ -0,0 +1,30 @@
> +// Avoid uses of address_space_rw() with a constant is_write argument.
> +// Usage:
> +//  spatch --sp-file as-rw-const.spatch --dir . --in-place

Nitpick, script is now scripts/coccinelle/as_rw_const.cocci.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> +
> +@@
> +expression E1, E2, E3, E4, E5;
> +symbol false;
> +@@
> +
> +- address_space_rw(E1, E2, E3, E4, E5, false)
> ++ address_space_read(E1, E2, E3, E4, E5)
> +@@
> +expression E1, E2, E3, E4, E5;
> +@@
> +
> +- address_space_rw(E1, E2, E3, E4, E5, 0)
> ++ address_space_read(E1, E2, E3, E4, E5)
> +@@
> +expression E1, E2, E3, E4, E5;
> +symbol true;
> +@@
> +
> +- address_space_rw(E1, E2, E3, E4, E5, true)
> ++ address_space_write(E1, E2, E3, E4, E5)
> +@@
> +expression E1, E2, E3, E4, E5;
> +@@
> +
> +- address_space_rw(E1, E2, E3, E4, E5, 1)
> ++ address_space_write(E1, E2, E3, E4, E5)
>=20


