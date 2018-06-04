Received: from eggs.gnu.org ([2001:4830:134:3::10]:55202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fPmpc-0002sH-Tz
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 06:35:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fPmpc-0002ii-0J
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 06:35:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49978 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fPmpb-0002iQ-Qy
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 06:35:19 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6A7C7402242D
	for <qemu-devel@nongnu.org>; Mon,  4 Jun 2018 10:35:19 +0000 (UTC)
Date: Mon, 4 Jun 2018 11:35:15 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180604103515.GE19749@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180604102752.32260-1-berrange@redhat.com>
	<8297e5b4-dca4-f080-fb87-4cf29a2bb857@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8297e5b4-dca4-f080-fb87-4cf29a2bb857@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] vl: don't use RUN_STATE_PRECONFIG unless
 --preconfig is given
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Michal Privoznik <mprivozn@redhat.com>

On Mon, Jun 04, 2018 at 12:33:04PM +0200, Max Reitz wrote:
> On 2018-06-04 12:27, Daniel P. Berrang=C3=A9 wrote:
> > The RUN_STATE_PRECONFIG state is not supposed to be reachable unless =
the
> > --preconfig argument is given to QEMU, but when it was introduced in:
> >=20
> >   commit 047f7038f586d2150f16c6d9ba9cfd0479f0f6ac
> >   Author: Igor Mammedov <imammedo@redhat.com>
> >   Date:   Fri May 11 19:24:43 2018 +0200
> >=20
> >     cli: add --preconfig option
> >=20
> > The global 'current_run_state' variable was changed to have an initia=
l
> > value of RUN_STATE_PRECONFIG regardless of whether --preconfig is giv=
en.
> >=20
> > It then relies on the main loop to toggle it back to RUN_STATE_PRELAU=
NCH
> > when --preconfig is not given. This is racy because it means that the=
re
> > is a window where QEMU is in RUN_STATE_PRECONFIG despite --preconfig =
not
> > being given. This can be seen with the failure:
> >=20
> >   $ echo | x86_64-softmmu/qemu-system-x86_64 -monitor stdio
> >   QEMU 2.12.50 monitor - type 'help' for more information
> >   (qemu)
> >   HMP not available in preconfig state, use QMP instead
> >=20
> > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > ---
> >  vl.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> This indeed fixes the issue that the preconfig state is reachable
> without --preconfig, but it still keeps the main loop being invoked
> twice (which means that e.g. HMP will process a single character before
> the main loop is actually really invoked:
>=20
> $ echo quit | x86_64-softmmu/qemu-system-x86_64 \
>     -drive file=3D/dev/null,if=3Dide,readonly=3Don -monitor stdio
> QEMU 2.12.50 monitor - type 'help' for more information
> (qemu) qqemu-system-x86_64: Initialization of device ide-hd failed:
> Block node is read-only
>=20
> (Note the "q" before "qemu-system-x86_64"))
>=20
> (Naively,) I agree with Michal that the main loop should only be invoke=
d
> twice if --preconfig has been given, which is implemented by his patch:
>=20
> http://lists.nongnu.org/archive/html/qemu-devel/2018-06/msg00367.html

I think we probably need a combination of both patches for maximum safety=
.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
