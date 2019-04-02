Received: from eggs.gnu.org ([209.51.188.92]:37634)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hBBIi-0006eL-1o
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 00:45:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hBBIf-0006m4-Hs
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 00:45:31 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a]:46790)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hBBId-0006aq-Ei
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 00:45:29 -0400
Received: by mail-ot1-x32a.google.com with SMTP id s24so10781925otk.13
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 21:45:21 -0700 (PDT)
MIME-Version: 1.0
References: <1553849325-44201-1-git-send-email-like.xu@linux.intel.com>
	<1553849325-44201-5-git-send-email-like.xu@linux.intel.com>
	<87h8bmuj2d.fsf@zen.linaroharston>
	<2546bf3e-2009-5a76-bc63-0ad73d333a78@linux.intel.com>
	<20190401233818.GA22884@habkost.net>
	<965d5d2f-1717-dcd0-8707-f6629f54e504@linux.intel.com>
In-Reply-To: <965d5d2f-1717-dcd0-8707-f6629f54e504@linux.intel.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 2 Apr 2019 04:45:08 +0000
Message-ID: <CAFEAcA_i9Te5Gs9GWnqH+JvTPFbp80+n2D=VAoC0e2DS7OfSeg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 4/9] cpu/topology: add ARM support for smp
 machine properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Like Xu <like.xu@linux.intel.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, like.xu@intel.com, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On Tue, 2 Apr 2019 at 09:46, Like Xu <like.xu@linux.intel.com> wrote:
>
> On 2019/4/2 7:38, Eduardo Habkost wrote:
> > On Mon, Apr 01, 2019 at 10:56:30AM +0800, Like Xu wrote:
> >> On 2019/3/29 17:27, Alex Benn=C3=A9e wrote:
> > [...]
> >>>> @@ -1713,6 +1717,9 @@ static void cortex_a9_initfn(Object *obj)
> >>>>    #ifndef CONFIG_USER_ONLY
> >>>>    static uint64_t a15_l2ctlr_read(CPUARMState *env, const ARMCPRegI=
nfo *ri)
> >>>>    {
> >>>> +    MachineState *ms =3D MACHINE(qdev_get_machine());
> >>>
> >>> How expensive is qdev_get_machine? This could potentially be a
> >>> performance issue if this register is read a lot.
> >>
> >> It may not bother us cause the MachineState object would be feteched f=
rom
> >> qemu QOM at its first requested time and save it as static variable fo=
r
> >> incoming requests.
> >
> > We already have a current_machine variable declared in
> > include/hw/boards.h.  We normally avoid using it and use
> > MACHINE(qdev_get_machine()) instead, but I never understood why.
> >
> Which one do you prefer to access smp machine properties?

My suggestion would be that we use qdev_get_machine(). I think
it would be nice to make the remaining dozen or so uses of
the global current_machine outside vl.c use qdev_get_machine()
instead, and then make current_machine local to vl.c instead
of global.

thanks
-- PMM
