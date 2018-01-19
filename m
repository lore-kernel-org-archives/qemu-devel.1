Received: from eggs.gnu.org ([2001:4830:134:3::10]:56738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pisa@cmp.felk.cvut.cz>) id 1ecSPV-0008H7-0d
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 03:52:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pisa@cmp.felk.cvut.cz>) id 1ecSPQ-0001Bb-4b
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 03:52:29 -0500
Received: from relay.felk.cvut.cz ([2001:718:2:1611:0:1:0:70]:65130)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pisa@cmp.felk.cvut.cz>) id 1ecSPP-0001B1-Ln
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 03:52:24 -0500
From: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Date: Fri, 19 Jan 2018 09:51:35 +0100
References: <cover.1515960078.git.pisa@cmp.felk.cvut.cz>
	<201801152229.53520.pisa@cmp.felk.cvut.cz>
	<04fbdf17-6431-5d67-6681-3cc0f375b32a@amsat.org>
In-Reply-To: <04fbdf17-6431-5d67-6681-3cc0f375b32a@amsat.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <201801190951.35681.pisa@cmp.felk.cvut.cz>
Subject: Re: [Qemu-devel] [PATCH V4 2/7] CAN bus support to connect bust to
 Linux host SocketCAN interface.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Marek Vasut <marex@denx.de>, Oliver Hartkopp <socketcan@hartkopp.net>, Stefan Hajnoczi <stefanha@gmail.com>, Deniz Eren <deniz.eren@icloud.com>, Oleksij Rempel <o.rempel@pengutronix.de>, Konrad Frederic <frederic.konrad@adacore.com>, Jan Kiszka <jan.kiszka@siemens.com>

Hello Philippe,

On Tuesday 16 of January 2018 01:12:09 Philippe Mathieu-Daud=C3=A9 wrote:
> On 01/15/2018 06:29 PM, Pavel Pisa wrote:
> > Hello Philippe,
> >
> > thanks for review.
> >
> > I have updated patch series in can-pci branch in
> >
> >   https://gitlab.fel.cvut.cz/canbus/qemu-canbus
> >
> > I would wait some day if there is some remark
> > from other developers and socket ones especially.
>
> I'll have a look.

if there are no more comments, I prepare version 5
of the patches at start of the next week.

Already implemented changes for version 5:

Assertions to check match to Linux struct can_frame
has been moved out of the function.
The case statements use ranges.
min_access_size=3D1 removed.
"for loops" are used to process operations
for the first and the second chip where
appropriate in PCM-3680I and MIOe-3680 patches.
Deniz Eren reported that updated version
works correctly.

I have not proceed with next two remarks yet:

Inlining in can_sja_single_filter and can_sja_dual_filter
functions. There is only single group of repeated four lines
of code which could be inlined, others are groups of two
lines each.=20

>     if (extended) {
vvvvvvvvvvvvvvv
>         filter->can_id =3D (uint32_t)acr[0] << 21;
>         filter->can_id |=3D (uint32_t)acr[1] << 13;
>         filter->can_id |=3D (uint32_t)acr[2] << 5;
>         filter->can_id |=3D (uint32_t)acr[3] >> 3;
^^^^^^^^^^^^^^^
>         if (acr[3] & 4) {
>             filter->can_id |=3D QEMU_CAN_RTR_FLAG;
>         }
>
vvvvvvvvvvvvvvv
>         filter->can_mask =3D (uint32_t)amr[0] << 21;
>         filter->can_mask |=3D (uint32_t)amr[1] << 13;
>         filter->can_mask |=3D (uint32_t)amr[2] << 5;
>         filter->can_mask |=3D (uint32_t)amr[3] >> 3;
^^^^^^^^^^^^^^^
>         filter->can_mask =3D ~filter->can_mask & QEMU_CAN_EFF_MASK;
>         if (!(amr[3] & 4)) {
>             filter->can_mask |=3D QEMU_CAN_RTR_FLAG;
>         }

Only these marked parts repeats.
Rest is similar but not material for simple inline.
Same for others two line sequences.
All these bit level manipulations are moved from frame
processing and another more top level functions into these
short can_sja_{single,dual}_filter functions.

> /* PeliCAN mode */
> enum SJA1000_PeliCAN_regs {
>         SJA_MOD      =3D 0x00,
> /* Command register */
>         SJA_CMR      =3D 0x01,
=2E...
> /* TX Error Counter */
>         SJA_TXERR0   =3D 0x0e,
>         SJA_TXERR1   =3D 0x0f,
> /* Rx Message Counter (number of msgs. in RX FIFO */
>         SJA_RMC      =3D 0x1d,
> /* Rx Buffer Start Addr. (address of current MSG) */
>         SJA_RBSA     =3D 0x1e,
> /* Transmit Buffer (write) Receive Buffer (read) Frame Information */
>         SJA_FRM      =3D 0x10,
> /*
>  * ID bytes (11 bits in 0 and 1 for standard message or
>  *          16 bits in 0,1 and 13 bits in 2,3 for extended message)
>  */
>         SJA_ID0      =3D 0x11, SJA_ID1 =3D 0x12,
> /* ID cont. for extended frames */
>         SJA_ID2      =3D 0x13, SJA_ID3 =3D 0x14,

Proposed formating

           SJA_MOD      =3D 0x00, /* Command */
           SJA_CMR      =3D 0x01, /* Status */

this is really better for short comments.
But how format long ones then to keep lines max 80 characters

           SJA_FRM      =3D 0x10, /* Transmit Buffer (write) Receive Buffer
                                 * (read) Frame Information
                                 */

The SJA_ID0 is would look even worse.

But if the second format is preferred then I update the patch.

> > Trace events seems as nice feature. But simple text printf
> > like output has been enough till now for CAN testing.
> > There is no debugging output in production build.
> > So I would add tracing infrastructure later if needed.
>
> They are as useful as console printf, but less invasive and more
> powerful: you can use a much precise timing, select which set of events
> to display without having to recompile.
> The default backend behaves as console printf.
>
> You should try them :)

I have tried them on=20

  pci_update_mappings_del
  pci_update_mappings_add
  pci_cfg_write

and they work great. They would be nice for SJA1000
register accesses, PCI boards configuration etc.
I am not sure how to use them for CAN messages
which has a variable length data field.
Any of debugging outputs is active (all is optimized out)
in regular build.

> >>> +    /* open socket */
> >>> +    s =3D socket(PF_CAN, SOCK_RAW, CAN_RAW);
> >>
> >> I never used it, but I think QEMU uses his socket API: "qemu/sockets.h"
> >
> > The SocketCAN host connection code is Linux specific,
> > but I can switch to qemu_socket() if it is preferred.
> > But address family has to be from Linux header file anyway.
>
> qemu_socket() sockets are heavily tested and already solve many things,
> like async I/O and error handling.

The CAN socket works with RAW packets read and written as 16 bytes.
So some higher level of optimizations used for stream or larger packets
have no significant effect there and SocketCAN API is Linux kernel
specific so generic abstraction layers has no effect there as well.

I have question about reporting fatal error.

Our code uses error_report() and exit(1) for now.

        error_report("CAN host device \"%s\" connect to bus \"%s\" failed",
                      host_dev_name, bus->name);
        exit(1);

Is that correct or there is better solution/function instead of exit?
I have seen this combination in many other places of QEMU code
in past but may it be there is some proposed change already.

Best wishes,

Pavel Pisa
