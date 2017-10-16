Received: from eggs.gnu.org ([2001:4830:134:3::10]:52830)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e41mC-0001zz-QJ
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 05:33:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e41m8-0004Wp-F1
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 05:33:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51928)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1e41m8-0004WF-6U
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 05:33:32 -0400
Date: Mon, 16 Oct 2017 11:33:24 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20171016113324.14e549c9@nial.brq.redhat.com>
In-Reply-To: <49d576f3-454f-05f4-7afd-9ca8b5fb0706@huawei.com>
References: <8ba7e693-4e32-7873-70bf-4efbf57f9cf5@huawei.com>
	<20170928011407-mutt-send-email-mst@kernel.org>
	<405bbc99-1a43-aa8b-37e9-9599480f4c06@huawei.com>
	<20171001063010-mutt-send-email-mst@kernel.org>
	<49d576f3-454f-05f4-7afd-9ca8b5fb0706@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] using which notification for guest about GHES error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: gengdongjiu <gengdongjiu@huawei.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, James Morse <james.morse@arm.com>, Wuquanming <wuquanming@huawei.com>, Laszlo Ersek <lersek@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Huangshaoyu <huangshaoyu@huawei.com>, Andrew Jones <drjones@redhat.com>

On Mon, 16 Oct 2017 14:10:05 +0800
gengdongjiu <gengdongjiu@huawei.com> wrote:

> Hi Igor/Michael,
>    I am very sorry to disturb you again.
> Now we use Qemu to create APEI table and record CPER for guest,
> After QEMU recorded a asynchronous CPER error, we needs to notify guest u=
sing interrupt or Polled notification.
> For the asynchronous error. I think using GPIO-signaled notification may =
be better in the Qemu, and also which is suggested by APEI spec.
> James worried that old guest OS may not support GPIO or GSIV notification=
 for GHES, because GPIO or GSIV notification is supported in OS since about=
 kernel version 4.10.

How APEI support is fairly new on ARM (kernel), isn't it still in state of =
development?
Do we really care about old guests in this case?

We'd like to stick to ACPI spec as much as possible and also to
http://infocenter.arm.com/help/topic/com.arm.doc.den0044b/DEN0044B_Server_B=
ase_Boot_Requirements.pdf
which mandates GPIO in platform (QEMU)
"
4.5 Hardware Requirements Imposed on the Platform by ACPI
...
Platforms compliant with this specification must provide the following GPIO=
-Signaled platform events:
...
"

> and suggested using Polled notification. About above two notifications, d=
o you think which is better? and could you give us some suggestion? thanks.
how polling is supposed to be implemented in QEMU?

>=20
>=20
> Hi James,
>   Below is APEI spec, From the spec, it suggested using GPIO interrupt or=
 GPIO-signaled events in ARM64 [1]. If using Polled notification for GHES, =
I do not sure whether it is reasonable.
> In the Qemu, X86 does not using Polled notification. it mainly use SCI. U=
ntil now, I do not found there is peopled using Polled notification in qemu=
. if implemented polled notification, I
> do not know how much work effort need to do. Now I have already implement=
ed the GPIO-Signal notification using GPIO pin.
>=20
>=20
> [1]
> HW-reduced ACPI platforms signal the error using a GPIO interrupt or anot=
her interrupt declared under a generic event device (Section 5.6.9). In the=
 case of GPIO-signaled events,
> an _AEI object lists the appropriate GPIO pin, while for Interrupt-signal=
ed events a _CRS object is used to list the interrupt:
> 	=E2=80=A2 The OSPM evaluates the control method associated with this eve=
nt as indicated in Section 5.6.5.3 and Section 5.6.9.3.
> 	=E2=80=A2 OSPM responds to this notification by checking the error statu=
s block of all generic error sources with the GPIO-Signal notification or I=
nterrupt-signaled notification types to identify the
> 	  source reporting the error.
>=20
>=20
>=20
>=20
>=20
> On 2017/10/1 11:30, Michael S. Tsirkin wrote:
> > On Thu, Sep 28, 2017 at 06:10:05PM +0800, gengdongjiu wrote: =20
> >>
> >>
> >> On 2017/9/28 6:15, Michael S. Tsirkin wrote: =20
> >>> On Wed, Sep 27, 2017 at 07:32:35PM +0800, gengdongjiu wrote: =20
> >>>> Hi Igor/Laszlo
> >>>>
> >>>>    I am very sorry to disturb you. I have a question that want to co=
nsult with you.
> >>>> Now In ARM64 platform I need to send a IRQ notification to guest OS =
through Qemu, so that guest OS can receive a IRQ notification and parse the=
 APEI table.
> >>>> but Now I do not find a proper API to send the IRQ notification to g=
uest, seems X86 mainly uses the API "acpi_send_gpe_event"
> >>>> in the ARM64 platform, whether we have existed API that can send IRQ=
 notification to guest? thank you very much in advance. =20
> >>>
> >>> ACPI events fundamentally go through the GPE mechanism. As the spec
> >>> says:
> >>>
> >>> 	ACPI Event Programming Model
> >>> 	The ACPI event programming model is based on the SCI interrupt and G=
eneral-Purpose Event
> >>> 	(GPE) register. =20
> >>
> >> got it, thanks Michael =20
> >=20
> > As Igor pointed out, the next spec sentence states that reduced HW
> > configurations use GPIO.
> >  =20
> >>>
> >>> =20
> >>>>
> >>>> [1]
> >>>> void acpi_send_gpe_event(ACPIREGS *ar, qemu_irq irq,
> >>>>                          AcpiEventStatusBits status)
> >>>> {
> >>>>     ar->gpe.sts[0] |=3D status;
> >>>>     acpi_update_sci(ar, irq);
> >>>> }
> >>>>
> >>>> void acpi_update_sci(ACPIREGS *regs, qemu_irq irq)
> >>>> {
> >>>>     int sci_level, pm1a_sts;
> >>>>
> >>>>     pm1a_sts =3D acpi_pm1_evt_get_sts(regs);
> >>>>
> >>>>     sci_level =3D ((pm1a_sts &
> >>>>                   regs->pm1.evt.en & ACPI_BITMASK_PM1_COMMON_ENABLED=
) !=3D 0) ||
> >>>>                 ((regs->gpe.sts[0] & regs->gpe.en[0]) !=3D 0);
> >>>>
> >>>>     qemu_set_irq(irq, sci_level);
> >>>>
> >>>>     /* schedule a timer interruption if needed */
> >>>>     acpi_pm_tmr_update(regs,
> >>>>                        (regs->pm1.evt.en & ACPI_BITMASK_TIMER_ENABLE=
) &&
> >>>>                        !(pm1a_sts & ACPI_BITMASK_TIMER_STATUS));
> >>>> } =20
> >>>
> >>> .
> >>> =20
> >=20
> > .
> >  =20
>=20
>=20
