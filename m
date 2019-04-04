Received: from eggs.gnu.org ([209.51.188.92]:49181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hBzBS-0007We-F9
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 06:01:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hBzBO-0007HZ-FJ
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 06:01:22 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:51982)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hBzBM-000768-4U
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 06:01:16 -0400
From: Yury Kotov <yury-kotov@yandex-team.ru>
In-Reply-To: <20190404095212.GC2678@work-vm>
References: <156671554283778@vla1-1374b6242101.qloud-c.yandex.net>
	<20190404095212.GC2678@work-vm>
MIME-Version: 1.0
Date: Thu, 04 Apr 2019 13:01:09 +0300
Message-Id: <111121554372069@iva7-0f652523820f.qloud-c.yandex.net>
Content-Type: text/plain; charset=utf-8
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
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "wrfsh@yandex-team.ru" <wrfsh@yandex-team.ru>, Richard Henderson <rth@twiddle.net>

I saw Catherine Ho's patch series and it seems ok to me, but in this RFC =
I asked
about a way how to detect other writes which may not be covered by partic=
ular
fixes.
Perhaps this is excessive caution...

Regards,
Yury

04.04.2019, 12:52, "Dr. David Alan Gilbert" <dgilbert@redhat.com>:
> * =D0=AE=D1=80=D0=B8=D0=B9 =D0=9A=D0=BE=D1=82=D0=BE=D0=B2 (yury-kotov@y=
andex-team.ru) wrote:
>> =C2=A0Ping
>
> Is this fixed by Catherine Ho's patch series?
>
> Dave
>
>> =C2=A021.03.2019, 19:27, "Yury Kotov" <yury-kotov@yandex-team.ru>:
>> =C2=A0> Hi,
>> =C2=A0>
>> =C2=A0> 19.03.2019, 14:52, "Dr. David Alan Gilbert" <dgilbert@redhat.c=
om>:
>> =C2=A0>> =C2=A0* Peter Maydell (peter.maydell@linaro.org) wrote:
>> =C2=A0>>> =C2=A0=C2=A0On Tue, 19 Mar 2019 at 11:03, Dr. David Alan Gil=
bert
>> =C2=A0>>> =C2=A0=C2=A0<dgilbert@redhat.com> wrote:
>> =C2=A0>>> =C2=A0=C2=A0>
>> =C2=A0>>> =C2=A0=C2=A0> * Peter Maydell (peter.maydell@linaro.org) wro=
te:
>> =C2=A0>>> =C2=A0=C2=A0> > I didn't think migration distinguished betwe=
en "main memory"
>> =C2=A0>>> =C2=A0=C2=A0> > and any other kind of RAMBlock-backed memory=
 ?
>> =C2=A0>>> =C2=A0=C2=A0>
>> =C2=A0>>> =C2=A0=C2=A0> In Yury's case there's a distinction between R=
AMBlock's that are mapped
>> =C2=A0>>> =C2=A0=C2=A0> with RAM_SHARED (which normally ends up as MAP=
_SHARED) and all others.
>> =C2=A0>>> =C2=A0=C2=A0> You can set that for main memory by using -num=
a to specify a memdev
>> =C2=A0>>> =C2=A0=C2=A0> that's backed by a file and has the share=3Don=
 property.
>> =C2=A0>>> =C2=A0=C2=A0>
>> =C2=A0>>> =C2=A0=C2=A0> On x86 the ROMs end up as separate RAMBlock's =
that aren't affected
>> =C2=A0>>> =C2=A0=C2=A0> by that -numa/share=3Don - so they don't fight=
 Yury's trick.
>> =C2=A0>>>
>> =C2=A0>>> =C2=A0=C2=A0You can use the generic loader on x86 to load an=
 ELF file
>> =C2=A0>>> =C2=A0=C2=A0into RAM if you want, which would I think also t=
rigger this.
>> =C2=A0>>
>> =C2=A0>> =C2=A0OK, although that doesn't worry me too much - since in =
the majority
>> =C2=A0>> =C2=A0of cases Yury's trick still works well.
>> =C2=A0>>
>> =C2=A0>> =C2=A0I wonder if there's a way to make Yury's code to detect=
 these cases
>> =C2=A0>> =C2=A0and not allow the feature; the best thing for the momen=
t would seem to
>> =C2=A0>> =C2=A0be to skip the aarch test that uses elf loading.
>> =C2=A0>
>> =C2=A0> Currently, I've no idea how to detect such cases, but there is=
 an ability to
>> =C2=A0> detect memory corruption. I want to update the RFC patch to le=
t user to map some
>> =C2=A0> memory regions as readonly until incoming migration start.
>> =C2=A0>
>> =C2=A0> E.g.
>> =C2=A0> 1) If x-ignore-shared is enabled in command line or memory reg=
ion is marked
>> =C2=A0> =C2=A0=C2=A0=C2=A0(something like ',readonly=3Don'),
>> =C2=A0> 2) Memory region is shared (,share=3Don),
>> =C2=A0> 3) And qemu is started with '-incoming' option
>> =C2=A0>
>> =C2=A0> Then map such regions as readonly until incoming migration fin=
ished.
>> =C2=A0> Thus, the patch will be able to detect memory corruption and w=
ill not affect
>> =C2=A0> normal cases.
>> =C2=A0>
>> =C2=A0> How do you think, is it needed?
>> =C2=A0>
>> =C2=A0> I already have a cleaner version of the RFC patch, but I'm not=
 sure about 1).
>> =C2=A0> Which way is better: enable capability in command line, add a =
new option for
>> =C2=A0> memory-backend or something else.
>> =C2=A0>
>> =C2=A0>> =C2=A0Dave
>> =C2=A0>>
>> =C2=A0>>> =C2=A0=C2=A0thanks
>> =C2=A0>>> =C2=A0=C2=A0-- PMM
>> =C2=A0>> =C2=A0--
>> =C2=A0>> =C2=A0Dr. David Alan Gilbert / dgilbert@redhat.com / Manchest=
er, UK
>> =C2=A0>
>> =C2=A0> Regards,
>> =C2=A0> Yury
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
