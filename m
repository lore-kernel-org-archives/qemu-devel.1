Received: from eggs.gnu.org ([209.51.188.92]:55834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hBcDM-0006YQ-5A
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 05:29:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hBcDK-0003hr-RW
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 05:29:48 -0400
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:54900)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hBcDK-0003hL-EZ
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 05:29:46 -0400
From: =?utf-8?B?0K7RgNC40Lkg0JrQvtGC0L7Qsg==?= <yury-kotov@yandex-team.ru>
MIME-Version: 1.0
Date: Wed, 03 Apr 2019 12:29:43 +0300
Message-Id: <156671554283778@vla1-1374b6242101.qloud-c.yandex.net>
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
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "wrfsh@yandex-team.ru" <wrfsh@yandex-team.ru>, Richard Henderson <rth@twiddle.net>

Ping

21.03.2019, 19:27, "Yury Kotov" <yury-kotov@yandex-team.ru>:
> Hi,
>
> 19.03.2019, 14:52, "Dr. David Alan Gilbert" <dgilbert@redhat.com>:
>> =C2=A0* Peter Maydell (peter.maydell@linaro.org) wrote:
>>> =C2=A0=C2=A0On Tue, 19 Mar 2019 at 11:03, Dr. David Alan Gilbert
>>> =C2=A0=C2=A0<dgilbert@redhat.com> wrote:
>>> =C2=A0=C2=A0>
>>> =C2=A0=C2=A0> * Peter Maydell (peter.maydell@linaro.org) wrote:
>>> =C2=A0=C2=A0> > I didn't think migration distinguished between "main =
memory"
>>> =C2=A0=C2=A0> > and any other kind of RAMBlock-backed memory ?
>>> =C2=A0=C2=A0>
>>> =C2=A0=C2=A0> In Yury's case there's a distinction between RAMBlock's=
 that are mapped
>>> =C2=A0=C2=A0> with RAM_SHARED (which normally ends up as MAP_SHARED) =
and all others.
>>> =C2=A0=C2=A0> You can set that for main memory by using -numa to spec=
ify a memdev
>>> =C2=A0=C2=A0> that's backed by a file and has the share=3Don property=
.
>>> =C2=A0=C2=A0>
>>> =C2=A0=C2=A0> On x86 the ROMs end up as separate RAMBlock's that aren=
't affected
>>> =C2=A0=C2=A0> by that -numa/share=3Don - so they don't fight Yury's t=
rick.
>>>
>>> =C2=A0=C2=A0You can use the generic loader on x86 to load an ELF file
>>> =C2=A0=C2=A0into RAM if you want, which would I think also trigger th=
is.
>>
>> =C2=A0OK, although that doesn't worry me too much - since in the major=
ity
>> =C2=A0of cases Yury's trick still works well.
>>
>> =C2=A0I wonder if there's a way to make Yury's code to detect these ca=
ses
>> =C2=A0and not allow the feature; the best thing for the moment would s=
eem to
>> =C2=A0be to skip the aarch test that uses elf loading.
>
> Currently, I've no idea how to detect such cases, but there is an abili=
ty to
> detect memory corruption. I want to update the RFC patch to let user to=
 map some
> memory regions as readonly until incoming migration start.
>
> E.g.
> 1) If x-ignore-shared is enabled in command line or memory region is ma=
rked
> =C2=A0=C2=A0=C2=A0(something like ',readonly=3Don'),
> 2) Memory region is shared (,share=3Don),
> 3) And qemu is started with '-incoming' option
>
> Then map such regions as readonly until incoming migration finished.
> Thus, the patch will be able to detect memory corruption and will not a=
ffect
> normal cases.
>
> How do you think, is it needed?
>
> I already have a cleaner version of the RFC patch, but I'm not sure abo=
ut 1).
> Which way is better: enable capability in command line, add a new optio=
n for
> memory-backend or something else.
>
>> =C2=A0Dave
>>
>>> =C2=A0=C2=A0thanks
>>> =C2=A0=C2=A0-- PMM
>> =C2=A0--
>> =C2=A0Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>
> Regards,
> Yury
