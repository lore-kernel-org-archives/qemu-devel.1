Received: from eggs.gnu.org ([2001:4830:134:3::10]:41674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cVzVI-0006cS-CY
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 06:43:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cVzVD-0006iV-D6
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 06:43:12 -0500
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:33966)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cVzVD-0006eM-6C
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 06:43:07 -0500
Received: by mail-lf0-x244.google.com with SMTP id q89so16885592lfi.1
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 03:43:05 -0800 (PST)
Date: Tue, 24 Jan 2017 11:43:02 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170124114302.GB17221@stefanha-x1.localdomain>
References: <20170118160332.13390-1-marcandre.lureau@redhat.com>
	<20170123105502.GH29186@stefanha-x1.localdomain>
	<10505721.4200193.1485170849535.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4bRzO86E/ozDv8r1"
Content-Disposition: inline
In-Reply-To: <10505721.4200193.1485170849535.JavaMail.zimbra@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 00/25] qmp: add async command type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <mlureau@redhat.com>
Cc: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, kraxel@redhat.com, armbru@redhat.com, Jeff Cody <jcody@redhat.com>, John Snow <jsnow@redhat.com>


--4bRzO86E/ozDv8r1
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 23, 2017 at 06:27:29AM -0500, Marc-Andr=E9 Lureau wrote:
> ----- Original Message -----
> > On Wed, Jan 18, 2017 at 08:03:07PM +0400, Marc-Andr=E9 Lureau wrote:
> > > Hi,
> >=20
> > CCing Jeff Cody and John Snow, who have been working on generalizing
> > Block Job APIs to generic background jobs.  There is some overlap
> > between async commands and background jobs.
>=20
> If you say so :) Did I miss a proposal or a discussion for async qmp comm=
ands?

There is no recent mailing list thread, so it's probably best to discuss
here:

The goal of jobs is to support long-running operations that can be
managed via QMP.  Jobs can have a more elaborate lifecycle than just
start -> finish/cancel (e.g. they can be paused/resumed and may have
multiple phases of execution that the client controls).  There are QMP
APIs to query their state (Are they running?  How much "progress" has
been made?).

A client reconnecting to QEMU can query running jobs.  This way a client
can resume with a running QEMU process.  For commands like saving a
screenshot is mostly does not matter, but for commands that modify state
it's critical that clients are aware of running commands after reconnect
to prevent corruption/interference.  This behavior is what I asked about
in my previous mail.

Jobs are currently only used by the block layer and called "block jobs",
but the idea is to generalize this.  They use synchronous QMP + events.

Jobs are more heavy-weight than async QMP commands, but pause/resume,
rate-limiting, progress reporting, robust reconnect, etc are important
features.  Users want to be aware of long-running operations and have
the ability to control them.

I suspect that if we transition synchronous QMP commands to async we'll
soon have requirements for progress reporting, pause/resume, etc.  So is
there a set of commands that should be async and others that should be
jobs or should everything just be a job?

--4bRzO86E/ozDv8r1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYhz3FAAoJEJykq7OBq3PIlNQH/RPrC1lvMDuAEUuTi/uk6rQe
CE0aWtUaLqOljIXjRymljnrSYjqrNUCWIG+Fztn9vAyGhtjpZwwLIalOpyS9qN7J
JW2dtCaoYkThrSOZsoreIT12T+tWUUWaXDfIG/kijeBZexM6WYJr3Ydr7yuQIVvJ
B+Q1GZKDZP390vmmS2jghReuKJvPqjAb5VoiQep8zdEQfoYZ7FYtf/4Ia5kbxw4v
SwVuVzkvXOGmPtfJd7OAqqm27jNM4/HiDJjunAzZvIeC5J3Wa2SNRvpCIFcZgRWk
s0DMT4yH7XdATg4vXB8fry0cw5VAMB2Ri8BYFt/xvb5kZ+MacVuWeCK6ipgW1jY=
=fs6F
-----END PGP SIGNATURE-----

--4bRzO86E/ozDv8r1--
