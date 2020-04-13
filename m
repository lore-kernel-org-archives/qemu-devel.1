Return-Path: <SRS0=kd+i=55=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A90C2BA19
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 18:12:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1B7620735
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 18:12:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pO/Ifq5M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1B7620735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jO3Z1-0006QM-4S
	for qemu-devel@archiver.kernel.org; Mon, 13 Apr 2020 14:12:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47763)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <rfried.dev@gmail.com>) id 1jO3Y4-0005SU-0p
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 14:11:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rfried.dev@gmail.com>) id 1jO3Y2-0006Ug-Ue
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 14:11:07 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:43450)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <rfried.dev@gmail.com>)
 id 1jO3Y2-0006US-OL; Mon, 13 Apr 2020 14:11:06 -0400
Received: by mail-oi1-x243.google.com with SMTP id j16so8116682oih.10;
 Mon, 13 Apr 2020 11:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=D2o7yS8lDP+9vZND/93mgvVi5n/zRoNMfS7bbRBUMcA=;
 b=pO/Ifq5M4VAeasoXLDg/vVog6X5HgXzNyQ0QuJ4qbkfMfECC1Pq3fdtQvfT1gQO//I
 BN8CUXiVXHiqvzZ2DmYoHsfpIy4txtf6qeNcGN4Eb/pIfRmnxHdaaHAKZl8lIvwcGbFk
 0SyBH3ADPGZg3BD8lAIuNhjYnDx8nVjfa4dAYMhHXWcJafMrZnDpzl3eLzUjphEtnJyx
 4vZPRLaMzt4zEtY6twBenhkOOH3Jfhxu7C3fnglOKJwyrWKlZGdb2gOmEuTrZlkEqUfj
 590tGHjN3Zq+yKgk1CDc8lhIOdtBw/weOHhIHuzO7rfJk6IrG4Pq708TJm6b6/OeFbdq
 9APg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=D2o7yS8lDP+9vZND/93mgvVi5n/zRoNMfS7bbRBUMcA=;
 b=TophCyFTfnNwheX0ArOdJj9F1zhpiSz0ur+5QgcecLgsAgwgpYKYBDGz/42Cy6YpBe
 p0wsCTyvMXrkct86agAd1hYysDm1FnXso488+tNGWavHtmaxtBmQHpgvpEhX+OHTUhKb
 0fUpnVixUs/ucsItVuytJxjjgTQoK4MPJZJEixnGxghzFCuUW91CRP7X0n0dRGefIf3/
 tR17p8T7sZTCDVzva12Eu05odKTdC2AcVQ0pKNrrGuKnqpa9a97cKd+XGJW6mtVVYaUs
 kcl4YKNcz0UZfy0+2xZaK8KrHt+Ik7bzgv+bJj0hrHUFsSg0OdNa3KG2r13f2xlZZAcw
 MvsQ==
X-Gm-Message-State: AGi0PuaiZ+90Qkxm4pw+OjbTk0hJbXHfTVdjSHO9qjkKsDzNwDzWYEvI
 LIIopnaDoTPefXKRM4cl6OWiQq+D8XwrH9AH2QI=
X-Google-Smtp-Source: APiQypLaXbywEhR68lkXtndaGn6jXVBJN5d5B7s3Rt4LUKmvB4/ZCiV6Hp+OaoWeKZ/CInfFoe4IOy1kZyKDh22+SrE=
X-Received: by 2002:aca:c691:: with SMTP id w139mr6985242oif.147.1586801465659; 
 Mon, 13 Apr 2020 11:11:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190615051559.13767-1-rfried.dev@gmail.com>
 <d87ea542-7ecc-4fb1-ac1d-929825d23a8a@redhat.com>
 <E1523CDB-895A-4EC7-908F-8A3A3717353C@gmail.com>
 <CAGi-RUJ_0LBfAe6eVXRrhqpW0EQH97TtdvjaQnXNY0Ts73zJCg@mail.gmail.com>
In-Reply-To: <CAGi-RUJ_0LBfAe6eVXRrhqpW0EQH97TtdvjaQnXNY0Ts73zJCg@mail.gmail.com>
From: Ramon Fried <rfried.dev@gmail.com>
Date: Mon, 13 Apr 2020 21:10:54 +0300
Message-ID: <CAGi-RU+aC=c8fZRRdCvSmxtcwhoCG5oAKES7DVDP037iBWy3zQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v3] net: cadence_gem: fix compilation error
 when debug is on
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, 
 qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 "open list:Xilinx Zynq" <qemu-arm@nongnu.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

False alarm, exact same patch was merged by someone else.

On Mon, Apr 13, 2020 at 8:55 PM Ramon Fried <rfried.dev@gmail.com> wrote:
>
> Hi.
> Just noticed that this patch didn't hit master.
> Got lost ?
>
> Thanks,
> Ramon.
>
> On Sat, Jun 15, 2019 at 9:16 AM Ramon Fried <rfried.dev@gmail.com> wrote:
> >
> >
> >
> > On June 15, 2019 8:38:35 AM GMT+03:00, "Philippe Mathieu-Daud=C3=A9" <p=
hilmd@redhat.com> wrote:
> > >Hi Ramon,
> > >
> > >On 6/15/19 7:15 AM, Ramon Fried wrote:
> > >> defining CADENCE_GEM_ERR_DEBUG causes compilation
> > >> errors, fix that.
> > >>
> > >> Signed-off-by: Ramon Fried <rfried.dev@gmail.com>
> > >> ---
> > >> v2: change %lx to HWADDR_PRIx and %lx to %zdx
> > >> v3: change %zdx to %zx
> > >>
> > >>  hw/net/cadence_gem.c | 6 +++---
> > >>  1 file changed, 3 insertions(+), 3 deletions(-)
> > >>
> > >> diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
> > >> index 7f63411430..ecee22525c 100644
> > >> --- a/hw/net/cadence_gem.c
> > >> +++ b/hw/net/cadence_gem.c
> > >> @@ -982,8 +982,8 @@ static ssize_t gem_receive(NetClientState *nc,
> > >const uint8_t *buf, size_t size)
> > >>              return -1;
> > >>          }
> > >>
> > >> -        DB_PRINT("copy %d bytes to 0x%x\n", MIN(bytes_to_copy,
> > >rxbufsize),
> > >> -                rx_desc_get_buffer(s->rx_desc[q]));
> > >> +        DB_PRINT("copy %d bytes to 0x%" HWADDR_PRIx "\n",
> > >MIN(bytes_to_copy, rxbufsize),
> > >> +                rx_desc_get_buffer(s, s->rx_desc[q]));
> > >>
> > >>          /* Copy packet data to emulated DMA buffer */
> > >>          address_space_write(&s->dma_as, rx_desc_get_buffer(s,
> > >s->rx_desc[q]) +
> > >> @@ -1156,7 +1156,7 @@ static void gem_transmit(CadenceGEMState *s)
> > >>              if (tx_desc_get_length(desc) > sizeof(tx_packet) -
> > >>                                                 (p - tx_packet)) {
> > >>                  DB_PRINT("TX descriptor @ 0x%x too large: size 0x%x
> > >space " \
> > >> -                         "0x%x\n", (unsigned)packet_desc_addr,
> > >> +                         "0x%zx\n", (unsigned)packet_desc_addr,
> > >>                           (unsigned)tx_desc_get_length(desc),
> > >>                           sizeof(tx_packet) - (p - tx_packet));
> > >>                  break;
> > >>
> > >
> > >I still get an error when trying to build on 32bit host with
> > >CADENCE_GEM_ERR_DEBUG enabled (pre-existing to your patch):
> > >
> > >  CC      hw/net/cadence_gem.o
> > >./hw/net/cadence_gem.c: In function 'gem_receive':
> > >./hw/net/cadence_gem.c:973:14: error: format '%ld' expects argument of
> > >type 'long int', but argument 4 has type 'size_t {aka unsigned int}'
> > >[-Werror=3Dformat=3D]
> > >    DB_PRINT("config bufsize: %d packet size: %ld\n", rxbufsize, size)=
;
> > >              ^
> > >./hw/net/cadence_gem.c:38:24: note: in definition of macro 'DB_PRINT'
> > >     fprintf(stderr, ## __VA_ARGS__); \
> > >                        ^
> > >cc1: all warnings being treated as errors
> > >./rules.mak:69: recipe for target 'hw/net/cadence_gem.o' failed
> > >make: *** [hw/net/cadence_gem.o] Error 1
> > >
> > >However the 64bit host is indeed fixed, so I'm fine with your patch:
> > >Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> > >Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> > >
> > >Regards,
> > >
> > >Phil.
> > Thanks!
> >
> > --
> > Sent from my Android device with K-9 Mail. Please excuse my brevity.

