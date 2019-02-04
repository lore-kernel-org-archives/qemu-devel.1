Received: from eggs.gnu.org ([209.51.188.92]:37411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gqbb6-0006J7-L5
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 05:35:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gqbay-0000Jq-2b
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 05:35:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60686)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gqbav-0000A2-Uq
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 05:35:18 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CDFA87F7B1
	for <qemu-devel@nongnu.org>; Mon,  4 Feb 2019 10:35:12 +0000 (UTC)
Date: Mon, 4 Feb 2019 10:35:06 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190204103506.GG1905@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190202110834.24880-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190202110834.24880-1-pbonzini@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] char: allow specifying a GMainContext at
 opening time
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

On Sat, Feb 02, 2019 at 12:08:34PM +0100, Paolo Bonzini wrote:
> This will be needed by vhost-user-test, when each test switches to
> its own GMainLoop and GMainContext.  Otherwise, for a reconnecting
> socket the initial connection will happen on the default GMainContext,
> and no one will be listening on it.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Based-on: <1544684731-18828-1-git-send-email-thuth@redhat.com>

I'm wondering if you had looked at my series related to the chardev
reconnect feature, as this feature has many flaws as implemented
right now:

  https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg05947.html

Our patches will conflict, but I think yours is needed regardless.

Incidentally I'm increasingly of the opinion that the qemu_chr_new()
design right now is flawed.

IMHO we should really decouple the parsing & creation of the
Chardev object, from the opening of the backend. eg I would like
to see a qemu_chr_open() as a separate explicitly callable step
from qemu_chr_new(). If we had that, then we would not need to
pass GMainContext into qemu_chr_new() as we would be able to
call the API to set the GMainContext before calling qemu_chr_open

I fear that would be a complex refactoring job though, so no
objection to your current patch for solving the immediate need.

> ---
>  chardev/char.c          | 30 +++++++++++++++-------------
>  gdbstub.c               |  4 ++--
>  hmp.c                   |  2 +-
>  hw/arm/omap2.c          |  2 +-
>  hw/bt/hci-csr.c         |  2 +-
>  hw/char/omap_uart.c     |  4 ++--
>  hw/char/xen_console.c   |  3 ++-
>  hw/isa/isa-superio.c    |  4 ++--
>  hw/mips/boston.c        |  2 +-
>  hw/mips/mips_malta.c    |  2 +-
>  hw/usb/dev-serial.c     |  2 +-
>  include/chardev/char.h  | 16 +++++++++++----
>  net/slirp.c             |  2 +-
>  qtest.c                 |  2 +-
>  tests/test-char.c       | 43 +++++++++++++++++++++--------------------
>  tests/vhost-user-test.c |  2 +-
>  vl.c                    |  8 ++++----
>  17 files changed, 72 insertions(+), 58 deletions(-)


Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
