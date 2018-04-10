Received: from eggs.gnu.org ([2001:4830:134:3::10]:40128)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1f5ihy-0001dL-RI
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 22:08:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1f5ihv-0005MH-MR
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 22:08:30 -0400
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:35543)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1f5ihv-0005Lr-E2
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 22:08:27 -0400
Received: by mail-pl0-x241.google.com with SMTP id 61-v6so6381037plb.2
	for <qemu-devel@nongnu.org>; Mon, 09 Apr 2018 19:08:27 -0700 (PDT)
Date: Tue, 10 Apr 2018 10:08:23 +0800
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180410020823.GB11203@stefanha-x1.localdomain>
References: <20180404103440.19546-1-stefanha@redhat.com>
	<008ac6e8-1e68-b0f6-7e75-77453721d031@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="i0/AhcQY5QxfSsSZ"
Content-Disposition: inline
In-Reply-To: <008ac6e8-1e68-b0f6-7e75-77453721d031@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH] scripts/qemugdb: support coroutine
 backtrace in coredumps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, gdb@sourceware.org


--i0/AhcQY5QxfSsSZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 09, 2018 at 04:01:24PM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
> 04.04.2018 13:34, Stefan Hajnoczi wrote:
> > Use the 'select-frame' GDB command to switch stacks instead of manually
> > setting the debugged thread's registers (this only works when debugging
> > a live process, not in a coredump).
> >=20
> > Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> > Vladimir: Does this work for you?
> >=20
> >   scripts/qemugdb/coroutine.py | 6 ++----
> >   1 file changed, 2 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/scripts/qemugdb/coroutine.py b/scripts/qemugdb/coroutine.py
> > index ab699794ab..ed96434aee 100644
> > --- a/scripts/qemugdb/coroutine.py
> > +++ b/scripts/qemugdb/coroutine.py
> > @@ -77,13 +77,11 @@ def bt_jmpbuf(jmpbuf):
> >       for i in regs:
> >           old[i] =3D gdb.parse_and_eval('(uint64_t)$%s' % i)
> > -    for i in regs:
> > -        gdb.execute('set $%s =3D %s' % (i, regs[i]))
> > +    gdb.execute('select-frame %s %s' % (regs['rsp'], regs['rip']))
> >       gdb.execute('bt')
> > -    for i in regs:
> > -        gdb.execute('set $%s =3D %s' % (i, old[i]))
> > +    gdb.execute('select-frame %s %s' % (old['rsp'], old['rip']))
> >   def coroutine_to_jmpbuf(co):
> >       coroutine_pointer =3D co.cast(gdb.lookup_type('CoroutineUContext'=
).pointer())
>=20
> strange, but it doesn't work. it prints the same backtrace, as if I just
> call bt.
> (I applied it onto "[PATCH 2/4] scripts/qemugdb: improve "qemu coroutine"
> command")
>=20
> also, I can just call select-frame with zeros or any garbage in gdb, with
> same effect:
> (gdb) select-frame 0 0
> (gdb) bt
>=20
> and get same backtrace.
>=20
> so, bt command not related to selected frame. also, up and down commands
> don't help too, they go to frames in current bt, instead of moving
> relatively to selected frame.

I wonder what the point of select-frame is then...

I have CCed the GDB mailing list.  Maybe someone can help us.  Context:

QEMU implements coroutines using jmpbuf.  We'd like to print coroutine
call stacks in GDB and have a script that works when a process is being
debugged (it sets the registers).

Now we'd like to extend the script to work on core dumps where it's not
possible to set registers (since there is no process being debugged).

Is there a way to backtrace an arbitrary call stack in a core dump?

Stefan

--i0/AhcQY5QxfSsSZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJazByXAAoJEJykq7OBq3PI9TEH/jIozpJTO3kOtpzgYRSApTW6
p/k4xuQ051XgdOXGF+YXkl4LDOD4dbD33Dr8aAxnRJOy1SmNetnSozU8GXFNQDic
NKp+J2QjWpTNdEE0TYKGwhXxZyBwGz8AbeNvkS6blrEVZOPSIm7asR4OmhMAVWST
FPFaEftZFqUFv0kurEx3CQRSH+g+anJ/q+VQKD6pPXfqRAhOLoL0M+A3syU8V9Wx
xqOgkFt7gXVlpikxMjohgWAPMNWPzzu5LXssKzSz8yDYv/BnZ7BEaTuOf+QgiYSt
67kMiLNxMb4LT5i9niB95Ui7b63NORlcSk/Iu8Z5sSkf6FDRs48Wvjx9KLGB0ys=
=IOqm
-----END PGP SIGNATURE-----

--i0/AhcQY5QxfSsSZ--
