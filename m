Received: from eggs.gnu.org ([2001:4830:134:3::10]:39633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <artem.k.pisarenko@gmail.com>) id 1gDD8W-0007gT-6T
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 14:35:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <artem.k.pisarenko@gmail.com>) id 1gDD8V-0002TU-90
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 14:35:08 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:36651)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <artem.k.pisarenko@gmail.com>)
	id 1gDD8U-0002R9-TT
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 14:35:07 -0400
Received: by mail-ot1-x341.google.com with SMTP id x4so29349487otg.3
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 11:35:06 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1539860473.git.artem.k.pisarenko@gmail.com>
	<ecc524bb47e169394f9bed88c979fdc8d990111a.1539861171.git.artem.k.pisarenko@gmail.com>
	<ede122b1-f98b-b094-f106-119d25243382@redhat.com>
	<CANzW0mvXfmeFoSqQy42gNg+Pbg12zRrz7bZYKLB2s+oxD=8iiQ@mail.gmail.com>
	<ad8fc9e1-af6c-b753-83ca-0dedc2a4e60f@redhat.com>
	<CANzW0muBKDUHUa01SgQgNajBX5ZqS3sM71qmPPZd_ocNFRKsag@mail.gmail.com>
	<f3fb302a-cc58-30b6-e59a-4f1ba9445054@redhat.com>
In-Reply-To: <f3fb302a-cc58-30b6-e59a-4f1ba9445054@redhat.com>
From: Artem Pisarenko <artem.k.pisarenko@gmail.com>
Date: Fri, 19 Oct 2018 00:34:53 +0600
Message-ID: <CANzW0mv6sTyinMw7fdZe4aKnKGzOgcJMXq-M1uCF9bTMCnkV_A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] Optimize record/replay checkpointing
 for all clocks it applies to
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, qemu-devel@nongnu.org

>=D1=87=D1=82, 18 =D0=BE=D0=BA=D1=82. 2018 =D0=B3., 23:25 Paolo Bonzini:
>On 18/10/2018 19:10, Artem Pisarenko wrote:
>>
>>> No, you're right. The if should remain in the caller, or
>>> need_replay_checkpoint must be initialized with replay_mode.
>>
>> If initialize 'need_replay_checkpoint', then it should also account for
>> clock !=3D QEMU_CLOCK_REALTIME.
>
> Or you just get a unlock/lock pair for QEMU_CLOCK_REALTIME (which should
> really never happen if e.g. you have no UI).

And still have duplication (just smaller in this case).


>> Why do you want to split up such tightly coupled code?
>
> Because it's *too* coupled and not very readable.

Tightly coupled code in my understanding is property having its roots in
design, which usually has wider context than piece of code in question. So
we canot avoid this by definition (limiting changes only to this code).
Trying to improve it is just like a playing with bubble wrap - pressing
each bubble causes another bubble to pop up.

In our particular case it's because of overall rr design, qemu architecture
and a way how rr integrated in timers. The best we can do in this case is
to localise/quarantine ugly aspects as much as possible, carefully and
plenteously comment and try don't touch them... never... I consider
'timerlist_run_timers()' is already totally infected and we're just late to
save anyone of its residents (by isolating others).
