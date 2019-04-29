Received: from eggs.gnu.org ([209.51.188.92]:44913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hL5Of-0001lA-1K
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 08:28:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hL5Od-00075S-U7
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 08:28:36 -0400
Date: Mon, 29 Apr 2019 08:28:19 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190429122819.GB7587@stefanha-x1.localdomain>
References: <20190103144124.18917-1-stefanha@redhat.com>
	<CAFEAcA-B_T9E3ezWFXg-wp3RotMjv3-z3qY7hSJZEoqFBqCWnQ@mail.gmail.com>
	<62b29bc1-cc78-cd64-4377-fc4007ba7189@redhat.com>
	<20190426091702.GA2071@stefanha-x1.localdomain>
	<CAFEAcA8OVKO087uiNvwDGObiaxHAPYHwoXLEN1t5Y4v9B43r9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lEGEL1/lMxI0MVQ2"
Content-Disposition: inline
In-Reply-To: <CAFEAcA8OVKO087uiNvwDGObiaxHAPYHwoXLEN1t5Y4v9B43r9A@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH] Revert "armv7m: Guard against no -kernel
 argument"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>, QEMU Developers <qemu-devel@nongnu.org>, Steffen Gortz <qemu.ml@steffen-goertz.de>, qemu-arm <qemu-arm@nongnu.org>, Joel Stanley <joel@jms.id.au>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Thomas Huth <thuth@redhat.com>


--lEGEL1/lMxI0MVQ2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2019 at 12:45:37PM +0100, Peter Maydell wrote:
> On Fri, 26 Apr 2019 at 10:17, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> > On Thu, Apr 25, 2019 at 08:07:06PM +0200, Philippe Mathieu-Daud=E9 wrot=
e:
> > Old boards probably want to continue using -kernel.  New boards like
> > microbit may use just -device loader.  Perhaps there is even a group
> > that wants both options.
> >
> > A solution is to introduce explicit checks so that we can tell the user
> > the appropriate option for the machine type.  I can work on this if you
> > like, but probably won't be able to send a patch until Tuesday.
>=20
> But it's difficult to tell how to identify whether there's really
> any guest code there. For instance the user might want to start
> QEMU, connect via the gdbstub and load guest code from gdb.
> Or they might be using the generic-loader device. Or they might
> really be using -kernel but with a broken guest image which doesn't
> have a vector table in it, which will result in the same message.
> I guess you could have a heuristic for "if an M-profile CPU is in reset
> and the value it loads for the starting PC is zero and the gdb
> stub is not connected, then print a warning that the guest image
> is missing or there's no vector table" but I'm not a big fan of
> heuristics...

I was going to add a function to check kernel_filename and the presence
of -device loader.  Then each machine type init function would call the
function with flags indicating which modes are allowed:

  /* Allow both -kernel and -device loader */
  check_kernel_loaded(KERNEL_CMDLINE | KERNEL_LOADER);

  /* Allow only -kernel */
  check_kernel_loaded(KERNEL_CMDLINE);

  /* Allow only -device loader */
  check_kernel_loaded(KERNEL_LOADER);

This doesn't support the gdbstub use case you've described though.  No
heuristics but a bit inflexible.

What do you think?

Stefan

--lEGEL1/lMxI0MVQ2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcxu3jAAoJEJykq7OBq3PIiFEIAJIUtogxNcq8ENA6dUkbecEg
g5mU9zDH+mDPUIXnKmKTjuzRUHJ2ub9gPu5rrZUF5doS3F0B4hGwfciMld+q7cKK
eXFroOORsDJ3hYY9iB2/KyFj4dfr3SaDrciT4kXouSMGi1+il2DadtIOai0eljny
IVketkBvz7V+v/UVvUMbkKOp3hGwJ8nyP2s0CmK6tsZLzu7D9kUabBFADfCpLdn2
Jng0B3TADi1N50T3wOSoci/8XiVUWZ+WBR3AW4ZZDUIhMSUHaCg3Co5F5xI6Z6/0
wBeXm9BLwMLShGF34THQ042ezxA+2oYKIjj/pnqaxACRIwSNFM63IwQ6UsE8/ms=
=nz8+
-----END PGP SIGNATURE-----

--lEGEL1/lMxI0MVQ2--
