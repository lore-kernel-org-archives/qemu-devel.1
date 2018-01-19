Received: from eggs.gnu.org ([2001:4830:134:3::10]:36625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ecaTW-00024B-40
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 12:29:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ecaTV-0000Ug-5n
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 12:29:10 -0500
References: <20180119132856.3786-1-lvivier@redhat.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <9bac8781-0582-63ba-8e2e-0820e65cc69b@ilande.co.uk>
Date: Fri, 19 Jan 2018 17:28:47 +0000
MIME-Version: 1.0
In-Reply-To: <20180119132856.3786-1-lvivier@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2] hw/char: remove legacy interface
 escc_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, Artyom Tarasenko <atar4qemu@gmail.com>, David Gibson <david@gibson.dropbear.id.au>

On 19/01/18 13:28, Laurent Vivier wrote:

> Move necessary stuff in escc.h and update type names.
> Remove slavio_serial_ms_kbd_init().
> Fix code style problems reported by checkpatch.pl
> Update mac_newworld, mac_oldworld and sun4m to use directly the
> QDEV interface.
> 
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
> v2: in sun4m, move comments about Slavio TTY close to
>      their qdev_prop_set_chr()

Ah okay perhaps I didn't express myself particularly well: what I was 
suggesting was moving the comment above both qdev_create()s rather than 
in the middle e.g.

   /* Slavio TTYA (base+4, Linux ttyS0) is the first QEMU serial device
      Slavio TTYB (base+0, Linux ttyS1) is the second QEMU serial device
    */
    dev = qdev_create(NULL, TYPE_ESCC);
    qdev_prop_set_uint32(dev, "disabled", !machine->enable_graphics);
    ...
    ...
    sysbus_mmio_map(s, 0, hwdef->ms_kb_base);

    dev = qdev_create(NULL, TYPE_ESCC);
    qdev_prop_set_uint32(dev, "disabled", 0);
    ...
    ...
    sysbus_mmio_map(s, 0, hwdef->serial_base);


instead of v1 which does:


    dev = qdev_create(NULL, TYPE_ESCC);
    qdev_prop_set_uint32(dev, "disabled", !machine->enable_graphics);
    ...
    ...
    sysbus_mmio_map(s, 0, hwdef->ms_kb_base);

   /* Slavio TTYA (base+4, Linux ttyS0) is the first QEMU serial device
      Slavio TTYB (base+0, Linux ttyS1) is the second QEMU serial device
    */
    dev = qdev_create(NULL, TYPE_ESCC);
    qdev_prop_set_uint32(dev, "disabled", 0);
    ...   ...
    sysbus_mmio_map(s, 0, hwdef->serial_base);



ATB,

Mark.
