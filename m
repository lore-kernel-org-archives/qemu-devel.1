Received: from eggs.gnu.org ([2001:4830:134:3::10]:50569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1coDER-0002u6-Hj
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 14:01:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1coDEN-0006Uk-7E
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 14:01:07 -0400
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:36635)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1coDEM-0006Sy-St
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 14:01:03 -0400
Received: by mail-wr0-x22d.google.com with SMTP id u108so16323703wrb.3
	for <qemu-devel@nongnu.org>; Wed, 15 Mar 2017 11:01:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <23d89ab3bd16ebf7a864ab75c300de7b@whitewinterwolf.com>
References: <11569d75b61122820f186a32cdd20689@whitewinterwolf.com>
	<20170315144124.GP7770@redhat.com>
	<23d89ab3bd16ebf7a864ab75c300de7b@whitewinterwolf.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 15 Mar 2017 18:00:40 +0000
Message-ID: <CAFEAcA-9GXiS+ByQgo+=tQ-_ZGR5egDcZMurEyfiA9vPkE9O9w@mail.gmail.com>
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
To: Simon <qemu.bugs@whitewinterwolf.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 15 March 2017 at 17:46, Simon <qemu.bugs@whitewinterwolf.com> wrote:
> OK for not using SIGHUP and keep SIGTERM, SIGINT and SIGHUP to have the
> same behavior.
>
> SIGQUIT is reserved for core files generation.
>
> SIGUSR1 is already used in 'util/qemu-progress.c' to trigger a report
> on ongoing jobs, so it does not seem usable.
>
> SIGUSR2 is temporarily used in 'util/coroutine-sigaltstack.c' which
> takes care however to preserve the original handler. I did not saw
> any other place where it is used, so it seems to be a better candidate.

I don't think we can use SIGUSR2 here -- as you say, it's used
in the sigaltstack version of coroutines, and so there would
be races if the user tried to use SIGUSR2 to power down the
machine while we happened to be starting a new coroutine.

SIGUSR1 is also no good, as it is used by main-loop.c as
the SIG_IPI.

thanks
-- PMM
