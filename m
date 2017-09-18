Received: from eggs.gnu.org ([2001:4830:134:3::10]:47738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1du04l-0003JT-Ts
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 13:43:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1du04k-0003cA-Sc
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 13:43:20 -0400
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:46488)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1du04k-0003ZN-LB
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 13:43:18 -0400
Received: by mail-wm0-x235.google.com with SMTP id i189so4827944wmf.1
	for <qemu-devel@nongnu.org>; Mon, 18 Sep 2017 10:43:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87d16o53xr.fsf@frigg.lan>
References: <150529642278.10902.18234057937634437857.stgit@frigg.lan>
	<150529666493.10902.14830445134051381968.stgit@frigg.lan>
	<CAFEAcA9p9B8AFaaSaSOOSsFsEhHW=XPLBFs5MrozWq=7p4_9Zg@mail.gmail.com>
	<87poasgjyh.fsf@frigg.lan>
	<CAFEAcA8XP+8Jz9Dn-mEQ3CCrVj00t3HA0praQ-OSggtQGAmQ5Q@mail.gmail.com>
	<87d16o53xr.fsf@frigg.lan>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 Sep 2017 18:42:55 +0100
Message-ID: <CAFEAcA9FhXKVKe1E_pVDWX3u0W7WuKQmO54Z1Jgj-iL980yPew@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 01/22] instrument: Add documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, "Emilio G. Cota" <cota@braap.org>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Markus Armbruster <armbru@redhat.com>

On 18 September 2017 at 18:09, Llu=C3=ADs Vilanova <vilanova@ac.upc.edu> wr=
ote:
> Peter Maydell writes:
>> It's also exposing internal QEMU implementation detail.
>> What if in future we decide to switch from our current
>> setup to always interpreting guest instructions as a
>> first pass with JITting done only in the background for
>> hot code?
>
> TCI still has a separation of translation-time (translate.c) and executio=
n-time
> (interpreting the TCG opcodes), and I don't think that's gonna go away an=
ytime
> soon.

I didn't mean TCI, which is nothing like what you'd use for
this if you did it (TCI is slower than just JITting.)

> Even if it did, I think there still will be a translation/execution separ=
ation
> easy enough to hook into (even if it's a "fake" one for the cold-path
> interpreted instructions).

But what would it mean? You don't have basic blocks any more.

>> Sticking to instrumentation events that correspond exactly to guest
>> execution events means they won't break or expose internals.
>
> It also means we won't be able to "conditionally" instrument instructions=
 (e.g.,
> based on their opcode, address range, etc.).

You can still do that, it's just less efficient (your
condition-check happens in the callout to the instrumentation
plugin). We can add "filter" options later if we need them
(which I would rather do than have translate-time callbacks).

> Of course we can add the translation/execution differentiation later if w=
e find
> it necessary for performance, but I would rather avoid leaving "historica=
l"
> instrumentation points behind on the API.
>
> What are the use-cases you're aiming for?

* I want to be able to point the small stream of people who come
into qemu-devel asking "how do I trace all my guest's memory
accesses" at a clean API for it.

* I want to be able to have less ugly and confusing tracing
than our current -d output (and perhaps emit tracing in formats
that other analysis tools want as input)

* I want to keep this initial tracing API simple enough that
we can agree on it and get a first working useful version.

thanks
-- PMM
