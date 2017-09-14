Received: from eggs.gnu.org ([2001:4830:134:3::10]:47044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sundeep.lkml@gmail.com>) id 1dsW5m-0006QS-5a
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 11:30:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sundeep.lkml@gmail.com>) id 1dsW5k-00070f-W8
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 11:30:14 -0400
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8KUtG=2Cr_PndUqOxp5PN6bTJR_t=s+Ch+Y2WVfHVjQg@mail.gmail.com>
References: <1504812251-23438-1-git-send-email-sundeep.lkml@gmail.com>
	<1504812251-23438-3-git-send-email-sundeep.lkml@gmail.com>
	<a9891f10-9643-96ee-7f99-7a384b9ea302@amsat.org>
	<CAFEAcA8KUtG=2Cr_PndUqOxp5PN6bTJR_t=s+Ch+Y2WVfHVjQg@mail.gmail.com>
From: sundeep subbaraya <sundeep.lkml@gmail.com>
Date: Thu, 14 Sep 2017 21:00:09 +0530
Message-ID: <CALHRZupPj2cJJAr57n+E6Q0xF1qpsewHsDzS03mQmoHfL98j6g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu devel v8 PATCH 2/5] msf2: Microsemi
 Smartfusion2 System Register block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Alistair Francis <alistair23@gmail.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

Hi Philippe,

On Thu, Sep 14, 2017 at 6:43 PM, Peter Maydell <peter.maydell@linaro.org>
wrote:

> On 14 September 2017 at 05:36, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg>
> wrote:
> > On 09/07/2017 04:24 PM, Subbaraya Sundeep wrote:
> >> +static uint64_t msf2_sysreg_read(void *opaque, hwaddr offset,
> >> +    unsigned size)
> >> +{
> >> +    MSF2SysregState *s =3D opaque;
> >> +    uint32_t ret =3D 0;
> >> +
> >> +    offset >>=3D 2;
> >> +    if (offset < ARRAY_SIZE(s->regs)) {
> >
> >
> > This comment is controversial, I'll let Peter nod.
> >
> > The SYSREG behaves differently regarding which bus access it (CPU, AHB)=
.
> > You are implementing CPU access to the SYSREG, the registers have
> different
> > permissions when accessed by the CPU. (see the SmartFusion2 User Guide:
> > Table 21-1 "Register Types" and Table 21-2 "Register Map").
>

CPU is also one of the bus masters in AHB matrix (Fig 6.1 in page 248).

>
> > I'd think of this stub:
> >
> > switch(reg) {
> > case register_supported1:
> > case register_supported2:
> > case register_supported3:
> >            ret =3D s->regs[offset];
> >            trace_msf2_sysreg_read(offset, ret);
> >            break;
> > case RO-U:
> >            qemu_log_mask(LOG_GUEST_ERROR, "Illegal AHB access 0x%08"...
> >            break;
> > case W1P:
> >            qemu_log_mask(LOG_GUEST_ERROR, "Illegal read access ...
> >            break;
> > case RW:
> > case RW-P:
> > case RO:
> > case RO-P:
> > default:
> >            ret =3D s->regs[offset];
> >            qemu_log_mask(LOG_UNIMP, "...
> >            break;
> > }
>

This sounds good to me and will fix later by rearranging registers in enum
sorted
based on type (RO, RW, etc.,) and use those ranges in switch case.

>
> This doesn't look entirely right, since this is the read interface.
> Shouldn't we be allowing pretty much all of these register types
> except maybe W1P to do a read?
>

Peter, some of the registers are not allowed to access by CPU and are only
set during
device programming. For those registers Philippe is suggesting to log
"Illegal AHB access"
when guest is trying to read/write.

Thanks,
Sundeep


>
> On the other hand, in the write function we should probably not allow
> writes to registers documented as read only.
>
> thanks
> -- PMM
>
