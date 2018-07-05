Received: from eggs.gnu.org ([2001:4830:134:3::10]:58818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fb54w-0001Jg-Eu
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 10:17:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fb54r-0007Na-FA
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 10:17:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36232 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fb54r-0007M1-8l
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 10:17:45 -0400
Date: Thu, 5 Jul 2018 15:17:39 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180705141739.GM2538@work-vm>
References: <20180629174305.42849-1-dgilbert@redhat.com>
	<CAFEAcA8AdAYdnaCgyyEDwqbNd+0ZovfG2O3wLGcumRg2b3RW1g@mail.gmail.com>
	<CAFEAcA_wvRnHvy7CVO48DdHNaQxCyBhmjUrBVM-rGiXViH+jDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_wvRnHvy7CVO48DdHNaQxCyBhmjUrBVM-rGiXViH+jDg@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH] tests/migration: Skip tests for ppc tcg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Juan Quintela <quintela@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Peter Xu <peterx@redhat.com>

* Peter Maydell (peter.maydell@linaro.org) wrote:
> On 30 June 2018 at 17:28, Peter Maydell <peter.maydell@linaro.org> wrote:
> > On 29 June 2018 at 18:43, Dr. David Alan Gilbert (git)
> > <dgilbert@redhat.com> wrote:
> >> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> >>
> >> PPC tcg seems to be failing migration tests quite regularly;
> >> we believe this is TCG bugs in dirty bit updating; it's
> >> not clear why PPC fails more but lets skip for the moment.
> >>
> >> $ ./tests/migration-test
> >> /ppc64/migration/deprecated: OK
> >> /ppc64/migration/bad_dest: SKIP
> >> /ppc64/migration/postcopy/unix: SKIP
> >> /ppc64/migration/precopy/unix: SKIP
> >
> > This patch seems to make the test fail in some setups:
> 
> Specifically, it's the 'gtester' command in 'make check'
> that makes the difference:
> 
> e104462:xenial:ppc$ QTEST_QEMU_BINARY=ppc64-softmmu/qemu-system-ppc64
> tests/migration-test
> /ppc64/migration/deprecated: OK
> /ppc64/migration/bad_dest: SKIP
> /ppc64/migration/postcopy/unix: SKIP
> /ppc64/migration/precopy/unix: SKIP
> e104462:xenial:ppc$ QTEST_QEMU_BINARY=ppc64-softmmu/qemu-system-ppc64
> gtester -k --verbose -m=quick tests/migration-test
> TEST: tests/migration-test... (pid=23304)
>   /ppc64/migration/deprecated:                                         OK
>   /ppc64/migration/bad_dest:                                           FAIL
> GTester: last random seed: R02Sa45f28859314d31ea4e89aeee4851d87
>   /ppc64/migration/postcopy/unix:                                      FAIL
> GTester: last random seed: R02Sa45f28859314d31ea4e89aeee4851d87
>   /ppc64/migration/precopy/unix:                                       FAIL
> GTester: last random seed: R02Sa45f28859314d31ea4e89aeee4851d87
> PASS: tests/migration-test
> 
> This seems to be a bug in gtester:
> https://bugzilla.gnome.org/show_bug.cgi?id=790934

Bah, and I liked that I was using a nice new gtk feature.

> which I guess we need to work around -- the easy approach would be to just
> call this a pass rather than a skip, I suppose.

Yeh, I'll rework it.  I'll include a printf saying we skipped it though
just to remove any false feeling of warmth and reassurance of an OK.

> I also note that in that bug report the glib folks say
> "don't use gtester, it's not maintained", and recommend that
> we switch to something else (a 'TAP harness', whatever that is)...

https://testanything.org/ I think, but I don't know anything about it.

Dave

> 
> thanks
> -- PMM
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
