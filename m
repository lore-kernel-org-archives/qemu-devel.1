Received: from eggs.gnu.org ([209.51.188.92]:46905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hBz2h-0004sP-QI
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 05:52:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hBz2g-0004Dp-Mo
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 05:52:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41076)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hBz2g-0004DD-DX
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 05:52:18 -0400
Date: Thu, 4 Apr 2019 10:52:12 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190404095212.GC2678@work-vm>
References: <156671554283778@vla1-1374b6242101.qloud-c.yandex.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <156671554283778@vla1-1374b6242101.qloud-c.yandex.net>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH] QEMU may write to system_memory before
 guest starts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?B?0K7RgNC40Lkg0JrQvtGC0L7Qsg==?= <yury-kotov@yandex-team.ru>
Cc: Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "wrfsh@yandex-team.ru" <wrfsh@yandex-team.ru>, Richard Henderson <rth@twiddle.net>

* =D0=AE=D1=80=D0=B8=D0=B9 =D0=9A=D0=BE=D1=82=D0=BE=D0=B2 (yury-kotov@yan=
dex-team.ru) wrote:
> Ping

Is this fixed by Catherine Ho's patch series?

Dave

> 21.03.2019, 19:27, "Yury Kotov" <yury-kotov@yandex-team.ru>:
> > Hi,
> >
> > 19.03.2019, 14:52, "Dr. David Alan Gilbert" <dgilbert@redhat.com>:
> >> =C2=A0* Peter Maydell (peter.maydell@linaro.org) wrote:
> >>> =C2=A0=C2=A0On Tue, 19 Mar 2019 at 11:03, Dr. David Alan Gilbert
> >>> =C2=A0=C2=A0<dgilbert@redhat.com> wrote:
> >>> =C2=A0=C2=A0>
> >>> =C2=A0=C2=A0> * Peter Maydell (peter.maydell@linaro.org) wrote:
> >>> =C2=A0=C2=A0> > I didn't think migration distinguished between "mai=
n memory"
> >>> =C2=A0=C2=A0> > and any other kind of RAMBlock-backed memory ?
> >>> =C2=A0=C2=A0>
> >>> =C2=A0=C2=A0> In Yury's case there's a distinction between RAMBlock=
's that are mapped
> >>> =C2=A0=C2=A0> with RAM_SHARED (which normally ends up as MAP_SHARED=
) and all others.
> >>> =C2=A0=C2=A0> You can set that for main memory by using -numa to sp=
ecify a memdev
> >>> =C2=A0=C2=A0> that's backed by a file and has the share=3Don proper=
ty.
> >>> =C2=A0=C2=A0>
> >>> =C2=A0=C2=A0> On x86 the ROMs end up as separate RAMBlock's that ar=
en't affected
> >>> =C2=A0=C2=A0> by that -numa/share=3Don - so they don't fight Yury's=
 trick.
> >>>
> >>> =C2=A0=C2=A0You can use the generic loader on x86 to load an ELF fi=
le
> >>> =C2=A0=C2=A0into RAM if you want, which would I think also trigger =
this.
> >>
> >> =C2=A0OK, although that doesn't worry me too much - since in the maj=
ority
> >> =C2=A0of cases Yury's trick still works well.
> >>
> >> =C2=A0I wonder if there's a way to make Yury's code to detect these =
cases
> >> =C2=A0and not allow the feature; the best thing for the moment would=
 seem to
> >> =C2=A0be to skip the aarch test that uses elf loading.
> >
> > Currently, I've no idea how to detect such cases, but there is an abi=
lity to
> > detect memory corruption. I want to update the RFC patch to let user =
to map some
> > memory regions as readonly until incoming migration start.
> >
> > E.g.
> > 1) If x-ignore-shared is enabled in command line or memory region is =
marked
> > =C2=A0=C2=A0=C2=A0(something like ',readonly=3Don'),
> > 2) Memory region is shared (,share=3Don),
> > 3) And qemu is started with '-incoming' option
> >
> > Then map such regions as readonly until incoming migration finished.
> > Thus, the patch will be able to detect memory corruption and will not=
 affect
> > normal cases.
> >
> > How do you think, is it needed?
> >
> > I already have a cleaner version of the RFC patch, but I'm not sure a=
bout 1).
> > Which way is better: enable capability in command line, add a new opt=
ion for
> > memory-backend or something else.
> >
> >> =C2=A0Dave
> >>
> >>> =C2=A0=C2=A0thanks
> >>> =C2=A0=C2=A0-- PMM
> >> =C2=A0--
> >> =C2=A0Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> >
> > Regards,
> > Yury
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
