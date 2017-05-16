Received: from eggs.gnu.org ([2001:4830:134:3::10]:39263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gm.ijewski@web.de>) id 1dAYHd-00081p-Mh
	for qemu-devel@nongnu.org; Tue, 16 May 2017 04:56:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gm.ijewski@web.de>) id 1dAYHc-00078C-Is
	for qemu-devel@nongnu.org; Tue, 16 May 2017 04:56:45 -0400
References: <757990479.60759.1494722527715.ref@mail.yahoo.com>
	<757990479.60759.1494722527715@mail.yahoo.com>
From: Geert Martin Ijewski <gm.ijewski@web.de>
Message-ID: <79d5c7a2-c5be-a4b3-3cc3-85c3e572d062@web.de>
Date: Tue, 16 May 2017 10:55:16 +0200
MIME-Version: 1.0
In-Reply-To: <757990479.60759.1494722527715@mail.yahoo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Changes to Broadcom(BCM) files and Raspberry Pi
 files. Addition of PanelEmu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Bradley <flypie1@yahoo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: John Bradley <flypie@rocketmail.com>, Laurent Vivier <lvivier@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, Markus Armbruster <armbru@redhat.com>, Alistair Francis <alistair.francis@xilinx.com>

Am 14.05.2017 um 02:42 schrieb John Bradley via Qemu-devel:
>>From 7f74f048f135d9c9c230a9e90f72451c841c6d35 Mon Sep 17 00:00:00 2001
> From: John Bradley <flypie@rocketmail.com>
> Date: Sat, 13 May 2017 23:07:47 +0100
> Subject: [PATCH] Changes to Broadcom(BCM) files and Raspberry Pi files.
> Addition of PanelEmu
>
> The files add the ability to attach, via TCP, a panel emulator
> The include a unification of several PD Raspberry PI additions
> A modification to dev-network to all circle SDK WWW client to work
> The DummyPanel is not included but available at
> https://github.com/flypie/GDummyPanel.git
>
> Signed-off-by: John Bradley <flypie@rocketmail.com>
> ---
> [ ... snip ... ]
> diff --git a/util/PanelEmu.c b/util/PanelEmu.c
> new file mode 100644
> index 0000000000..59c87d2747
> --- /dev/null
> +++ b/util/PanelEmu.c
> @@ -0,0 +1,293 @@
> +/*
> + * Emulation for Rasp PI GPIO via Server connected to via Socket
> + *
> + */
> +#include "qemu/osdep.h"
> +
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <memory.h>
> +#include <errno.h>
> +#include <string.h>
> +#include <sys/types.h>
> +#ifdef __MINGW32__
I think that should be #ifdef _WIN32.
Maybe in the far future QEMU could also be compiled with Visual Studio 
or any other windows compiler
> +#include <winsock2.h>
> +#else
> +#include <sys/socket.h>
> +#include <arpa/inet.h>
> +#include <netinet/in.h>
> +#endif
> +
> +
> +#include "qemu/PanelEmu.h"
> +
> +typedef enum
> +{
> +    MACHINEDESC = 0,
> +    PINSTOPANEL = 1,
> +    READREQ = 2,
> +    PINCOUNT = 3,
> +    ENABLEMAP = 4,
> +    INPUTMAP = 5,
> +    OUTPUTMAP = 6,
> +    PINSTOQEMU = 7
> +} PacketType;
> +
> +#define MAXPACKET   255
> +
> +#define PACKETLEN   0  //Includes Packet Length
> +#define PACKETTYPE  1
> +
> +typedef struct
> +{
> +    unsigned short int Data[MAXPACKET];
> +} CommandPacket;

Why not something like
typedef struct
{
     uint8_t len;
     uint8_t type;
     union {
         struct {
             uint8_t cnt;
         } pinCount;
         struct {
             uint16_t pin0to15;
             uint16_t pin16to31;
             uint16_t pin32to47;
             uint16_t pin48to63;
         } dataUpdate;
         /* todo: other packet types */
     };
} CommandPacket;
> [ ... snip ... ]
> +/* Set a pin to a specified value */
> +void senddatatopanel(panel_connection_t* h, uint64_t pin, bool val)
> +{
> +    CommandPacket Pkt;
> +
> +    Pkt.Data[PACKETLEN] = (char *) &Pkt.Data[6 + 1]-(char *) &Pkt.Data[0];
what's the use of this pointer aritmethic instead of just 6?

Geert
