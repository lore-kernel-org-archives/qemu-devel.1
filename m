Received: from eggs.gnu.org ([2001:4830:134:3::10]:46976)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1e2JWm-000623-9c
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 12:06:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1e2JWg-0003MO-Ds
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 12:06:36 -0400
References: <1506524205-20763-1-git-send-email-eric.auger@redhat.com>
	<CAFEAcA_UfXaO-KEgXb+GSUT=XhQar_gxshUV_GWO_axcZ0R4sA@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <73b7916a-4bb3-3913-ed6f-23e5c3e4fa23@redhat.com>
Date: Wed, 11 Oct 2017 18:06:18 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_UfXaO-KEgXb+GSUT=XhQar_gxshUV_GWO_axcZ0R4sA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC 0/3] vITS Reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Wei Huang <wei@redhat.com>, Andrew Jones <drjones@redhat.com>, Vijay Kilari <vijay.kilari@gmail.com>, Juan Quintela <quintela@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, wu.wubin@huawei.com, wanghaibin.wang@huawei.com, Christoffer Dall <christoffer.dall@linaro.org>, eric.auger.pro@gmail.com

Hi Peter,

On 09/10/2017 20:17, Peter Maydell wrote:
> On 27 September 2017 at 15:56, Eric Auger <eric.auger@redhat.com> wrote=
:
>> At the moment the ITS is not properly reset. On System reset or
>> reboot, previous ITS register values and caches are left
>> unchanged. Some of the registers might point to some guest RAM
>> tables which are not provisionned. This leads to state
>> inconsistencies that are detected by the kernel save/restore
>> code. And eventually this may cause qemu abort on source or
>> destination.
>>
>> The 1st patch, suggested to be cc'ed stable proposes to remove
>> the abort in case of table save/restore failure. This is
>> definitively not ideal but looks the most reasonable until we
>> get a proper way to reset the ITS. Still a message is emitted
>> to report the save/restore did not happen correctly.
>>
>> Subsequent patches add the support of explicit reset using
>> a new kvm device group/attribute combo. The associated kernel
>> series is not upstream [1], hence the RFC.
>>
>> ITS specification is not very clear about reset. There is no
>> reset wire. Some register fields are documented to have
>> architecturally defined reset values and we use those here:
>> Most importantly the Valid bit of GITS_CBASER and GITS_BASER
>> are cleared and the GITS_CTLR.Enabled bit is cleared as well.
>=20
> The ITS is a device, not part of the CPU, so its reset is
> implementation-defined but typically via some signal that's
> controlled by the SoC (this is no different to the other
> parts of the GICv3 which aren't denoted as being in the
> reset domain of the CPU). For instance if you look at the TRM
> for the GIC-500 it has a single 'resetn' reset signal which
> resets all of the GIC/ITS apart from the CPU interface parts:
> http://infocenter.arm.com/help/index.jsp?topic=3D/com.arm.doc.100336_00=
02_01_en/index.html
>=20
> The GICv3 spec 6.6 indicates what is supposed to happen to
> the ITS on powerup. For QEMU's purposes reset is generally
> considered to be a cold reset and we should always reset our
> state to the same thing it was when QEMU first started.
>=20
> It's not clear to me why we need a new KVM device attribute
> for doing ITS reset. The usual approach for this is:
>  * system reset causes QEMU's device model reset code
>    to reset state structure values to whatever their
>    reset value is
>  * we write those values up into the kernel, which is
>    sufficient to reset it
>=20
> What goes wrong with that in the case of the ITS?
> In particular, if GITS_CTLR.Enabled is 0 then I think the
> kernel should not be trying to read guest memory tables.

We discussed that on the kernel thread and Christoffer seemed to prefer
an IOTCL instead of individual register writes
(https://www.spinics.net/lists/kvm-arm/msg27211.html)

The IOCTL empties the ITS cached data (list of collection, list of
devices and list of LPIs) while it is not obvious the reset of BASER<n>
would mandate that. Eventually in my kernel series I also voided the
list on BASER<n>.valid toggling from 1 to 0.

Spec also says:
If a write to GITS.CTLR changes the Enabled field from 1 to 0, the
Interrupt Translation Space must ensure
that both:
=E2=80=A2 Any caches containing mapping data are made consistent with ext=
ernal
memory.
=E2=80=A2 GITS_CTLR.Quiescent =3D=3D 0 until all caches are consistent wi=
th external
memory.

I aknowledge I don't really get at which moment we are supposed to void
the caches.

Nevertheless, personnally I think we can achieve the same reset
functionality with individual register writes.

Thanks

Eric






>=20
> thanks
> -- PMM
>=20
