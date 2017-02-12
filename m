Received: from eggs.gnu.org ([2001:4830:134:3::10]:37311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marex@denx.de>) id 1cd3IV-0000eg-7l
	for qemu-devel@nongnu.org; Sun, 12 Feb 2017 18:11:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marex@denx.de>) id 1cd3IS-0000oc-0s
	for qemu-devel@nongnu.org; Sun, 12 Feb 2017 18:11:11 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:57907)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marex@denx.de>) id 1cd3IR-0000na-NK
	for qemu-devel@nongnu.org; Sun, 12 Feb 2017 18:11:07 -0500
References: <1486925722-19264-1-git-send-email-juro.bystricky@intel.com>
From: Marek Vasut <marex@denx.de>
Message-ID: <702a1a80-b822-013e-89da-6d1ea503fde8@denx.de>
Date: Mon, 13 Feb 2017 00:10:59 +0100
MIME-Version: 1.0
In-Reply-To: <1486925722-19264-1-git-send-email-juro.bystricky@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] nios2: Add Altera JTAG UART emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juro Bystricky <juro.bystricky@intel.com>, qemu-devel@nongnu.org
Cc: crwulff@gmail.com, jurobystricky@hotmail.com, fred.konrad@greensocs.com

On 02/12/2017 07:55 PM, Juro Bystricky wrote:

Subject should contain [PATCH v5] ...

> Add the Altera JTAG UART model.
> 
> Hardware emulation based on:
> https://www.altera.com/en_US/pdfs/literature/ug/ug_embedded_ip.pdf
> (Please see "Register Map" on page 65)

[...]

> +static void altera_juart_write(void *opaque, hwaddr addr,
> +                       uint64_t value, unsigned int size)
> +{
> +    AlteraJUARTState *s = opaque;
> +    unsigned char c;
> +
> +    switch (addr) {
> +    case OFFSET_R_DATA:
> +        c = value & 0xFF;
> +        /*
> +         * We do not decrement the write fifo,
> +         * we "tranmsmit" instanteniously, CONTROL_WI always asserted

Nit, fix this comment (transmit, instantly) and it's alignment.

I don't quite understand what this comment is trying to tell me though.

> +         */
> +        s->jcontrol |= CONTROL_WI;
> +        s->jdata = c;
> +        qemu_chr_fe_write(&s->chr, &c, 1);
> +        altera_juart_update_irq(s);
> +        break;
> +
> +    case OFFSET_R_CONTROL:
> +        /* Only RE and WE are writable */
> +        value &= CONTROL_WMASK;
> +        s->jcontrol &= ~CONTROL_WMASK;
> +        s->jcontrol |= value;
> +
> +        /* Writing 1 to AC clears it to 0 */
> +        if (value & CONTROL_AC) {
> +            s->jcontrol &= ~CONTROL_AC;
> +        }
> +        altera_juart_update_irq(s);
> +        break;
> +    }
> +}

[...]

> +void altera_juart_create(int channel, const hwaddr addr, qemu_irq irq, uint32_t fifo_size)
> +{
> +    DeviceState *dev;
> +    SysBusDevice *bus;
> +    Chardev *chr;
> +    const char chr_name[] = "juart";
> +    char label[ARRAY_SIZE(chr_name) + 1];
> +
> +    dev = qdev_create(NULL, TYPE_ALTERA_JUART);
> +
> +    if (channel >= MAX_SERIAL_PORTS) {
> +        error_report("Only %d serial ports are supported by QEMU",
> +                     MAX_SERIAL_PORTS);
> +        exit(1);
> +    }
> +
> +    chr = serial_hds[channel];
> +    if (!chr) {
> +        snprintf(label, ARRAY_SIZE(label), "%s%d", chr_name, channel);
> +        chr = qemu_chr_new(label, "null");
> +        if (!chr) {
> +            error_report("Failed to assign serial port to altera %s", label);
> +            exit(1);
> +        }
> +    }
> +    qdev_prop_set_chr(dev, "chardev", chr);
> +
> +    /*
> +     * FIFO size can be set from 8 to 32,768 bytes.
> +     * Only powers of two are allowed.
> +     */
> +    if (fifo_size < 8 || fifo_size > 3276 || (fifo_size & ~(1 << ctz32(fifo_size)))) {

32768 , not 3276 ...

> +        error_report("juart%d: Invalid FIFO size. [%u]", channel, fifo_size);
> +        exit(1);
> +    }
> +
> +    qdev_prop_set_uint32(dev, "fifo-size", fifo_size);
> +    bus = SYS_BUS_DEVICE(dev);
> +    qdev_init_nofail(dev);
> +
> +    if (addr != (hwaddr)-1) {
> +        sysbus_mmio_map(bus, 0, addr);
> +    }
> +
> +    sysbus_connect_irq(bus, 0, irq);
> +}

[...]

> +typedef struct AlteraJUARTState {
> +    SysBusDevice busdev;
> +    MemoryRegion mmio;
> +    CharBackend chr;
> +    qemu_irq irq;
> +
> +    unsigned int rx_fifo_size;
> +    unsigned int rx_fifo_pos;
> +    unsigned int rx_fifo_len;
> +    uint32_t jdata;
> +    uint32_t jcontrol;
> +    uint8_t *rx_fifo;
> +} AlteraJUARTState;
> +
> +void altera_juart_create(int channel, const hwaddr addr, qemu_irq irq,
> +                                                        uint32_t fifo_size);

Fix the alignment here so it doesn't look so braindead, align under the
first open parenthesis.

> +#endif /* ALTERA_JUART_H */
> 


-- 
Best regards,
Marek Vasut
