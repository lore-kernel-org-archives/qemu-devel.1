Received: from eggs.gnu.org ([2001:4830:134:3::10]:35430)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1drM9D-0003SV-6i
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 06:41:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1drM9C-0007Tr-C5
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 06:40:59 -0400
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:34243)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1drM9C-0007SK-47
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 06:40:58 -0400
Received: by mail-wr0-x231.google.com with SMTP id v109so13670856wrc.1
	for <qemu-devel@nongnu.org>; Mon, 11 Sep 2017 03:40:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <bf940d49-7ab5-d8ba-d8c7-3bc097e0b673@redhat.com>
References: <20170818222313.13391-1-eblake@redhat.com>
	<1c41ef09-3e34-63ba-fc85-5aac46a5c355@linux.vnet.ibm.com>
	<ebea7edf-6f5b-9096-552c-079bfcad71a4@redhat.com>
	<87d17lqu85.fsf@dusky.pond.sub.org>
	<f40a5fc9-a140-041f-1c3c-d97036dab898@redhat.com>
	<f14f7069-6557-8633-d7c4-3caee567f905@redhat.com>
	<bf940d49-7ab5-d8ba-d8c7-3bc097e0b673@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 Sep 2017 11:40:36 +0100
Message-ID: <CAFEAcA8RXCkk-912Q2YPJEwJx4s9RMkY21+OGkhStKRiirzLNg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC PATCH] osdep.h: Prohibit disabling assert()
 in supported builds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, QEMU Developers <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>

On 11 September 2017 at 11:30, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 06/09/2017 07:26, Thomas Huth wrote:
>> You asked for opinions, so here's mine: I agree with you, please do
>> *not* add a new QEMU-specific construct here. assert() should be a
>> well-known C construct that every programmer should have understood. You
>> also need it for other projects. If you haven't understood that it's a
>> macro and has side-effects, you should learn it (e.g. during patch
>> review), not avoid it, otherwise you'll run into problems in another
>> project that is using it again.
>>
>> But IMHO we should still try to get rid of wrong usage of assert() in
>> the QEMU sources. So maybe we could allow building with NDEBUG one day
>> for the brave people who need the extra percent of additional speed.
>
> It's not only about the side effects.  There are a couple cases in
> migration (IIRC) where our error propagation is not up to the task, and
> failing assertions are used to validate untrusted input.  NDEBUG in that
> case can introduce a known vulnerability.
>
>> But as long as we're not there, I think this patch is a good thing to
>> avoid wrong expectations.
>
> Agreed.

Mmm. The only thing that makes me hesitate is that this is moving
the flagging up that we rely on assert() causing a failure away
from the places where we do that -- if we want in future to fix
these migration issues then they'll get harder to find.
(If we already think we have more of those that aren't marked
by testing NDEBUG then we'd already need to do a wider code audit
anyway, though...)

thanks
-- PMM
