Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D82EAC33C99
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 00:22:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAB91206DB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 00:22:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAB91206DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioz6v-0004BU-Ns
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 19:22:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49185)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fthain@telegraphics.com.au>) id 1ioz6J-0003J3-Ba
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 19:21:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fthain@telegraphics.com.au>) id 1ioz6H-0003aT-Rq
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 19:21:31 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:33308)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <fthain@telegraphics.com.au>)
 id 1ioz6H-0003Xp-N3; Tue, 07 Jan 2020 19:21:29 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
 by kvm5.telegraphics.com.au (Postfix) with ESMTP id 4BDB82A88E;
 Tue,  7 Jan 2020 19:21:22 -0500 (EST)
Date: Wed, 8 Jan 2020 11:21:24 +1100 (AEDT)
From: Finn Thain <fthain@telegraphics.com.au>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH v2 02/13] dp8393x: Clean up endianness hacks
In-Reply-To: <46e5c684-6fbb-fca2-82e5-d6c39a530c68@redhat.com>
Message-ID: <alpine.LNX.2.21.1.2001081033550.8@nippy.intranet>
References: <cover.1576815466.git.fthain@telegraphics.com.au>
 <e44d136b8b71414e17200bb1b7edfd94fe866705.1576815466.git.fthain@telegraphics.com.au>
 <alpine.LNX.2.21.1.2001061953150.65@nippy.intranet>
 <46e5c684-6fbb-fca2-82e5-d6c39a530c68@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 98.124.60.144
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
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>,
 =?ISO-8859-15?Q?Herv=E9_Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 7 Jan 2020, Philippe Mathieu-Daud? wrote:

> On 1/6/20 11:19 PM, Finn Thain wrote:
> > On Fri, 20 Dec 2019, Finn Thain wrote:
> > 
> > > The in_use field is no different to the other words handled using
> > > dp8393x_put() and dp8393x_get(). Use the same technique for in_use
> > > that is used everywhere else.
> > > 
> > > Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> > > ---
> > > Changed since v1:
> > >   - Use existing 'address' variable rather than declare a new one.
> > > 
> > > Laurent tells me that this clean-up has been tried before. He referred
> > > me to commit c744cf7879 ("dp8393x: fix dp8393x_receive()") and
> > > commit 409b52bfe1 ("net/dp8393x: correctly reset in_use field").
> > > 
> > > Both of those patches look wrong to me because they both pass the wrong
> > > byte count to address_space_rw(). It's possible that those patches were
> > > needed to work around some kind of bug elsewhere, for example, an
> > > off-by-one result from dp8393x_crda(). The preceding patch in this series
> > > might help there.
> > 
> > Unfortunately this patch really does break NetBSD/arc 5.1, just as
> > Laurent said it would, just as commit c744cf7879 did.
> > 
> > Yet these patches are correct. What gives?
> > 
> > I found that one more change can make guests work (for both m68k q800 and
> > mips64el magnum machines) --
> > 
> > --- a/hw/net/dp8393x.c
> > +++ b/hw/net/dp8393x.c
> > @@ -246,8 +246,10 @@ static void dp8393x_put(dp8393xState *s, int width,
> > int offset,
> >                           uint16_t val)
> >   {
> >       if (s->big_endian) {
> > +          s->data[offset * width] = 0;
> >           s->data[offset * width + width - 1] = cpu_to_be16(val);
> >       } else {
> > +          s->data[offset * width + width - 1] = 0;
> >           s->data[offset * width] = cpu_to_le16(val);
> >       }
> >   }
> > 
> > For a wide bus interface, this forces the Most Significant Word (MSW) to
> > zero. Yet another endianness hack, but it makes NetBSD 5.1 'sn' driver
> > happy.
> 
> Can you write a list of real word addresses/values/result expected for each
> endianess, so we can add a qtest for this?
> 

I'm afraid I've no idea how qtests work. If you are talking about a unit 
test for dp8393x.c, this would be non-trivial because you need to have the 
SONIC in bus master mode (i.e. you have to get the chip to do some DMA).

The chip datasheet says,

    Data Bus: These bidirectional lines are used to transfer data on the 
    system bus. When the SONIC is a bus master, 16-bit data is transferred 
    on D15-D0 and 32-bit data is transferred on D31-D0. When the SONIC is 
    accessed as a slave, register data is driven onto lines D15-D0. 
    D31-D16 are held TRI-STATE if SONIC is in 16-bit mode. If SONIC is in 
    32-bit mode, they are driven, but invalid.

The datasheet does not explicitly state that D31-D16 are held low during a 
DMA write, it just says they are "not used". But I'm beginning to think 
that forcing the MSW to zero (see above) is the right thing to do.

> > There is a similar issue with the Linux jazzsonic driver. This driver uses
> > long-word-sized loads with word-sized MMIO registers --
> > 
> > #define SONIC_READ(reg) (*((volatile unsigned int *)dev->base_addr+reg))
> > 
> > This driver also expects the MSW to be zero. But the MSW actually equals
> > the LSW, and the driver fails to probe:
> > 
> > SONIC ethernet controller not found (0x40004)
> > 
> > This seems to indicate that qemu-system-mips64el -M magnum is doing word
> > smearing on the processor bus. Does anyone know how to prevent that?
> 
> I remember a similar issue with another MIPS board because QEMU doesn't model
> the bus controller, which might do such magic.
> 

The bus slave situation relates to e.g. the Silicon Revision register 
access. This is what breaks the Linux jazzsonic driver.

In that situation, the datasheet says that D31-D16 are "driven, but 
invalid". I think the right fix for that is,

--- a/hw/net/dp8393x.c
+++ b/hw/net/dp8393x.c
@@ -695,8 +695,8 @@ static void dp8393x_write(void *opaque, hwaddr addr, 
uint64_t data,
 static const MemoryRegionOps dp8393x_ops = {
     .read = dp8393x_read,
     .write = dp8393x_write,
-    .impl.min_access_size = 2,
-    .impl.max_access_size = 2,
+    .impl.min_access_size = 4,
+    .impl.max_access_size = 4,
     .endianness = DEVICE_NATIVE_ENDIAN,
 };

This change seems to fix Linux/mipsel and break Linux/m68k, even though 
both use the chip in 32-bit mode... I guess there's another endianness 
bug somewhere.

> > 
> > > ---
> > >   hw/net/dp8393x.c | 17 ++++++-----------
> > >   1 file changed, 6 insertions(+), 11 deletions(-)
> > > 
> > > diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
> > > index 1957bd391e..b2cc768d9b 100644
> > > --- a/hw/net/dp8393x.c
> > > +++ b/hw/net/dp8393x.c
> > > @@ -765,8 +765,6 @@ static ssize_t dp8393x_receive(NetClientState *nc,
> > > const uint8_t * buf,
> > >           return -1;
> > >       }
> > >   -    /* XXX: Check byte ordering */
> > > -
> > >       /* Check for EOL */
> > >       if (s->regs[SONIC_LLFA] & SONIC_DESC_EOL) {
> > >           /* Are we still in resource exhaustion? */
> > > @@ -836,15 +834,12 @@ static ssize_t dp8393x_receive(NetClientState *nc,
> > > const uint8_t * buf,
> > >           /* EOL detected */
> > >           s->regs[SONIC_ISR] |= SONIC_ISR_RDE;
> > >       } else {
> > > -        /* Clear in_use, but it is always 16bit wide */
> > > -        int offset = dp8393x_crda(s) + sizeof(uint16_t) * 6 * width;
> > > -        if (s->big_endian && width == 2) {
> > > -            /* we need to adjust the offset of the 16bit field */
> > > -            offset += sizeof(uint16_t);
> > > -        }
> > > -        s->data[0] = 0;
> > > -        address_space_rw(&s->as, offset, MEMTXATTRS_UNSPECIFIED,
> > > -                         (uint8_t *)s->data, sizeof(uint16_t), 1);
> > > +        /* Clear in_use */
> > > +        address = dp8393x_crda(s) + sizeof(uint16_t) * 6 * width;
> > > +        size = sizeof(uint16_t) * width;
> > > +        dp8393x_put(s, width, 0, 0);
> > > +        address_space_rw(&s->as, address, MEMTXATTRS_UNSPECIFIED,
> > > +                         (uint8_t *)s->data, size, 1);
> > >           s->regs[SONIC_CRDA] = s->regs[SONIC_LLFA];
> > >           s->regs[SONIC_ISR] |= SONIC_ISR_PKTRX;
> > >           s->regs[SONIC_RSC] = (s->regs[SONIC_RSC] & 0xff00) |
> > > (((s->regs[SONIC_RSC] & 0x00ff) + 1) & 0x00ff);
> > > 
> > 
> 
> 

