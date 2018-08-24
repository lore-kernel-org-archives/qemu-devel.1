Received: from eggs.gnu.org ([2001:4830:134:3::10]:41030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1ftCPq-0006HU-99
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 09:46:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1ftCPp-00028f-5o
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 09:46:18 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:40575)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1ftCPo-00028B-SP
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 09:46:17 -0400
Received: by mail-wr1-x441.google.com with SMTP id n2-v6so7523145wrw.7
	for <qemu-devel@nongnu.org>; Fri, 24 Aug 2018 06:46:16 -0700 (PDT)
MIME-Version: 1.0
References: <20180824090826.21370-1-peterx@redhat.com>
In-Reply-To: <20180824090826.21370-1-peterx@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 24 Aug 2018 15:46:03 +0200
Message-ID: <CAJ+F1C+4rshvZ6wNLq0Lo95tPXm_iUxorgRYeNYqgyQCYvxBNQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC 0/3] chardev: introduce chardev contexts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Hi,

On Fri, Aug 24, 2018 at 11:10 AM Peter Xu <peterx@redhat.com> wrote:
>
> This is a RFC series.  It majorly did these things:
>
> (1) move the monitor iothread management from monitor code to chardev
>     code somehow,
>
> (2) decide which context/iothread to use for the chardev before
>     chardev creates, by parsing monitor options earlier (not init, but
>     only parsing) since monitor is the only exception now,
>
> (2) disallow chardev context to change for the whole lifecycle.
>
> Basically this work moves the only chardev iothread (the monitor
> iothread) into chardev's management, then it's easy to setup the
> iothread even before the chardev creates, hence no context switch for
> chardev is needed any more.  In the future if we want to let any
> chardev to run on some other threads, we just define a new
> ChardevContext, then do qemu_opt_set_number(...) for the chardev.  For
> now, there is only a monitor context.
>
> It does not mean that this will let chardev depend on monitor code,
> instead it'll totally remove the reverse dependency - before this
> work, the chardev backend strangely depends on the frontend to setup
> the context (which brought us many trouble).  Now this should be gone.
>
> This series should solve the potential issue raised here:
>
>   https://patchwork.kernel.org/patch/10122713/#22187395
>
> And also should let Marc-Andr=C3=A9's vhost-user reconnect series work
> without breaking context switch of chardev (since it never switches
> now hence no way to break):
>
>   http://patchwork.ozlabs.org/cover/961442/
>
> Only smoke test carried out with out-of-band, and make check.
>
> Please have a look on whether this is a workable solution,

Clever hack!

The code could be simplified somewhat:
- it probably doesn't need ChardevContextMap
- I would not typedef ChardevContext (took me a while to realize it was an =
enum)
- we should avoid the "context" option, perhaps during chardev
parsing, check -mon usage.
- more :)

Other issues:
- blend monitor code in chardev
- chardev cleanup is done after monitor cleanup, this may race iothreads
- breaks chardev context switching (colo)
- not a very dynamic solution (doesn't help to create oob monitor dynamical=
ly)

I'd continue to look for options, we might come back to this one eventually=
 :)

thanks!

>
> TODO:
> - should not allow user to specify the "context" parameter
> - more ...
>
> Thanks,
>
> Peter Xu (3):
>   chardev: introduce chardev contexts
>   monitor: generate flag parse helper from init func
>   monitor: switch to use chardev's iothread
>
>  chardev/char-fe.c      |  6 ++++
>  chardev/char.c         | 74 ++++++++++++++++++++++++++++++++++++++----
>  gdbstub.c              |  2 +-
>  hw/bt/hci-csr.c        |  2 +-
>  include/chardev/char.h | 15 ++++++++-
>  monitor.c              |  4 +--
>  tests/test-char.c      |  4 +--
>  vl.c                   | 45 +++++++++++++++++++++++--
>  8 files changed, 136 insertions(+), 16 deletions(-)
>
> --
> 2.17.1
>
>


--=20
Marc-Andr=C3=A9 Lureau
