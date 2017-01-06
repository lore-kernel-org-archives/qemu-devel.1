Received: from eggs.gnu.org ([2001:4830:134:3::10]:34826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pisa@cmp.felk.cvut.cz>) id 1cPRVp-0000Pk-GQ
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 05:12:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pisa@cmp.felk.cvut.cz>) id 1cPRVm-0002oO-8H
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 05:12:41 -0500
Received: from relay.felk.cvut.cz ([2001:718:2:1611:0:1:0:70]:64063)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pisa@cmp.felk.cvut.cz>) id 1cPRVl-0002mR-Ox
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 05:12:38 -0500
From: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Date: Fri, 6 Jan 2017 10:38:17 +0100
References: <148365854761.172.17519978648303772799@790289a7ca88>
In-Reply-To: <148365854761.172.17519978648303772799@790289a7ca88>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201701061038.18013.pisa@cmp.felk.cvut.cz>
Subject: Re: [Qemu-devel] [PATCH 0/6] CAN bus support for QEMU (SJA1000 PCI
 so far)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, stefanha@gmail.com, deniz.eren@icloud.com, socketcan@hartkopp.net, fred.konrad@greensocs.com

Hello all,

On Friday 06 of January 2017 00:22:28 no-reply@patchew.org wrote:
> Hi,
>
> Your series seems to have some coding style problems. See output below for
> more information:
>
> Message-id: cover.1483655893.git.pisa@cmp.felk.cvut.cz
> Subject: [Qemu-devel] [PATCH 0/6] CAN bus support for QEMU (SJA1000 PCI so
> far) Type: series

I have gone through patch style problems and reduced number
of problems.

Actual complete list attached to the end of the e-mail.

I would like to discuss/get feedback/suggestions for some
of reported problems

> WARNING: architecture specific defines should be avoided
> #117: FILE: hw/can/can_core.c:34:
> +#ifdef __linux__
>
> WARNING: architecture specific defines should be avoided
> #236: FILE: hw/can/can_core.c:153:
> +#ifdef __linux__
>
> WARNING: architecture specific defines should be avoided
> #1869: FILE: include/can/can_emu.h:45:
> +#if defined(__GNUC__) || defined(__linux__)

these parts are specific for connection to host system
SocketCAN support. Code is written such way that
the base infrastructure has no dependence on the host
system and providing multiple transports for other systems
or UDP/TCP should not be a problem. So I think that
limiting of these parts to Linux only is not a problem.
It is possible to move these to separate file in
the future, but can require to add some more functions
to the external interface so keeping in the core
is easier for now. __GNUC__ define is used to allow alignment
of data even on non-Linux system to match SocketCAN standard
but internally there is no dependence on that so for example
on WIndows with other C compiler it is not required

#if defined(__GNUC__) || defined(__linux__)
    #define QEMU_CAN_FRAME_DATA_ALIGN __attribute__((aligned(8)))
#else
    #define QEMU_CAN_FRAME_DATA_ALIGN
#endif

> ERROR: do not use C99 // comments
> #724: FILE: hw/can/can_sja1000.c:34:
> +// #define DEBUG_FILTER
>
> ERROR: do not use C99 // comments
> #1684: FILE: hw/can/can_sja1000.h:39:
> +//#define DEBUG_CAN

The DEBUG* defines can be helpful for development and it
seems that use of C99 // comments to disable these
is widely used practice in the QEMU

> ERROR: externs should be avoided in .c files
> #305: FILE: hw/can/can_core.c:222:
> +int can_bus_host_set_filters(CanBusClientState *,

This function is not used at the actual version and I am
not sure if it should get to the external API.
But it documents use of filters with SocketCAN
so that is why my weak preference is to keep it.

> WARNING: line over 80 characters
> #1199: FILE: hw/can/can_sja1000.c:509:
> +                s->statusB &= ~(3 << 2); /* Clear transmission complete status, */

How strict is a requirement for 80 characters in qemu?
If the slight overflow is caused by comment then I feel
better to keep comment descriptive than to short it and
moving comment above statement can lead to longer
functions bodies and worse reability, at least for me.
But if strict 80 chars are preferred I try that.

> WARNING: line over 80 characters
> #306: FILE: hw/can/can_core.c:223:
> +                             const struct qemu_can_filter *filters, size_t filters_cnt);
>
> WARNING: line over 80 characters
> #296: FILE: hw/can/can_core.c:213:
> +    CanBusHostConnectState *c = container_of(client, CanBusHostConnectState, bus_client);

Then there are function declarations and some code which
looks for me much worse readable when wrapped.
The length is caused mainly by attempt to provide
descriptive identifiers/types names. I personally
prefer uniqueness of the identifiers and descriptive
names above length. I have correct cases where width
is above 90 chars but left some warnings uncorrected.

Thanks for feedback in advance,

Pavel


Actual complete run of the series through scripts/checkpatch.pl


WARNING: architecture specific defines should be avoided
#117: FILE: hw/can/can_core.c:34:
+#ifdef __linux__

WARNING: architecture specific defines should be avoided
#236: FILE: hw/can/can_core.c:153:
+#ifdef __linux__

WARNING: line over 80 characters
#258: FILE: hw/can/can_core.c:175:
+    CanBusHostConnectState *c = container_of(client, CanBusHostConnectState, bus_client);

WARNING: line over 80 characters
#270: FILE: hw/can/can_core.c:187:
+    CanBusHostConnectState *c = container_of(client, CanBusHostConnectState, bus_client);

WARNING: line over 80 characters
#296: FILE: hw/can/can_core.c:213:
+    CanBusHostConnectState *c = container_of(client, CanBusHostConnectState, bus_client);

ERROR: externs should be avoided in .c files
#305: FILE: hw/can/can_core.c:222:
+int can_bus_host_set_filters(CanBusClientState *,

WARNING: line over 80 characters
#306: FILE: hw/can/can_core.c:223:
+                             const struct qemu_can_filter *filters, size_t filters_cnt);

WARNING: line over 80 characters
#309: FILE: hw/can/can_core.c:226:
+                             const struct qemu_can_filter *filters, size_t filters_cnt)

WARNING: line over 80 characters
#311: FILE: hw/can/can_core.c:228:
+    CanBusHostConnectState *c = container_of(client, CanBusHostConnectState, bus_client);

WARNING: line over 80 characters
#635: FILE: hw/can/can_pci.c:192:
+        VMSTATE_STRUCT(sja_state, CanPCIState, 0, vmstate_can_sja, CanSJA1000State),

ERROR: do not use C99 // comments
#724: FILE: hw/can/can_sja1000.c:34:
+// #define DEBUG_FILTER

WARNING: line over 80 characters
#919: FILE: hw/can/can_sja1000.c:229:
+        buff[++count] = (frame->can_id << 05) & 0xe0; /* ID.02~ID.00,x,x,x,x,x */

WARNING: line over 80 characters
#1096: FILE: hw/can/can_sja1000.c:406:
+                s->statusP &= ~(3 << 2); /* Clear transmission complete status, */

WARNING: line over 80 characters
#1199: FILE: hw/can/can_sja1000.c:509:
+                s->statusB &= ~(3 << 2); /* Clear transmission complete status, */

WARNING: line over 80 characters
#1221: FILE: hw/can/can_sja1000.c:531:
+                    printf(" %02X", s->rx_buff[(s->rxbuf_start + i) % SJA_RCV_BUF_LEN]);

WARNING: line over 80 characters
#1315: FILE: hw/can/can_sja1000.c:625:
+        case 8: /* Output control register, hardware related, not support now. */

WARNING: line over 80 characters
#1346: FILE: hw/can/can_sja1000.c:656:
+                temp = s->rx_buff[(s->rxbuf_start + addr - 16) % SJA_RCV_BUF_LEN];

ERROR: do not use C99 // comments
#1684: FILE: hw/can/can_sja1000.h:39:
+//#define DEBUG_CAN

WARNING: line over 80 characters
#1702: FILE: hw/can/can_sja1000.h:57:
+    uint8_t         interrupt_en;  /* PeliCAN, addr 4, Interrupt Enable register */

WARNING: line over 80 characters
#1703: FILE: hw/can/can_sja1000.h:58:
+    uint8_t         rxmsg_cnt;     /* PeliCAN, addr 29, RX message counter. DS-p49 */

WARNING: line over 80 characters
#1704: FILE: hw/can/can_sja1000.h:59:
+    uint8_t         rxbuf_start;   /* PeliCAN, addr 30, RX buffer start address, DS-p49 */

WARNING: line over 80 characters
#1705: FILE: hw/can/can_sja1000.h:60:
+    uint8_t         clock;         /* PeliCAN, addr 31, Clock Divider register, DS-p55 */

WARNING: line over 80 characters
#1719: FILE: hw/can/can_sja1000.h:74:
+    uint8_t         code;          /* BasicCAN, addr 4, Acceptance code register */

WARNING: line over 80 characters
#1720: FILE: hw/can/can_sja1000.h:75:
+    uint8_t         mask;          /* BasicCAN, addr 5, Acceptance mask register */

WARNING: line over 80 characters
#1765: FILE: hw/can/can_sja1000.h:120:
+/* ID bytes (11 bits in 0 and 1 or 16 bits in 0,1 and 13 bits in 2,3 (extended)) */

WARNING: architecture specific defines should be avoided
#1869: FILE: include/can/can_emu.h:45:
+#if defined(__GNUC__) || defined(__linux__)

total: 3 errors, 23 warnings, 1870 lines checked

/home/pi/patches/qemu/out/0001-CAN-bus-simple-SJA1000-PCI-card-emulation-for-QEMU.patch has style problems, please review.  If any of these errors
are false positives report them to the maintainer, see
CHECKPATCH in MAINTAINERS.
WARNING: line over 80 characters
#152: FILE: hw/can/can_kvaser_pci.c:121:
+static uint64_t kvaser_pci_s5920_io_read(void *opaque, hwaddr addr, unsigned size)

WARNING: line over 80 characters
#211: FILE: hw/can/can_kvaser_pci.c:180:
+static uint64_t kvaser_pci_xilinx_io_read(void *opaque, hwaddr addr, unsigned size)

WARNING: line over 80 characters
#310: FILE: hw/can/can_kvaser_pci.c:279:
+    pci_register_bar(&d->dev, /*BAR*/ 0, PCI_BASE_ADDRESS_SPACE_IO, &d->s5920_io);

WARNING: line over 80 characters
#312: FILE: hw/can/can_kvaser_pci.c:281:
+    pci_register_bar(&d->dev, /*BAR*/ 2, PCI_BASE_ADDRESS_SPACE_IO, &d->xilinx_io);

WARNING: line over 80 characters
#346: FILE: hw/can/can_kvaser_pci.c:315:
+        VMSTATE_STRUCT(sja_state, KvaserPCIState, 0, vmstate_can_sja, CanSJA1000State),

total: 0 errors, 5 warnings, 370 lines checked

/home/pi/patches/qemu/out/0002-CAN-bus-Kvaser-PCI-CAN-S-single-SJA1000-channel-emul.patch has style problems, please review.  If any of these errors
are false positives report them to the maintainer, see
CHECKPATCH in MAINTAINERS.
WARNING: line over 80 characters
#77: FILE: hw/can/can_pcm3680_pci.c:46:
+#define PCM3680i_PCI_VENDOR_ID1     0x13fe    /* the PCI device and vendor IDs */

WARNING: line over 80 characters
#120: FILE: hw/can/can_pcm3680_pci.c:89:
+static uint64_t pcm3680i_pci_sja1_io_read(void *opaque, hwaddr addr, unsigned size)

WARNING: line over 80 characters
#145: FILE: hw/can/can_pcm3680_pci.c:114:
+static uint64_t pcm3680i_pci_sja2_io_read(void *opaque, hwaddr addr, unsigned size)

WARNING: line over 80 characters
#258: FILE: hw/can/can_pcm3680_pci.c:227:
+    pci_register_bar(&d->dev, /*BAR*/ 0, PCI_BASE_ADDRESS_SPACE_IO, &d->sja_io[0]);

WARNING: line over 80 characters
#259: FILE: hw/can/can_pcm3680_pci.c:228:
+    pci_register_bar(&d->dev, /*BAR*/ 1, PCI_BASE_ADDRESS_SPACE_IO, &d->sja_io[1]);

total: 0 errors, 5 warnings, 321 lines checked

/home/pi/patches/qemu/out/0003-CAN-bus-PCM-3680I-PCI-dual-SJA1000-channel-emulation.patch has style problems, please review.  If any of these errors
are false positives report them to the maintainer, see
CHECKPATCH in MAINTAINERS.
total: 0 errors, 0 warnings, 39 lines checked

/home/pi/patches/qemu/out/0004-Fixed-IRQ-problem-for-CAN-device-can_pcm3680_pci.patch has no obvious style problems and is ready for submission.
total: 0 errors, 0 warnings, 19 lines checked

/home/pi/patches/qemu/out/0005-Minor-clean-up-of-can_pcm3680_pci.patch has no obvious style problems and is ready for submission.
WARNING: line over 80 characters
#77: FILE: hw/can/can_mioe3680_pci.c:46:
+#define MIOe3680_PCI_VENDOR_ID1     0x13fe    /* the PCI device and vendor IDs */

WARNING: line over 80 characters
#127: FILE: hw/can/can_mioe3680_pci.c:96:
+static uint64_t mioe3680_pci_sja1_io_read(void *opaque, hwaddr addr, unsigned size)

WARNING: line over 80 characters
#152: FILE: hw/can/can_mioe3680_pci.c:121:
+static uint64_t mioe3680_pci_sja2_io_read(void *opaque, hwaddr addr, unsigned size)

WARNING: line over 80 characters
#228: FILE: hw/can/can_mioe3680_pci.c:197:
+            error_report("Cannot connect CAN bus to host #1 device \"%s\"", d->host[0]);

WARNING: line over 80 characters
#235: FILE: hw/can/can_mioe3680_pci.c:204:
+            error_report("Cannot connect CAN bus to host #2 device \"%s\"", d->host[1]);

WARNING: line over 80 characters
#265: FILE: hw/can/can_mioe3680_pci.c:234:
+    pci_register_bar(&d->dev, /*BAR*/ 0, PCI_BASE_ADDRESS_SPACE_IO, &d->sja_io[0]);

WARNING: line over 80 characters
#266: FILE: hw/can/can_mioe3680_pci.c:235:
+    pci_register_bar(&d->dev, /*BAR*/ 1, PCI_BASE_ADDRESS_SPACE_IO, &d->sja_io[1]);

total: 0 errors, 7 warnings, 329 lines checked

/home/pi/patches/qemu/out/0006-CAN-bus-MIOe-3680-PCI-dual-SJA1000-channel-emulation.patch has style problems, please review.  If any of these errors
are false positives report them to the maintainer, see
CHECKPATCH in MAINTAINERS.
