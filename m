Received: from eggs.gnu.org ([2001:4830:134:3::10]:54828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1coDLd-0000CV-6U
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 14:08:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1coDLZ-0002yu-G2
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 14:08:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36236)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1coDLZ-0002yK-7j
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 14:08:29 -0400
Date: Wed, 15 Mar 2017 18:08:22 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170315180822.GU7770@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <11569d75b61122820f186a32cdd20689@whitewinterwolf.com>
	<20170315144124.GP7770@redhat.com>
	<23d89ab3bd16ebf7a864ab75c300de7b@whitewinterwolf.com>
	<CAFEAcA-9GXiS+ByQgo+=tQ-_ZGR5egDcZMurEyfiA9vPkE9O9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA-9GXiS+ByQgo+=tQ-_ZGR5egDcZMurEyfiA9vPkE9O9w@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Simon <qemu.bugs@whitewinterwolf.com>, QEMU Developers <qemu-devel@nongnu.org>

On Wed, Mar 15, 2017 at 06:00:40PM +0000, Peter Maydell wrote:
> On 15 March 2017 at 17:46, Simon <qemu.bugs@whitewinterwolf.com> wrote:
> > OK for not using SIGHUP and keep SIGTERM, SIGINT and SIGHUP to have the
> > same behavior.
> >
> > SIGQUIT is reserved for core files generation.
> >
> > SIGUSR1 is already used in 'util/qemu-progress.c' to trigger a report
> > on ongoing jobs, so it does not seem usable.
> >
> > SIGUSR2 is temporarily used in 'util/coroutine-sigaltstack.c' which
> > takes care however to preserve the original handler. I did not saw
> > any other place where it is used, so it seems to be a better candidate.
> 
> I don't think we can use SIGUSR2 here -- as you say, it's used
> in the sigaltstack version of coroutines, and so there would
> be races if the user tried to use SIGUSR2 to power down the
> machine while we happened to be starting a new coroutine.
> 
> SIGUSR1 is also no good, as it is used by main-loop.c as
> the SIG_IPI.

Which means we'd be into the realm of having to pick  SIGRTMIN + N for
some arbitrary N >= 0


Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
