Received: from eggs.gnu.org ([2001:4830:134:3::10]:43859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dmitry@daynix.com>) id 1d9tLy-00068K-I2
	for qemu-devel@nongnu.org; Sun, 14 May 2017 09:14:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dmitry@daynix.com>) id 1d9tLv-00034b-Bj
	for qemu-devel@nongnu.org; Sun, 14 May 2017 09:14:30 -0400
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:35008)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dmitry@daynix.com>) id 1d9tLv-00032d-2R
	for qemu-devel@nongnu.org; Sun, 14 May 2017 09:14:27 -0400
Received: by mail-wr0-x22d.google.com with SMTP id z52so64873737wrc.2
	for <qemu-devel@nongnu.org>; Sun, 14 May 2017 06:14:26 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Dmitry Fleytman <dmitry@daynix.com>
In-Reply-To: <20170511123639.GE2078@work-vm>
Date: Sun, 14 May 2017 16:14:22 +0300
Content-Transfer-Encoding: quoted-printable
Message-Id: <225AC0F4-5672-456F-9032-F2C1C86342E5@daynix.com>
References: <20170511123639.GE2078@work-vm>
Subject: Re: [Qemu-devel] e1000e migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org

Hello Dave,

We are trying to reproduce this issue on our systems but with no luck so =
far=E2=80=A6

=46rom what you describe it looks like some bit in ICR is not being =
cleared by the driver.
This usually means that this bit should never be set in that specific =
interrupt mode.

Could you please check which bit is not cleared and who sets it?

Regards,
Dmitry

> On 11 May 2017, at 15:36 PM, Dr. David Alan Gilbert =
<dgilbert@redhat.com> wrote:
>=20
> Hi Dmitry,
>  Have you seen any problems with e1000e migration under windows?
> I've got a repeatable case where after migration with e1000e windows
> hangs/almost hangs.
>  I'm seeing the e1000e generate interrupts at a very very high
> rate (maybe ~1000 second ish?) after migration.
>=20
>  Some versions of qemu do it and some dont, but my attempts
> at bisection lead me to code that should be irrelevant.
>=20
> Prior to migration I see:
>=20
> 36461@1494504466.711929:e1000e_irq_pending_interrupts ICR PENDING: =
0x100000 (ICR: 0x80100082, IMS: 0x1f00004)
> 36461@1494504466.711992:e1000e_irq_pending_interrupts ICR PENDING: 0x0 =
(ICR: 0x80000082, IMS: 0x1a00004)
> 36461@1494504466.712076:e1000e_irq_pending_interrupts ICR PENDING: 0x0 =
(ICR: 0x80000082, IMS: 0x1f00004)
> 36461@1494504466.712245:e1000e_irq_pending_interrupts ICR PENDING: 0x0 =
(ICR: 0x80000082, IMS: 0x1a00004)
> 36461@1494504466.712332:e1000e_irq_pending_interrupts ICR PENDING: 0x0 =
(ICR: 0x80000082, IMS: 0x1f00004)
>=20
> which I think the ICR means:
>      31 - int asserted
>      20 - RxQ0 - receive queue 0 interrupt
>      7  - RXT0 - receiver timer interrupt
>      1  - TXQE - Transmit Queue empty
>=20
> after migration it varies more, I'm seeing mostly:
> 21977@1494504516.320707:e1000e_irq_pending_interrupts ICR PENDING: =
0x1000000 (ICR: 0x815000c2, IMS: 0x1a00004)
>      31 - int asserted
>      24 - 'Other'
>      22 - TxQ0 interrupt
>      20 - RxQ0 interrupt
>      07 - RXT0 Receiver timer interrupt
>      06 - RX0 - Receiver overrun
>      01 - TXQE - Transmit queue empty
>=20
> For reference this is =
https://bugzilla.redhat.com/show_bug.cgi?id=3D1447935
>=20
> Dave
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
