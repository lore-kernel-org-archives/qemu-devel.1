Received: from eggs.gnu.org ([2001:4830:134:3::10]:59104)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cTQLk-0006o2-1e
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 04:46:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cTQLg-0002kf-7B
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 04:46:44 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:35735)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cTQLg-0002ka-11
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 04:46:40 -0500
Received: by mail-wm0-x242.google.com with SMTP id d140so20708921wmd.2
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 01:46:39 -0800 (PST)
Date: Tue, 17 Jan 2017 09:46:31 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170117094631.GA4265@stefanha-x1.localdomain>
References: <148278447806.8988.12706825771606357198.stgit@fimbulvetr.bsc.es>
	<148278449426.8988.2219094135462471980.stgit@fimbulvetr.bsc.es>
	<20170109154439.GF30228@stefanha-x1.localdomain>
	<87a8ardjft.fsf@ac.upc.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="17pEHd4RhPHOinZp"
Content-Disposition: inline
In-Reply-To: <87a8ardjft.fsf@ac.upc.edu>
Subject: Re: [Qemu-devel] [PATCH v4 3/6] hypertrace: [*-user] Add QEMU-side
 proxy to "guest_hypertrace" event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, Daniel P Berrange <berrange@redhat.com>, Luiz Capitulino <lcapitulino@redhat.com>, Eric Blake <eblake@redhat.com>, Riku Voipio <riku.voipio@iki.fi>


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 16, 2017 at 06:05:26PM +0100, Llu=EDs Vilanova wrote:
> Stefan Hajnoczi writes:
> > On Mon, Dec 26, 2016 at 09:34:54PM +0100, Llu=EDs Vilanova wrote:
> >> +void hypertrace_init_config(struct hypertrace_config *config,
> >> +                            unsigned int max_clients)
> >> +{
> >> +    config->max_clients =3D max_clients;
> >> +    config->client_args =3D CONFIG_HYPERTRACE_ARGS;
> >> +    config->client_data_size =3D config->client_args * sizeof(uint64_=
t);
> >> +    config->control_size =3D QEMU_ALIGN_UP(
> >> +        config->max_clients * sizeof(uint64_t), TARGET_PAGE_SIZE);
>=20
> > This needs to be host page size aligned, too.  Otherwise protect will
> > affect bytes beyond the end of the control region.
>=20
> Ummm, so right. Although I think only host page alignment is required (th=
ere's
> no soft TLB in user-mode, right?).

Yes.

> >> +static void init_channel(const char *base, const char *suffix, size_t=
 size,
> >> +                         char **path, int *fd, uint64_t **addr)
> >> +{
> >> +    *path =3D g_malloc(strlen(base) + strlen(suffix) + 1);
> >> +    sprintf(*path, "%s%s", base, suffix);
> >> +
> >> +    *fd =3D open(*path, O_CREAT | O_EXCL | O_RDWR, S_IRUSR | S_IWUSR);
> >> +    if (*fd =3D=3D -1) {
> >> +        error_report("error: open(%s): %s", *path, strerror(errno));
> >> +        abort();
> >> +    }
>=20
> > open() can fail for reasons outside QEMU's control.  This isn't an
> > internal error.  Please exit cleanly instead of using abort(3).
>=20
> By cleanly you mean exit with a non-zero code, right? It still is an erro=
r that
> cannot be recovered.

Right, it's an error.

> Also, if this goes with exit() what about the abort()s I have added in ot=
her
> places? (e.g., on a failed call to sigaction)

abort(3) is useful for internal errors where a core dump and debugging
are required.

exit(3) is useful for graceful exit (both successful and unsuccessful).
Over the past few years the codebase has been moving towards using Error
**errp and letting the top-level functions handle errors instead of
exiting deep inside QEMU.  This is necessary because lots of things can
be initialized at runtime (like device hotplug) and shouldn't bring down
QEMU.  But it's okay to exit in initialization code that will only be
called once.

> >> +
> >> +    } else {
> >> +        /* proxy to next handler */
> >> +        if (segv_next.sa_sigaction !=3D NULL) {
> >> +            segv_next.sa_sigaction(signum, siginfo, sigctxt);
> >> +        } else if (segv_next.sa_handler !=3D NULL) {
> >> +            segv_next.sa_handler(signum);
> >> +        }
>=20
> > Is there a case when no signal handler was installed (i.e. default
> > action)?
>=20
> Yes, before calling hypertrace_init() or if it is called without a
> "hypertrace_base" argument set (i.e., the user has not enabled hypertrace=
 in the
> command line).

I meant "what happens if !segv_next.sa_action &&
!segv_next.sa_handler?".  The default signal disposition should take
effect.  This code is ignoring that case, turning everything into
SIG_IGN but there is also SIG_DFL.

--17pEHd4RhPHOinZp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYfef3AAoJEJykq7OBq3PIY4MIAMAxTDI8tNiq8V2CMygtvLLt
mkMct0AxqCgTVemWJlISwLvD3hibQj3l57O9I4NVCLf2N+4YWsnT+nXhBinA0odj
Wm9GH4YbBOzLFUqtfJq8fipl7ids/AZJXa8Wmhp1vV6Onrx2UPYs/0J9nYt/+4Wp
XywvgVOiw92Do1Xz5XoYlZ4VG6J7TN4zcf1AptwfYrEiOGW0muTTfYQhfpuqt6us
B2CJvBQ0uuWwkfSlzNzPYB0oqeN+QTvPUzpgICNI9ZO0ozoU27+HSSHUs0S6mu7+
kuLDz/FYz37PKFrbeIxlN5Vq0SVAUgASvc93ujjh2vcS13uEOyZaw1EsViysw3o=
=AJf5
-----END PGP SIGNATURE-----

--17pEHd4RhPHOinZp--
