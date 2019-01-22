Received: from eggs.gnu.org ([209.51.188.92]:45527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gm1nf-0007vz-Rp
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:33:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gm1gh-0005Qd-6b
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:26:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55806)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gm1gf-0005OM-Qb
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:26:19 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B9C392CE90B
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 14:39:37 +0000 (UTC)
Date: Tue, 22 Jan 2019 14:39:10 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190122143910.GT13143@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190118173103.4903-1-berrange@redhat.com>
	<20190118173103.4903-5-berrange@redhat.com>
	<64c2ec84-8950-3c58-0ca7-d54c1a9438d2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <64c2ec84-8950-3c58-0ca7-d54c1a9438d2@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 4/4] trace: add ability to do simple
 printf logging via systemtap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On Fri, Jan 18, 2019 at 12:14:14PM -0600, Eric Blake wrote:
> On 1/18/19 11:31 AM, Daniel P. Berrang=C3=A9 wrote:
> > The dtrace systemtap trace backend for QEMU is very powerful but it i=
s
> > also somewhat unfriendly to users who aren't familiar with systemtap,
> > or who don't need its power right now.
> >=20
> >   stap -e "....some strange script...."
> >=20
>=20
> > We go one step further though and introduce a 'qemu-trace-stap' tool =
to
> > make this even easier
> >=20
> >  $ qemu-trace-stap run qemu-system-x86_64 qio*
> >  22806@1547735341399856820 qio_channel_socket_new Socket new ioc=3D0x=
56135d1d7c00
>=20
> One thing I did not immediately get on the first read, and therefore
> which may be worth mentioning in the docs portion of the patch:
>=20
> Am I correct that stap is always run as a separate process from the
> process(es) being traced, and that you can start the two in either orde=
r
> (qemu first, then stap; or stap first, then qemu), where the tracing is
> effectively output as long as both processes are running and trace
> points being hit in the qemu process?

If you're using the stap binary directly you have a choice of it
working against any existing process on the system, or you can have
it launch the process on your behalf and target just that one process.

For our wrapper script I'm only targetting the former, since I think
the common case is that someone/something else has already run the
QEMU process. I could however easily add a "-p PID" option too which
would allow the trace to be tailored to a specific QEMU process, instead
of all running QEMU processes.

And yes, there's no ordering dependancy - unless it is critical that
you see traces from QEMU's early initialization of course, in which
case you'd launch the tracing first.

> >  5 files changed, 339 insertions(+), 1 deletion(-)
> >  create mode 100755 scripts/qemu-trace-stap
> >  create mode 100644 scripts/tracetool/format/log_stap.py
> >=20
> > diff --git a/Makefile b/Makefile
> > index dccba1dca2..22e481e7ba 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -736,6 +736,9 @@ endif
> >  ifneq ($(HELPERS-y),)
> >  	$(call install-prog,$(HELPERS-y),$(DESTDIR)$(libexecdir))
> >  endif
> > +ifdef CONFIG_TRACE_SYSTEMTAP
> > +	$(INSTALL_PROG) "scripts/qemu-trace-stap" $(DESTDIR)$(bindir)
> > +endif
>=20
> No man page being installed?  If we're planning on this binary being
> available on a similar par with qemu-io, it deserves some installed
> documentation.

Heh, no good deed / quick enhancement goes unpunished :-P Yes, I'll
do a proper job of this and write a man page too :-)


> > +To watch all trace points on the qemu-system-x86_64 binary:
> > +
> > +   %(argv0)s run qemu-system-x86_64
> > +
> > +To only watch the trace points matching the qio* and qcrypto* patter=
ns
> > +
> > +   %(argv0)s run qemu-system-x86_64 qio* qcrypto*
>=20
> This output is not copy-pastable - it includes shell globs which might
> inadvertantly expand based on the contents of $PWD. Should you amend th=
e
> output to be properly quoted for reuse in shell commands?

Yes, that is true


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
