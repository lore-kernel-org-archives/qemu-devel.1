Received: from eggs.gnu.org ([2001:4830:134:3::10]:34128)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pisa@cmp.felk.cvut.cz>) id 1eaJtV-0005h8-3g
	for qemu-devel@nongnu.org; Sat, 13 Jan 2018 06:22:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pisa@cmp.felk.cvut.cz>) id 1eaJtR-00050q-US
	for qemu-devel@nongnu.org; Sat, 13 Jan 2018 06:22:37 -0500
Received: from relay.felk.cvut.cz ([2001:718:2:1611:0:1:0:70]:29525)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pisa@cmp.felk.cvut.cz>) id 1eaJtR-0004zg-Jp
	for qemu-devel@nongnu.org; Sat, 13 Jan 2018 06:22:33 -0500
From: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Date: Sat, 13 Jan 2018 12:21:52 +0100
References: <cover.1515260163.git.pisa@cmp.felk.cvut.cz>
	<c6b7795b-9ac0-10ef-bb46-eca23ba3662a@adacore.com>
In-Reply-To: <c6b7795b-9ac0-10ef-bb46-eca23ba3662a@adacore.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201801131221.52923.pisa@cmp.felk.cvut.cz>
Subject: Re: [Qemu-devel] [PATCH 0/7] CAN bus support for QEMU (SJA1000 PCI
 so far)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: KONRAD Frederic <frederic.konrad@adacore.com>
Cc: qemu-devel@nongnu.org, Marek Vasut <marex@denx.de>, Oliver Hartkopp <socketcan@hartkopp.net>, Deniz Eren <deniz.eren@icloud.com>, Oleksij Rempel <o.rempel@pengutronix.de>, Jan Kiszka <jan.kiszka@siemens.com>

Hello Konrad,

thanks for review.

On Friday 12 of January 2018 11:43:18 KONRAD Frederic wrote:
> You should add that to the title as well:
>
> git format-patch ... --subject-prefix="PATCH V3" ...
>
> to avoid any confusion.

OK, I add V4.

> You need to run the ./scripts/checkpatch.pl on your patches to
> check the coding-style before submitting.

I have run ./scripts/checkpatch.pl on patches but I have
ignored warnings for comments overflowing column 80,
because of better readability, same for

//#define DEBUG_CAN

which seems to be used quite often in the rest of the QEMU
code. But I (try hard) switch to the strict mode for next
version.

I follow all your comments. I have send e-mail to Deniz Eren
to provide his signed-off. I have received plain patches
from him without this line. I trust that they have been
intended to be integrated/released under GPL but
I am not sure if rules allows to add the line myself.

As for the inline can_bus_filter_match

> > +static inline
> > +int can_bus_filter_match(struct qemu_can_filter *filter, qemu_canid_t
> > can_id) +{
> > +    int m;
> > +    if (((can_id | filter->can_mask) & QEMU_CAN_ERR_FLAG)) {
> > +        return (filter->can_mask & QEMU_CAN_ERR_FLAG) != 0;
> > +    }
> > +    m = (can_id & filter->can_mask) == (filter->can_id &
> > filter->can_mask); +    return filter->can_id & QEMU_CAN_INV_FILTER ? !m
> > : m;
> > +}

> Is it really required to inline this?

I agree that it size is on upper size for inline.
My initial version has next form which would be better
to be inlined

int can_bus_filter_match(struct qemu_can_filter *filter, qemu_canid_t can_id)
{
    return (can_id & filter->can_mask) == (filter->can_id & filter->can_mask);
}

but I decided then to add more SocketCAN like behavior
to can use it for CAN bus clients filters list in the future.
Function call cost is not so high today.
The function can be sometimes optimized to basic form when
it is inlined and actual masks computation eliminates
some cases, but again branch predictor should take care
about that.

> > +void can_sja_hardware_reset(CanSJA1000State *s)

> Is something able to reset the chip outside?

I have found and supported more SJA1000 based
CAN cards with reset option during my LinCAN driver
development in the past. The card have special
register or address which allows to activate
RESET pin of SJA1000. So even that reset cannot
be activated externally on currently supported cards,
I would keep that function available for future
boards emulation if there is no objection.

Best wishes,

Pavel
