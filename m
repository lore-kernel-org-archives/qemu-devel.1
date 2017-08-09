Received: from eggs.gnu.org ([2001:4830:134:3::10]:52455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfYyx-0004R9-8J
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 17:57:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfYyu-0007uS-Sm
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 17:57:38 -0400
References: <20170804012551.2714-1-eblake@redhat.com>
	<20170804012551.2714-18-eblake@redhat.com>
	<87shh0n38c.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <fb135fb9-8c99-912e-ffe7-9d06800e8f5e@redhat.com>
Date: Wed, 9 Aug 2017 16:57:19 -0500
MIME-Version: 1.0
In-Reply-To: <87shh0n38c.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="pwhScptiVMmrIPSDTVVUtG9P6IKioQLiR"
Subject: Re: [Qemu-devel] [PATCH v4 17/22] libqtest: Add qmp_args() helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, "open list:IDE" <qemu-block@nongnu.org>, Amit Shah <amit@kernel.org>, Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pwhScptiVMmrIPSDTVVUtG9P6IKioQLiR
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, "open list:IDE" <qemu-block@nongnu.org>,
 Amit Shah <amit@kernel.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, =?UTF-8?Q?Andreas_F=c3=a4rber?=
 <afaerber@suse.de>
Message-ID: <fb135fb9-8c99-912e-ffe7-9d06800e8f5e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 17/22] libqtest: Add qmp_args() helper
References: <20170804012551.2714-1-eblake@redhat.com>
 <20170804012551.2714-18-eblake@redhat.com>
 <87shh0n38c.fsf@dusky.pond.sub.org>
In-Reply-To: <87shh0n38c.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/09/2017 10:57 AM, Markus Armbruster wrote:

> I don't like the qmp_args name.  It's not about arguments, it's about
> sending a command with arguments.
>=20
> I'm afraid I'm getting pretty thorougly confused by the evolving
> interface.  So I stop and think how it should look like when done.

At a bare minimum, I like your idea that we want:

FOO_send()     # sends a message, does not wait for a reply
FOO_receive()  # reads one JSON object, returns QObject counterpart
FOO() # combo of FOO_send() and FOO_receive()

Then FOO_discard() is a convenient shorthand for QDECREF(FOO_receive()).

Which FOO do we need? Right now, we have 'qmp' for anything using the
global_qtest, 'qtest_qmp' for anything using an explicit QTestState (but
we're arguing that is overkill), and 'qmp_fd' for anything using a raw
fd (test-qga.c - and where I added 'qga' in 11/22, although that
addition was local rather than in libqtest.h).

I also just had an insight: it is possible to write a macro
qmp_send(...) that will expand to qmp_send_cmd(name) if there is only
one argument, but to qmp_send_cmdf(name, fmt, ...) if there is more than
one argument (and later expose a public qmp_send_cmdv(name, fmt,
va_list) as pair if it is needed, although right now it is not).
Perhaps we can even make the one-arg form expand to qmp_send_cmdf(name,
" "), if that's enough to silence gcc's -Wformat-zero-length, and if our
underlying routines are smart enough to recognize a single-space
argument as not being worthy of calling qobject_from_jsonf() (since
qobject_from_jsonf() aborts rather than returning NULL when presented
just whitespace).

In fact, having a macro qmp_send(cmd, ...) expand to
qmp_send_internal(cmd, " " __VA_ARGS__) might even do the trick without
preprocessor magic of checking whether __VA_ARGS__ contains a comma
(although it has the subtle limitation that if present, a format
argument MUST be a string literal because we now rely on string
concatenation with " " - although given gcc's -Wformat-nonliteral, we
are probably okay with that limitation).

So, with a nice macro, the bulk of the testsuite would just write in
this style:

qmp_send("foo");
qmp_send("foo", "{literal_args...}");
qmp_send("foo", "{'name':%s}", value);

for send without waiting, or:

obj =3D qmp("foo");
obj =3D qmp(foo", "{literal_args...}");
obj =3D qmp("foo", "{'name':%s}", value);

where the result matters.  And the names we choose for internal
implementation are no longer quite as important (although still helpful
to get right).

>=20
> We need send and receive.  Convenience functions to do both, and to
> receive and throw away are nice to have.

Do we want both a convenience function to throw away a single read, AND
a function to send a command + throw away a read? Prior to this series,
we have qmp_discard_response() which is send + discard, but nothing that
does plain discard; although plain discard is a better building block
(precisely because then we don't have to duplicate all the different
send forms) - the convenience of send+receive in one call should be
limited to the most common case.

Also, the qmp_eventwait() is a nice convenience function for wait in a
loop until the received object matches a given name; whether we also
need the convenience of qmp_eventwait_ref() is a bit more debatable
(perhaps we could just as easily have qmp_event_wait() always return an
object, and require the caller to QDECREF() it, for one less function to
maintain).

>=20
> We need qmp_raw().  We haven't found a need for a raw receive function.=


Yes, qmp_raw() (or maybe it should be named qmp_send_raw(), depending on
whether the receive is coupled with it?) is our backdoor for sending
JSON that does not match the normal {'execute':'name','arguments':{}}
paradigm (and pretty much qmp-test.c, or maybe also test-qga.c, would be
the only clients).

[Side node - why can't we pick a consistent naming of our tests?  The
name 'FOO-test' is a bit nicer than 'test-FOO' when it comes to writing
=2Egitignore entries. Should we do a bulk cleanup rename to get all the
tests into one consistent naming style?]

>=20
> Convenience functions to build commands and send are nice to have.  The=
y
> come in pairs, without arguments, to avoid -Wno-format-zero-length
> (aside: that's one of the sillier warnings).

It's possible to alter CFLAGS to shut gcc up on that one while still
getting the rest of -Wformat, if we don't think it adds value to qemu.
My idea above is that you can use a macro to hide the worst of the
paired nature, so that the bulk of the testsuite can supply or omit an
arguments format string as desired.

>=20
> We used to have almost everything with and without QTestState, but we'r=
e
> refusing to continue that self-flagellation.

And for v5, I think I'll reorder my series to get rid of QTestState
sooner, rather than later.

>=20
> For every function taking ..., we want one taking va_list.

Under the hood, probably.  Whether the va_list form has to be exported
is a different question (we might be able to get by with just the ... for=
m).

>=20
> Makes sense?
>=20
> Can we derive a sensible set of function names from this?
>=20

I gave it a shot.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--pwhScptiVMmrIPSDTVVUtG9P6IKioQLiR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmLhT8ACgkQp6FrSiUn
Q2o8hQgAqC7TMN0PLZfyKJpRCsrNhJIuny71LKm7i0q0QwgzwDm9kTPn8gKidYxX
o4gnEV2/0a3HY5/10+1fcsFjsab367GTlrIZQ7X66XNkMQ88h1dWyVFj35Bo+nSe
O+6cbYdWkvmnS4HCt+RZD9LaggB32P5rMe9t9rpDt58iQqqE9pG0HBSFVXzs6AON
LPyKARVlfwA0wpK9nqZZ1s6bsz4ZSSgyLAdFZXurcdAB2M6Db9eifctJJ7krOSVD
WNp5iqG7tr9e4VqweK47LJ0OOpIyL7+fP5KzHK0BhTt0KZi3aJvf5Kp5K6gCeXaZ
6eJ+oQow4ISlcuP2T0eWnJhvaQUTaA==
=RJUq
-----END PGP SIGNATURE-----

--pwhScptiVMmrIPSDTVVUtG9P6IKioQLiR--
