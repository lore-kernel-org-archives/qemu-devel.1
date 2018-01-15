Received: from eggs.gnu.org ([2001:4830:134:3::10]:46864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pisa@cmp.felk.cvut.cz>) id 1ebCL1-0002nA-JE
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 16:30:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pisa@cmp.felk.cvut.cz>) id 1ebCKy-0007cM-Ft
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 16:30:39 -0500
Received: from relay.felk.cvut.cz ([2001:718:2:1611:0:1:0:70]:35679)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pisa@cmp.felk.cvut.cz>) id 1ebCKy-0007bH-5g
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 16:30:36 -0500
From: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Date: Mon, 15 Jan 2018 22:29:53 +0100
References: <cover.1515960078.git.pisa@cmp.felk.cvut.cz>
	<425e38f28bba536cfb1ae389ffa963984990f306.1515960078.git.pisa@cmp.felk.cvut.cz>
	<65ff7759-2e09-fba6-e60e-41e8d89d0e7c@amsat.org>
In-Reply-To: <65ff7759-2e09-fba6-e60e-41e8d89d0e7c@amsat.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <201801152229.53520.pisa@cmp.felk.cvut.cz>
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

thanks for review.

I have updated patch series in can-pci branch in

  https://gitlab.fel.cvut.cz/canbus/qemu-canbus

I would wait some day if there is some remark
from other developers and socket ones especially.

On Monday 15 of January 2018 03:55:00 Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Pavel,
>
> I'm CC'ing the QEMU Sockets maintainer to ask them a quick review of the
> socket part.
>
> On 01/14/2018 05:14 PM, pisa@cmp.felk.cvut.cz wrote:
> > From: Pavel Pisa <pisa@cmp.felk.cvut.cz>

> Please move those checks out of the function, to call them once at build
> time and not at runtime.
>
> /* Check that QEMU and Linux kernel flags encoding matches */
> QEMU_BUILD_BUG_ON(QEMU_CAN_EFF_FLAG =3D=3D CAN_EFF_FLAG);
> QEMU_BUILD_BUG_ON(QEMU_CAN_RTR_FLAG =3D=3D CAN_RTR_FLAG);
> QEMU_BUILD_BUG_ON(QEMU_CAN_ERR_FLAG =3D=3D CAN_ERR_FLAG);
> QEMU_BUILD_BUG_ON(QEMU_CAN_INV_FILTER =3D=3D CAN_INV_FILTER);
> QEMU_BUILD_BUG_ON(offsetof(qemu_can_frame, data)
>                   =3D=3D offsetof(struct can_frame, data));

moved

> > +
> > +    qemu_log_lock();
> > +    qemu_log("[cansocketcan]: %03X [%01d] %s %s",
> > +             msg->can_id & QEMU_CAN_EFF_MASK,
> > +             msg->can_dlc,
> > +             msg->can_id & QEMU_CAN_EFF_FLAG ? "EFF" : "SFF",
> > +             msg->can_id & QEMU_CAN_RTR_FLAG ? "RTR" : "DAT");
> > +
> > +    for (i =3D 0; i < msg->can_dlc; i++) {
> > +        qemu_log(" %02X", msg->data[i]);
> > +    }
> > +    qemu_log("\n");
>
> I'd rather use tracepoints, but since this is restricted by DEBUG_CAN
> this doesn't bother the user console, so ok.
>
> > +    qemu_log_flush();
> > +    qemu_log_unlock();
> > +}

Trace events seems as nice feature. But simple text printf
like output has been enough till now for CAN testing.
There is no debugging output in production build.
So I would add tracing infrastructure later if needed.

> > +    /* open socket */
> > +    s =3D socket(PF_CAN, SOCK_RAW, CAN_RAW);
>
> I never used it, but I think QEMU uses his socket API: "qemu/sockets.h"

The SocketCAN host connection code is Linux specific,
but I can switch to qemu_socket() if it is preferred.
But address family has to be from Linux header file anyway.

Best wishes,

Pavel
