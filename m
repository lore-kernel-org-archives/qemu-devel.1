Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B8DCA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 12:03:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9D99214B2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 12:03:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FFr2/9Dj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9D99214B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMst8-0007tG-R4
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 08:03:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49564)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iMsrx-0007HL-Io
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 08:02:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iMsrr-0000eB-D6
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 08:02:33 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:33178)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iMsrr-0000dt-5a
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 08:02:27 -0400
Received: by mail-ot1-x344.google.com with SMTP id 60so13922238otu.0
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 05:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/2RC2NHuCpuQjfTpSCpTJniz0x3ggU9ysyTPg2MZM40=;
 b=FFr2/9Dj8K7mgfoeLwg5Gh5etDV43QlVR1mrBg3cSQTlSSpXSF3p7mDrMJcqh1O43c
 hl6JvKEdT0jhWjEc94kbQbjCAKS/JHCSPYE5aEQquXexvzscN2/W1PihPiu5vWvxzTaX
 0PzwrHNH3E8widoZmMSEMOX3C9ct+A2ftgHrJ7nKLBv26eQfWSzJdLs6XI5qoYTJzMqN
 O5OYIAjdTcMxUiWwDCyIv4zXlIpepnUyDzkklZKUoedPC27DBUSn+zrSxFi6q1IyYJNj
 sGoEyTE8lY0NmOBOFNl8zBM3/Qdma9MkykcfCaKLCTIdzlyAkfYiWyIU900wj+TRK/BL
 kWEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/2RC2NHuCpuQjfTpSCpTJniz0x3ggU9ysyTPg2MZM40=;
 b=bEsfpsnio5zPP3Hvivbo0/hb1DmNYrCYsh6VCtL6HxR819LL2ECOXuHuq93ba+GwbB
 9+pgqIW3TH8cxMt7+iHEUmh/MSwFrsf++7fa+zl8QyoWX7pCuAGdHA1L9bP3zwINHYNo
 YvLx7aMmU8KF8MT4ZNleUgRREk30DOc4SS52Wm3crriTSCkZDbdx+Xgqv1QgVoEcgPO+
 2VzAFMYagqvPQnw/98rWnsajhk1OHC/rGTkc1OOcXdS1qU0JnAZqeOnfKSxrwqrgNg5U
 6yysWxuEH08Zv5LjYuxrTf+yi7YHG/cAMaRqwL6FcxtJzewC5EhG1cQKb3NqkhBAB0zy
 H/tQ==
X-Gm-Message-State: APjAAAUTFaikBYtfykGKLNP3FRiiMGUXPb5mySAmKQ+tJMQiWsdpRqJ+
 /Ho3irI0DX+qPjLwAwIF3m/4Sis0VNMf1DsYDDyYIg==
X-Google-Smtp-Source: APXvYqw4gAfrGSaI2B9sok3HlIVGmuFfrXbL6EXp8+cDpcUUOfU0Ciz/8svzf5oBto6NS/85+kLsgH3Gq+9ccDTjA6s=
X-Received: by 2002:a9d:708e:: with SMTP id l14mr2391409otj.135.1571745745559; 
 Tue, 22 Oct 2019 05:02:25 -0700 (PDT)
MIME-Version: 1.0
References: <20191019173801.939-1-svens@stackframe.org>
In-Reply-To: <20191019173801.939-1-svens@stackframe.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 Oct 2019 13:02:13 +0100
Message-ID: <CAFEAcA_2UN6wwGOowKCcDwr+ywA04q+qPsa-j05AH4webuysew@mail.gmail.com>
Subject: Re: [PATCH] net: add tulip (dec21143) driver
To: Sven Schnelle <svens@stackframe.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: Jason Wang <jasowang@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 19 Oct 2019 at 18:40, Sven Schnelle <svens@stackframe.org> wrote:
>
> This adds the basic functionality to emulate a Tulip NIC.
>
> Implemented are:
>
> - RX and TX functionality
> - Perfect Frame Filtering
> - Big/Little Endian descriptor support
> - 93C46 EEPROM support
> - LXT970 PHY
>
> Not implemented, mostly because i had no OS using these functions:
>
> - Imperfect frame filtering
> - General Purpose Timer
> - Transmit automatic polling
> - Boot ROM support
> - SIA interface
> - Big/Little Endian data buffer conversion
>
> Successfully tested with the following Operating Systems:
>
> - MSDOS with Microsoft Network Client 3.0 and DEC ODI drivers
> - HPPA Linux
> - Windows XP
> - HP-UX
>
> Signed-off-by: Sven Schnelle <svens@stackframe.org>
> ---

Thanks for this patch; I have some code review comments below;
nothing too difficult to address I think.

> diff --git a/hw/net/tulip.c b/hw/net/tulip.c
> new file mode 100644
> index 0000000000..a99b1b81c4
> --- /dev/null
> +++ b/hw/net/tulip.c
> @@ -0,0 +1,992 @@
> +/*
> + * QEMU TULIP Emulation
> + *
> + * Copyright (c) 2019 Sven Schnelle <svens@stackframe.org>
> + *
> + * This work is licensed under the GNU GPL license version 2 or later.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/log.h"
> +#include "hw/irq.h"
> +#include "hw/pci/pci.h"
> +#include "hw/qdev-properties.h"
> +#include "hw/nvram/eeprom93xx.h"
> +#include "migration/vmstate.h"
> +#include "sysemu/sysemu.h"
> +#include "tulip.h"
> +#include "trace.h"
> +#include "net/eth.h"
> +
> +typedef struct TULIPState {
> +    PCIDevice dev;
> +    MemoryRegion io;
> +    MemoryRegion memory;
> +    NICConf c;
> +    qemu_irq irq;
> +    NICState *nic;
> +    eeprom_t *eeprom;
> +    uint32_t csr[16];
> +
> +    /* state for MII */
> +    uint32_t old_csr9;
> +    uint32_t mii_word;
> +    uint32_t mii_bitcnt;
> +
> +    hwaddr current_rx_desc;
> +    hwaddr current_tx_desc;
> +
> +    uint8_t rx_frame[2048];
> +    uint8_t tx_frame[2048];
> +    uint16_t tx_frame_len;
> +    uint16_t rx_frame_len;
> +    uint16_t rx_frame_size;
> +
> +    uint32_t rx_status;
> +    uint8_t filter[16][6];
> +} TULIPState;
> +
> +static const VMStateDescription vmstate_pci_tulip = {
> +    .name = "tulip",
> +    .fields = (VMStateField[]) {
> +        VMSTATE_PCI_DEVICE(dev, TULIPState),
> +        VMSTATE_UINT32_ARRAY(csr, TULIPState, 16),
> +        VMSTATE_UINT32(old_csr9, TULIPState),
> +        VMSTATE_UINT32(mii_word, TULIPState),
> +        VMSTATE_UINT32(mii_bitcnt, TULIPState),
> +        VMSTATE_UINT64(current_rx_desc, TULIPState),
> +        VMSTATE_UINT64(current_tx_desc, TULIPState),

I wondered whether the device really maintained these as separate
persistent internal state from any of the guest-visible registers.
Checking the datasheet suggests it really does (eg if transmit
is suspended because we hit a descriptor owned by the host,
then the datasheet just says the guest can fix the ownership
and issue a poll-demand, so we must have to keep the address
of that descriptor in the device to retry it).

> +        VMSTATE_BUFFER(rx_frame, TULIPState),
> +        VMSTATE_BUFFER(tx_frame, TULIPState),
> +        VMSTATE_UINT16(rx_frame_len, TULIPState),
> +        VMSTATE_UINT16(tx_frame_len, TULIPState),
> +        VMSTATE_UINT16(rx_frame_size, TULIPState),
> +        VMSTATE_UINT32(rx_status, TULIPState),
> +        VMSTATE_UINT8_2DARRAY(filter, TULIPState, 16, 6),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static void tulip_desc_read(TULIPState *s, hwaddr p, void *buf)
> +{
> +        int i;
> +
> +        if (s->csr[0] & CSR0_DBO) {
> +            for (i = 0; i < sizeof(struct tulip_descriptor) / 4; i++) {
> +                ((uint32_t *)buf)[i] = ldl_be_pci_dma(&s->dev, p + (i << 2));
> +            }
> +        } else {
> +            for (i = 0; i < sizeof(struct tulip_descriptor) / 4; i++) {
> +                ((uint32_t *)buf)[i] = ldl_le_pci_dma(&s->dev, p + (i << 2));
> +            }
> +        }

Indentation in these functions seems wrong.

It looks like both tulip_desc_read() and tulip_desc_write()
always take a pointer to a struct tulip_descriptor and
are intended to either read or write exactly that much
data -- I think it would be better to use the right type in
the function, to indicate you can't pass in any old buffer.

Casting a void* to uint32_t* to write an integer into it risks
alignment issues. If you need to write a 32-bit value into a
possibly unaligned value then we have stl_p() for that (with
ldl_p() for the read). But better would be to just do four stores
to desc->status, ->control, ->buf_addr1 , buf_addr2 directly.
Then you don't need to mark the tulip_descriptor struct as being
atribute packed (attribute packed is often a bad idea -- among
other things it means there's no guarantee that the struct
is aligned at all, and the compiler may be forced to generate
bad code for accessing fields within it).

> +}
> +
> +static void tulip_desc_write(TULIPState *s, hwaddr p, const void *buf)
> +{
> +        int i;
> +
> +        if (s->csr[0] & CSR0_DBO) {
> +            for (i = 0; i < sizeof(struct tulip_descriptor) / 4; i++) {
> +                stl_be_pci_dma(&s->dev, p + (i << 2), ((uint32_t *)buf)[i]);
> +            }
> +        } else {
> +            for (i = 0; i < sizeof(struct tulip_descriptor) / 4; i++) {
> +                stl_le_pci_dma(&s->dev, p + (i << 2), ((uint32_t *)buf)[i]);
> +            }
> +        }
> +}
> +

> +static ssize_t _tulip_receive(TULIPState *s, const uint8_t *buf, size_t size)

Don't use function names starting with _, please. (These
are reserved.)

> +{
> +    struct tulip_descriptor desc;
> +
> +    trace_tulip_receive(buf, size);
> +
> +    if (size < 14 || size > 2048 || s->rx_frame_len || tulip_rx_stopped(s)) {
> +        return 0;
> +    }
> +
> +    if (!tulip_filter_address(s, buf)) {
> +        return size;
> +    }
> +
> +    do {
> +        tulip_desc_read(s, s->current_rx_desc, &desc);
> +        tulip_dump_rx_descriptor(s, &desc);
> +
> +        if (!(desc.status & RDES0_OWN)) {
> +            s->csr[5] |= CSR5_RU;
> +            tulip_update_int(s);
> +            return s->rx_frame_size - s->rx_frame_len;
> +        }
> +        desc.status = 0;
> +
> +        if (!s->rx_frame_len) {
> +            s->rx_frame_size = size + 4;
> +            s->rx_status = RDES0_LS |
> +                 ((s->rx_frame_size & RDES0_FL_MASK) << RDES0_FL_SHIFT);
> +            desc.status |= RDES0_FS;
> +            memcpy(s->rx_frame, buf, size);
> +            s->rx_frame_len = s->rx_frame_size;
> +        }
> +
> +        tulip_copy_rx_bytes(s, &desc);
> +
> +        if (!s->rx_frame_len) {
> +            desc.status |= s->rx_status;
> +            s->csr[5] |= CSR5_RI;
> +            tulip_update_int(s);
> +        }
> +        tulip_dump_rx_descriptor(s, &desc);
> +        tulip_desc_write(s, s->current_rx_desc, &desc);
> +        tulip_next_rx_descriptor(s, &desc);
> +    } while (s->rx_frame_len);
> +    return size;
> +}
> +
> +static ssize_t tulip_receive(NetClientState *nc,
> +                             const uint8_t *buf, size_t size)
> +{
> +    return _tulip_receive(qemu_get_nic_opaque(nc), buf, size);
> +}
> +

> +static void tulip_reset(TULIPState *s)
> +{
> +    trace_tulip_reset();
> +
> +    s->csr[0] = 0xfe000000;
> +    s->csr[1] = 0xffffffff;
> +    s->csr[2] = 0xffffffff;
> +    s->csr[5] = 0xf0000000;
> +    s->csr[6] = 0x32000040;
> +    s->csr[7] = 0xf3fe0000;
> +    s->csr[8] = 0xe0000000;
> +    s->csr[9] = 0xfff483ff;
> +    s->csr[11] = 0xfffe0000;
> +    s->csr[12] = 0x000000c6;
> +    s->csr[13] = 0xffff0000;
> +    s->csr[14] = 0xffffffff;
> +    s->csr[15] = 0x8ff00000;
> +    tulip_update_int(s);

Reset functions shouldn't do things that call qemu_set_irq();
they should only update the device's internal state. (So you'll
want a reset function to call from the "write to a register
asked for a device reset" codepath which does do the update_int,
and one which just updates the internal registers, to use
as the dc->reset method.)

> +}
> +
> +static void tulip_write(void *opaque, hwaddr addr,
> +                           uint64_t data, unsigned size)
> +{
> +    TULIPState *s = opaque;
> +    trace_tulip_reg_write(addr, tulip_reg_name(addr), size, data);
> +
> +    if (addr > CSR(15)) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: out of bound access\n", __func__);
> +        return;
> +    }
> +
> +
> +    switch (addr) {
> +    case CSR(0):
> +        s->csr[0] = data;
> +        if (data & CSR0_SWR) {
> +            tulip_reset(s);
> +        }
> +        break;
> +
> +    case CSR(3):
> +        s->csr[3] = data & ~3ULL;
> +        s->current_rx_desc = s->csr[3];
> +            /* fall through */
> +
> +    case CSR(2):
> +        qemu_flush_queued_packets(qemu_get_queue(s->nic));
> +        break;
> +
> +    case CSR(4):
> +        s->csr[4] = data & ~3ULL;
> +        s->current_tx_desc = s->csr[4];
> +            /* fall through */
> +
> +    case CSR(1):
> +        if (tulip_ts(s) == CSR5_TS_SUSPENDED) {
> +            tulip_xmit_list_update(s);
> +        }
> +        break;
> +
> +    case CSR(5):
> +        /* Status register, write clears bit */
> +        s->csr[5] &= ~(data & (CSR5_TI | CSR5_TPS | CSR5_TU | CSR5_TJT |
> +                               CSR5_LNP_ANC | CSR5_UNF | CSR5_RI | CSR5_RU |
> +                               CSR5_RPS | CSR5_RWT | CSR5_ETI | CSR5_GTE |
> +                               CSR5_LNF | CSR5_FBE | CSR5_ERI | CSR5_AIS |
> +                               CSR5_NIS | CSR5_GPI | CSR5_LC));
> +        tulip_update_int(s);
> +        break;
> +
> +    case CSR(6):
> +        s->csr[6] = data;
> +        if (s->csr[6] & CSR6_SR) {
> +            tulip_update_rs(s, CSR5_RS_RUNNING_WAIT_RECEIVE);
> +            qemu_flush_queued_packets(qemu_get_queue(s->nic));
> +        } else {
> +            tulip_update_rs(s, CSR5_RS_STOPPED);
> +        }
> +
> +        if (s->csr[6] & CSR6_ST) {
> +            tulip_update_ts(s, CSR5_TS_SUSPENDED);
> +            tulip_xmit_list_update(s);
> +        } else {
> +            tulip_update_ts(s, CSR5_TS_STOPPED);
> +        }
> +        break;
> +
> +    case CSR(7):
> +        s->csr[7] = data;
> +        tulip_update_int(s);
> +        break;
> +
> +    case CSR(9):
> +        tulip_csr9_write(s, s->csr[9], data);
> +        /* don't clear MII read data */
> +        s->csr[9] &= CSR9_MDI;
> +        s->csr[9] |= (data & ~CSR9_MDI);
> +        tulip_mii(s);
> +        s->old_csr9 = s->csr[9];
> +        break;
> +
> +    case CSR(12):
> +        /* SIA Status register, some bits are cleared by writing 1 */
> +        s->csr[12] &= ~(data & (CSR12_MRA | CSR12_TRA | CSR12_ARA));
> +        break;
> +
> +    default:
> +        s->csr[addr >> 3] = data;

Do you really want to fall through to this as default?
CSR(x) is x << 3, so CSR(0) is 0, CSR(1) is 8, and
if the guest does an access at address offset 4 then
you'll drop through to here and set s->csr[0] without
the special case handling in the CSR(0) case.

> +        break;
> +    }
> +}
> +
> +static const MemoryRegionOps tulip_ops = {
> +    .read = tulip_read,
> +    .write = tulip_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,

Do you need to specify .impl.min_access_size ? Otherwise
you'll get byte and halfword accesses as well as word accesses
(which is fine if you want to handle them in the read/write
functions, but it looks like you aren't.)

> +};
> +
> +static void tulip_idblock_crc(TULIPState *s, uint16_t *srom)
> +{
> +    int word, n;
> +    char bit;
> +    unsigned char bitval, crc;
> +    const int len = 9;
> +    n = 0;
> +    crc = -1;
> +
> +    for (word = 0; word < len; word++) {
> +        for (bit = 15; bit >= 0; bit--) {
> +            if ((word == (len - 1)) && (bit == 7)) {
> +                /*
> +                 * Insert the correct CRC result into input data stream
> +                 * in place.
> +                 */
> +                srom[len - 1] = (srom[len - 1] & 0xff00) | (unsigned short)crc;
> +                break;
> +            }
> +            n++;
> +            bitval = ((srom[word] >> bit) & 1) ^ ((crc >> 7) & 1);
> +            crc = crc << 1;
> +            if (bitval == 1) {
> +                crc ^= 6;
> +                crc |= 0x01;
> +            }
> +        }
> +    }
> +}
> +
> +static uint16_t tulip_srom_crc(TULIPState *s, uint8_t *eeprom, size_t len)
> +{
> +    unsigned long crc = 0xffffffff;
> +    unsigned long flippedcrc = 0;
> +    unsigned char currentbyte;
> +    unsigned int msb, bit, i;
> +
> +    for (i = 0; i < len; i++) {
> +        currentbyte = eeprom[i];
> +        for (bit = 0; bit < 8; bit++) {
> +            msb = (crc >> 31) & 1;
> +            crc <<= 1;
> +            if (msb ^ (currentbyte & 1)) {
> +                crc ^= 0x04c11db6;
> +                crc |= 0x00000001;
> +            }
> +            currentbyte >>= 1;
> +        }
> +    }
> +
> +    for (i = 0; i < 32; i++) {
> +        flippedcrc <<= 1;
> +        bit = crc & 1;
> +        crc >>= 1;
> +        flippedcrc += bit;
> +    }
> +    return (flippedcrc ^ 0xffffffff) & 0xffff;
> +}
> +
> +static const uint8_t eeprom_default[128] = {
> +    0x3c, 0x10, 0x4f, 0x10, 0x00, 0x00, 0x00, 0x00,
> +    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +    0x56, 0x08, 0x04, 0x01, 0x00, 0x80, 0x48, 0xb3,
> +    0x0e, 0xa7, 0x00, 0x1e, 0x00, 0x00, 0x00, 0x08,
> +    0x01, 0x8d, 0x03, 0x00, 0x00, 0x00, 0x00, 0x78,
> +    0xe0, 0x01, 0x00, 0x50, 0x00, 0x18, 0x00, 0x00,
> +    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xe8, 0x6b,
> +    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x80,
> +    0x48, 0xb3, 0x0e, 0xa7, 0x40, 0x00, 0x00, 0x00,
> +    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +};
> +
> +static void tulip_fill_eeprom(TULIPState *s)
> +{
> +    uint16_t *eeprom = eeprom93xx_data(s->eeprom);
> +    memcpy(eeprom, eeprom_default, 128);
> +
> +    /* patch in our mac address */
> +    eeprom[10] = cpu_to_le16(s->c.macaddr.a[0] | (s->c.macaddr.a[1] << 8));
> +    eeprom[11] = cpu_to_le16(s->c.macaddr.a[2] | (s->c.macaddr.a[3] << 8));
> +    eeprom[12] = cpu_to_le16(s->c.macaddr.a[4] | (s->c.macaddr.a[5] << 8));
> +    tulip_idblock_crc(s, eeprom);
> +    eeprom[63] = cpu_to_le16(tulip_srom_crc(s, (uint8_t *)eeprom, 126));
> +}
> +
> +static void pci_tulip_realize(PCIDevice *pci_dev, Error **errp)
> +{
> +    TULIPState *s = DO_UPCAST(TULIPState, dev, pci_dev);
> +    uint8_t *pci_conf;
> +
> +    pci_conf = s->dev.config;
> +    pci_conf[PCI_INTERRUPT_PIN] = 1; /* interrupt pin A */
> +
> +    s->eeprom = eeprom93xx_new(&pci_dev->qdev, 64);
> +    memory_region_init_io(&s->io, OBJECT(&s->dev), &tulip_ops, s,
> +            "tulip-io", 128);
> +
> +    memory_region_init_io(&s->memory, OBJECT(&s->dev), &tulip_ops, s,
> +            "tulip-mem", 128);
> +
> +    pci_register_bar(&s->dev, 0, PCI_BASE_ADDRESS_SPACE_IO, &s->io);
> +    pci_register_bar(&s->dev, 1, PCI_BASE_ADDRESS_SPACE_MEMORY, &s->memory);
> +
> +    s->irq = pci_allocate_irq(&s->dev);
> +
> +    qemu_macaddr_default_if_unset(&s->c.macaddr);
> +    tulip_fill_eeprom(s);
> +    tulip_reset(s);

Don't call reset in the realize function -- just set
the dc->reset pointer in the DeviceClass struct in
tulip_class_init(), and reset will be called for you.

> +
> +    s->nic = qemu_new_nic(&net_tulip_info, &s->c,
> +                          object_get_typename(OBJECT(pci_dev)),
> +                          pci_dev->qdev.id, s);
> +    qemu_format_nic_info_str(qemu_get_queue(s->nic), s->c.macaddr.a);
> +    tulip_reset(s);

...reset called again here?

> +}
> +
> +static void pci_tulip_exit(PCIDevice *pci_dev)
> +{
> +    TULIPState *s = DO_UPCAST(TULIPState, dev, pci_dev);
> +
> +    qemu_del_nic(s->nic);
> +    qemu_free_irq(s->irq);
> +    eeprom93xx_free(&pci_dev->qdev, s->eeprom);
> +}
> +
> +static void tulip_instance_init(Object *obj)
> +{
> +    PCIDevice *pci_dev = PCI_DEVICE(obj);
> +    TULIPState *d = DO_UPCAST(TULIPState, dev, pci_dev);
> +
> +    device_add_bootindex_property(obj, &d->c.bootindex,
> +                                  "bootindex", "/ethernet-phy@0",
> +                                  &pci_dev->qdev, NULL);
> +}
> +
> +static Property tulip_properties[] = {
> +    DEFINE_NIC_PROPERTIES(TULIPState, c),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void tulip_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
> +
> +    k->realize = pci_tulip_realize;
> +    k->exit = pci_tulip_exit;
> +    k->vendor_id = PCI_VENDOR_ID_DEC;
> +    k->device_id = PCI_DEVICE_ID_DEC_21143;
> +    k->subsystem_vendor_id = 0x103c;
> +    k->subsystem_id = 0x104f;
> +    k->class_id = PCI_CLASS_NETWORK_ETHERNET;
> +    dc->vmsd = &vmstate_pci_tulip;
> +    dc->props = tulip_properties;
> +    set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
> +}
> +
> +static const TypeInfo tulip_info = {
> +    .name          = "tulip",
> +    .parent        = TYPE_PCI_DEVICE,
> +    .instance_size = sizeof(TULIPState),
> +    .class_init    = tulip_class_init,
> +    .instance_init = tulip_instance_init,
> +    .interfaces = (InterfaceInfo[]) {
> +        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
> +        { },
> +    },
> +};

thanks
-- PMM

