Received: from eggs.gnu.org ([2001:4830:134:3::10]:40236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1coDwB-0005c2-Rd
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 14:46:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1coDwA-0001YC-Tw
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 14:46:19 -0400
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:37328)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1coDwA-0001Y1-NP
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 14:46:18 -0400
Received: by mail-wm0-x22f.google.com with SMTP id n11so30404537wma.0
	for <qemu-devel@nongnu.org>; Wed, 15 Mar 2017 11:46:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170315180822.GU7770@redhat.com>
References: <11569d75b61122820f186a32cdd20689@whitewinterwolf.com>
	<20170315144124.GP7770@redhat.com>
	<23d89ab3bd16ebf7a864ab75c300de7b@whitewinterwolf.com>
	<CAFEAcA-9GXiS+ByQgo+=tQ-_ZGR5egDcZMurEyfiA9vPkE9O9w@mail.gmail.com>
	<20170315180822.GU7770@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 15 Mar 2017 18:45:57 +0000
Message-ID: <CAFEAcA-WzT80S_NJb8rSALspBZcCQbT7eounFn9HusjtLWoi_Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [Bug 1217339] [PATCH] Unix signal to send
 ACPI-shutdown to Guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Simon <qemu.bugs@whitewinterwolf.com>, QEMU Developers <qemu-devel@nongnu.org>

On 15 March 2017 at 18:08, Daniel P. Berrange <berrange@redhat.com> wrote:
> On Wed, Mar 15, 2017 at 06:00:40PM +0000, Peter Maydell wrote:
>> On 15 March 2017 at 17:46, Simon <qemu.bugs@whitewinterwolf.com> wrote:
>> > OK for not using SIGHUP and keep SIGTERM, SIGINT and SIGHUP to have the
>> > same behavior.
>> >
>> > SIGQUIT is reserved for core files generation.
>> >
>> > SIGUSR1 is already used in 'util/qemu-progress.c' to trigger a report
>> > on ongoing jobs, so it does not seem usable.
>> >
>> > SIGUSR2 is temporarily used in 'util/coroutine-sigaltstack.c' which
>> > takes care however to preserve the original handler. I did not saw
>> > any other place where it is used, so it seems to be a better candidate.
>>
>> I don't think we can use SIGUSR2 here -- as you say, it's used
>> in the sigaltstack version of coroutines, and so there would
>> be races if the user tried to use SIGUSR2 to power down the
>> machine while we happened to be starting a new coroutine.
>>
>> SIGUSR1 is also no good, as it is used by main-loop.c as
>> the SIG_IPI.
>
> Which means we'd be into the realm of having to pick  SIGRTMIN + N for
> some arbitrary N >= 0

That's pretty nasty. Why can't we use SIGHUP, again?

thanks
-- PMM
