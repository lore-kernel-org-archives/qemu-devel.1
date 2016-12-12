Received: from eggs.gnu.org ([2001:4830:134:3::10]:36469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cGQiJ-0005A2-Fd
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 08:32:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cGQiG-0000mc-RO
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 08:32:19 -0500
Received: from mail-vk0-f41.google.com ([209.85.213.41]:34648)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cGQiG-0000mV-NO
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 08:32:16 -0500
Received: by mail-vk0-f41.google.com with SMTP id x186so40075259vkd.1
	for <qemu-devel@nongnu.org>; Mon, 12 Dec 2016 05:32:16 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20161212132209.ryh4uojsz7uev2a6@kamzik.brq.redhat.com>
References: <CAFEAcA9_E=uPX5GqryrF4kyrXNYbH-8Oiv1mgbJM6VshnQe-kw@mail.gmail.com>
	<20161102135933.h6clwz4ahsgchwgv@hawk.localdomain>
	<CAFEAcA9hb1M25AYnBDY0OYTMGvGe5VVR0SLg=T5MR_k1U_S=fw@mail.gmail.com>
	<20161212132209.ryh4uojsz7uev2a6@kamzik.brq.redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 Dec 2016 13:30:55 +0000
Message-ID: <CAFEAcA9v2Wpdsg6iGqBX74_vGp-fB4bOM=DF5z7E32s-0rieoA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] when we add EL2 to QEMU TCG ARM emulation and the
 virt board, should it default on or off?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>

On 12 December 2016 at 13:22, Andrew Jones <drjones@redhat.com> wrote:
> On Mon, Dec 12, 2016 at 12:48:14PM +0000, Peter Maydell wrote:
>> And of course you can drive
>> the board changes off a CPU property value if you want...
>
> Fair point. What do we typically do? I think it'd be nice to be
> consistent here.

We're not terribly consistent for ARM. We do this for 'pmu' but
not for EL3. (Part of my motivation for this thread was to
find out which of these two precedents we should follow for
EL2.)

> Do cpu properties typically [silently] drive
> board changes? Or do board properties, depending on cpu properties,
> simply fail when those cpu properties aren't selected by the user,
> or do they silently enable them?

For ARM so far the answer has mostly been "CPU properties are
there for the board to set, either unconditionally or sometimes
based on a board property; the user isn't intended to set them,
and if the user does mess with them results are unsupported".
The PMU property is an exception to this rule (perhaps our only
exception so far, though the "define the SCTLR.EE reset value"
property patches currently on the list would be another where
the user is allowed to set them in some cases).

I'm not sure how other CPU architectures handle this.

>> The other reason I made EL3 have both a CPU property and a
>> board property is that it allowed us to have the board
>> property default to false (for back-compat) but the
>> CPU property default to true (so that any future boards
>> would get EL3 support by default, like the h/w -- you
>> can't get a real Cortex-A57 without EL2 and EL3).
>
> This makes sense to me. A good goal is to keep the processor model
> as close as possible to real hardware. I guess that pretty much
> just leaves one option: creating a board property that enables the
> there-by-default (but still special) cpu feature use.
>
> So, EL2 cpu property on by default, but EL2 board property off
> by default. And with EL2 board property off, El2 cpu property
> automatically turned off?

Yes; this matches how we handle EL3, anyway.

thanks
-- PMM
